#!/bin/bash
set -e
umask 0022

VERSION="1.7.9"

if [ -r "flasher/sd_image.bin" ]; then
SD="flasher/sd_image.bin"
else
SD=""
fi

# TODO: Reinstate this:
# X-OD-Manual=CHANGELOG

if [ -r "flasher/sd_image.bin" ] ; then
   DATE=`date -r "$SD" +%F`

fi


echo "$DATE" > flasher/date.txt

echo "$VERSION" > flasher/version.txt

# Report metadata.
echo
echo "=========================="
echo "SD Imagen:            $SD"
echo "build date:           $DATE"
echo "build version:        $VERSION"
echo "=========================="
echo

# Write metadata.
cat > flasher/default.gcw0.desktop <<EOF
[Desktop Entry]
Name=Flasher $VERSION
Comment=RG350 ROGUE flasher $DATE
Exec=flasher.sh
Icon=rogue
Terminal=true
Type=Application
StartupNotify=true
Categories=applications;
EOF

# Create OPK.
OPK_FILE=flasher/rg350-flasher-$VERSION-$DATE.opk
mksquashfs \
	flasher/default.gcw0.desktop \
	flasher/rogue.png \
	flasher/flasher.sh \
	flasher/dd \
	flasher/pv \
	flasher/date.txt \
        flasher/version.txt \
	$SD \
	$OPK_FILE \
	-no-progress -noappend -comp gzip -all-root

echo
echo "=========================="
echo
echo "Flasher OPK:       $OPK_FILE"
echo
