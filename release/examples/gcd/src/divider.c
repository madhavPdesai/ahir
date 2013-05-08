#include <stdint.h>

// long division algorithm.
uint16_t udiv16(uint16_t dividend, uint16_t divisor, uint16_t* remainder) 
{

   uint16_t quotient = 0xffff;
   *remainder = 0;
   if(divisor == 0)
   {
	return(quotient);
   }
   else if(divisor == 1)
   {
	return(dividend);
   }
   else if(divisor > dividend)
   {
	quotient = 0;
	*remainder = dividend;
	return(quotient);
   }
   else
   {
	quotient = 0;
	while(dividend >= divisor)
	{
		uint16_t curr_quotient = 1;
       		uint16_t dividend_by_2 = (dividend >> 1);
		uint16_t shifted_divisor = divisor;

		while(1)
		{
			if(shifted_divisor < dividend_by_2)
			{
				shifted_divisor = (shifted_divisor << 1);
				curr_quotient = (curr_quotient << 1);
			}
			else	
		  		break;
		}

		quotient += curr_quotient;
		dividend -= shifted_divisor;
	}

	*remainder = dividend;
   }
   return(quotient);
}
