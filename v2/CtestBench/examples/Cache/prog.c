#include <stdlib.h>
#include <stdint.h>
#include <iolib.h>
#include <stdio.h>

// 64K words.
uint32_t main_memory[256 * 256];

// direct mapped cache, 256x32
// 32 blocks, each 8x32.
uint32_t cache_data[256];
uint32_t  cache_tag[32];
uint8_t   cache_flags[32];

#define IS_VALID(x) (x & 1)
#define SET_VALID(x) {x = x | 1;}
#define RESET_VALID(x) {x = x & ~1;}

#define IS_DIRTY(x) (x & 2)
#define SET_DIRTY(x) {x = x | 2;}
#define RESET_DIRTY(x) {x = x & ~2;}


void init_cache()
{
	uint8_t idx;
	for(idx = 0; idx < 32; idx++)
	{
		cache_flags[idx] = 0;
	}
}


void write_back(uint32_t block_index, uint32_t cache_block_address)
{
	uint32_t idx;
	for(idx = 0; idx < 32; idx++)
	{
		main_memory[cache_block_address + idx] = cache_data[block_index + idx];
	}
}

void read_line(uint32_t block_index, uint32_t block_address)
{
	uint32_t idx;
	for(idx = 0; idx < 32; idx++)
	{
		cache_data[block_index + idx] = main_memory[block_address + idx];
	}
	cache_tag[block_index] = block_address;
}

uint32_t read_mem(uint32_t addr)
{
	uint8_t hit = 0;
        uint32_t ret_val = 0;

	uint32_t block_index = (addr >> 27);
        uint32_t block_address = (addr & 0xfffffff8);
        uint32_t block_offset = (addr & 0x00000007);
	uint8_t flag = cache_flags[block_index];
	
	ret_val = cache_data[block_index + block_offset];	

	if(IS_VALID(flag) && (block_address == cache_tag[block_index]))
	{
		return(ret_val);
	}
	else 
	{
		uint8_t idx;

		// write back
		if(IS_VALID(flag) && IS_DIRTY(flag))
		{ 
			uint32_t cache_block_address = cache_tag[block_index];
			write_back(block_index, cache_block_address);
		}
		
		// read cache-line
		read_line(block_index, block_address);

		SET_VALID(flag);
		RESET_DIRTY(flag);
		cache_flags[block_index] = flag;

	        ret_val = cache_data[block_index + block_offset];	
	}

	return(ret_val);
}

void write_mem(uint32_t addr, uint32_t data)
{
	uint8_t hit = 0;
        uint32_t ret_val = 0;

	uint32_t block_index = (addr >> 30);
        uint32_t block_address = (addr & 0xfffffff8);
        uint32_t block_offset = (addr & 0x00000007);

	uint8_t flag = cache_flags[block_index];

	if(IS_VALID(flag) && (block_address == cache_tag[block_index]))
	{
	        cache_data[block_index + block_offset] = data;	
	}
	else 
	{
		uint8_t idx;

		// write back
		if(IS_VALID(flag) && IS_DIRTY(flag))
		{ 
			uint32_t cache_block_address = cache_tag[block_index];
			write_back(block_index, cache_block_address);
		}
		
		// read cache-line
		read_line(block_index, block_address);

		SET_VALID(flag);
		SET_DIRTY(flag);
		cache_flags[block_index] = flag;

	        cache_data[block_index + block_offset] = data;	
	}
}

