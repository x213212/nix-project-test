// main.c
#include <stdio.h>
#include "libdep.h"

int main() {
    int result = add(3, 4);
    printf("appA: 3 + 4 = %d\n", result);
    printf("appA: 99 + 4s = %d\n", result);
    return 0;
}
