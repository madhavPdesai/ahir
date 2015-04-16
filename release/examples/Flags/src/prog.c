#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>
#include <fpu.h>
#include "prog.h"

//
// a simple signaling mechanism with three agents.
//


void Rx()
{
	write_uint8("rx_env_ack",0);
	write_uint8("rx_tx_req",0);

	while(1)
	{
		uint8_t ack_from_tx  = read_uint8("tx_rx_ack");
		uint8_t req_from_env = read_uint8("env_rx_req");
		if(!ack_from_tx && !req_from_env)
			break;
	}

	while(1)
	{
		// get req from environment.
		while(1)
		{
			uint8_t reqE = read_uint8("env_rx_req");
			if(reqE) 
				break;
		}
		write_uint8("rx_env_ack", 1);
		while(1)
		{
			uint8_t reqE = read_uint8("env_rx_req");
			if(!reqE) 
				break;
		}
		write_uint8("rx_env_ack", 0);

		write_uint8("rx_tx_req", 1);
		while(1)
		{
			uint8_t tx_ack = read_uint8("tx_rx_ack");
			if(tx_ack)
				break;
		}
		write_uint8("rx_tx_req",0);
		while(1)
		{
			uint8_t tx_ack = read_uint8("tx_rx_ack");
			if(!tx_ack)
				break;
		}
		
	}
}

void Tx()
{
	write_uint8("tx_rx_ack",0);
	write_uint8("tx_env_req",0);
	while(1)
	{
		uint8_t req_from_rx  = read_uint8("rx_tx_req");
		uint8_t ack_from_env = read_uint8("env_tx_ack");
		if(!req_from_rx && !ack_from_env)
			break;
	}
	while(1)
	{
		while(1)
		{
			uint8_t rx_req = read_uint8("rx_tx_req");
			if(rx_req) 
				break;
		}
		write_uint8("tx_rx_ack", 1);
		while(1)
		{
			uint8_t rx_req = read_uint8("rx_tx_req");
			if(!rx_req) 
				break;
		}
		write_uint8("tx_rx_ack", 0);

		write_uint8("tx_env_req", 1);
		while(1)
		{
			uint8_t env_ack = read_uint8("env_tx_ack");
			if(env_ack)
				break;
		}
		write_uint8("tx_env_req",0);
		while(1)
		{
			uint8_t env_ack = read_uint8("env_tx_ack");
			if(!env_ack)
				break;
		}
	}
}

