#!/bin/bash

# Title: install.sh
# Author: Pelochus
# Brief: Basic installation script for Rockchip NPUs, including LLMs and RKNN Toolkit 2
# Check for more info: https://github.com/Pelochus/ezrknpu/

REPO_URL="https://github.com/Pelochus/ezrknpu"
INSTALL_DIR="ezrknpu"

# APT package dependencies
APT_DEPS=(
    git git-lfs python-is-python3 python3-pip python3-dev build-essential cmake
    libxslt1-dev zlib1g-dev libglib2.0-dev libsm6 libprotobuf-dev libhdf5-dev
)

# Dependencies for different OS versions
APT_DEPS_NEW=(libgl1 libglx-mesa0)
APT_DEPS_OLD=(libgl1-mesa-glx)

message_print() {
    echo
    echo "#########################################"
    echo "$1"
    echo "#########################################"
    echo
}

non_zero_status_command() {
    echo "Error: $1"
    exit 1
}

message_print "Checking script arguments..."

# If zero, both Toolkit2 and LLM will be installed
ARGCOUNT_IS_ZERO=$([ $# = 0 ]; echo $?)

if [[ $1 = '-h' ]]
then
    echo
    echo "ezrknpu install help"
    echo
    echo "If you want to install both LLM and NN-Toolkit do not provide any parameter"
    echo
    echo "-llm: \tOnly installs ezrknn-llm"
    echo "-toolkit: \tOnly installs ezrknn-toolkit2"
    echo "-h: \tShows this help screen"
    echo
    echo "For more information visit $REPO_URL"
    echo
    exit 0
fi

message_print "Checking root permission..."

if [ "$EUID" -ne 0 ]
then
    echo "Please run this script as root!"
    exit 1
fi

message_print "Installing apt dependencies..."

if dpkg --compare-versions "$OS_VERSION" "ge" "24.10"
then
    ALL_DEPS=("${APT_DEPS[@]}" "${APT_DEPS_NEW[@]}")
else
    ALL_DEPS=("${APT_DEPS[@]}" "${APT_DEPS_OLD[@]}")
fi

sudo apt update && sudo apt install -y "${ALL_DEPS[@]}"

if [[ $? -ne 0 ]]
then
    non_zero_status_command "Could not update/upgrade with apt. No internet connection?"
fi

message_print "Cloning main repo with submodules..."

# Clone (recurse-submodules) submodules and update (remote-submodules) to latest commit of the branch
git clone --remote-submodules --recurse-submodules -j2 "$REPO_URL" "$INSTALL_DIR"

if [[ $? -ne 0 ]]
then
    non_zero_status_command "Could not clone ezrknpu. No internet connection?"
fi

cd "$INSTALL_DIR"

# Install RKNN LLM if requested or by default
if [[ $1 = '-llm' || $ARGCOUNT_IS_ZERO ]]
then
    message_print "Installing RKNN LLM with install.sh script..."
    cd ezrknn-llm
    bash install.sh

    if [[ $? -ne 0 ]]
    then
        non_zero_status_command "Failed installing RKNN LLM"
    fi
fi

# Install RKNN Toolkit 2 if requested or by default
if [[ $1 = '-toolkit' || $ARGCOUNT_IS_ZERO ]]
then
    message_print "Installing RKNN Toolkit 2 with install.sh script..."
    cd ../ezrknn-toolkit2
    bash install.sh

    if [[ $? -ne 0 ]]
    then
        non_zero_status_command "Failed installing RKNN Toolkit 2"
    fi
fi

cd ..
message_print "Everything done!"

