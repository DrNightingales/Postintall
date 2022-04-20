# Screen size etc
sudo cp environment /etc/
sudo cp 90-monitor.conf /etc/X11/xorg.conf.d/
# Update
sudo dnf update -y
# RPM Fusion
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf groupupdate -y core
sudo dnf groupupdate -y multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf groupupdate -y sound-and-video
sudo dnf install -y rpmfusion-free-release-tainted
sudo dnf install -y libdvdcss
sudo dnf install -y rpmfusion-nonfree-release-tainted
sudo dnf install -y \*-firmware

# Codecs

sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
sudo dnf install -y lame\* --exclude=lame-devel
sudo dnf group upgrade -y --with-optional Multimedia
sudo dnf install -y vlc
 

# Arc dark
sudo dnf install -y arc-theme arc-kde papirus-icon-theme
cd ~
mkdir Apps
cd Apps
sudo dnf install -y git
git clone https://github.com/varlesh/VLC-Arc-Dark.git ;\
cd VLC-Arc-Dark ;\
sudo make install

cd ~

# oh-my-zsh
sudo dnf install -y zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# TODO auto .zshrc

# Flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub us.zoom.Zoom -y
flatpak install flathub com.github.tchx84.Flatseal -y

# Apps 
apps="krita qbittorrent gparted filelight yakuake xournal thunderbird goldendict kompare krusader microcode_ctl
pulseeffects krename rar unrar telegram-desktop xdpyinfo julia octave bleachbit anki gsmartcontrol"
for app in $apps; do
	sudo dnf install -y $app
done 

# LaTex
sudo dnf install -y texlive-scheme-full

# VS code
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
sudo dnf install code -y
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
chsh -s /bin/zsh drn
cp .zshrc ~/
