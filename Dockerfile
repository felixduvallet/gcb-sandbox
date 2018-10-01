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

WORKDIR /workspace

COPY . /workspace

RUN chmod +x /workspace/install/install_bazel.sh && \
    /workspace/install/install_bazel.sh

# RUN bazel build //source/py_native:all && \
#     bazel test --test_output=errors //source/py_native:all
