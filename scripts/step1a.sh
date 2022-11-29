
#2. Configure mount points, home and locale
mount none -t proc /proc

mount none -t sysfs /sys

mount none -t devpts /dev/pts

export HOME=/root

export LC_ALL=C

#3. Set a custom hostname
cat <<EOF > /etc/hostname
bullgharos 
EOF

#3.1 Set hosts
touch /etc/hosts
cat <<EOF > /etc/hosts
127.0.0.1       localhost
127.0.0.1       bullgharos

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
EOF

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
#apt-get -y upgrade

#9. Install packages needed for Live System
#apt-get install -y \
#    sudo \
#    ubuntu-minimal \
#    casper \
#    lupin-casper \
#    discover \
#    laptop-detect \
#    os-prober \
#    network-manager \
#    resolvconf \
#    net-tools \
#    wireless-tools \
#    wpagui \
#    locales \
#    grub-common \
#    grub-gfxpayload-lists \
#    grub-pc \
#    grub-pc-bin \
#    grub2-common \
#    linux-firmware \
#    epiphany-browser \
#    spectrwm \
#    tint2
    
#apt-get install -y \
#    mate-backgrounds \
#    mate-indicator-applet \
#    bcmwl-kernel-source \
#    broadcom-sta-common \
#    broadcom-sta-source \
#    b43-fwcutter \
#    firmware-b43-installer \
#    wpasupplicant \
#    wpagui 

#apt-get install -y libqt5core5a \
#    libqt53dcore5
    
apt-get install -y --no-install-recommends linux-generic

#10. Graphical installer Ubiquity
apt-get install -y \
   ubiquity \
   ubiquity-casper \
   ubiquity-frontend-gtk \
   ubiquity-slideshow-ubuntu-mate \
   ubiquity-ubuntu-artwork --no-install-recommends
   
#10.1 Graphical installer Calamares
   apt-get install -y \
   calamares \
   calamares-settings-lubuntu --no-install-recommends
   
   
#11. Install window manager
#apt-get install -y \
#    plymouth-theme-ubuntu-mate-logo \
#    ubuntu-mate-desktop \
#    ubuntu-mate-wallpapers \
#    gnome-tweaks --no-install-recommends
    
#apt-get remove ubuntu-session
    
#12. Install useful applications
apt-get install -y \
    clamav-daemon \
    terminator \
    apt-transport-https \
    curl \
    vim \
    nano \
    less --no-install-recommends
    
#13. Install joe editor
apt-get install -y joe

#14. Then update the package cache and install the package using
#apt-get update

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

#23. Clean up
apt-get clean

rm -rf /tmp/* ~/.bash_history

umount /proc

umount /sys

umount /dev/pts

export HISTSIZE=0

exit
