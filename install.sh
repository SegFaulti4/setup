#!/bin/bash
set -eux

# enable vial support
sudo usermod -aG input popovms
export USER_GID=`id -g`; sudo --preserve-env=USER_GID sh -c 'echo "KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\", ATTRS{serial}==\"*vial:f64c2b3c*\", MODE=\"0660\", GROUP=\"$USER_GID\", TAG+=\"uaccess\", TAG+=\"udev-acl\"" > /etc/udev/rules.d/99-vial.rules && udevadm control --reload && udevadm trigger'

# install common packages
sudo apt update
sudo apt upgrade
sudo apt install -y \
    tree diffutils git ssh curl wget apt-transport-https  \
    build-essential net-tools fontconfig ca-certificates \
    python3-dev python3-venv pipx \
    wayland-protocols xwayland xdg-desktop-portal-wlr wl-clipboard \
    seatd acpid thermald greetd libxkbcommon-tools \
    sway swaybg swayidle swaylock \
    chromium mpv gedit foot waybar dunst fuzzel \
    breeze-gtk-theme papirus-icon-theme xfce4-settings \
    blueman pavucontrol gammastep wob pamixer \
    network-manager network-manager-gnome network-manager-openvpn \
    thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman \
    qemu-system libvirt-daemon-system virt-manager \
    grim wf-recorder slurp vlc viewnior \
    keepassxc
sudo install -m 0755 -d /etc/apt/keyrings

# install fonts
tar --one-top-level -xJf ./JetBrainsMono.tar.xz
sudo mkdir -p /usr/share/fonts
sudo cp ./JetBrainsMono/*.ttf /usr/share/fonts
sudo fc-cache -f -v /usr/share/fonts
rm -rf JetBrainsMono

# add sway launch script
sudo mkdir -p /usr/local/bin
sudo cp -f ./start-sway /usr/local/bin/start-sway
sudo chmod 0755 /usr/local/bin/start-sway

# apply greetd config
sudo mkdir -p /etc/greetd
sudo cp -f ./greetd.toml /etc/greetd/config.toml

# install dotfiles
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin init --apply SegFaulti4


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

