#!/bin/bash
# Title: ntop.sh
# Author: Pelochus
# Brief: Basic installation script for Rockchip NPUs, including LLMs and RKNN Toolkit 2
# Check for more info: https://github.com/Pelochus/ezrknpu/

message_print() {
    echo
    echo "#########################################"
    echo $1
    echo "#########################################"
    echo
}

# If zero, both NN and LLM will be installed
[ $# = 0 ]
ARGCOUNT_IS_ZERO=$?

if [[ $1 = '-h' ]]
then
    echo
    echo "ezrknpu install help"
    echo
    echo "If you want to install both LLM and NN-Toolkit do not provide any parameter"
    echo
    echo "-llm: \ŧOnly installs ezrknn-llm"
    echo "-nn: \tOnly installs ezrknn-toolkit2"
    echo "-h: \tShows this help screen"
    echo
    echo "For more information visit https://github.com/Pelochus/ezrknpu"
    echo
    exit
fi

message_print "Installing apt dependencies..."

sudo apt update
sudo apt install -y git git-lfs python-is-python3 python3-pip python3-dev build-essential cmake libxslt1-dev zlib1g-dev libglib2.0-dev libsm6 libgl1-mesa-glx libprotobuf-dev libhdf5-dev
# sudo apt install -y adb # For running the NPU in Android

message_print "Cloning main repo with submodules..."

# This also clones submodules
# Add --remote-submodules if you want to update submodules to latest commit and not current repo commit
git clone --recurse-submodules -j2 https://github.com/Pelochus/ezrknpu
cd ezrknpu

message_print "Updating submodules..."
git submodule update --recursive --remote # Submodules should be updated, but just in case I forget

if [[ $1 = '-llm' || $ARGCOUNT_IS_ZERO ]]
then
    message_print "Installing RKNN LLM with install.sh script..."
    cd ezrknn-llm
    bash install.sh
fi

if [[ $1 = '-nn' || $ARGCOUNT_IS_ZERO ]]
then
    message_print "Installing RKNN Toolkit 2 with install.sh script..."
    cd ../ezrknn-toolkit2
    bash install.sh
fi

message_print "Everything done!"
