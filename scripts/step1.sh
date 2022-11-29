#!/bin/bash
#export HOME=~/

#Prerequisites (GNU/Linux Debian/Ubuntu)

#Install packages we need in the build system required by our scripts.
sudo apt-get install \
    binutils \
    debootstrap \
    squashfs-tools \
    xorriso \
    grub-pc-bin \
    grub-efi-amd64-bin \
    mtools
    
mkdir $HOME/live-ubuntu-from-scratch


#Bootstrap and Configure Ubuntu
#Checkout bootstrap
sudo debootstrap \
   --arch=amd64 \
   --variant=minbase \
   focal \
   $HOME/live-ubuntu-from-scratch/chroot \
   http://us.archive.ubuntu.com/ubuntu/


#Configure external mount points
sudo mount --bind /dev $HOME/live-ubuntu-from-scratch/chroot/dev
  
sudo mount --bind /run $HOME/live-ubuntu-from-scratch/chroot/run

########################
#Define chroot environment

#Copy step1a.sh
sudo cp step1a.sh $HOME/live-ubuntu-from-scratch/chroot/root

#1. Access chroot environment
sudo chroot $HOME/live-ubuntu-from-scratch/chroot
#sh /root/step1a.sh

#exit

#Remove step1a.sh
sudo rm -rf $HOME/live-ubuntu-from-scratch/chroot/root/step1a.sh

#24. Unbind mount points
sudo umount $HOME/live-ubuntu-from-scratch/chroot/dev

sudo umount $HOME/live-ubuntu-from-scratch/chroot/run

#End step 1
echo "End step 1"
