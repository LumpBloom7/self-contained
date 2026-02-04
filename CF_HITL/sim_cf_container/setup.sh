#!/usr/bin/env bash --login

cd ~
# Make sure sources are automatically performed


echo 'source /opt/ros/kinetic/setup.sh' >> ~/.bashrc
source ~/.bashrc

# Create and initialise ROS workspace

mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/src
catkin_init_workspace
cd ..
catkin_make
echo 'source ~/catkin_ws/devel/setup.bash' >> ~/.bashrc
source ~/.bashrc

# Crazyflie client python dependencies

pip3.7 install --upgrade pip
git clone --depth 1 --branch  2016.4 https://github.com/bitcraze/crazyflie-clients-python.git
cd crazyflie-clients-python
pip3.7 install --user -e .

cd ~/catkin_ws/src
git clone https://github.com/whoenig/crazyflie_ros.git
cd crazyflie_ros
git submodule update --init --recursive

cd ~/catkin_ws/src
git clone https://github.com/wuwushrek/sim_cf.git
cd sim_cf/
git submodule update --init --recursive



# Crazyflie_gazebo
cd ~/catkin_ws

catkin_make
source devel/setup.bash

# Compile HITL
cd ~/catkin_ws/src/sim_cf/crazyflie-firmware
make PLATFORM=hitl 
sed -i 's/python3/python3.7/g' Makefile ## Change python3 to python3.7 in make file
make cload ## Flash firmware to drone