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
yay -S playerctl alsa-utils sysstat xkb-switch lm-sensors
# zsh
yay -S zsh-completions zsh-syntax-highlighting
# kitty
yay -S kitty ttf-jetbrains-mono-nerd
# Neovim
yay -S python-pip python-jedi npm jedi-language-server clang
```

Install GPU drivers based on [Xorg ArchWiki](https://wiki.archlinux.org/title/Xorg#Driver_installation)

## Kitty


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
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
git clone git@github.com:sainnhe/gruvbox-material.git ~/.vim/bundle/gruvbox-material
git clone https://github.com/itchyny/lightline.vim ~/.vim/bundle/lightline
git clone -b release https://github.com/neoclide/coc.nvim ~/.vim/bundle/coc.nvim
```

### Create `init.vim` file for nvim

```bash
mkdir -p ~/.config/nvim
vim ~/.config/nvim/init.vim
```

`init.vim` has the following content:

```bash
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
```

### Complete the setup of COC

```bash
:CocInstall coc-clangd coc-jedi coc-json coc-markdownlint
```

## Link configs

```bash
ln -s <path_to_Linux_Files_repo>/.gitconfig ~/.gitconfig
ln -s <path_to_Linux_Files_repo>/.vimrc ~/.vimrc
ln -s <path_to_Linux_Files_repo>/.zshrc ~/.zshrc
ln -s <path_to_Linux_Files_repo>/coc-settings.json ~/.config/nvim/coc-settings.json
ln -s <path_to_Linux_Files_repo>/gruvbox_dark.conf ~/.config/kitty/gruvbox_dark.conf
ln -s <path_to_Linux_Files_repo>/i3_config ~/.config/i3/config
ln -s <path_to_Linux_Files_repo>/i3blocks_config ~/.config/i3blocks/config
ln -s <path_to_Linux_Files_repo>/kitty.conf ~/.config/kitty/kitty.conf
```

Note that all other configs which do not start with a "." are located under
`~/.config` by default
