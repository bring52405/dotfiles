#!/bin/bash

if [ $(id -u) = 0 ]; then
   echo "This script changes your users gsettings and should thus not be run as root!"
   echo "You may need to enter your password multiple times!"
   exit 1
fi


while test $# -gt 0
do
    case "$1" in
        --nonfree) 
			echo "Nonfree Additions will be added"
			NONFREE=true
            ;;
        --steam) 
			echo "Adding Steam as flatpak to avoid fedora lib misaligment issues for games"
			STEAMFLAT=true
            ;;
    esac
    shift
done


###
# Optionally clean all dnf temporary files
###

sudo dnf clean all

###
# RpmFusion Free Repo
# This is holding only open source, vetted applications - fedora just cant legally distribute them themselves thanks to 
# Software patents
###

sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm 

###
# RpmFusion NonFree Repo
# This includes Nvidia Drivers and more
###

if [ ! -z "$NONFREE" ]; then
	sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
fi


###
# Disable the Modular Repos
# So far they are pretty empty, and sadly can muck with --best updates
# Reenabling them at the end for future use
###

sudo sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/fedora-updates-modular.repo
sudo sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/fedora-modular.repo


###
# Force update the whole system to the latest and greatest
###

sudo dnf upgrade --best --allowerasing --refresh -y
# And also remove any packages without a source backing them
# If you come from the Fedora 31 Future i'll check if this is still optimal before F31 comes out.
sudo dnf distro-sync -y

###
# Install base packages and applications
###

sudo dnf install \
-y \
#arc-theme `#A more comfortable GTK/Gnome-Shell Theme` \
#blender `#3D Software Powerhouse` \
#breeze-cursor-theme `#A more comfortable Cursor Theme from KDE` \
#calibre `#Ebook management` \
#chrome-gnome-shell `#Gnome <> Browser Integration for the gnome plugins website` \
#chromium-vaapi `#Comes with hardware acceleration and all Codecs` \
#darktable `#Easy RAW Editor` \
#evolution-spamassassin `#Helps you deal with spam in Evolution` \
exfat-utils `#Allows managing exfat (android sd cards and co)` \
ffmpeg `#Adds Codec Support to Firefox, and in general` \
#file-roller-nautilus `#More Archives supported in nautilus` \
#filezilla `#S/FTP Access` \
fuse-exfat `#Allows mounting exfat` \
fuse-sshfs `#Allows mounting servers via sshfs` \
#gimp `#The Image Editing Powerhouse - and its plugins` \
#gimp-data-extras \
#gimp-dbp \
#gimp-dds-plugin \
#gimp-elsamuko \
#gimp-focusblur-plugin \
#gimp-fourier-plugin \
#gimpfx-foundry.noarch \
#gimp-gap \
#gimp-high-pass-filter \
#gimp-layer-via-copy-cut \
#gimp-lensfun \
#gimp-lqr-plugin \
#gimp-luminosity-masks \
#gimp-paint-studio \
#gimp-resynthesizer \
#gimp-save-for-web \
#gimp-wavelet-decompose \
#gimp-wavelet-denoise-plugin \
git `#VCS done right` \
#gmic-gimp \
#gnome-shell-extension-dash-to-dock `#dash for gnome` \
#gnome-shell-extension-topicons-plus `#Notification Icons for gnome` \
#gnome-shell-extension-user-theme `#Enables theming the gnome shell` \
#gnome-tweak-tool `#Your central place to make gnome like you want` \
#GREYCstoration-gimp \
#gtkhash-nautilus `#To get a file has via gui` \
#gvfs-fuse `#gnome<>fuse` \
#gvfs-mtp `#gnome<>android` \
#gvfs-nfs `#gnome<>ntfs` \
#gvfs-smb `#gnome<>samba` \
htop `#Cli process monitor` \
#inkscape  `#Working with .svg files` \
#kdenlive  `#Advanced Video Editor` \
#keepassxc  `#Password Manager` \
#krita  `#Painting done right keep in mind mypaint and gimp cant work together in current upstream versions - yet` \
#libreoffice-gallery-vrt-network-equipment `#Network Icon Preset for LibreOffice` \
lm_sensors `#Show your systems Temparature` \
'mozilla-fira-*' `#A nice font family` \
mpv `#The best media player (with simple gui)` \
mumble `#Talk with your friends` \
#nautilus-extensions `#What it says on the tin` \
#nautilus-image-converter \
#nautilus-search-tool \
#NetworkManager-openvpn-gnome `#To enforce that its possible to import .ovpn files in the settings` \
#openshot `#Simple Video Editor` \
openssh-askpass `#Base Lib to let applications request ssh pass via gui` \
p7zip `#Archives` \
p7zip-plugins `#Even more of them` \
papirus-icon-theme `#A quite nice icon theme` \
pv `#pipe viewer - see what happens between the | with output | pv | receiver ` \
python3-devel `#Python Development Gear` \
python3-neovim `#Python Neovim Libs` \
#rawtherapee `#Professional RAW Editor` \
#spamassassin `#Dep to make sure it is locally installed for Evolution` \
telegram-desktop `#Chatting, with newer openssl and qt base!` \
#tilix `#The best terminal manager i know of` \
#tilix-nautilus `#Adds right click open in tilix to nautilus` \
transmission `#Torrent Client` \
tuned `#Tuned can optimize your performance according to metrics. tuned-adm profile powersave can help you on laptops, alot` \
unar `#free rar decompression` \
vagrant `#Virtual Machine management and autodeployment` \
vagrant-libvirt `#integration with libvirt` \
virt-manager `#A gui to manage virtual machines` \
wavemon `#a cli wifi status tool` \
youtube-dl `#Allows you to download and save youtube videos but also to open their links by dragging them into mpv!` \
ansible `#Awesome to manage multiple machines or define states for systems` \
adobe-source-code-pro-fonts `#The most beautiful monospace font around` \
borgbackup `#If you need backups, this is your tool for it` \
gitg `#a gui for git, a little slow on larger repos sadly` \
iotop  `#disk usage cli monitor` \
meld `#Quick Diff Tool` \
nano `#Because pressing i is too hard sometimes` \
neovim `#the better vim` \
nethogs `#Whats using all your traffic? Now you know!` \
nload `#Network Load Monitor` \
tig `#cli git tool` \
vim-enhanced `#full vim` \
zsh `#Best shell` \
zsh-syntax-highlighting `#Now with syntax highlighting` \
cantata `#A beautiful mpd control` \
#caddy `#A quick webserver that can be used to share a directory with others in <10 seconds` \
cockpit `#A An awesome local and remote management tool` \
cockpit-bridge \
fortune-mod `#Inspiring Quotes` \
hexchat `#Irc Client` \
libguestfs-tools `#Resize Vm Images and convert them` \
ncdu `#Directory listing CLI tool. For a gui version take a look at "baobab"` \
nextcloud-client `#Nextcloud Integration for Fedora` \
#nextcloud-client-nautilus `#Also for the File Manager, shows you file status` \
sqlite-analyzer `#If you work with sqlite databases` \
sqlitebrowser `#These two help alot` \
syncthing-gtk `#Syncing evolved - to use the local only mode open up the ports with firewall-cmd --add-port=port/tcp --permanent && firewall-cmd --reload` \
feh `#bckground imaging tool` \
openbox \
xbacklight \
feh \
conky \
xorg-x11-drv-libinput \
tint2 \
volumeicon \
xorg-x11-server-utils \
network-manager-applet \
lightdm

###
# Remove some un-needed stuff
###

sudo dnf remove \
-y \
gnome-shell-extension-background-logo `#Tasteful but nah` \
totem `#With mpv installed totem became a little useless` \
chromium `#Using Chromium resets chromium-vaapi so remove it if installed, userprofiles will be kept and can be used in -vaapi` \
flowblade `#Sadly has really outdated mlt dependencies`


###
# Enable some of the goodies, but not all
# Its the users responsibility to choose and enable zsh, with oh-my-zsh for example
# or set a more specific tuned profile
###
sudo systemctl enable lightdm
sudo systemctl enable --now tuned
sudo tuned-adm profile balanced

#Performance:
#sudo tuned-adm profile desktop

#Virtual Machine Host:
#sudo tuned-adm profile virtual-host

#Virtual Machine Guest:
#sudo tuned-adm profile virtual-guest

#Battery Saving:
#sudo tuned-adm profile powersave

# Virtual Machines
#sudo systemctl enable --now libvirtd

# Management of local/remote system(s) - available via http://localhost:9090
sudo systemctl enable --now cockpit.socket

###
# Theming and GNOME Options
###
# OpenBox Configuring
touch ~/.config/openbox/autostart

# Set desktop wallpaper:
#feh --bg-scale ~/path/to/wallpaper.png &


# Steam games (32bit) have issues with the too new 32bit compat libs in fedora
# Flatpak is the better option here
if [ ! -z "$STEAMFLAT" ]; then
	sudo dnf install -y flatpak
	sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak -y install flathub com.valvesoftware.Steam
	# Installed but not displayed? Check with: flatpak run com.valvesoftware.Steam
fi


###
# These will be more used in the future by some maintainers
# Reenabling them just to make sure.
###

sudo sed -i '0,/enabled=0/s/enabled=0/enabled=1/g' /etc/yum.repos.d/fedora-updates-modular.repo
sudo sed -i '0,/enabled=0/s/enabled=0/enabled=1/g' /etc/yum.repos.d/fedora-modular.repo

#The user needs to reboot to apply all changes.
echo "Please Reboot" && exit 0
