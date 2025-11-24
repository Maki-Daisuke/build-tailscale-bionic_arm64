# syntax=docker/dockerfile:1.4

FROM --platform=linux/arm64 ubuntu:18.04 AS builder

RUN apt update && apt install -y wget git  && \
    apt clean                              && \
    rm -rf /var/lib/apt/lists/*

# Tailscale requires Go 1.25 to build, as of now
RUN wget -O /tmp/go.tar.gz https://go.dev/dl/go1.25.4.linux-arm64.tar.gz && \
    tar -C /usr/local -xzf /tmp/go.tar.gz && \
    rm /tmp/go.tar.gz
ENV PATH="/usr/local/go/bin:${PATH}"

WORKDIR /app
RUN git clone https://github.com/tailscale/tailscale.git  && \
    cd tailscale                                          && \
    git checkout v1.90.8
# v1.90.8 is the latest version at the time of writing

WORKDIR /app/tailscale

RUN ./build_dist.sh tailscale.com/cmd/tailscale   && \
    ./build_dist.sh tailscale.com/cmd/tailscaled  && \
    mkdir /out  &&  mv tailscaled tailscale /out
