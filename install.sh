#!/bin/bash
set -eux

sudo usermod -aG input popovms

sudo apt update
sudo apt install -y \
    tree diffutils git ssh curl wget \
    build-essential net-tools fontconfig \
    python3-dev python3-venv pipx \
    wayland-protocols xwayland xdg-desktop-portal-wlr wl-clipboard \
    seatd acpid thermald greetd libxkbcommon-tools \
    sway swaybg swayidle swaylock \
    chromium mpv gedit foot waybar dunst fuzzel \
    breeze-gtk-theme papirus-icon-theme xfce4-settings \
    blueman pavucontrol gammastep wob pamixer \
    network-manager network-manager-gnome network-manager-openvpn \
    thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman \
    qemu-system libvirt-daemon-system virt-manager

pipx install poetry
pipx install termdown

curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
tar --one-top-level -xJf ./JetBrainsMono.tar.xz
sudo mkdir -p /usr/share/fonts
sudo cp ./JetBrainsMono/*.ttf /usr/share/fonts
sudo fc-cache -f -v /usr/share/fonts
rm -rf JetBrainsMono.tar.xz JetBrainsMono

sudo mkdir -p /usr/local/bin
sudo cp -f ./start-sway /usr/local/bin/start-sway
sudo chmod 0755 /usr/local/bin/start-sway

sudo mkdir -p /etc/greetd
sudo cp -f ./greetd.toml /etc/greetd/config.toml

sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply SegFaulti4
rm -rf ./bin

