
#include <stdio.h>
#define N 10

int main (void)
{

    float b[N], a;

    /* We would like to declare a[][lda], but c does not allow it. In
       this function, references to a[i][j] are written a[lda*i+j]. */

    int init, i, j;
    FILE *out;
    
    init = 1325;
    
    for (i = 0; i < N; i++) {
	b[i] = 0.0;
    }
    
    out = fopen("a.txt", "w");
    for (j = 0; j < N; j++) {
	for (i = 0; i < N; i++) {
	    
	    init = 3125*init % 65536;
	    a = (init - 32768.0)/16384.0;

	    fprintf(out, "\n<scalar type=\"float\" size=\"1\">");
	    fprintf(out, "%f</scalar>", a);
	    
	    b[i] = b[i] + a;
	}
    }
    fclose(out);

    out = fopen("b.txt", "w");
    for (i = 0; i < N; ++i) {
	fprintf(out, "\n<scalar type=\"float\" size=\"1\">");
	fprintf(out, "%f</scalar>", b[i]);
    }
    
}
