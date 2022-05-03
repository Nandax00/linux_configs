zstyle :compinstall filename '/home/nandax/.zshrc'

autoload -Uz compinit
compinit

export CINEMO_TOOLCHAINS=/opt/cinemo/toolchains
HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000
unsetopt beep
setopt PROMPT_SUBST

alias ls='ls --color=auto'
alias ll='ls -lah'
alias remote='pip install -i \
    https://artifactory.internal.cinemo.com/artifactory/api/pypi/pypi/simple \
    --find-links ../robot/target_lib/whls/dist ../robot/target_lib \
    ../robot/host_lib && ../robot/scripts/remote/remote.sh'
alias s_venv='s_venv38'
alias s_venv38='source ./.env38/bin/activate'
alias s_venv310='source ./.env310/bin/activate'
alias g_venv38='python3.8 -m venv ./.env38 && s_venv'
alias g_venv310='python3.10 -m venv ./.env310 && s_venv310'
alias r='cd ~/repos/robot'
alias t='cd ~/repos/tests'
alias c='cd ~/repos/cinemo'
alias cs='cd ~/repos/cinemo/src'
alias ca='cd ~/repos/cinemo-audio'
alias gs='git status'
alias cal='cal -m'

bindkey -v
bindkey '^R' history-incremental-search-backward
bindkey 'jk' vi-cmd-mode

mkcd() {
    mkdir $1
    cd $1
}

parse_git_branch() {
    git symbolic-ref --short HEAD 2> /dev/null
}

PS1='%f[%F{yellow}%?%f] %F{red}%n%F{cyan}@%F{red}%m %F{cyan}> %f'
RPS1='%f[%F{yellow}$(parse_git_branch)%f] %F{green}%~'
