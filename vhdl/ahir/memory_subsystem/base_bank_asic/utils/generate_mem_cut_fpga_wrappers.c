#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>
#include "common.h"

int main(int argc, char* argv[])
{
	fprintf(stderr,"Usage: %s  <input-file>\n",argv[0]);
	if(argc < 2)
	{
		fprintf(stderr,"Error: specify  input-file\n");
		return(1);
	}

	int tech = -1;

	IntPairList* sp_list = NULL;
	IntPairList* dp_list = NULL;
	IntPairList* rf_list = NULL;

	FILE* infile = fopen(argv[1],"r");
	if(infile == NULL)
	{
		fprintf(stderr,"Error: could not file %s\n", argv[1]);
		return(1);
	}

	fprintf(stderr,"Info: opened cut description file file %s\n", argv[1]);

	char line_buffer[4096];

	FILE* fpga_wrapper_file = fopen ("__fpga_wrapper.vhdl", "w");

	int block_id = 0;
	while (!feof(infile))
	{

		char* N = fgets(line_buffer,4095,infile);
		if(N == NULL)
			break;

		if (line_buffer[0] == '!')
			continue;

		char* rest_of_line = NULL;
		char* descr = strtok_r (line_buffer," \t\n", &rest_of_line);
		
		int addr_width, data_width;
		char entity_prefix[256];
		char entity_postfix[256];

		if(strcmp(descr,"scl180") == 0)
			tech = SCL180;
		else if(strcmp(descr,"umc65") == 0)
			tech = UMC65;
		else if(strcmp(descr,"umc65_2024") == 0)
			tech = UMC65_2024;
		else if(strcmp(descr,"sac") == 0)
			tech = SAC;
		else if (strcmp (descr,"DP") == 0)
		{
			sscanf(rest_of_line,"%d %d %s %s", &addr_width, &data_width, entity_prefix, entity_postfix);
			printWrapperEntity(tech, "DP",
						fpga_wrapper_file,
						entity_prefix, 
						addr_width, data_width,
						entity_postfix);
		}
		else if ((strcmp (descr,"SP") == 0) || (strcmp(descr,"1R1W") == 0))
		{
			if(tech == SAC)
			{
				sscanf(rest_of_line,"%d %d %s ", &addr_width, &data_width, entity_prefix);
			}	
			else
				sscanf(rest_of_line,"%d %d %s %s", &addr_width, &data_width, entity_prefix, 
												entity_postfix);
			printWrapperEntity(tech, descr,
						fpga_wrapper_file, 
						entity_prefix, 
						addr_width, data_width,
						entity_postfix);
		}
		else if (strcmp (descr,"1R1W") == 0)
		{
			sscanf(rest_of_line,"%d %d %s %s", &addr_width, &data_width, entity_prefix, entity_postfix);
			printWrapperEntity(tech, "1R1W",
						fpga_wrapper_file, 
						entity_prefix,
						addr_width, data_width, entity_postfix);
		}
	}

	fclose(fpga_wrapper_file);

	return(0);
}
