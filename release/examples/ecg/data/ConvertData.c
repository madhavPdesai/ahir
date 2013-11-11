#include <stdio.h>

int main(int argc, char* argv[])
{
	char c;
	while((c = getchar()) != EOF)
	{
		if(c == ',')
			putchar('\n');
		else
			putchar(c);
	}
}
