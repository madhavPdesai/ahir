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

#define _Theta(x) ( (x < 0) ? 0.0 : 1.0 )
#define _diffNorm(_x,_y,_vecsize,_ret_val) {\
	int idx;\
	_ret_val = 0.0;\
	for(idx = 0; idx < _vecsize; idx++)\
	{\
		float err = fabs(_x[idx] - _y[idx]);\
		_ret_val = ((_ret_val < err) ? err : _ret_val);\
	}\
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
		fprintf(stderr,"Specify OMEGA, EPSILON, vector-size, number of vectors, number-of-loops.\n");
		return(1);
	}

	OMEGA = atoi(argv[1]);
        EPSILON = atof(argv[2]);
	int vecsize = atoi(argv[3]);
	int numvecs = atoi(argv[4]);
	int num_loops = atoi(argv[5]);

	if((vecsize < 0) || (numvecs < 0))
	{
		fprintf(stderr,"vector-size, number of vectors must both be > 0.\n");
		return(1);
	}
	
	generateVectors(vecsize,numvecs);

	while(num_loops > 0)
	{
		float num_pairs = 0.0;	
		float total_sum = 0.0;
		for(i = 0; i < (numvecs - OMEGA); i++)
		{
			for(j = i + OMEGA; j < numvecs; j++)
			{
				num_pairs += 1.0;
				float* x = &(vec_array[i*vecsize]);
				float* y = &(vec_array[j*vecsize]);
				float dnorm;
				_diffNorm(x,y,vecsize,dnorm);
				float diff = EPSILON - dnorm;
				total_sum += _Theta(diff);
			}
		}

		total_sum = total_sum/num_pairs;

		fprintf(stdout,"Result = %le.\n", total_sum);
		num_loops--;
	}
	return(0);
}

