# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

if [ "$PS1" ]; then
    complete -cf sudo
fi

# If user ID is greater than or equal to 1000 & if ~/bin exists and is a directory & if ~/bin is not already in your $PATH
# then export ~/bin to your $PATH.
if [[ $UID -ge 1000 && -d $HOME/bin && -z $(echo $PATH | grep -o $HOME/bin) ]]
then
    export PATH=$HOME/bin:${PATH}
fi

# activate the numlock at startup
if [ -x /usr/bin/numlockx ]; then
      /usr/bin/numlockx on
fi

# **********************************************************************
# Add the local paths in the user home to the global PATH variable
# **********************************************************************

# Personal informations
export EMAIL="dartzon@gmail.com"
export NAME="Othmane AIT EL CADI"
export SMTPSERVER="smtp.gmail.com"

# Set default terminal
export TERMINAL=urxvt

# Define the default editor for terminal
export EDITOR="emacs -nw"

# Public GPG Key for my main gpg key
export GPGKEY=9BCA883C70D3CD44FA946FB915665824A3731BC3

# Set default GPG tty
export GPG_TTY=/dev/console

# Global variables for my current Linux configuration
export AUDIOOUT="hdmi"
