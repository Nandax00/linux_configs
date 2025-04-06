autoload -Uz compinit promptinit
compinit
promptinit

export CINEMO_TOOLCHAINS=/opt/cinemo/toolchains
HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000
unsetopt beep
setopt PROMPT_SUBST

alias ls='ls --color=always'
alias ip='ip -color=always'
alias grep='grep --color=always'
alias ll='ls -lah'
alias gs='git status'
alias cal='cal -m'
alias vim='nvim'
export LESS='-R --use-color -Dd+r$Du+b'

alias p='cd /mnt/storage/projects'
alias t='cd /mnt/storage/projects/TemaProject'
alias r='cd ~/repos/robot'
alias c='cd ~/repos/cinemo'
alias cs='cd ~/repos/cinemo/src'
alias ca='cd ~/repos/cinemo-audio'

# Link file from directory, e.g. link compile_commands.json from different
# build dirs.
link() {
    rm ./$1:t
    local path=`readlink -f $1`
    /usr/bin/ln -s $path ./$1:t
}

# Repeat Command
rc() {
    rep=$1
    shift

    i=0;
    while (( i < rep || rep == 0 )); do
        ((i++))
        echo $i;
        $@ || break;
    done
}

prompt_theme_setup() {
    parse_git_branch() {
        local branch_name
        branch_name=$(git symbolic-ref --short HEAD 2>/dev/null | head -c 30)
        if [[ ${#branch_name} -lt 30 ]]; then
            echo "$branch_name"
        else
            echo "$branch_name..."
        fi
    }
    PS1='%f[%F{yellow}%(?.+.-)%f] %F{blue}%m %F{cyan}> %f'
    RPS1='%f[%F{yellow}$(parse_git_branch)%f] %F{green}%~'
}

prompt_themes+=( theme )
prompt theme

# Create a zkbd compatible hash;
# To add other keys to this hash, see: man 5 terminfo
typeset -g -A key

# User bindings
bindkey -v
bindkey "^R" history-incremental-search-backward
bindkey "jk" vi-cmd-mode

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

# Setup key accordingly
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

bindkey "^[." insert-last-word
bindkey "^[0" digit-argument
bindkey "^[1" digit-argument
bindkey "^[2" digit-argument
bindkey "^[3" digit-argument
bindkey "^[4" digit-argument
bindkey "^[5" digit-argument
bindkey "^[6" digit-argument
bindkey "^[7" digit-argument
bindkey "^[8" digit-argument
bindkey "^[9" digit-argument

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
