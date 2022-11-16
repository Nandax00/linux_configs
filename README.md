#Linux Files

## General recommendations on fresh install

Replace i3-gaps with i3-wm.
```bash
pacman -S dhcpcd sshd i3 i3-wm xorg-xinit xorg-server iftop
# Check name of wired/wireless interface
ip a
# Wired
sudo systemctl start dhcpcd@<interface>
# Wireless
pacman -S iwd
sudo systemctl start iwd
```

## Zsh

```bash
chsh -s /usr/bin/zsh
ln -s <path_to_Linux_Files_repo>/.zshrc ~/.zshrc
```

## Yay

```bash
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

## I3

Install GPU drivers based on [Xorg ArchWiki](https://wiki.archlinux.org/title/Xorg#Driver_installation)
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

### Dependencies for i3blocks_config:
```bash
yay -S playerctl alsa-utils sysstat xkb-switch
```

## .vimrc

### Create `init.vim` file for nvim:

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

### Dependencies for .vimrc:
```bash
yay -S vim-youcompleteme-git python-pip
pip install pynvim
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
git clone git@github.com:sainnhe/gruvbox-material.git ~/.vim/bundle/gruvbox-material
git clone https://github.com/itchyny/lightline.vim ~/.vim/bundle/lightline
git clone --recurse-submodules https://github.com/python-mode/python-mode.git ~/.vim/bundle/python-mode
```

