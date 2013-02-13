#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

/*
 * C(\epsilon) = frac{1}{#N_{pairs}} \sum_{i}^{N-\omega}
 * \sum_{j>i+\omega} \Theta \left( \epsilon - || x_i - x_j ||  \right)
 *
 * \Theta is the heavysde step function which is has a binary output (1 if
 * \epsilon >  || x_i - x_j ||, and 0 otherwise)
 * There are thousand of vectors x_n
 * The norm ||.|| is normally computed as the infinite norm, that is, the
 * maximum value of the vector (in our case the difference of the
 * vectors)
 *
 * To give you some numbers, we are comparing around 40K 10-dimension
 * vectors. The vectors are sorted with an index i \in \{0... N-1\}
 * For each vector we compute how many vector with a superior index
 * (j>i+\omega) are within a distance \epsilon.
 *
 *
 */

float* vec_array = NULL;
int OMEGA = 1;
float EPSILON=0.1;


float Theta(float x)
{
	float ret_val;

	if(x < 0)
		return(0);
	else
		return(1.0);
}

float diffNorm(int i, int j, int vecsize)
{
	int idx;
	float ret_val = 0.0;
	for(idx = 0; idx < vecsize; idx++)
	{
		float err = fabs(vec_array[(i*vecsize)+idx] - vec_array[(j*vecsize)+idx]);
		if(ret_val < err)
			ret_val = err;
	}

	return(ret_val);
}

void generateVectors(int vecsize, int numvecs)
{
	int idx;
	srand48(923);

	int array_size = vecsize*numvecs;
	vec_array = (float*) malloc( array_size*sizeof(float));

	for(idx = 0; idx < array_size; idx++)
	{
		vec_array[idx] = drand48();
	}
}

int main(int argc, char* argv[])
{
	int i,j;
	if(argc < 5)
	{
		fprintf(stderr,"Specify OMEGA, EPSILON, vector-size, number of vectors.\n");
		return(1);
	}

	OMEGA = atoi(argv[1]);
        EPSILON = atof(argv[2]);
	int vecsize = atoi(argv[3]);
	int numvecs = atoi(argv[4]);

	if((vecsize < 0) || (numvecs < 0))
	{
		fprintf(stderr,"vector-size, number of vectors must both be > 0.\n");
		return(1);
	}
	
	generateVectors(vecsize,numvecs);

        float num_pairs = 0.0;	
	float total_sum = 0.0;
	for(i = 0; i < (numvecs - OMEGA); i++)
	{
		for(j = i + OMEGA; j < numvecs; j++)
		{
			num_pairs += 1.0;
			total_sum += Theta(EPSILON - diffNorm(i,j,vecsize));
		}
	}

	total_sum = total_sum/num_pairs;

	fprintf(stdout,"Result = %le.\n", total_sum);
	return(0);
}

