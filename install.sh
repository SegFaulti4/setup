#!/bin/bash
set -eux

# install packages
sudo apt update
sudo apt upgrade
sudo apt install -y \
    wayland-protocols xwayland xdg-desktop-portal-wlr libxkbcommon-tools \
    seatd acpid thermald greetd \
    sway swaybg swayidle swaylock \
    foot waybar dunst fuzzel micro \
    pavucontrol gammastep wob pamixer \
    wl-clipboard grim wf-recorder slurp \
    chromium gedit mpv viewnior blueman keepassxc \
    network-manager network-manager-gnome network-manager-openvpn \
    thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman \
    papirus-icon-theme fontconfig libglib2.0-bin \
    net-tools ca-certificates curl wget apt-transport-https \
    build-essential git ssh tree diffutils \
    ffmpeg 7zip jq poppler-utils fd-find ripgrep fzf zoxide imagemagick \
    python3-dev python3-venv pipx

sudo install -m 0755 -d /etc/apt/keyrings


# add sway launch script
sudo mkdir -p /usr/local/bin
sudo cp -f ./start-sway /usr/local/bin/start-sway
sudo chmod 0755 /usr/local/bin/start-sway

# apply greetd config
sudo mkdir -p /etc/greetd
sudo cp -f ./greetd.toml /etc/greetd/config.toml

# install dotfiles
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin init --apply SegFaulti4

# install fonts
sudo fc-cache -f -v /home/popovms/.local/share/fonts

# enable vial support
sudo usermod -aG input popovms
export USER_GID=`id -g`; sudo --preserve-env=USER_GID sh -c 'echo "KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\", ATTRS{serial}==\"*vial:f64c2b3c*\", MODE=\"0660\", GROUP=\"$USER_GID\", TAG+=\"uaccess\", TAG+=\"udev-acl\"" > /etc/udev/rules.d/99-vial.rules && udevadm control --reload && udevadm trigger'


# add docker key
sudo rm -f /etc/apt/keyrings/docker.asc
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# add docker repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# install docker
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# docker post-install steps
sudo groupadd -f docker
MY_USER=$USER && sudo usermod -aG docker $MY_USER


# add openvpn3 key
sudo rm -f /etc/apt/keyrings/openvpn.asc
sudo curl -sSfL https://packages.openvpn.net/packages-repo.gpg -o /etc/apt/keyrings/openvpn.asc

# add openvpn3 repository
echo "deb [signed-by=/etc/apt/keyrings/openvpn.asc] https://packages.openvpn.net/openvpn3/debian $(. /etc/os-release && echo "$VERSION_CODENAME") main" | sudo tee /etc/apt/sources.list.d/openvpn3.list > /dev/null

# install openvpn3
sudo apt update
sudo apt install -y openvpn3-client
