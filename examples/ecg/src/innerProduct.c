#include <stdio.h>
#include <math.h>

int main(int argc, char* argv[])
{
	int I;
	double dotP, X, Y;

	if(argc < 3)
	{
		fprintf(stderr, "Supply two file names\n");
		return(1);
	}

	
	FILE* f1 = fopen(argv[1],"r");
	if(f1 == NULL)
	{
		fprintf(stderr, "File %s could not be opened.\n", argv[1]);
		return(1);
	}
	FILE* f2 = fopen(argv[2],"r");
	if(f2 == NULL)
	{
		fprintf(stderr, "File %s could not be opened.\n", argv[2]);
		return(1);
	}


	dotP = 0;
	while(!feof(f1) && !feof(f2))
	{
		int I = fscanf(f1, "%le", &X);
		int J = fscanf(f2, "%le", &Y);
		
		if((I == 0)  || (J == 0))
			break;

	
		fprintf(stderr,"X=%le, Y=%le.\n", X,Y);
		dotP += (X*Y);
	}
	

	fclose(f1);
	fclose(f2);

	fprintf(stdout,"Dot product is %f.\n", dotP);
	return(0);
}
