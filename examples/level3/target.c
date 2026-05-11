#include <stdio.h>
#include <unistd.h>

/* -O0 필수: 최적화 시 인라인되면 uprobe 붙을 함수 심볼이 사라짐 */

int add(int a, int b)
{
    return a + b;
}

int multiply(int a, int b)
{
    return a * b;
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
