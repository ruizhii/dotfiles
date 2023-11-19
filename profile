# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs
setxkbmap -option caps:swapescape
xset r rate 300 50

export TERMINAL="kitty"
export EDITOR="nvim"

