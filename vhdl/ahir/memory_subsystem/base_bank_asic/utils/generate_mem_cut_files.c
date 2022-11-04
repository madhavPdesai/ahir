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

	FILE* comp_decls_file = fopen ("__component_decls.vhdl", "w");
	FILE* sp_arch_file = fopen ("__sp_arch_body.vhdl", "w");
	FILE* dp_arch_file = fopen ("__dp_arch_body.vhdl", "w");
	FILE* rf_arch_file = fopen ("__rf_arch_body.vhdl", "w");
	FILE* cut_constants_file = fopen ("__cut_constants.vhdl", "w");

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
		else if(strcmp(descr,"sac") == 0)
			tech = SAC;

		if (strcmp (descr,"DP") == 0)
		{
			if(tech == SAC)
			{
				sscanf(rest_of_line,"%d %d %s ", &addr_width, &data_width, entity_prefix);
			}
			else
			{
				sscanf(rest_of_line,"%d %d %s %s", &addr_width, &data_width, entity_prefix, 
												entity_postfix);
			}

			printInstanceAndComponents(tech, "DP",
							dp_arch_file, 
							comp_decls_file, 
							entity_prefix, 
							addr_width, data_width,
							entity_postfix);
			appendToList(addr_width, data_width, &dp_list);
		}
		else if (strcmp (descr,"SP") == 0) 
		{
			sscanf(rest_of_line,"%d %d %s %s", &addr_width, &data_width, entity_prefix, entity_postfix);
			printInstanceAndComponents(tech, descr,
							sp_arch_file, 
							comp_decls_file, 
							entity_prefix, 
							addr_width, data_width,
							entity_postfix);
			appendToList(addr_width, data_width, &sp_list);
		}
		else if (strcmp (descr,"1R1W") == 0)
		{
			sscanf(rest_of_line,"%d %d %s %s", &addr_width, &data_width, entity_prefix, entity_postfix);
			printInstanceAndComponents(tech, "RF",
						rf_arch_file, comp_decls_file, entity_prefix,
						addr_width, data_width, entity_postfix);
			appendToList(addr_width, data_width, &rf_list);
		}

	}

	if(sp_list != NULL)
		printCutConstants(cut_constants_file, "spmem", sp_list);
	else
		printDummyCutConstants(cut_constants_file, "spmem");

	if(dp_list != NULL)
		printCutConstants(cut_constants_file, "dpmem", dp_list);
	else
		printDummyCutConstants(cut_constants_file, "dpmem");

	if(rf_list != NULL)
		printCutConstants(cut_constants_file, "register_file_1w_1r",    rf_list);
	else
		printDummyCutConstants(cut_constants_file, "register_file_1w_1r");

	fclose(comp_decls_file);
	fclose(sp_arch_file);
	fclose(dp_arch_file);
	fclose(rf_arch_file);
	fclose(cut_constants_file);

	return(0);
}
