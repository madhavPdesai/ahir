float sqroot (float number)
{
	int i;
	float ulimit = 0, llimit = 0, mid = 0, temp = 0;
	float eps = 0.0001;

/*	ulimit = number;
	llimit = 0.0;
*/

        if(number > 1.0)
	{
		ulimit = number;
		llimit = 0;
	}
	else
	{
		ulimit = 1.0;
		llimit = number;
	}
	
	for( i=0; i<13 ;i++)
	{
		mid = (ulimit + llimit) * 0.5;
		temp = mid*mid;
		if(temp < number)
		{	
			llimit = mid;
		}
		else
		{
			ulimit = mid;
		}
	}

	return mid;
}

float start(float number)
{
	float sq;
	
	sq = sqroot(number);

	return sq;
}
