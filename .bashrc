#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

pwd_short() {
  pwd | sed -e "s:$HOME:~:" -e "s:\(.\)[^/]*/:\1/:g"
}

git_branch() {
    # Since I have a git repo over /home/matty for config,
    # I need to hide this tag when there is either no branch or the repo root is /home/matty
    if [[ $(git rev-parse --show-toplevel 2> /dev/null) != "/home/matty" ]] && [[ $(git branch 2> /dev/null) ]]
    then
        echo $(git branch | grep \* | tr -d "\n" | tr -d " ")" "
    fi
}

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
PURPLE=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)

BOLD=$(tput bold)
NORMAL=$(tput sgr0)


## The prompt string at the start of every command
USER='\[${GREEN}${BOLD}\]\u\[${WHITE}${NORMAL}\] '
WD='\[${YELLOW}\]$(pwd_short)\[${WHITE}\] '
BRANCH='\[${PURPLE}\]$(git_branch)\[${WHITE}\]'
SYMBOL='\[❤️\]  '$(echo -ne '\b') # idk why this fixes it but it does
#PS1=$USER$WD$BRANCH$SYMBOL
PS1=$USER$WD$BRANCH$SYMBOL


# Set kitty tab name after each command
PROMPT_COMMAND="echo -en '\033]0;'; echo -n 'bash '; pwd_short; echo -en '\a'"


export EDITOR='nvim'


# Some useful aliases
#alias l='ls --color=auto -lh'
alias ls='echo USE l INSTEAD!'
alias l='exa -l --time-style=long-iso'
alias cat='bat'

alias pls='sudo $(fc -ln -1)' # runs the previous command with sudo
alias cls='clear'
alias clip='xclip -selection "clipboard"' # ctrl+v
alias clipp='xclip -selection "primary"' # middle click
alias py='python3'
alias ipy='ipython'
alias vim='nvim'
alias v='nvim'
alias ip='ip -c'

# cd into mountpoint of target device like `cdm /dev/sda1`
# There is probably already a command for this but whatever
cdm() {
    if [ -z "$1" ]
    then
        echo "ERROR: First argument should be a /dev/XXX device path."
    else
        PATH_MNT=`findmnt $1 -o TARGET -n`
        cd "$PATH_MNT"
    fi
}


# Open file manager (explorer) detached from terminal
# e.g. `f ./foo/bar` to open file explorer at `./foo/bar`
FILE_EXPLORER='nautilus'
f() {
    (&>/dev/null $FILE_EXPLORER $@ &)
}

alias rstudio='rstudio-bin --disable-seccomp-filter-sandbox'

git() {
    if [[ $@ == "log" ]]; then
        command git log --graph
    else
        command git "$@"
    fi
}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/matty/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/home/matty/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/matty/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/home/matty/Downloads/google-cloud-sdk/completion.bash.inc'; fi

# Add bindings to bring back Ctrl-Left and Ctrl-Right cursor navigation
bind '"\eOc":shell-forward-word'
bind '"\eOd":shell-backward-word'

# Binding for Ctrl-Backspace to delete word
bind '"\C-h":shell-backward-kill-word'


# Duplicate the current terminal WD
alias dupe='(&>/dev/null kitty -d "$PWD" &) && echo Duplicated WD $PWD'

d() {
    echo "Running command detached from terminal..."
    ($@ &)
}

# There are a few icat kitty commands, this one has autocomplete.
alias icat='kitty +kitten icat'

# Open files qik
alias o='xdg-open'


export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH=/usr/local/share/pkgconfig:$PKG_CONFIG_PATH

export LD_LIBRARY_PATH=/usr/local/lib/:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/lib64/:$LD_LIBRARY_PATH

# Conda
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/opt/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/opt/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/opt/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<

export http_proxy=''
export https_proxy=''
export ftp_proxy=''
export socks_proxy=''


# Give man pages (and less/more) colours
# This kinda messes up the `env` command... Need to address that
export LESS_TERMCAP_md=$(tput setaf 10) # green
export LESS_TERMCAP_us=$(tput bold; tput setaf 14) # red

export LESS_TERMCAP_mb=$(tput bold; tput setaf 6) # cyan
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4) # yellow on blue
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)
# export GROFF_NO_SGR=1         # For Konsole and Gnome-terminal
# export LESS_TERMCAP_mb=$'\e[1;32m'


