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

cat <<EOF > /etc/skel/.config/autostart/setuptheme.desktop
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

#End step 1
echo "End step 1"
