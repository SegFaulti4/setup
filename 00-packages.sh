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
    wl-clipboard grim wf-recorder slurp wayvnc \
    chromium gedit mpv viewnior blueman keepassxc \
    thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman \
    papirus-icon-theme fontconfig libglib2.0-bin fonts-noto-color-emoji \
    qt6-gtk-platformtheme qt5-gtk-platformtheme \
    net-tools ca-certificates curl wget apt-transport-https \
    build-essential git ssh tree diffutils \
    ffmpeg 7zip jq poppler-utils fd-find ripgrep fzf zoxide imagemagick \
    qmk python3-dev python3-venv pipx

sudo install -m 0755 -d /etc/apt/keyrings
