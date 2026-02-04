#!/usr/bin/env bash

# # Get dependencies
apt update
apt-get install -y git zip qtcreator cmake build-essential genromfs ninja-build protobuf-compiler libgoogle-glog-dev libeigen3-dev libxml2-utils ros-kinetic-mav-comm ros-kinetic-joy ros-kinetic-rqt-multiplot python-jinja2 build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev wget libbz2-dev gcc-arm-none-eabi

sudo apt update

# Setup python3.7
wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz
tar -xf Python-3.7.4.tgz

cd Python-3.7.4
./configure --enable-optimizations
make -j$(nproc) -l$(nproc)
make altinstall

rm -rf Python-3.7.4 Python-3.7.4.tgz
