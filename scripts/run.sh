#!/bin/bash
# run.sh — php-fpm 바이너리 경로를 /proc/<pid>/root 경유로 해결한 뒤 bpftrace 실행
#
# 사용법:
#   ./run.sh request.bt
#   ./run.sh function.bt
#   ./run.sh trace.bt

set -euo pipefail

SCRIPT=${1:?"Usage: $0 <script.bt>"}

# php-fpm master 프로세스 PID (가장 낮은 PID = master)
PHP_PID=$(pgrep -xo php-fpm 2>/dev/null || true)

if [ -z "$PHP_PID" ]; then
    echo "[ERROR] php-fpm 프로세스를 찾을 수 없습니다." >&2
    echo "        pid 네임스페이스 공유 여부 확인: docker compose ps" >&2
    exit 1
fi

PHP_BIN="/proc/${PHP_PID}/root/usr/local/sbin/php-fpm"

if [ ! -f "$PHP_BIN" ]; then
    echo "[ERROR] 바이너리를 찾을 수 없습니다: $PHP_BIN" >&2
    exit 1
fi

echo "[INFO] php-fpm pid=$PHP_PID"
echo "[INFO] binary=$PHP_BIN"
echo "[INFO] script=$SCRIPT"
echo ""

# 스크립트 내 플레이스홀더 경로를 /proc/<pid>/root/... 로 치환해서 실행
sed "s|/usr/local/sbin/php-fpm|${PHP_BIN}|g" "$SCRIPT" | bpftrace -
