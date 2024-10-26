// main.c
#include <stdio.h>
#include "libdep.h"

int main() {
    int result = add(7, 8);
    printf("appB: 7 + 8 = %d\n", result);
    return 0;
}
