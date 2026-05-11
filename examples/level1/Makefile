CLANG  = clang
CC     = gcc
ARCH  := $(shell uname -m | sed 's/x86_64/x86/' | sed 's/aarch64/arm64/')

BPF_CFLAGS  = -target bpf -O2 -g \
              -D__TARGET_ARCH_$(ARCH) \
              -I. \
              -I/usr/include/$(shell uname -m)-linux-gnu

USER_CFLAGS = -Wall -g
LIBS        = -lbpf -lelf -lz
TARGET      = kprobe

.PHONY: all clean

all: $(TARGET)

# Step 1: BPF 바이트코드 컴파일
$(TARGET).bpf.o: $(TARGET).bpf.c vmlinux.h
	$(CLANG) $(BPF_CFLAGS) -c $< -o $@

# Step 2: Skeleton 헤더 생성
$(TARGET).skel.h: $(TARGET).bpf.o
	bpftool gen skeleton $< name $(TARGET)_bpf > $@

# Step 3: 유저 공간 바이너리 컴파일
$(TARGET): $(TARGET).c $(TARGET).skel.h
	$(CC) $(USER_CFLAGS) -o $@ $< $(LIBS)

clean:
	rm -f $(TARGET) $(TARGET).bpf.o $(TARGET).skel.h
