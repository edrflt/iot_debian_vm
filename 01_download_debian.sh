#!/bin/sh

rm *.iso
wget https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.5.0-amd64-netinst.iso

xorriso -osirrox on -indev debian-11.5.0-amd64-netinst.iso  -extract / isofiles/

chmod +w isofiles/isolinux
chmod +w isofiles/isolinux/isolinux.cfg
chmod a+w isofiles/isolinux/isolinux.bin
cp isolinux.cfg isofiles/isolinux

chmod +w -R isofiles/install.amd/
gunzip isofiles/install.amd/initrd.gz
echo preseed.cfg | cpio -H newc -o -A -F isofiles/install.amd/initrd
gzip isofiles/install.amd/initrd

pushd isofiles
	md5sum `find -follow -type f` > md5sum.txt
popd

genisoimage -r -J -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o debian-11.5.0-amd64-netinst.iso isofiles

chmod +w -R isofiles/
rm -rf isofiles
