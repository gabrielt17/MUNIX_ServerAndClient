#!/bin/env bash

# Script built for Armbian 20.10 running Ubuntu Focal 20.04 LTS based distro.


# It seems that we do not need to compile anything by ourselves.
# We can simply install required development packages from gst-rtsp-server1.0 source package :

sudo apt-get install libgstrtspserver-1.0-dev gstreamer1.0-rtsp

# and then you can use it as planned.

# Below is manual compilation method if you are sure that you want to do.

# Install development tools:

sudo apt-get install git build-essential autoconf automake autopoint libtool pkg-config -y
sudo apt-get install gtk-doc-tools libglib2.0-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev -y
sudo apt-get install checkinstall

# (note libgstreamer1.0-dev above).

# Clone the repository:

git clone https://github.com/GStreamer/gst-rtsp-server.git
cd gst-rtsp-server/

# But Ubuntu 18.04 LTS has old version of GStreamer library (1.14.0) so we need to checkout previous version and then compile:

git checkout 1.16.3
./autogen.sh
./configure
make
sudo checkinstall make install # enter 3 and fill *Version* field with 1.13.91

# Note: you can use sudo make install in the last stage, but checkinstall is safer as it will create deb-package with compiled application (so it is controlled by APT and may be removed with sudo dpkg # -r gst-rtsp).
#

# Installing gst-rtsp-launch-1.0 bin

cd examples
gcc test-launch.c -o gst-rtsp-launch-1.0 \
$(pkg-config --cflags --libs gstreamer-rtsp-server-1.0)
sudo install gst-rtsp-launch-1.0 /usr/local/bin/
gst-rtsp-launch-1.0 --help


# Command line working with MATLAB ipcam objetct
# gst-rtsp-launch-1.0 "( \
# v4l2src device=/dev/video1 io-mode=2 ! \
# videoconvert ! \
# video/x-raw,format=I420 ! \
# x264enc tune=zerolatency speed-preset=ultrafast bitrate=800 key-int-max=30 byte-stream=true ! \
# rtph264pay name=pay0 pt=96 config-interval=1 \
# )"


