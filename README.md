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
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
git clone git@github.com:sainnhe/gruvbox-material.git ~/.vim/bundle
git clone git@github.com:itchyny/lightline.vim.git ~/.vim/bundle
git clone git@github.com:aklt/plantuml-syntax.git ~/.vim/bundle
git clone git@github.com:williamboman/mason.nvim.git
git clone git@github.com:nvim-lua/plenary.nvim.git ~/.vim/bundle
git clone git@github.com:nvim-telescope/telescope.nvim.git ~/.vim/bundle
git clone git@github.com:nvim-telescope/telescope-fzf-native.nvim.git ~/.vim/bundle
git clone git@github.com:neovim/nvim-lspconfig.git ~/.vim/bundle
git clone git@github.com:ms-jpq/coq_nvim.git ~/.vim/bundle
```

### Create directory structure for nvim

```bash
mkdir -p ~/.config/nvim/lua
```


## Link configs

```bash
ln -s <path_to_Linux_Files_repo>/.gitconfig ~/.gitconfig
ln -s <path_to_Linux_Files_repo>/.vimrc ~/.vimrc
ln -s <path_to_Linux_Files_repo>/init.vim ~/.config/nvim/init.vim
ln -s <path_to_Linux_Files_repo>/init.lua ~/.config/nvim/lua/init.lua
ln -s <path_to_Linux_Files_repo>/.zshrc ~/.zshrc
ln -s <path_to_Linux_Files_repo>/gruvbox_dark.conf ~/.config/kitty/gruvbox_dark.conf
ln -s <path_to_Linux_Files_repo>/i3_config ~/.config/i3/config
ln -s <path_to_Linux_Files_repo>/i3blocks_config ~/.config/i3blocks/config
ln -s <path_to_Linux_Files_repo>/alacritty.toml ~/.config/alacritty/alacritty.toml
```

Note that all other configs which do not start with a "." are located under
`~/.config` by default

### Complete the setup of LSPs

```bash
:MasonInstall clangd clang-format jedi-language-server json-lsp marksman rust-analyzer
:COQdeps
```
