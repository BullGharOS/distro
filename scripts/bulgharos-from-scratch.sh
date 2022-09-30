#!/bin/bash

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

#1. Access chroot environment
sudo chroot $HOME/live-ubuntu-from-scratch/chroot

#2. Configure mount points, home and locale
mount none -t proc /proc

mount none -t sysfs /sys

mount none -t devpts /dev/pts

export HOME=/root

export LC_ALL=C

#3. Set a custom hostname
echo "bullgharos" > /etc/hostname

#4. Configure apt sources.list
cat <<EOF > /etc/apt/sources.list
deb http://us.archive.ubuntu.com/ubuntu/ focal main restricted universe multiverse
deb-src http://us.archive.ubuntu.com/ubuntu/ focal main restricted universe multiverse

deb http://us.archive.ubuntu.com/ubuntu/ focal-security main restricted universe multiverse
deb-src http://us.archive.ubuntu.com/ubuntu/ focal-security main restricted universe multiverse

deb http://us.archive.ubuntu.com/ubuntu/ focal-updates main restricted universe multiverse
deb-src http://us.archive.ubuntu.com/ubuntu/ focal-updates main restricted universe multiverse
EOF

#5. Update indexes packages
apt-get update

#6. Install systemd
apt-get install -y libterm-readline-gnu-perl systemd-sysv

#7. Configure machine-id and divert
dbus-uuidgen > /etc/machine-id

ln -fs /etc/machine-id /var/lib/dbus/machine-id


dpkg-divert --local --rename --add /sbin/initctl
ln -s /bin/true /sbin/initctl

#8. Upgrade packages
apt-get -y upgrade

#9. Install packages needed for Live System
apt-get install -y \
    sudo \
    ubuntu-mate-desktop \
    mate-backgrounds \
    casper \
    lupin-casper \
    discover \
    laptop-detect \
    os-prober \
    network-manager \
    resolvconf \
    net-tools \
    wireless-tools \
    wpagui \
    locales \
    grub-common \
    grub-gfxpayload-lists \
    grub-pc \
    grub-pc-bin \
    grub2-common

apt-get install -y --no-install-recommends linux-generic

#10. Graphical installer
apt-get install -y \
   ubiquity \
   ubiquity-casper \
   ubiquity-frontend-gtk \
   ubiquity-slideshow-ubuntu-mate \
   ubiquity-ubuntu-artwork
   
#11. Install window manager
apt-get install -y \
    plymouth-theme-ubuntu-mate-logo \
    ubuntu-mate-desktop \
    ubuntu-mate-wallpapers \
    gnome-tweaks
    
apt-get remove ubuntu-session
    
#12. Install useful applications
apt-get install -y \
    clamav-daemon \
    terminator \
    apt-transport-https \
    curl \
    vim \
    nano \
    less
    
#13. Install joe editor
apt-get install -y joe

#14. Then update the package cache and install the package using
apt-get update

#apt-get install -y code

#15. Remove unused applications
apt-get purge -y \
    transmission-gtk \
    transmission-common \
    gnome-mahjongg \
    gnome-mines \
    gnome-sudoku \
    aisleriot \
    hitori
    
#16. Remove unused packages
apt-get autoremove -y


#17. Generate locales
dpkg-reconfigure locales

#18. Reconfigure resolvconf
dpkg-reconfigure resolvconf

#19. Configure network-manager
cat <<EOF > /etc/NetworkManager/NetworkManager.conf
[main]
rc-manager=resolvconf
plugins=ifupdown,keyfile
dns=dnsmasq

[ifupdown]
managed=false
EOF

#20. Reconfigure network-manager
dpkg-reconfigure network-manager

#21. If you installed software, be sure to run
truncate -s 0 /etc/machine-id

#22. Remove the diversion
rm /sbin/initctl

dpkg-divert --rename --remove /sbin/initctl



#PREPARATIONS
#from ~/live-ubuntu-from-scratch
sudo cp ~/Pictures/BullGharOS/backgrounds/plymouth_background_future.png /home/niki/live-ubuntu-from-scratch/chroot/usr/share/backgrounds/default-theme-bgos.png

sudo cp ~/Pictures/BullGharOS/backgrounds/plymouth_background_future.png /home/niki/live-ubuntu-from-scratch/chroot/usr/share/backgrounds/mate/desktop/bgos.png

sudo cp ~/Pictures/BullGharOS/backgrounds/Float-into-BGOS.png /home/niki/live-ubuntu-from-scratch/chroot/usr/share/backgrounds/warty-final-ubuntu.png 

sudo cp ~/Pictures/BullGharOS/backgrounds/light_blue_moon.png /home/niki/live-ubuntu-from-scratch/chroot/usr/share/ubiquity-slideshow/slides/screenshots/welcome.png 

sudo cp -rf /usr/share/icons/BGOS-Icons /home/niki/live-ubuntu-from-scratch/chroot/usr/share/icons/BGOS

sudo cp -rf /usr/share/themes/Blue-Bgos /home/niki/live-ubuntu-from-scratch/chroot/usr/share/themes

sudo cp /usr/share/themes/Blue-Bgos/index.theme /home/niki/live-ubuntu-from-scratch/chroot/usr/share/themes/Default

sudo cp /home/niki/live-ubuntu-from-scratch/chroot/usr/share/icons/BGOS/index.theme /home/niki/live-ubuntu-from-scratch/chroot/usr/share/icons/default/index.theme

sudo mkdir  /home/niki/live-ubuntu-from-scratch/chroot/etc/skel/.icons
sudo mkdir  /home/niki/live-ubuntu-from-scratch/chroot/etc/skel/.themes
sudo cp -rf /usr/share/icons/BGOS-Icons /home/niki/live-ubuntu-from-scratch/chroot/etc/skel/.icons
sudo cp -rf /etc/skel/.themes/Blue-Bgos /home/niki/live-ubuntu-from-scratch/chroot/etc/skel/.themes
sudo cp -rf /etc/skel/.themes/index.theme /home/niki/live-ubuntu-from-scratch/chroot/etc/skel/.themes

sudo cp -rf /etc/skel/.icons/index.theme /home/niki/live-ubuntu-from-scratch/chroot/etc/skel/.icons

sudo cp -rf /etc/skel/.config /home/niki/live-ubuntu-from-scratch/chroot/etc/skel/

sudo cp -rf /usr/share/backgrounds/default-theme-bgos.png chroot/usr/share/plymouth/themes/ubuntu-mate-logo/ubuntu-mate-logo.png

sudo cp -rf /usr/share/backgrounds/default-theme-bgos.png chroot/usr/share/plymouth/themes/ubuntu-mate-logo/ubuntu-mate-logo16.png

sudo mkdir -p /home/niki/live-ubuntu-from-scratch/chroot/etc/skel/.config/autostart
sudo touch /home/niki/live-ubuntu-from-scratch/chroot/etc/skel/.config/autostart/setuptheme.desktop
sudo cp -rf /etc/skel/.config/dconf /home/niki/live-ubuntu-from-scratch/chroot/etc/skel/.config/
cat <<EOF > /home/niki/live-ubuntu-from-scratch/chroot/etc/skel/.config/autostart/setuptheme.desktop
[Desktop Entry]
Name=MATE_autostart
Comment=MATE_autostart: invokes script to start programs at login to MATE
Exec=~/.test.sh
Icon=mate-desktop
Terminal=false
Type=Application
StartupNotify=true
X-GNOME-Autostart-enabled=true
EOF

#Setup gui 
sudo cp ~/.Xauthority chroot/root/
#/etc/fstab
#add line
#/home/bullgharos       /home/niki/live-ubuntu-from-scratch/chroot/             none    rbind          0




###########################################################
#chroot
#sudo apt install gconf2

#gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.defaults --set -t string /desktop/gnome/background/picture_filename /usr/share/backgrounds/ubuntu-default-greyscale-wallpaper.png

#gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.defaults --set -t string /desktop/gnome/interface/gtk_theme Blue-Bgos



export DISPLAY=":0.0"
export XAUTHORITY=/root/.Xauthority
gnome-tweaks

gsettings set org.mate.interface gtk-theme Blue-Bgos
gsettings set org.mate.background picture-filename "/usr/share/backgrounds/ubuntu-default-greyscale-wallpaper.png"
gsettings set org.mate.interface icon-theme 'BGOS-Icons'


mkdir -p /usr/share/images/desktop-base/

update-alternatives --install /usr/share/images/desktop-base/login-background.svg desktop-login-background /usr/share/backgrounds/ubuntu-default-greyscale-wallpaper.png 0

update-alternatives --install /usr/share/images/desktop-base/background.svg desktop-background /usr/share/backgrounds/ubuntu-default-greyscale-wallpaper.png 0

cp /home/distroshare/rootfs/usr/share/glib-2.0/schemas/30_ubuntu-mate.gschema.override usr/share/glib-2.0/schemas/30_ubuntu-mate.gschema.override

###########################################################


#23. Clean up
apt-get clean

rm -rf /tmp/* ~/.bash_history

umount /proc

umount /sys

umount /dev/pts

export HISTSIZE=0

exit

#24. Unbind mount points
sudo umount $HOME/live-ubuntu-from-scratch/chroot/dev

sudo umount $HOME/live-ubuntu-from-scratch/chroot/run


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

menuentry "Install Bullgharos" {
   linux /casper/vmlinuz boot=casper only-ubiquity quiet splash ---
   initrd /casper/initrd
}

menuentry "Check disc for defects" {
   linux /casper/vmlinuz boot=casper integrity-check quiet splash ---
   initrd /casper/initrd
}

menuentry "Test memory Memtest86+ (BIOS)" {
   linux16 /install/memtest86+
}

menuentry "Test memory Memtest86 (UEFI, long load time)" {
   insmod part_gpt
   insmod search_fs_uuid
   insmod chain
   loopback loop /install/memtest86
   chainloader (loop,gpt1)/efi/boot/BOOTX64.efi
}
EOF


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


#Create ISO Image for a LiveCD (BIOS + UEFI)
#1. Access image directory
cd $HOME/live-ubuntu-from-scratch/image

#2. Create a grub UEFI image
grub-mkstandalone \
   --format=x86_64-efi \
   --output=isolinux/bootx64.efi \
   --locales="" \
   --fonts="" \
   "boot/grub/grub.cfg=isolinux/grub.cfg"

#3. Create a FAT16 UEFI boot disk image containing the EFI bootloader
(
   cd isolinux && \
   dd if=/dev/zero of=efiboot.img bs=1M count=10 && \
   sudo mkfs.vfat efiboot.img && \
   LC_CTYPE=C mmd -i efiboot.img efi efi/boot && \
   LC_CTYPE=C mcopy -i efiboot.img ./bootx64.efi ::efi/boot/
)

#4. Create a grub BIOS image
grub-mkstandalone \
   --format=i386-pc \
   --output=isolinux/core.img \
   --install-modules="linux16 linux normal iso9660 biosdisk memdisk search tar ls" \
   --modules="linux16 linux normal iso9660 biosdisk search" \
   --locales="" \
   --fonts="" \
   "boot/grub/grub.cfg=isolinux/grub.cfg"

#5. Combine a bootable Grub cdboot.img
cat /usr/lib/grub/i386-pc/cdboot.img isolinux/core.img > isolinux/bios.img

#6. Generate md5sum.txt
sudo /bin/bash -c "(find . -type f -print0 | xargs -0 md5sum | grep -v -e 'md5sum.txt' -e 'bios.img' -e 'efiboot.img' > md5sum.txt)"


#7. Create iso from the image directory using the command-line
sudo xorriso \
   -as mkisofs \
   -iso-level 3 \
   -full-iso9660-filenames \
   -volid "Bullgharos" \
   -output "../bullgharos.iso" \
   -eltorito-boot boot/grub/bios.img \
      -no-emul-boot \
      -boot-load-size 4 \
      -boot-info-table \
      --eltorito-catalog boot/grub/boot.cat \
      --grub2-boot-info \
      --grub2-mbr /usr/lib/grub/i386-pc/boot_hybrid.img \
   -eltorito-alt-boot \
      -e EFI/efiboot.img \
      -no-emul-boot \
   -append_partition 2 0xef isolinux/efiboot.img \
   -m "isolinux/efiboot.img" \
   -m "isolinux/bios.img" \
   -graft-points \
      "/EFI/efiboot.img=isolinux/efiboot.img" \
      "/boot/grub/bios.img=isolinux/bios.img" \
      "."
