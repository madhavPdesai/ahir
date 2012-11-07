#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>

#include "prog.h"
#include "fpu.h"

float global_best_result_value;
uint32_t global_best_result_offset;
uint32_t global_job_counter;

#define MASK ((((unsigned int) 1) << Log2ORDER)-1)

#define CORRELATOR(ret_val,offset)  { unsigned int  I1_0, I2_0, I1_1, I2_1, I1_2, I2_2, I1_3, I2_3; \
	ret_val = 0.0;\
        float A0,A1,A2,A3,B0,B1,B2,B3, P0,P1,P2,P3, S0,S1;\
	for (I1_0 = 0; I1_0 < ORDER; I1_0 = I1_0 + 4)\
	{\
		I1_1 = (I1_0 + 1); I1_2 = (I1_0 +2); I1_3= (I1_0 + 3);\
		A0 = A[I1_0]; A1 = A[I1_1]; A2 = A[I1_2]; A3 = A[I1_3];\
		I2_0 = (I1_0 + offset) & MASK;\
		I2_1 = (I1_1 + offset) & MASK;\
		I2_2 = (I1_2 + offset) & MASK;\
		I2_3 = (I1_3 + offset) & MASK;\
		B0 = B[I2_0]; B1 = B[I2_1]; B2 = B[I2_2]; B3 = B[I2_3];\
		P0 = fpu32(A0,B0,MUL);\
		P1 = fpu32(A1,B1,MUL);\
		P2 = fpu32(A2,B2,MUL);\
		P3 = fpu32(A3,B3,MUL);\
		S0 = fpu32(P0,P1,ADD);\
		S1 = fpu32(P2,P3,ADD);\
		ret_val = fpu32(ret_val, fpu32(S0,S1,ADD), ADD);\
	}}


#define RXDATA(Id) { uint32_t idx; \
	for(idx = 0; idx < ORDER; idx++)\
	{\
		A[idx] = read_float32(#Id);\
		B[idx] = read_float32(#Id);\
	} } 


void master()
{
	float A[ORDER], B[ORDER];

#ifdef SW
	fprintf(stderr,"INFO: master: mask value is %x.\n", MASK);
#endif

	while(1)
	{
		uint32_t idx;

		// trigger all the correlators..
#if USE0
		write_uint8("start_0",1);
#endif
#if USE1
		write_uint8("start_1",1);
#endif
#if USE2
		write_uint8("start_2",1);
#endif
#if USE3
		write_uint8("start_3",1);
#endif

		// get the data and send it to all the correlators..
		for(idx = 0; idx < ORDER; idx++)
		{
			float a  = read_float32("data_in");	
			float b  = read_float32("data_in");	

#if USE0
			write_float32("data_to_0", a);
			write_float32("data_to_0", b);
#endif 
#if USE1
			write_float32("data_to_1", a);
			write_float32("data_to_1", b);
#endif 
#if USE2
			write_float32("data_to_2", a);
			write_float32("data_to_2", b);
#endif
#if USE3
			write_float32("data_to_3", a);
			write_float32("data_to_3", b);
#endif
		}

#ifdef SW
		fprintf(stderr,"Info:master: finished sending data to correlators.\n");
#endif
		// initialize globals
		global_job_counter = 0.0;
		global_best_result_value = - 1000000.0;
		global_best_result_offset = 0;

		write_uint8("best_result_lock_pipe", 1);


		// load the offsets.
		for(idx = 0; idx < ORDER; idx++)
		{
			write_uint32("offset_queue_pipe", idx);
		}


		uint8_t adone = read_uint8("all_done");

		write_float32("best_correlation", global_best_result_value);
		write_uint32("best_offset", global_best_result_offset);

	}
}


void result_counter()
{
	while(1)
	{
		uint32_t idx;
		// keep checking the lock.
		for(idx = 0; idx < ORDER; idx++)
		{
			uint8_t r = read_uint8("result_counter_pipe");
		}

		write_uint8("all_done",1);
	}
}

void correlater_0()
{
	float ret_val;
	float A[ORDER], B[ORDER];
	uint32_t offset;


	while(1)
	{
		uint8_t new_problem = read_uint8("start_0");

		// receive the data..
		RXDATA(data_to_0);
		{
#ifdef SW
			{
				uint32_t idx;
				for(idx =0; idx < ORDER; idx++)
					fprintf(stderr,"Info:correlater_0: A[%d] = %f, B[%d] = %f.\n", idx, A[idx], idx, B[idx]);
			}
#endif 
			while(1)
			{

				// receive offset-value.
				offset = read_uint32("offset_queue_pipe");

#ifdef SW

				fprintf(stderr,"Info:correlater_0: received offset %d.\n", offset);
#endif 
				// instantiate the correlator.
				CORRELATOR(ret_val,offset);
#ifdef SW
				fprintf(stderr,"Info:correlater_0: calculated correlation %f.\n", ret_val);
#endif 


				// get the lock.
				uint8_t lock_val = read_uint8("best_result_lock_pipe");

				// update the best result and the offset.
				if(global_best_result_value < ret_val)
				{
					global_best_result_value = ret_val;
					global_best_result_offset = offset;
					global_job_counter++;
				}
				write_uint8("result_counter_pipe", 1);
				write_uint8("best_result_lock_pipe",lock_val);
			}
		}
	}
}


void correlater_1()
{
	float ret_val;
	float A[ORDER], B[ORDER];
	uint32_t offset;


	while(1)
	{
		uint8_t new_problem = read_uint8("start_1");
		// receive the data..
		RXDATA(data_to_1);
#ifdef SW
		{
			uint32_t idx;
			for(idx =0; idx < ORDER; idx++)
				fprintf(stderr,"Info:correlater_1: A[%d] = %f, B[%d] = %f.\n", idx, A[idx], idx, B[idx]);
		}

#endif 
		while(1)
		{


			// receive offset-value.
			offset = read_uint32("offset_queue_pipe");
#ifdef SW
			fprintf(stderr,"Info:correlater_1: received offset %d.\n", offset);
#endif 

			// instantiate the correlator.
			CORRELATOR(ret_val,offset);

#ifdef SW
			fprintf(stderr,"Info:correlater_1: calculated correlation %f.\n", ret_val);
#endif 

			// get the lock.
			uint8_t lock_val = read_uint8("best_result_lock_pipe");


			// update the best result and the offset.
			if(global_best_result_value < ret_val)
			{
				global_best_result_value = ret_val;
				global_best_result_offset = offset;
				global_job_counter++;

			}
			write_uint8("result_counter_pipe", 1);
			write_uint8("best_result_lock_pipe",lock_val);
		}
	}
}

void correlater_2()
{
	float ret_val;
	float A[ORDER], B[ORDER];
	uint32_t offset;


	while(1)
	{

		uint8_t new_problem = read_uint8("start_2");
		// receive the data..
		RXDATA(data_to_2);
#ifdef SW
		{
			uint32_t idx;
			for(idx =0; idx < ORDER; idx++)
				fprintf(stderr,"Info:correlater_2: A[%d] = %f, B[%d] = %f.\n", idx, A[idx], idx, B[idx]);
		}
#endif 
		while(1)
		{

			// receive offset-value.
			offset = read_uint32("offset_queue_pipe");

#ifdef SW
			fprintf(stderr,"Info:correlater_2: received offset %d.\n", offset);
#endif 

			// instantiate the correlator.
			CORRELATOR(ret_val,offset);

#ifdef SW
			fprintf(stderr,"Info:correlater_2: calculated correlation %f.\n", ret_val);
#endif 

			// get the lock.
			uint8_t lock_val = read_uint8("best_result_lock_pipe");


			// update the best result and the offset.
			if(global_best_result_value < ret_val)
			{
				global_best_result_value = ret_val;
				global_best_result_offset = offset;
				global_job_counter++;

			}
			write_uint8("result_counter_pipe", 1);
			write_uint8("best_result_lock_pipe",lock_val);
		}
	}
}

void correlater_3()
{
	float ret_val;
	float A[ORDER], B[ORDER];
	uint32_t offset;


	while(1)
	{

		uint8_t new_problem = read_uint8("start_3");
		// receive the data..
		RXDATA(data_to_3);
#ifdef SW
		{
			uint32_t idx;
			for(idx =0; idx < ORDER; idx++)
				fprintf(stderr,"Info:correlater_3: A[%d] = %f, B[%d] = %f.\n", idx, A[idx], idx, B[idx]);
		}
#endif 

		while(1)
		{



			// receive offset-value.
			offset = read_uint32("offset_queue_pipe");

#ifdef SW
			fprintf(stderr,"Info:correlater_3: received offset %d.\n", offset);
#endif 

			// instantiate the correlator.
			CORRELATOR(ret_val,offset);


#ifdef SW
			fprintf(stderr,"Info:correlater_3: calculated correlation %f.\n", ret_val);
#endif 

			// get the lock.
			uint8_t lock_val = read_uint8("best_result_lock_pipe");


			// update the best result and the offset.
			if(global_best_result_value < ret_val)
			{
				global_best_result_value = ret_val;
				global_best_result_offset = offset;
				global_job_counter++;

			}
			write_uint8("result_counter_pipe", 1);
			write_uint8("best_result_lock_pipe",lock_val);
		}
	}
}

