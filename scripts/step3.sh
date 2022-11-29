#!/bin/bash
#export HOME=~/

#Create manifest
#1. Access build directory
cd $HOME/live-ubuntu-from-scratch

#2. Generate manifest
sudo chroot chroot dpkg-query -W --showformat='${Package} ${Version}\n' | sudo tee image/casper/filesystem.manifest

sudo cp -v image/casper/filesystem.manifest image/casper/filesystem.manifest-desktop

sudo sed -i '/ubiquity/d' image/casper/filesystem.manifest-desktop

sudo sed -i '/casper/d' image/casper/filesystem.manifest-desktop

sudo sed -i '/discover/d' image/casper/filesystem.manifest-desktop

sudo sed -i '/laptop-detect/d' image/casper/filesystem.manifest-desktop

sudo sed -i '/os-prober/d' image/casper/filesystem.manifest-desktop




#Compress the chroot
#1. Access build directory
cd $HOME/live-ubuntu-from-scratch

#2. Create squashfs
sudo mksquashfs chroot image/casper/filesystem.squashfs -noappend

#3. Write the filesystem.size
printf $(sudo du -sx --block-size=1 chroot | cut -f1) > image/casper/filesystem.size

#Create diskdefines
#1. Access build directory
cd $HOME/live-ubuntu-from-scratch

#2. Create file image/README.diskdefines
cat <<EOF > image/README.diskdefines
#define DISKNAME  Bullgharos
#define TYPE  binary
#define TYPEbinary  1
#define ARCH  amd64
#define ARCHamd64  1
#define DISKNUM  1
#define DISKNUM1  1
#define TOTALNUM  0
#define TOTALNUM0  1
EOF

#End step 3
echo "End step 3"
