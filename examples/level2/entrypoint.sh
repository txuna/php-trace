#!/usr/bin/env bash
set -e

echo "▶  do_unlinkat kprobe / kretprobe 추적 시작"
echo "   shell 컨테이너에서 rm 명령으로 이벤트를 발생시켜 보세요."
echo ""
# exec bpftrace /trace/unlink.bt
exec /bin/bash