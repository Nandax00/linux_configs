zstyle :compinstall filename '/home/nandax/.zshrc'

autoload -Uz compinit promptinit
compinit
promptinit

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

prompt_theme_setup() {
    parse_git_branch() {
        git symbolic-ref --short HEAD 2> /dev/null
    }
    PS1='%f[%F{yellow}%?%f] %F{red}%n%F{cyan}@%F{red}%m %F{cyan}> %f'
    RPS1='%f[%F{yellow}$(parse_git_branch)%f] %F{green}%~'
}

prompt_themes+=( theme )
prompt theme

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi
