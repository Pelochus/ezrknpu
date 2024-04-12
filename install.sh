#!/bin/bash
# Title: ntop.sh
# Author: Pelochus
# Brief: A very basic 'top' style program that shows the status of the NPU in Rockchip's SoCs 
# Check for more info: https://github.com/Pelochus/ezrknpu/

message_print() {
  echo
  echo "#########################################"
  echo $1
  echo "#########################################"
  echo
}

message_print "Installing apt dependencies..."

sudo apt update
sudo apt install -y git git-lfs python-is-python3 python3-pip libxslt1-dev zlib1g-dev libglib2.0-dev libsm6 libgl1-mesa-glx libprotobuf-dev build-essential
# sudo apt install -y adb # For running the NPU in Android

message_print "Cloning main repo with submodules..."

# This also clones submodules
# TODO: Add --remote-submodules if you want to update submodules to latest commit and not current repo commit
git clone --recurse-submodules https://github.com/Pelochus/ezrknpu
cd ezrknpu

# TODO: Add here option to skip installing LLM and/or RKNN?
message_print "Installing RKNN LLM with install.sh script..."
cd ezrknn-llm
bash install.sh

message_print "Installing RKNN Toolkit 2 with install.sh script..."
cd ezrknn-toolkit2
bash install.sh
