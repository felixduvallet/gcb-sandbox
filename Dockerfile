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

COPY install/ /workspace/install/
RUN chmod +x /workspace/install/install_bazel.sh && \
/workspace/install/install_bazel.sh

COPY install.sh /workspace/
# CMD ["/workspace/install.sh"]

COPY gcb-sandbox /workspace/gcb-sandbox

WORKDIR /workspace/gcb-sandbox/

RUN bazel build //source/py_native:all && \
    bazel test --test_output=errors //source/py_native:all
