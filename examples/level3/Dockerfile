FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    gcc \
    bpftrace \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY target.c .
# -O0: 인라인 방지 (인라인 시 uprobe 심볼 소멸)
# -g:  DWARF 디버그 정보 (bpftrace 심볼 해석에 활용)
RUN gcc -O0 -g -o target target.c

COPY scripts/trace.bt /trace/trace.bt
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
