#!/usr/bin/env python

def writeMBR(out, partitions):
	partitions = list(partitions)
	if len(partitions) > 4:
		raise ValueError('Too many partitions (%d)' % len(partitions))
	while len(partitions) < 4:
		partitions.append((0, 0, 0))

	# Jump to start of boot loader in sector 1.
	out.write('\x80\0\0\x10')
	out.write('\0' * (0x1BE - 4))

	for start, size, typ in partitions:
		# Bootable flag: not needed for Linux.
		out.write('\0')
		# First sector CHS: unused.
		out.write('\0\0\0')
		# Partition type.
		out.write(chr(typ))
		# Last sector CHS: unused.
		out.write('\0\0\0')
		# First sector LBA, little endian.
		for shift in xrange(0, 32, 8):
			out.write(chr((start >> shift) & 0xFF))
		# Size in sectors, little endian.
		for shift in xrange(0, 32, 8):
			out.write(chr((size >> shift) & 0xFF))
	out.write('\x55\xAA')

def readSpec(inp):
	for line in inp.readlines():
		parts = line.split(',')
		yield (int(parts[0]), int(parts[1]), int(parts[2], 16))

if __name__ == '__main__':
	import sys
	writeMBR(sys.stdout, readSpec(sys.stdin))
