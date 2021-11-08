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

# **********************************************************************
# Add the local paths in the user home to the global PATH variable
# **********************************************************************

# Personal informations
export EMAIL="dartzon@gmail.com"
export NAME="Othmane Ait El Cadi"

# Define the default editor for terminal
export EDITOR=nano

# Public GPG Key
export GPGKEY=


rm -rf docker/mariadb/socket/mysqld.sock/
