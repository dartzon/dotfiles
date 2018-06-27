#!/bin/bash

function getVolumeIcon
{
    _activePort=$(pactl list sinks | grep "Active Port" | cut -d' ' -f3)
    _volumeLvl=$(cat ~/.dotfiles/conky/outfiles/sounddevice-volume.out)
    if [ $_activePort == "analog-output-speaker" ]; then

        if [ $_volumeLvl == "0%" ]; then
            echo 
        else
            echo 
        fi
    elif [ $_activePort == "analog-output-headphones" ]; then
        echo 
    fi

    # _switchPort=$1
    # if [ $_switchPort -e 1 ]; then
    #     echo "Not yet implemented"
    # fi
}

function getBluetoothStatus
{
    _isActive=$(cat /sys/devices/platform/thinkpad_acpi/bluetooth_enable)
    if [ $_isActive == "1" ]; then
        echo 
    else
        echo 
    fi
}
function getBluetoothStatusColor
{
    _isActive=$(cat /sys/devices/platform/thinkpad_acpi/bluetooth_enable)
    if [ $_isActive == "1" ]; then
        echo "87c7bf"
    else
        echo "f57900"
    fi
}

function getNetworkStatus
{
    _isUP=$(ip link | grep "state UP" | wc -l)
    if [ $_isUP == "0" ]; then
        echo 
    else
        echo 
    fi

}

function getNetworkStatusColor
{
    _isUP=$(ip link | grep "state UP" | wc -l)
    if [ $_isUP == "0" ]; then
        echo "f57900"
    else
        echo "87c7bf"
    fi
}

function getMailCount
{
    # Store the path to the Inbox's new emails folder
    _maildir=~/.mail/dartzon@gmail.com/INBOX/new/
    # Check if there is new mail
    _countMsg=`ls $_maildir | wc -l`

    echo $_countMsg
}

function getMailCountColor
{
    # Store the path to the Inbox's new emails folder
    _maildir=~/.mail/dartzon@gmail.com/INBOX/new/
    # Check if there is new mail
    _countMsg=`ls $_maildir | wc -l`

    if [ $_countMsg == "0" ]; then
        echo "48f442"
    else
        echo "f57900"
    fi
}

case "$1" in
    vol-ico)            getVolumeIcon;;
    net-stat)           getNetworkStatus;;
    net-stat-color)     getNetworkStatusColor;;
    bt-stat)            getBluetoothStatus;;
    bt-stat-color)      getBluetoothStatusColor;;
    mail-count)         getMailCount;;
    mail-count-color)   getMailCountColor;;
*)          ;;
esac
