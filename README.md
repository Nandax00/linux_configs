# Linux Files

Clone this repository to /home/nandax/.config. Tracks many important
configuration files. Only a few has to be linked to other places, many are
already in the right location.

## General recommendations on fresh install

### Networking setup

```bash
# Check name of wired/wireless interface
ip a
# Wired
sudo systemctl start dhcpcd@<interface>
# Wireless, NOTE: Do in the installer, so that the laptop has internet connection
pacman -S iwd
sudo systemctl start iwd
```

### Yay

```bash
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

### Dependencies of various tools

```bash
yay -S dhcpcd sshd iftop pipewire pipewire-alsa pipewire-pulse\
    pipewire-media-session
# sway and Wayland deps
yay -S sway playerctl alsa-utils sysstat i2c-tools wl-clipboard\
    xdg-desktop-portal-wlr xdg-desktop-portal grim bemenu xorg-xwayland\
    swaylock swaybg swayidle swaync swayimg wmenu foot polkit waybar wayvnc\
    kanshi brightnessctl nwg-look slurp
# zsh
yay -S zsh-completions zsh-syntax-highlighting
# alacritty
yay -S alacritty ttf-fira-mono
```

Install GPU drivers based on [Xorg ArchWiki](https://wiki.archlinux.org/title/Xorg#Driver_installation)

## Zsh

```bash
chsh -s /usr/bin/zsh
```

## Sway

Set up [sway-specific daemons](https://wiki.archlinux.org/title/Sway#Manage_Sway-specific_daemons_with_systemd).

Sway can be started via:

```bash
sway
```

### Set up kanshi to automatically manage multiple display configs

Create a config file at ~/.config/kanshi/config, it can contain the separate
configs like so:
```bash
profile {
    output eDP-1
    output HDMI-A-2
}
profile {
    ...
}
...
```
the `output` commands are all calls to sway-output, so all the arguments are
supported, such as scale.

#### Optionally set up a kanshi service

Follow the [instructions on ArchWiki](https://wiki.archlinux.org/title/Kanshi#Manage_kanshi_with_systemd).

```bash
systemctl --user enable kanshi
systemctl --user start kanshi
```

### Set up swayidle service to manage idle logic

```bash
systemctl --user enable swayidle.service
systemctl --user start swayidle.service
```

## NeoVim

### Install dependencies

```bash
yay -S python-pip python-jedi jedi-language-server npm
```

### Create directory structure for nvim

```bash
mkdir -p ~/.config/nvim/lua/plugins
```

## Link configs

```bash
ln -s /home/nandax/.config/other/.gitconfig /home/nandax/.gitconfig
ln -s /home/nandax/.config/other/.zshrc /home/nandax/.zshrc
ln -s /home/nandax/.config/other/.zprofile /home/nandax/.zprofile
```

### Complete the setup of LSPs

```bash
:MasonInstall autopep8 clangd clang-format json-lsp lua-language-server marksman python-lsp-server rust-analyzer vim-language-server
```
