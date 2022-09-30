#!/bin/bash

sudo cp ./pictures/backgrounds/default-theme-bgos.png $HOME/live-ubuntu-from-scratch/chroot/usr/share/backgrounds/default-theme-bgos.png

sudo cp ./pictures/backgrounds/plymouth_background_future.png $HOME/live-ubuntu-from-scratch/chroot/usr/share/backgrounds/mate/desktop/bgos.png

sudo cp ./pictures/backgrounds/Float-into-BGOS.png $HOME/live-ubuntu-from-scratch/chroot/usr/share/backgrounds/warty-final-ubuntu.png 

sudo cp ./pictures/backgrounds/light_blue_moon.png $HOME/live-ubuntu-from-scratch/chroot/usr/share/ubiquity-slideshow/slides/screenshots/welcome.png 

sudo cp -rf ./pictures/icons/BGOS-Icons $HOME/live-ubuntu-from-scratch/chroot/usr/share/icons/

sudo cp -rf /usr/share/themes/Blue-Bgos $HOME/live-ubuntu-from-scratch/chroot/usr/share/themes

sudo cp /usr/share/themes/Blue-Bgos/index.theme $HOME/live-ubuntu-from-scratch/chroot/usr/share/themes/Default

sudo cp $HOME/live-ubuntu-from-scratch/chroot/usr/share/icons/BGOS-Icons/index.theme $HOME/live-ubuntu-from-scratch/chroot/usr/share/icons/default/index.theme

sudo mkdir  $HOME/live-ubuntu-from-scratch/chroot/etc/skel/.icons
sudo mkdir  $HOME/live-ubuntu-from-scratch/chroot/etc/skel/.themes
sudo cp -rf ./pictures/icons/BGOS-Icons $HOME/live-ubuntu-from-scratch/chroot/etc/skel/.icons
sudo cp -rf /etc/skel/.themes/Blue-Bgos $HOME/live-ubuntu-from-scratch/chroot/etc/skel/.themes
sudo cp -rf /etc/skel/.themes/index.theme $HOME/live-ubuntu-from-scratch/chroot/etc/skel/.themes

sudo cp -rf /etc/skel/.icons/index.theme $HOME/live-ubuntu-from-scratch/chroot/etc/skel/.icons

sudo cp -rf /etc/skel/.config $HOME/live-ubuntu-from-scratch/chroot/etc/skel/

sudo cp -rf ./pictures/backgrounds/default-theme-bgos.png $HOME/live-ubuntu-from-scratch/chroot/usr/share/plymouth/themes/ubuntu-mate-logo/ubuntu-mate-logo.png

sudo cp -rf ./pictures/backgrounds/default-theme-bgos.png $HOME/live-ubuntu-from-scratch/chroot/usr/share/plymouth/themes/ubuntu-mate-logo/ubuntu-mate-logo.png

sudo cp -rf ./pictures/backgrounds/background.svg $HOME/live-ubuntu-from-scratch/chroot/usr/share/desktop-base/active-theme/login/background.svg

sudo cp -rf ./pictures/logos/BGOS.png $HOME/live-ubuntu-from-scratch/chroot/usr/share/desktop-base/active-theme/plymouth/logo.png

sudo cp -rf ./pictures/logos/BGOS.png $HOME/live-ubuntu-from-scratch/chroot/usr/share/desktop-base/active-theme/plymouth/debian.png

sudo mkdir -p $HOME/live-ubuntu-from-scratch/chroot/etc/skel/.config/autostart
sudo touch $HOME/live-ubuntu-from-scratch/chroot/etc/skel/.config/autostart/setuptheme.desktop

cat <<EOF > $HOME/live-ubuntu-from-scratch/chroot/etc/skel/.config/autostart/setuptheme.desktop
[Desktop Entry]
Name=MATE_autostart
Comment=MATE_autostart: invokes script to start programs at login to MATE
Exec=mate-terminal
Icon=mate-desktop
Terminal=false
Type=Application
StartupNotify=true
X-GNOME-Autostart-enabled=true
EOF

sudo touch $HOME/live-ubuntu-from-scratch/chroot/etc/skel/.set-theme.sh

cat <<EOF > $HOME/live-ubuntu-from-scratch/chroot/etc/skel/.set-theme.sh
#!/bin/bash

gsettings set org.mate.interface gtk-theme Blue-Bgos
gsettings set org.mate.background picture-filename "/usr/share/backgrounds/default-theme-bgos.png"
gsettings set org.mate.interface icon-theme 'BGOS-Icons'

sed -i 's/\/bin\/bash ~\/\.set-theme.sh/#/g' ~/.bashrc
rm -rf ~/.config/autostart/setuptheme.desktop
exit 0


#End step 1 Preparation
echo "End step 1 Preparation"
