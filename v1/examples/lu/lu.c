float divide( float dividend, float divisor)
{
        float eps = 0.001;
        float diplus1,di,niplus1,nicurr,ni,riplus1,ri;
        int i;

        di = divisor;
        ni = dividend;

        for (i=0; di<=0.5; i++)
        {
                di = di * 2;
                ni = ni * 2;
        }

        for ( i=0; di>1; i++)
        {
                di = di * 0.5;
                ni = ni * 0.5;
        }

        nicurr = ni -1;
        ri = 2 - di;

        for ( i =0; (ni - nicurr > eps) ; i++ )
        {
		nicurr = ni;
                di = di * ri;
                ni = ni * ri;
                ri = 2 - di;
        }

        return ni;
}


void start(int noofelem,float *A, int *rcoeff,int *ccoeff,float *l_array,float *u_array)
{	
	int n=3;
	float B[3][3];
	float L[3][3],U[3][3];
	int maxcoeff=0;
	float temp=0;
	int i,j,k,p;

  n = 3;

  for (i = 0; i < n; i++)
    {
      for (j = 0; j < n; j++)
	{
	  B[i][j] = 0;
	}
    }

  for (i = 0; i < noofelem; i++)
    {
      B[rcoeff[i]][ccoeff[i]] = A[i];
    }


  for (i = 0; i < n; i++)
    {
      maxcoeff = i;
      for (j = i + 1; j < n; j++)
	{
	  if (B[j][i] > B[i][i])
	    maxcoeff = j;
	}
      for (j = 0; j < n; j++)
	{
	  temp = B[i][j];
	  B[i][j] = B[maxcoeff][j];
	  B[maxcoeff][j] = temp;
	}
    }

  for (p = 0; p < n - 1; p++)
    {
      for (k = p + 1; k < n; k++)
	{
	  B[k][p] = B[k][p] / B[p][p];
	  for (j = p + 1; j < n; j++)
	    {
	      B[k][j] = B[k][j] - B[k][p] * B[p][j];
	    }
	}
<<<<<<< .mine
    }

  for (i = 0; i < n; i++)
    {
      for (j = 0; j < n; j++)
	{
	  if (j < i)
	    {
	      L[i][j] = B[i][j];
	      U[i][j] = 0;
	    }
	  else if (j == i)
	    {
	      L[i][j] = 1;
	      U[i][j] = B[i][j];
	    }
	  else
	    {
	      L[i][j] = 0;
	      U[i][j] = B[i][j];
	    }
=======
		
	for (p=0;p<n-1;p++)
	{	
		for (k=p+1;k<n;k++)
		{
			B[k][p] = divide(B[k][p], B[p][p]);
			for (j=p+1;j<n;j++)
			{
				B[k][j] = B[k][j] - B[k][p]*B[p][j];
			}
		}
>>>>>>> .r669
	}
    }

  k = 0;
  for (i = 0; i < n; i++)
    {
      for (j = 0; j <= i; j++)
	{
	  l_array[k++] = L[i][j];
	}
    }

  k = 0;
  for (i = 0; i < n; i++)
    {
      for (j = i; j < n; j++)
	{
	  u_array[k++] = U[i][j];
	}
    }

}
