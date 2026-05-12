#include <stdio.h>
#include <unistd.h>
#include <sys/sdt.h>   /* systemtap-sdt-dev: DTRACE_PROBE 매크로 */

/*
 * DTRACE_PROBE 매크로는 asm("nop") + .note.stapsdt ELF 섹션으로 컴파일됨.
 * -O2 최적화에도 인라인·제거되지 않아 uprobe보다 안정적.
 *
 * 문법: DTRACE_PROBE<N>(provider, name, arg1, ..., argN)
 *   provider : 프로브 그룹 이름 (bpftrace에서 usdt:path:provider:name)
 *   name     : 개별 프로브 이름 (관례상 __ 로 단어 구분)
 */

int add(int a, int b)
{
    DTRACE_PROBE2(myapp, add__entry, a, b);
    int ret = a + b;
    DTRACE_PROBE1(myapp, add__return, ret);
    return ret;
}

int multiply(int a, int b)
{
    DTRACE_PROBE2(myapp, multiply__entry, a, b);
    int ret = a * b;
    DTRACE_PROBE1(myapp, multiply__return, ret);
    return ret;
}

int main(void)
{
    int i = 0;
    while (1) {
        int a = i % 50;
        int b = (i * 3) % 50;
        printf("add(%d,%d)=%d  multiply(%d,%d)=%d\n",
               a, b, add(a, b), a, b, multiply(a, b));
        i++;
        sleep(1);
    }
    return 0;
}
