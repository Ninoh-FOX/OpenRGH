#!/usr/bin/env python2

from os import SEEK_SET, SEEK_END

def checkPowerOfTwo(n, description):
	if n == 0 or (n & (n - 1)) != 0:
		raise ValueError('%s (%d) is not a power of two'
				% (description.capitalize(), n))
	return n

def formatSize(size):
	'''Returns a human-readable representation of a size in bytes.
	'''
	size = float(size)
	suffixes = iter(('bytes', 'KiB', 'MiB', 'GiB', None))
	while True:
		suffix = next(suffixes)
		if suffix is None or size < 1024:
			break
		size /= 1024
	if size >= 100:
		return '%.0f %s' % (size, suffix)
	elif size >= 10:
		return '%.1f %s' % (size, suffix)
	else:
		return '%.2f %s' % (size, suffix)

def formatPowerOfTwoSize(size):
	'''Returns a human-readable representation of a size in bytes,
	where the size is guaranteed to be a power of two.
	'''
	suffixes = iter(('bytes', 'KiB', 'MiB', 'GiB', None))
	while True:
		suffix = next(suffixes)
		if suffix is None or size < 1024:
			break
		assert size % 1024 == 0, size
		size /= 1024
	return '%d %s' % (size, suffix)

def checkPropertyIsPowerOfTwo(prop, description):
	if prop.fget is None:
		newGet = None
	else:
		def newGet(obj):
			return checkPowerOfTwo(prop.fget(obj), description)
	if prop.fset is None:
		newSet = None
	else:
		def newSet(obj, value):
			checkPowerOfTwo(value, description)
			prop.fset(obj, value)
	return property(newGet, newSet, prop.fdel)

def get8(data, offset):
	return ord(data[offset])

def get16(data, offset):
	return ord(data[offset]) | (ord(data[offset + 1]) << 8)

def get32(data, offset):
	return ord(data[offset]) | (ord(data[offset + 1]) << 8) \
			| (ord(data[offset + 2]) << 16) | (ord(data[offset + 3]) << 24)

def set8(data, offset, value):
	if not (0 <= value < 0x100):
		raise ValueError('Value does not fit in 8 bits: %d' % value)
	data[offset] = chr(value)

def set16(data, offset, value):
	if not (0 <= value < 0x10000):
		raise ValueError('Value does not fit in 16 bits: %d' % value)
	data[offset] = chr(value & 0xFF)
	data[offset + 1] = chr((value >> 8) & 0xFF)

def set32(data, offset, value):
	if not (0 <= value < 0x100000000):
		raise ValueError('Value does not fit in 32 bits: %d' % value)
	data[offset] = chr(value & 0xFF)
	data[offset + 1] = chr((value >> 8) & 0xFF)
	data[offset + 2] = chr((value >> 16) & 0xFF)
	data[offset + 3] = chr((value >> 24) & 0xFF)

def property8(offset):
	return property(
		lambda self: get8(self.data, offset),
		lambda self, value: set8(self.data, offset, value)
		)

def property16(offset):
	return property(
		lambda self: get16(self.data, offset),
		lambda self, value: set16(self.data, offset, value)
		)

def property32(offset):
	return property(
		lambda self: get32(self.data, offset),
		lambda self, value: set32(self.data, offset, value)
		)

class BootSector(object):

	sectorSize = checkPropertyIsPowerOfTwo(
			property16(0x00B), 'sector size')
	sectorsPerCluster = checkPropertyIsPowerOfTwo(
			property8(0x00D), 'sectors per cluster')
	reservedSectors = property16(0x00E)
	numFATs = property8(0x010)
	sectorsPerFAT = property32(0x024)

	@classmethod
	def read(cls, f):
		f.seek(0, SEEK_SET)
		data = f.read(512)

		# A few sanity checks: is this really a FAT32 partition?
		if len(data) != 512:
			raise ValueError('Too little data to even contain a boot sector')
		if data[-2 : ] != '\x55\xaa':
			raise ValueError('Missing boot sector signature')
		if data[0x052 : 0x05A] != 'FAT32   ':
			raise ValueError('Missing FAT32 file system type string')

		return cls(data)

	def __init__(self, data):
		self.data = data

	def getFATRange(self, index):
		'''Returns the offset and length (both in bytes) of the given FAT.
		'''
		assert 0 <= index < self.numFATs, index
		sectorSize = self.sectorSize
		length = self.sectorsPerFAT * sectorSize
		offset = self.reservedSectors * sectorSize + index * length
		return offset, length

class FAT(object):

	@classmethod
	def read(cls, f, bootSector, index):
		offset, length = bootSector.getFATRange(index)
		f.seek(offset, SEEK_SET)
		data = f.read(length)
		if len(data) != length:
			raise ValueError('Data ends within FAT%d' % index)
		return cls(data)

	def __init__(self, data):
		assert len(data) % 4 == 0, len(data)
		self.data = data

	def __getitem__(self, index):
		return get32(self.data, index * 4) & 0x0fffffff

	def __setitem__(self, index, value):
		set32(self.data, index * 4, value)

	def __len__(self):
		return len(self.data) / 4

	def dump(self):
		for i in xrange(len(self.data) / 4):
			print '%08X' % self[i],
			if i % 8 == 7:
				print

def getOffsetLastSector(imageFile):
	# Determine size of container (partition/image).
	# Note: stat-based approaches don't work for device nodes.
	imageFile.seek(0, SEEK_END)
	imageSize = imageFile.tell()
	print 'Image size:', formatSize(imageSize)

	# Read and check boot sector.
	bootSector = BootSector.read(imageFile)
	sectorSize = bootSector.sectorSize
	imageSectors, imageRemainder = divmod(imageSize, sectorSize)
	if imageRemainder != 0:
		raise ValueError('Partition/image size (%d) is not a multiple of '
				'sector size (%d)' % (imageSize, sectorSize))

	numFATs = bootSector.numFATs
	last = 2
	for idx in xrange(0, numFATs):
		fat = FAT.read(imageFile, bootSector, idx)
		for cluster in xrange(2, len(fat)):
			val = fat[cluster]
			if val >= 2 and (val <= 0x0FFFFFEF or val >= 0x0FFFFFF8) and cluster > last:
				last = cluster
	print 'Highest cluster found: %i' % last

	lastSector = bootSector.reservedSectors \
			+ bootSector.sectorsPerFAT * numFATs \
			+ (last + 1) * bootSector.sectorsPerCluster

	print 'Image can be trimmed from sector %i (one sector is %s)' % \
			(lastSector, formatSize(sectorSize))
	
	newSize = lastSector * sectorSize
	print 'New image file size will be %s (saves %s)' % \
			(formatSize(newSize), formatSize(imageSize - newSize))
	return lastSector * sectorSize

if __name__ == '__main__':
	import sys
	if len(sys.argv) == 2:
		with open(sys.argv[1], 'a+b') as imageFile:
			length = getOffsetLastSector(imageFile)
			print 'Truncating %s...' % sys.argv[1]
			imageFile.truncate(length)
	else:
		print >>sys.stderr, 'Usage: trimfat.py <image>'
		print >>sys.stderr, ''
		print >>sys.stderr, 'Trims the given filesystem image.'
		print >>sys.stderr, 'Only FAT32 is supported.'
		sys.exit(2)
