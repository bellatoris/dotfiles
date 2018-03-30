##########################
# 1. Basic Configuration #
##########################

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return ;;
esac

# Platform detection
platform='linux'
if [[ `uname` == 'Darwin' ]]; then
    platform='mac'
fi

# history settings

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length
HISTSIZE=100000
HISTFILESIZE=200000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Bash completion
[ -f /etc/bash_completion ] && . /etc/bash_completion

# Alias definitions.
# You may want to put all your additions into a separate file like 
# ~/.bash_aliases, instead of adding them here directly.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Global
export EDITOR=vim
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

##############
# 2. Aliases #
##############

# ls color and with classification
if [[ $platform == 'mac' ]]; then
    alias ls='ls -F -G'
else 
    alias ls='ls -F --color=auto'
fi
alias ll='ls -alF'

# grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# alert for rm, cp, mv
alias rm='rm -iv'
alias cp='cp -iv'
alias mv='mv -iv'

# Tmux
alias tmux="tmux -2"

# Keymap
if [[ $platform == 'linux' ]]; then
#    setxkbmap -option ctrl:nocaps
    localectl --no-convert set-x11-keymap us pc105 "" ctrl:nocaps
fi

##################
# 3. Color & PS1 #
##################

# Terminal
COLOR_NONE="\e[0m"
BLACK="\033[0;30m"
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
PURPLE="\033[0;35m"
CYAN="\033[0;36m"
GRAY="\033[0;37m"
BOLD_RED="\033[1;31m"
BOLD_GREEN="\033[1;32m"
BOLD_YELLOW="\033[1;33m"
BOLD_BLUE="\033[1;34m"
BOLD_PURPLE="\033[1;35m"
BOLD_CYAN="\033[1;36m"
WHITE="\033[1;39m"
LIGHT_GREEN="\033[0;92m"

git_branch() {
    local git_branch=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'`
    local git_stat="`git status -unormal 2>&1`"

    local color_stat=''
    if [[ "$git_stat" =~ "nothing to commit" ]]; then
        color_stat="$GREEN"
    elif [[ "$git_stat" =~ "nothing added to commit but untracked files present" ]]; then
        color_stat="$LIGHT_GREEN"
    elif [[ "$git_stat" =~ "# Untracked files:" ]]; then
        color_stat="$YELLOW"
    else
        color_stat="$RED"
    fi

    echo -en "$color_stat$git_branch"
}

docker_machine() {
    echo -en "$(__docker_machine_ps1)"
}

PS1="\[$WHITE\]\u\[$BOLD_GREEN\]@\[$BOLD_RED\]\h:\[$WHITE\]\w\[$BLUE\]"'`docker_machine`'" "'`git_branch`'" \[$GRAY\]\t\n\[$BOLD_GREEN\]"'\$'"\[$COLOR_NONE\] "

# screen-256color if inside tmux, xterm-256color otherwise
if [[ -n "$TMUX" ]]; then
    export TERM='screen-256color'
else 
    export TERM='xterm-256color'
fi

##################
# 4. Plugin      #
##################

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

eval "$(fasd --init auto)"
alias v='f -e vim'
alias vr='f -e vimr'
_fasd_bash_hook_cmd_complete v vr
