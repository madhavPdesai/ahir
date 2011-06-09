#include <iostream>

int main(void)

/* We would like to declare a[][lda], but c does not allow it.  In this
function, references to a[i][j] are written a[lda*i+j].  */

{
    float a[200][200],b[200];
    int lda = 200, n = 200;
    int init, i, j;

    init = 1325;

    for (j = 0; j < n; j++) {
	for (i = 0; i < n; i++) {
	    init = 3125*init % 65536;
	    a[j][i] = (init - 32768.0)/16384.0;
	}
    }

    for (i = 0; i < n; i++) {
	b[i] = 0.0;
    }

    for (j = 0; j < n; j++) {
	for (i = 0; i < n; i++) {
	    b[i] = b[i] + a[j][i];
	}
    }

    std::cerr << "<composite type=\"array [200 x array [200 x int] ]\""
      "\" size=\"\">";
    for (i = 0; i < n; ++i) {
      
      for (j = 0; j < n; ++j) {
	
      }
    }
}
