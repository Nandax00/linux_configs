# Linux Files

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
yay -S dhcpcd sshd i3 i3-wm xorg-xinit xorg-server iftop pipewire \
pipewire-alsa pipewire-pulse pipewire-media-session
# I3
yay -S playerctl alsa-utils sysstat xkb-switch lm-sensors picom
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

## I3

Setup Xorg:

```bash
cp /etc/X11/xinit/xinitrc ~/.xinitrc
```

Modify last line of `~/.xinitrc` to be:

```bash
exec /usr/bin/i3
```

Now I3 can be started via:

```bash
startx
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
ln -s /home/nandax/tools/linux_configs/.gitconfig /home/nandax/.gitconfig
ln -s /home/nandax/tools/linux_configs/init.lua /home/nandax/.config/nvim/init.lua
ln -s /home/nandax/tools/linux_configs/nvim_plugin_setup.lua /home/nandax/.config/nvim/lua/nvim_plugin_setup.lua
ln -s /home/nandax/tools/linux_configs/.zshrc /home/nandax/.zshrc
ln -s /home/nandax/tools/linux_configs/i3_config /home/nandax/.config/i3/config
ln -s /home/nandax/tools/linux_configs/i3blocks_config /home/nandax/.config/i3blocks/config
ln -s /home/nandax/tools/linux_configs/alacritty.toml /home/nandax/.config/alacritty/alacritty.toml
```

### Complete the setup of LSPs

```bash
:MasonInstall autopep8 clangd clang-format json-lsp lua-language-server marksman python-lsp-server rust-analyzer vim-language-server
```
