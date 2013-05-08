gcc -g -c test_divider.c
gcc -g -c divider.c
gcc -g -c test_gcd.c
gcc -g -c gcd.c
gcc -g -o testDivider divider.o test_divider.o 
gcc -g -o testGCD divider.o gcd.o test_gcd.o
