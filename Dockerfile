FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
  curl \
  g++ \
  pkg-config \
  python \
  python-numpy \
  unzip \
  wget \
  zip \
  zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /install

COPY ./install/install_bazel.sh /install/

RUN chmod +x /install/install_bazel.sh && \
    /install/install_bazel.sh

WORKDIR /workspace

COPY . /workspace
