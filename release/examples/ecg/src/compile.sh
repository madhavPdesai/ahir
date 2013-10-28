gcc -c -g -I./ hermite.c
gcc -c -g -I./ testHermite.c
gcc -g -I./ -o testHermite hermite.o testHermite.o -lm
