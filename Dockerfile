FROM ubuntu:18.04

RUN apt-get update -q && apt-get install -q -y --no-install-recommends \
        build-essential \
        curl \
        python \
        python-dev \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
