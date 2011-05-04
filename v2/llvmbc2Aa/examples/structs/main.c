#include <stdlib.h>
int main(int a)
{
typedef struct myrec_ myrec;
struct myrec_
{
  int a;
  int b;
  myrec* c;
};

	myrec t;
	t.a = a;
	t.b = a;
	return(t.a + t.b);
}

