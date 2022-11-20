#!/bin/bash

sudo cp ./pictures/backgrounds/default-theme-bgos.png $HOME/live-ubuntu-from-scratch/chroot/usr/share/backgrounds/default-theme-bgos.png

sudo cp ./pictures/backgrounds/plymouth_background_future_base.png $HOME/live-ubuntu-from-scratch/chroot/usr/share/backgrounds/mate/desktop/bgos.png

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

sudo mkdir -p $HOME/live-ubuntu-from-scratch/chroot/usr/share/desktop-base/active-theme/login/
sudo mkdir -p $HOME/live-ubuntu-from-scratch/chroot/usr/share/desktop-base/active-theme/plymouth/
sudo mkdir -p $HOME/live-ubuntu-from-scratch/chroot/usr/share/desktop-base/active-theme/plymouth/

sudo cp -rf ./pictures/backgrounds/background.svg $HOME/live-ubuntu-from-scratch/chroot/usr/share/desktop-base/active-theme/login/background.svg

sudo cp -rf ./pictures/logos/BGOS.png $HOME/live-ubuntu-from-scratch/chroot/usr/share/desktop-base/active-theme/plymouth/logo.png

sudo cp -rf ./pictures/logos/BGOS.png $HOME/live-ubuntu-from-scratch/chroot/usr/share/desktop-base/active-theme/plymouth/debian.png

sudo cp /usr/bin/neofetch $HOME/live-ubuntu-from-scratch/chroot/usr/bin/neofetch

sudo cp -r ./autostart $HOME/live-ubuntu-from-scratch/chroot/etc/skel/.config/

sudo chmod 777 $HOME/live-ubuntu-from-scratch/chroot/etc/lsb-release
sudo cat <<EOF > $HOME/live-ubuntu-from-scratch/chroot/etc/lsb-release
DISTRIB_ID=Bullgharos
DISTRIB_RELEASE=1
DISTRIB_CODENAME=focal
DISTRIB_DESCRIPTION="BullGharOS 1 LTS"
EOF

sudo chmod 644 $HOME/live-ubuntu-from-scratch/chroot/etc/lsb-release

sudo chmod 777 $HOME/live-ubuntu-from-scratch/chroot/etc/os-release
sudo cat <<EOF > $HOME/live-ubuntu-from-scratch/chroot/etc/os-release
NAME="Bullgharos"
VERSION="1 LTS (Focal Fossa)"
ID=Bullgharos
ID_LIKE=debian
PRETTY_NAME="BullGharOS LTS"
VERSION_ID="1"
HOME_URL="https://www.bullgharos.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=focal
UBUNTU_CODENAME=focal
EOF

sudo chmod 644 $HOME/live-ubuntu-from-scratch/chroot/etc/os-release

sudo touch $HOME/live-ubuntu-from-scratch/chroot/etc/skel/.set-theme.sh

sudo chmod 777 $HOME/live-ubuntu-from-scratch/chroot/etc/skel/.set-theme.sh

cat <<EOF > $HOME/live-ubuntu-from-scratch/chroot/etc/skel/.set-theme.sh
#!/bin/bash

gsettings set org.mate.interface gtk-theme Blue-Bgos
gsettings set org.mate.background picture-filename "/usr/share/backgrounds/default-theme-bgos.png"
gsettings set org.mate.interface icon-theme 'BGOS-Icons'

sed -i 's/\/bin\/bash ~\/\.set-theme.sh/#/g' ~/.bashrc
rm -rf ~/.config/autostart/setuptheme.desktop
exit 0
EOF

sudo cp desktop-env/bin/bullgharos_de.sh $HOME/live-ubuntu-from-scratch/chroot/bin/
sudo cp desktop-env/usr/share/xsessions/bullgharos_de.desktop $HOME/live-ubuntu-from-scratch/chroot/usr/share/xsessions/
sudo cp desktop-env/.spectrwm.conf $HOME/live-ubuntu-from-scratch/chroot/etc/skel/
sudo cp -rf desktop-env/tint2 $HOME/live-ubuntu-from-scratch/chroot/etc/skel/.config

#End step 1 Preparation
echo "End step 1 Preparation"

