#include <fpu.h>

float fpu32(float L, float R, uint8_t op_id) 
{
	switch(op_id)
	{
		case MUL: 
			return (L*R); 
			break;
		case ADD: 
			return (L+R); 
			break;
		case SUB: 
			return (L-R); 
			break;
		default : 
			break;
	}

	return(0.0);
}
float fpmul32(float L, float R) {return (L*R); }
float fpadd32(float L, float R) {return (L+R); }
float fpsub32(float L, float R) {return (L-R); }


double fpu64(double L, double R, uint8_t op_id) 
{
	switch(op_id)
	{
		case MUL: 
			return (L*R); 
			break;
		case ADD: 
			return (L+R); 
			break;
		case SUB: 
			return (L-R); 
			break;
		default : 
			break;
	}

	return(0.0);
}
double fpmul64(double L, double R) {return (L*R); }
double fpadd64(double L, double R) {return (L+R); }
double fpsub64(double L, double R) {return (L-R); }


