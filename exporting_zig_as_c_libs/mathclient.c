#include <stdio.h>
#include "mathtest.h"

extern int add(int, int);

int main(int argc, char *argv[])
{
    int x, y;

    scanf("%d%d", &x, &y);
    printf("%d\n", add(x, y));

    return 0;
}