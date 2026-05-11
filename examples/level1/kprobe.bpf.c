// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
/* Copyright (c) 2021 Sartura */

/* vmlinux.h: struct user_pt_regs 등 BPF_KPROBE 매크로 필요 타입 제공
 * BPF_CORE_READ → bpf_probe_read_kernel 으로 교체
 *   CO-RE 재배치 항목 제거 → 런타임 커널 BTF 불필요
 *   (Docker Desktop 등 BTF 미지원 환경 호환)              */
#include "vmlinux.h"
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>

char LICENSE[] SEC("license") = "Dual BSD/GPL";

SEC("kprobe/do_unlinkat")
int BPF_KPROBE(do_unlinkat, int dfd, struct filename *name)
{
	pid_t pid;
	const char *fname;

	pid = bpf_get_current_pid_tgid() >> 32;

	/* BPF_CORE_READ(name, name) 대신 bpf_probe_read_kernel 사용
	 * CO-RE 재배치 없음 → 커널 BTF 없어도 동작 */
	bpf_probe_read_kernel(&fname, sizeof(fname), &name->name);
	bpf_printk("KPROBE ENTRY pid = %d, filename = %s\n", pid, fname);
	return 0;
}

SEC("kretprobe/do_unlinkat")
int BPF_KRETPROBE(do_unlinkat_exit, long ret)
{
	pid_t pid;

	pid = bpf_get_current_pid_tgid() >> 32;
	bpf_printk("KPROBE EXIT: pid = %d, ret = %ld\n", pid, ret);
	return 0;
}