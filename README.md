#VIM Files

Dependencies for i3blocks_config:
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

