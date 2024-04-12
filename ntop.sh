#!/bin/bash
# Title: ntop.sh
# Author: Pelochus
# Brief: A very basic 'top' style program that shows the status of the NPU in Rockchip's SoCs 

# Variables
CLEAR=""

# Parameters check
if [[ $1 = '-h' ]]
then
    echo
    echo "ntop Help"
    echo
    echo "-c: Clears output every refresh"
    echo "-h: Shows this help screen"
    echo 
    echo "For more information visit https://github.com/Pelochus/ezrknn-toolkit2"
    echo
    exit 
elif [[ $1 = '-c' ]]
then
    CLEAR="clear"
fi

while true; do
    eval $CLEAR # If empty, will not clear
    cat /sys/kernel/debug/rknpu/load
    sleep 0.5
done
