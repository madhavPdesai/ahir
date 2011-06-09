void start(int noofelem,float *A, int *rcoeff,int *ccoeff)
{	
	int n;
	float B[5*5];
	float L[5*5],U[5*5];
	int maxcoeff=0;
	float temp=0;
	int i,j,k,p;

	n=5;

	for (i=0;i<5;i++)
	{
		for (j=0;j<5;j++)
		{
			B[5*i+j] = 0;
		}
	}

	for (i=0;i<noofelem;i++)
	{
		B[5*rcoeff[i] + ccoeff[i]] = A[i];
	}
	

	for(i=0;i<5;i++)
	{
		maxcoeff = i;
		for(j=i+1;j<5;j++)
		{
			if(B[5*j+i] > B[5*i+i])
				maxcoeff = j;
		}
		for (j=0;j<5;j++)
		{
			temp = B[5*i+j];
			B[5*i+j] = B[5*maxcoeff+j];
			B[5*maxcoeff+j] = temp;
		}
	}
		
	/*for (p=0;p<n-1;p++)
	{	
		for (k=p+1;k<n;k++)
		{
			B[k][p] = B[k][p]/B[p][p];
			for (j=p+1;j<n;j++)
			{
				B[k][j] = B[k][j] - B[k][p]*B[p][j];
			}
		}
	}
	
	for (i=0;i<n;i++)
        {
                for (j=0;j<n;j++)
		{
			if(j<i)
			{
                        	L[i][j] = B[i][j];
				U[i][j] = 0;
			}
			else if(j==i)
			{
				L[i][j] = 1;
				U[i][j] = B[i][j];
			}
			else
			{
				L[i][j] = 0;
				U[i][j] = B[i][j];
			}
		}
        }*/

}
