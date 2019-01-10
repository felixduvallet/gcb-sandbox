#!/usr/bin/env bash
# Install only the apt-get vehicle dependencies.

set -e
set -x

sudo apt-get update && \
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
clang \
clang-format \
cmake \
curl \
git \
git-lfs \
less \
libavcodec-dev \
libavformat-dev \
libczmq-dev \
libdc1394-22-dev \
libgtk2.0-dev \
libjpeg-dev \
libomp-dev \
libopencv-dev \
libpng-dev \
libswscale-dev \
libtbb-dev \
libtbb2 \
libtiff-dev \
libusb-1.0-0-dev \
libzmqpp-dev \
nano \
nvidia-cuda-toolkit \
pkg-config \
pmount \
python \
python-dev \
python-numpy \
python3-dev \
python3-pip \
sox \
unzip \
zip \
zlib1g-dev \
setserial
