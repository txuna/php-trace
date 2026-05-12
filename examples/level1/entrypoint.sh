#!/usr/bin/env bash
set -e

UNAME_ARCH=$(uname -m)
case "$UNAME_ARCH" in
    x86_64)  VMLINUX_ARCH="x86"     ;;
    aarch64) VMLINUX_ARCH="aarch64" ;;
    *)       VMLINUX_ARCH="$UNAME_ARCH" ;;
esac
echo "▶  아키텍처: $UNAME_ARCH → $VMLINUX_ARCH/vmlinux.h"
cp /vmlinux-headers/$VMLINUX_ARCH/vmlinux.h /kprobe/vmlinux.h

echo "▶  빌드 중..."
make -C /kprobe
echo "    완료"

echo ""
echo "▶  kprobe 실행 (do_unlinkat 후킹)"
echo "   출력 확인: cat /sys/kernel/debug/tracing/trace_pipe"
echo ""
# exec /kprobe/kprobe
