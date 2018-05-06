#!/bin/bash

mkdir -p ~/.mail/dartzon@gmail.com/INBOX/

# Fetch new mail
/usr/bin/mbsync --config ~/.dotfiles/mail/mbsyncrc personalgmail

# Store the path to the Inbox's new emails folder
CHECKDIR=~/.mail/dartzon@gmail.com/INBOX/new/

# Check if there is new mail
countMsg=`ls $CHECKDIR | wc -l`

# Blink the Scroll Lock LED on the keyboard if new mail
if [ $countMsg -gt 0 ]; then

    for t in {1..5}
    do
	xset led named 'Scroll Lock'
	sleep 1s
	xset -led named 'Scroll Lock'
	sleep 0.2s
    done

    xset led named 'Scroll Lock'

else
    xset -led named 'Scroll Lock'
fi
