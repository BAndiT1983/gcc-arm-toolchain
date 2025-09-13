FROM ubuntu:plucky

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get -y install --no-install-suggests --no-install-recommends ca-certificates git cmake ninja-build gcc-arm-none-eabi libnewlib-arm-none-eabi && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
