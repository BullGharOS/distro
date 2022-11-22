#!/bin/bash
#Create the CD image directory and populate it
#1. Access build directory
cd $HOME/live-ubuntu-from-scratch

#2. Create directories
mkdir -p image/{casper,isolinux,install}

#3. Copy kernel images
sudo cp chroot/boot/vmlinuz-**-**-generic image/casper/vmlinuz

sudo cp chroot/boot/initrd.img-**-**-generic image/casper/initrd

#4. Copy memtest86+ binary (BIOS)
sudo cp chroot/boot/memtest86+.bin image/install/memtest86+

#5. Download and extract memtest86 binary (UEFI)
wget --progress=dot https://www.memtest86.com/downloads/memtest86-usb.zip -O image/install/memtest86-usb.zip

unzip -p image/install/memtest86-usb.zip memtest86-usb.img > image/install/memtest86

rm -f image/install/memtest86-usb.zip


#GRUB menu configuration
#1. Access build directory
cd $HOME/live-ubuntu-from-scratch

#2. Create base point access file for grub
touch image/ubuntu

#3. Create image/isolinux/grub.cfg

cat <<EOF > image/isolinux/grub.cfg

search --set=root --file /ubuntu

insmod all_video

set default="0"
set timeout=30

menuentry "Try Bullgharos without installing" {
   linux /casper/vmlinuz boot=casper nopersistent toram quiet splash ---
   initrd /casper/initrd
}

#menuentry "Install Bullgharos" {
#   linux /casper/vmlinuz boot=casper only-ubiquity quiet splash ---
#   initrd /casper/initrd
#}

menuentry "Check disc for defects" {
   linux /casper/vmlinuz boot=casper integrity-check quiet splash ---
   initrd /casper/initrd
}

menuentry "Test memory Memtest86+ (BIOS)" {
   linux16 /install/memtest86+
}

#menuentry "Test memory Memtest86 (UEFI, long load time)" {
#   insmod part_gpt
#   insmod search_fs_uuid
#   insmod chain
#   loopback loop /install/memtest86
#   chainloader (loop,gpt1)/efi/boot/BOOTX64.efi
#}
EOF

#End step 2
echo "End step 2"
