#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>
#include "common.h"

void appendToList(int a, int d, IntPairList** ip_list)
{
	IntPairList* new_item = (IntPairList*) malloc(sizeof(IntPairList));
	new_item->a  = a;
	new_item->d  = d;

	new_item->next = *ip_list;
	*ip_list = new_item;
}



void generate_scl180_port_string (const char* mem_type, int addr_width, int data_width, char* result_string)
{
	char tmp_string[4096];
	result_string[0] = 0;

	if(strcmp(mem_type,"SP") == 0)
	{
		sprintf(tmp_string, "      A : in std_logic_vector(%d downto 0);\n", addr_width-1);
		strcat (result_string, tmp_string);

		sprintf(tmp_string, "      I  : in std_logic_vector(%d downto 0);\n", data_width-1);
		strcat (result_string, tmp_string);

		sprintf(tmp_string, "      CE, CSB, WEB: in std_logic;\n");
		strcat (result_string, tmp_string);

		sprintf(tmp_string, "      O  : out std_logic_vector(%d downto 0)", data_width-1);
		strcat (result_string, tmp_string);
	}
	else if (strcmp(mem_type,"DP") == 0)
	{
		sprintf(tmp_string, "      A1,A2  : in std_logic_vector(%d downto 0);\n", addr_width-1);
		strcat (result_string, tmp_string);

		sprintf(tmp_string, "      I1,I2  : in std_logic_vector(%d downto 0);\n", data_width-1);
		strcat (result_string, tmp_string);

		sprintf(tmp_string, "      CE1,CE2,CSB1,CSB2,WEB1,WEB2: in std_logic;\n");
		strcat (result_string, tmp_string);

		sprintf(tmp_string, "      O1,O2 : out std_logic_vector(%d downto 0)", data_width-1);
		strcat (result_string, tmp_string);

	}
	else
	{
		sprintf(result_string,"  FAKEIN:in std_logic; FAKEOUT: out std_logic ");
	}
}

void generate_scl180_port_map_string (char* mem_type, char* result_string)
{
	if(strcmp(mem_type,"SP") == 0)
	{
		sprintf(result_string,"A => ADDR, CE => CLK, WEB => WRITE_BAR, CSB => ENABLE_BAR, I => DATAIN, O => DATAOUT");
	}
	else if(strcmp(mem_type,"DP") == 0)
	{
		sprintf(result_string,"A1 => ADDR_0, A2 => ADDR_1, CE1 => CLK, CE2 => CLK, WEB1 => WRITE_0_BAR, WEB2 => WRITE_1_BAR, OEB1 => TIE_LOW, OEB2 => TIE_LOW, CSB1 => ENABLE_0_BAR, CSB2 => ENABLE_1_BAR, I1 => DATAIN_0, I2 => DATAIN_1, O1 => DATAOUT_0, O2 => DATAOUT_1");
	}
	else
	{
		sprintf(result_string,"  FAKEIN => TIE_LOW; FAKEOUT: TIE_HIGH; ");
	}

	return;
}

void generate_scl180_reverse_port_map_string (char* mem_type, char* result_string)
{

	if(strcmp(mem_type,"SP") == 0)
	{
		sprintf(result_string,"ADDR => A, CLK => CE, WRITE_BAR => WEB, ENABLE_BAR => CSB, DATAIN => I,  DATAOUT => O");
	}
	else if(strcmp(mem_type,"DP") == 0)
	{
		sprintf(result_string,"ADDR_0 => A1, ADDR_1 => A2, CLK => CE1, WRITE_0_BAR => WEB1, WRITE_1_BAR => WEB2,  ENABLE_0_BAR => CSB1, ENABLE_1_BAR => CSB2, DATAIN_0 => I1, DATAIN_1 => I2, DATAOUT_0 => O1, DATAOUT_1 => O2");
	}

	return;
}

void generate_umc65_port_string (const char* mem_type,  int addr_width, int data_width, char* result_string)
{
	result_string[0] = 0;
	char tmp_string[4096];
	if(strcmp(mem_type,"DP") == 0)
	{
/*
      DOA                           :   OUT  std_logic_vector (15 downto 0);
      DOB                           :   OUT  std_logic_vector (15 downto 0);
      A                             :   IN   std_logic_vector (7 downto 0);
      B                             :   IN   std_logic_vector (7 downto 0);
      DIA                           :   IN   std_logic_vector (15 downto 0);
      DIB                           :   IN   std_logic_vector (15 downto 0);
      WEAN                          :   IN   std_logic;
      WEBN                          :   IN   std_logic;
      DVSE                          :   IN   std_logic;
      DVS                           :   IN   std_logic_vector (3 downto 0);
      CKA                            :   IN   std_logic;
      CKB                            :   IN   std_logic;
      CSAN                            :   IN   std_logic;
      CSBN                            :   IN   std_logic
*/

		sprintf(tmp_string, "      DOA : out std_logic_vector(%d downto 0);\n", data_width-1);
		strcat (result_string, tmp_string);

		sprintf(tmp_string, "      DOB : out std_logic_vector(%d downto 0);\n", data_width-1);
		strcat (result_string, tmp_string);

		sprintf(tmp_string, "      A : in std_logic_vector(%d downto 0);\n", addr_width-1);
		strcat (result_string, tmp_string);

		sprintf(tmp_string, "      B : in std_logic_vector(%d downto 0);\n", addr_width-1);
		strcat (result_string, tmp_string);

		sprintf(tmp_string, "      DIA : in std_logic_vector(%d downto 0);\n", data_width-1);
		strcat (result_string, tmp_string);
		
		sprintf(tmp_string, "      DIB : in std_logic_vector(%d downto 0);\n", data_width-1);
		strcat (result_string, tmp_string);

		sprintf(tmp_string, 
      				    "     WEAN                          :   IN   std_logic;\n"
      				    "     WEBN                          :   IN   std_logic;\n"
      				    "     DVSE                          :   IN   std_logic;\n"
      				    "     DVS                           :   IN   std_logic_vector (3 downto 0);\n"
      				    "     CKA                            :   IN   std_logic;\n"
      				    "     CKB                            :   IN   std_logic;\n"
      				    "     CSAN                            :   IN   std_logic;\n"
      				    "     CSBN                            :   IN   std_logic\n");
		strcat (result_string, tmp_string);
	}
	else if((strcmp(mem_type,"SP") == 0) || (strcmp(mem_type,"1RW") == 0))
	{
/*
      DO                            :   OUT  std_logic_vector (31 downto 0);
      A                             :   IN   std_logic_vector (6 downto 0);
      DI                            :   IN   std_logic_vector (31 downto 0);
      WEB                           :   IN   std_logic;
      DVSE                          :   IN   std_logic;
      DVS                           :   IN   std_logic_vector (2 downto 0);
	OR
      DVS                           :   IN   std_logic_vector (3 downto 0);
      CK                            :   IN   std_logic;
      CSB                           :   IN   std_logic
*/

		sprintf(tmp_string, "      DO : out std_logic_vector(%d downto 0);\n", data_width-1);
		strcat (result_string, tmp_string);

		sprintf(tmp_string, "      A : in std_logic_vector(%d downto 0);\n", addr_width-1);
		strcat (result_string, tmp_string);

		sprintf(tmp_string, "      DI : in std_logic_vector(%d downto 0);\n", data_width-1);
		strcat (result_string, tmp_string);

		if(strcmp("SP", mem_type) == 0)
		{
			sprintf(tmp_string, 
					"      WEB  :   IN   std_logic;\n"
					"      DVSE :   IN   std_logic;\n"
					"      DVS  :   IN   std_logic_vector (2 downto 0);\n"
					"      CK   :   IN   std_logic;\n"
					"      CSB  :   IN   std_logic\n");
		}
		else
		{
			sprintf(tmp_string, 
					"      WEB  :   IN   std_logic;\n"
					"      DVSE :   IN   std_logic;\n"
					"      DVS  :   IN   std_logic_vector (3 downto 0);\n"
					"      CK   :   IN   std_logic;\n"
					"      CSB  :   IN   std_logic\n");
		}
		strcat (result_string, tmp_string);
	}
	else if(strcmp(mem_type,"RF") == 0)
	{
/*
      DO                            :   OUT  std_logic_vector (7 downto 0);
      A                             :   IN   std_logic_vector (5 downto 0);
      B                             :   IN   std_logic_vector (5 downto 0);
      DI                            :   IN   std_logic_vector (7 downto 0);
      WEB                           :   IN   std_logic;
      DVSE                          :   IN   std_logic;
      DVS                           :   IN   std_logic_vector (2 downto 0);
      CKA                            :   IN   std_logic;
      CKB                            :   IN   std_logic;
      CSAN                            :   IN   std_logic;
      CSBN                            :   IN   std_logic
*/
		sprintf(tmp_string, "      DO : out std_logic_vector(%d downto 0);\n", data_width-1);
		strcat (result_string, tmp_string);

		sprintf(tmp_string, "      A : in std_logic_vector(%d downto 0);\n", addr_width-1);
		strcat (result_string, tmp_string);

		sprintf(tmp_string, "      B : in std_logic_vector(%d downto 0);\n", addr_width-1);
		strcat (result_string, tmp_string);

		sprintf(tmp_string, "      DI : in std_logic_vector(%d downto 0);\n", data_width-1);
		strcat (result_string, tmp_string);

		sprintf(tmp_string, 
				    "      WEB  :   IN   std_logic;\n"
      				    "      DVSE :   IN   std_logic;\n"
      				    "      DVS  :   IN   std_logic_vector (2 downto 0);\n"
      				    "      CKA   :   IN   std_logic;\n"
      				    "      CKB   :   IN   std_logic;\n"
      				    "      CSAN  :   IN   std_logic;\n"
      				    "      CSBN  :   IN   std_logic\n");
		strcat (result_string, tmp_string);
	}
}


void generate_umc65_port_map_string (const char* mem_type,char* result_string)
{
	if(strcmp(mem_type,"DP") == 0)
	{
		sprintf(result_string,"A => ADDR_0, B => ADDR_1, CKA => CLK, CKB => CLK, WEAN => WRITE_0_BAR, WEBN => WRITE_1_BAR, DVSE => TIE_LOW, DVS => TIE_LOW_4, CSAN => ENABLE_0_BAR, CSBN => ENABLE_1_BAR, DIA => DATAIN_0, DIB => DATAIN_1, DOA => DATAOUT_0, DOB => DATAOUT_1");
	}
	else if(strcmp(mem_type,"SP") == 0)
	{
		sprintf(result_string,"A => ADDR, CK => CLK, WEB => WRITE_BAR, CSB => ENABLE_BAR, DI => DATAIN, DO => DATAOUT, DVSE => TIE_LOW, DVS => TIE_LOW_3");
	}
	else if(strcmp(mem_type,"1RW") == 0)
	{
		sprintf(result_string,"A => ADDR, CK => CLK, WEB => WRITE_BAR, CSB => ENABLE_BAR, DI => DATAIN, DO => DATAOUT, DVSE => TIE_LOW, DVS => TIE_LOW_4");
	}
	else if(strcmp(mem_type,"RF") == 0)
	{
		// Note: port B is write port in register file SZKA*
		sprintf(result_string,"B => ADDR_0, A => ADDR_1, CKA => CLK, CKB => CLK, WEB => ENABLE_0_BAR,  DVSE => TIE_LOW, DVS => TIE_LOW_3, CSAN => ENABLE_1_BAR, CSBN => ENABLE_0_BAR, DI => DATAIN_0,  DO => DATAOUT_1");
	}
}

void generate_umc65_reverse_port_map_string (const char* mem_type,char* result_string)
{
	if(strcmp(mem_type,"DP") == 0)
	{
		sprintf(result_string,"ADDR_0 => A, ADDR_1 => B, CLK => CKA,  WRITE_0_BAR => WEAN, WRITE_1_BAR => WEBN,   ENABLE_0_BAR => CSAN , ENABLE_1_BAR => CSBN, DATAIN_0 => DIA, DATAIN_1 => DIB, DATAOUT_0 => DOA, DATAOUT_1 => DOB");
	}
	else if((strcmp(mem_type,"SP") == 0) || (strcmp(mem_type,"1RW") == 0))
	{
		sprintf(result_string,"ADDR => A, CLK => CK, WRITE_BAR => WEB, ENABLE_BAR => CSB, DATAIN => DI,  DATAOUT => DO");
	}
	else if(strcmp(mem_type,"RF") == 0)
	{
		// SZK port B is write port, and CSAN=WEB.
		sprintf(result_string,"ADDR_0 => B, ADDR_1 => A, CLK => CKA,  ENABLE_0_BAR => CSBN , ENABLE_1_BAR => CSAN, DATAIN_0 => DI,  DATAOUT_1 => DO");
	}
}


int getWordSpec(int tech_flag, int addr_width)
{
	if(tech_flag == SCL180)
		return (addr_width);
	else if(tech_flag == UMC65)
		return (1 << addr_width);
	else
		assert(0);
}

	
void printCutConstants(FILE* f, const char* prefix, IntPairList* lst)
{
	int length = 0;
	IntPairList* t;
	for(t = lst; t != NULL; t=t->next)
	{
		length++;
	}
	fprintf(f,"   constant %s_cut_row_heights : IntegerArray(1 to %d) := (", prefix, length);
	for(t = lst; t != NULL; t=t->next)
	{
		fprintf(f,"%d", (1 << t->a));
		if (t->next != NULL)
			fprintf(f,", ");
	}
	fprintf(f, ");\n");
	fprintf(f,"    constant %s_cut_address_widths : IntegerArray(1 to %d) := (",prefix,  length);
	for(t = lst; t != NULL; t=t->next)
	{
		fprintf(f,"%d", t->a);
		if (t->next != NULL)
			fprintf(f,", ");
	}
	fprintf(f, ");\n");
	fprintf(f,"    constant %s_cut_data_widths : IntegerArray(1 to %d) := (",prefix,  length);
	for(t = lst; t != NULL; t=t->next)
	{
		fprintf(f,"%d", t->d);
		if (t->next != NULL)
			fprintf(f,", ");
	}
	fprintf(f, ");\n");
}

			
void printInstanceAndComponents(int tech_flag,
					char* mem_type,
					FILE* arch_file, 
					FILE* comp_decls_file, 
					char* entity_prefix,
					int addr_width, int data_width,
					char* entity_postfix)
{
	char entity_name[1024];
	char port_string[4096];
	char port_map_string[4096];

	// scl and umc indexing of word count is different.
	int aspec = getWordSpec(tech_flag, addr_width);

	if(strcmp(entity_postfix, "ignore") != 0)
	{
		sprintf(entity_name,"%s_%dX%dX%s", entity_prefix, aspec, data_width, entity_postfix);
	}
	else
	{
		sprintf(entity_name,"%s_%dX%d", entity_prefix, aspec, data_width);
	}
	if(tech_flag == SCL180)
	{
		generate_scl180_port_string(mem_type, addr_width, data_width, port_string);
		generate_scl180_port_map_string(mem_type, port_map_string);
	}
	else if(tech_flag == UMC65)
	{
		generate_umc65_port_string(mem_type, addr_width, data_width, port_string);
		generate_umc65_port_map_string(mem_type,  port_map_string);
	}
	else
	{
		assert(0);
	}
	
	fprintf(comp_decls_file, "  component %s is\n   port( %s);\n  end component;\n", entity_name, port_string);

	fprintf(arch_file, "  %s_gen: if (address_width = %d) and (data_width = %d) generate\n",
					entity_name, addr_width, data_width);
	fprintf(arch_file,"       inst: %s\n   port map (%s);\n", entity_name, port_map_string);
	fprintf(arch_file, "  end generate %s_gen;\n", entity_name);
}

void printWrapperEntity(int tech_flag, char* mem_type,
				FILE* f,
				char* entity_prefix,
				int addr_width, int data_width,
				char* entity_postfix)
{
	char entity_name[1024];
	char port_string[4096];
	char reverse_port_map_string[4096];

	// scl and umc indexing of word count is different.
	int aspec = getWordSpec(tech_flag, addr_width);

	if(strcmp(entity_postfix, "ignore") != 0)
	{
		sprintf(entity_name,"%s_%dX%dX%s", entity_prefix, aspec, data_width, entity_postfix);
	}
	else
	{
		sprintf(entity_name,"%s_%dX%d", entity_prefix, aspec, data_width);
	}
	if(tech_flag == SCL180)
	{
		generate_scl180_port_string(mem_type, addr_width, data_width, port_string);
		generate_scl180_reverse_port_map_string(mem_type, reverse_port_map_string);
	}
	else if(tech_flag == UMC65)
	{
		generate_umc65_port_string(mem_type, addr_width, data_width, port_string);
		generate_umc65_reverse_port_map_string(mem_type,  reverse_port_map_string);
	}
	else
	{
		assert(0);
	}

	
	fprintf(f,"library ieee;\n");
	fprintf(f,"use ieee.std_logic_1164.all;\n");
	fprintf(f,"library ahir;\n");
	fprintf(f,"use ahir.mem_component_pack.all;\n");
	
	fprintf(f, "entity %s is\n   port( %s);\n  end entity;\n", entity_name, port_string);
	fprintf(f, "architecture SimpleWrap of %s is \nbegin\n", entity_name);

	if(tech_flag == SCL180)
	{
		if(strcmp(mem_type,"DP") == 0)
		{
			fprintf(f,"  %s_wrap_inst: dpram_generic_reverse_wrapper \n", entity_name);
			fprintf(f,"       generic map (address_width => %d, data_width => %d)\n",
						addr_width, data_width);
			fprintf(f,"   port map (%s);\n", reverse_port_map_string);
			
		}
		else if(strcmp(mem_type,"SP") == 0)
		{
			fprintf(f,"  %s_wrap_inst: spram_generic_reverse_wrapper \n", entity_name);
			fprintf(f,"       generic map (address_width => %d, data_width => %d)\n",
						addr_width, data_width);
			fprintf(f,"   port map (%s);\n", reverse_port_map_string);
		}
	}
	else if(tech_flag == UMC65)
	{
		if(strcmp(mem_type,"DP") == 0)
		{
			fprintf(f,"  %s_wrap_inst: dpram_generic_reverse_wrapper \n", entity_name);
		}
		else if(strcmp(mem_type,"SP") == 0)
		{
			fprintf(f,"  %s_wrap_inst: spram_generic_reverse_wrapper \n", entity_name);
		}
		else 
		{
			fprintf(f,"  %s_wrap_inst: register_file_1w_1r_generic_reverse_wrapper \n", entity_name);
		}
		fprintf(f,"       generic map (address_width => %d, data_width => %d)\n",
						addr_width, data_width);
		fprintf(f,"   port map (%s);\n", reverse_port_map_string);
	}
	else
	{
		assert(0);
	}

	fprintf(f,"end SimpleWrap;\n");
}


				
