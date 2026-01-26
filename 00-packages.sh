#!/bin/bash
set -eux

# install packages
sudo apt update
sudo apt -y upgrade
sudo apt install -y \
    wayland-protocols xwayland xdg-desktop-portal-wlr libxkbcommon-tools \
    seatd acpid thermald greetd \
    sway swaybg swayidle swaylock \
    foot waybar dunst fuzzel micro \
    pavucontrol gammastep wob pamixer brightnessctl \
    wl-clipboard clipman grim wf-recorder slurp wayvnc wev \
    chromium gedit mpv viewnior blueman keepassxc speech-dispatcher flatpak \
    thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman \
    papirus-icon-theme fontconfig libglib2.0-bin fonts-noto-color-emoji \
    qt6-gtk-platformtheme qt5-gtk-platformtheme \
    net-tools ca-certificates curl wget apt-transport-https \
    build-essential git ssh tree diffutils btm gvfs-backends \
    ffmpeg 7zip jq poppler-utils fd-find ripgrep fzf zoxide imagemagick \
    cups cups-client cups-bsd system-config-printer simple-scan \
    qmk python3-dev python3-venv python3-pylsp pipx

sudo install -m 0755 -d /etc/apt/keyrings
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# add user to groups
sudo usermod -aG lpadmin popovms
