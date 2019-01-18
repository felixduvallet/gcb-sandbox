#!/usr/bin/env bash
# Install only the apt-get vehicle dependencies.

set -e
set -x

sudo apt-get update && \
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
     clang \
     clang-format \
     cmake \
     curl \
     git \
     less \
     llvm \
     nano \
     python-numpy \
     sudo \
     zsh
