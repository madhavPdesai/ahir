#ifdef RUN
#include <stdio.h>
#endif

int a[10] = {101, 102, 103, 104, 105, 106, 107, 108, 109, 110};
int b[10] = {201, 202, 203, 204, 205, 206, 207, 208, 209, 210};

int x;

void xxy(void)
{
    a[5] = b[5];
}

void bar (int x, int *b, int i)
{
	int y = b[i];
	b[i] = b[x];
	b[x] = y;
}

int foo (int x, int *a, int *b)
{
    int i, c;

    c = 0;
    for (i = 0; i < 9; i++) {
	a[i] = b[i];
	bar(x, b, i);
	c += a[i];
    }

    a[i] = b[i];
    bar(x, b, i);
    c += a[i];

    return c;
}

void start(void)
{
	x = x + 3;

	x = foo(x, a, b);

	x = a[3] + b[3];
	xxy();
}

#ifdef RUN
int main()
{
    printf("%d\n", start(0));
    return 0;
}
#endif
