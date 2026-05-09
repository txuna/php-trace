FROM ubuntu:26.04

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		# core eBPF tracing
		bpftrace \
		bpfcc-tools \
		libbpf-dev \
		# kernel headers (needed for eBPF CO-RE compilation)
		linux-headers-generic \
		# USDT probe support
		systemtap-sdt-dev \
		# perf / flamegraph
		linux-perf \
		# ELF/DWARF inspection
		binutils \
		# syscall-level tracing
		strace \
		# general utilities
		procps \
		curl \
	; \
	rm -rf /var/lib/apt/lists/*

WORKDIR /scripts

# Run with:
#   pid: "service:php-fpm"          <- share PHP-FPM PID namespace
#   privileged: true                <- required for eBPF
#   /sys/kernel/debug mounted       <- required for kprobes/uprobes
CMD ["bash"]
