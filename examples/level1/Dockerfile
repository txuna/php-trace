FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    clang llvm \
    libbpf-dev \
    libelf-dev \
    zlib1g-dev \
    gcc make \
    linux-tools-generic \
    && ln -sf /usr/lib/linux-tools/*/bpftool /usr/local/bin/bpftool \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /kprobe
COPY vmlinux.h/include/ /vmlinux-headers/
COPY level1/kprobe.bpf.c level1/kprobe.c level1/Makefile .
COPY level1/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
