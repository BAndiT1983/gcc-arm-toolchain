FROM ubuntu:questing

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get -y install --no-install-suggests --no-install-recommends ca-certificates wget git cmake ninja-build g++ gcc-arm-none-eabi libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib python3 libusb-1.0-0 && \
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Install the Pico SDK
RUN git clone --depth 1 https://github.com/raspberrypi/pico-sdk.git /opt/pico-sdk && \
    cd /opt/pico-sdk && \
    git submodule update --init
ENV PICO_SDK_PATH=/opt/pico-sdk

# Install the Pico SDK tools
ARG PICO_SDK_TOOLS_RELEASE=v2.2.0-2
ARG PICOTOOL_VERSION=2.2.0-a4
ARG PICOTOOL_SHA256=88e81b450c88f65d5e454470595cfdfd2670be0190487e20987e4b07c7583d69

RUN wget https://github.com/raspberrypi/pico-sdk-tools/releases/download/${PICO_SDK_TOOLS_RELEASE}/picotool-${PICOTOOL_VERSION}-x86_64-lin.tar.gz && \
    echo "${PICOTOOL_SHA256}  picotool-${PICOTOOL_VERSION}-x86_64-lin.tar.gz" | sha256sum -c - && \
    tar -xzf picotool-${PICOTOOL_VERSION}-x86_64-lin.tar.gz -C /usr/local/bin && \
    chmod +x /usr/local/bin/picotool/picotool && \
    rm picotool-${PICOTOOL_VERSION}-x86_64-lin.tar.gz

ENV PATH=/usr/local/bin/picotool:$PATH
WORKDIR /workspace
