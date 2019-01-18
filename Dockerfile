FROM ubuntu:18.04

RUN apt-get update && apt-get install -y --no-install-recommends \
  curl \
  ca-certificates \
  g++ \
  pkg-config \
  unzip \
  wget \
  zip \
  sudo \
  zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /install

COPY ./install/install_bazel.sh /install/
COPY ./install/install_apt_dependencies.sh /install/

RUN chmod +x /install/install_bazel.sh && \
    /install/install_bazel.sh
RUN chmod +x /install/install_apt_dependencies.sh && \
    /install/install_apt_dependencies.sh && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

COPY . /workspace
