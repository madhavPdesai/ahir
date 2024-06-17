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
	char tmp_string[16384];
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
		sprintf(tmp_string, "      AB,A2  : in std_logic_vector(%d downto 0);\n", addr_width-1);
		strcat (result_string, tmp_string);

		sprintf(tmp_string, "      I1,I2  : in std_logic_vector(%d downto 0);\n", data_width-1);
		strcat (result_string, tmp_string);

		sprintf(tmp_string, "      CE1,CE2,CSB1,CSB2,WEBB,WEB2: in std_logic;\n");
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
		sprintf(result_string,"AB => ADDR_0, A2 => ADDR_1, CE1 => CLK, CE2 => CLK, WEBB => WRITE_0_BAR, WEB2 => WRITE_1_BAR, OEB1 => TIE_LOW, OEB2 => TIE_LOW, CSB1 => ENABLE_0_BAR, CSB2 => ENABLE_1_BAR, I1 => DATAIN_0, I2 => DATAIN_1, O1 => DATAOUT_0, O2 => DATAOUT_1");
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
		sprintf(result_string,"ADDR_0 => AB, ADDR_1 => A2, CLK => CE1, WRITE_0_BAR => WEBB, WRITE_1_BAR => WEB2,  ENABLE_0_BAR => CSB1, ENABLE_1_BAR => CSB2, DATAIN_0 => I1, DATAIN_1 => I2, DATAOUT_0 => O1, DATAOUT_1 => O2");
	}

	return;
}

void generate_umc65_port_string (const char* mem_type,  int addr_width, int data_width, char* result_string)
{
	result_string[0] = 0;
	char tmp_string[16384];
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
	else if((strcmp(mem_type,"SP") == 0) || (strcmp(mem_type,"1R1W") == 0))
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
	else if(strcmp(mem_type,"1R1W") == 0)
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
	else if(strcmp(mem_type,"1R1W") == 0)
	{
		sprintf(result_string,"A => ADDR, CK => CLK, WEB => WRITE_BAR, CSB => ENABLE_BAR, DI => DATAIN, DO => DATAOUT, DVSE => TIE_LOW, DVS => TIE_LOW_4");
	}
	else if(strcmp(mem_type,"1R1W") == 0)
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
	else if((strcmp(mem_type,"SP") == 0) || (strcmp(mem_type,"1R1W") == 0))
	{
		sprintf(result_string,"ADDR => A, CLK => CK, WRITE_BAR => WEB, ENABLE_BAR => CSB, DATAIN => DI,  DATAOUT => DO");
	}
	else if(strcmp(mem_type,"1R1W") == 0)
	{
		// SZK port B is write port, and CSAN=WEB.
		sprintf(result_string,"ADDR_0 => B, ADDR_1 => A, CLK => CKA,  ENABLE_0_BAR => CSBN , ENABLE_1_BAR => CSAN, DATAIN_0 => DI,  DATAOUT_1 => DO");
	}
}

void generate_umc65_2024_port_string (const char* mem_type,  int addr_width, int data_width, char* result_string)
{
	int P;

	result_string[0] = 0;
	char tmp_string[16384];
	if(strcmp(mem_type,"DP") == 0)
	{
/*
      DOA0,DOA1,...                 :   OUT  std_logic;
      DOB0,DOB1,...                 :   OUT  std_logic;
      A0,A1,...                     :   IN   std_logic;
      B0,B1,...                     :   IN   std_logic;
      DIA0,DIA1,...                 :   IN   std_logic;
      DIB0,DIB1,...                 :   IN   std_logic;
      WEAN                          :   IN   std_logic;
      WEBN                          :   IN   std_logic;
      DVSE                          :   IN   std_logic;
      DVS0,DVS1,DVS2,DVS4           :   IN   std_logic;
      CKA                            :   IN   std_logic;
      CKB                            :   IN   std_logic;
      CSAN                            :   IN   std_logic;
      CSBN                            :   IN   std_logic
*/

		for(P = 0; P < data_width; P++)
		{
			sprintf(tmp_string, "      DOA%d : out std_logic;\n", P);
			strcat (result_string, tmp_string);
		}

		for(P = 0; P < data_width; P++)
		{
			sprintf(tmp_string, "      DOB%d : out std_logic;\n", P);
			strcat (result_string, tmp_string);
		}

		for(P = 0; P < addr_width; P++)
		{
			sprintf(tmp_string, "      A%d : in std_logic;\n", P);
			strcat (result_string, tmp_string);
		}

		for(P = 0; P < addr_width; P++)
		{
			sprintf(tmp_string, "      B%d : in std_logic;\n", P);
			strcat (result_string, tmp_string);
		}

		for(P = 0; P < data_width; P++)
		{
			sprintf(tmp_string, "      DIA%d : in std_logic;\n", P);
			strcat (result_string, tmp_string);
		}
		
		for(P = 0; P < data_width; P++)
		{
			sprintf(tmp_string, "      DIB%d : in std_logic;\n", P);
			strcat (result_string, tmp_string);
		}

		sprintf(tmp_string, 
      				    "     WEAN                          :   IN   std_logic;\n"
      				    "     WEBN                          :   IN   std_logic;\n"
      				    "     DVSE                          :   IN   std_logic;\n"
      				    "     DVS0, DVS1, DVS2, DVS3        :   IN   std_logic;\n"
      				    "     CKA                           :   IN   std_logic;\n"
      				    "     CKB                           :   IN   std_logic;\n"
      				    "     CSAN                          :   IN   std_logic;\n"
      				    "     CSBN                          :   IN   std_logic\n");
		strcat (result_string, tmp_string);
	}
	else if((strcmp(mem_type,"SP") == 0) || (strcmp(mem_type,"1R1W") == 0))
	{
/*
      DO0,DO1,...                   :   OUT  std_logic;
      A0,A1,...                     :   IN   std_logic;
      [for 1R1W, B0,B1,...                     :   IN   std_logic;
      DI0,DI1,...                   :   IN   std_logic;
      WEB                           :   IN   std_logic;
      DVSE                          :   IN   std_logic;
      DVS                           :   IN std_logic;
	OR
      DVS                           :   IN   std_logic;
      CK                            :   IN   std_logic;
      CSB                           :   IN   std_logic
*/

		for(P = 0; P < data_width; P++)
		{
			sprintf(tmp_string, "      DO%d : out std_logic;\n", P);
			strcat (result_string, tmp_string);
		}

		for(P = 0; P < addr_width; P++)
		{
			sprintf(tmp_string, "      A%d : in std_logic;\n", P);
			strcat (result_string, tmp_string);
		}

		for(P = 0; P < data_width; P++)
		{
			sprintf(tmp_string, "      DI%d : in std_logic;\n", P);
			strcat (result_string, tmp_string);
		}

		if(strcmp("SP", mem_type) == 0)
		{
			sprintf(tmp_string, 
					"      WEB  :   IN   std_logic;\n"
					"      DVSE :   IN   std_logic;\n"
					"      DVS0,DVS1,DVS2:   IN   std_logic;\n"
					"      CK   :   IN   std_logic;\n"
					"      CSB  :   IN   std_logic\n");
			strcat (result_string, tmp_string);
		}
		else
		{
			for(P = 0; P < addr_width; P++)
			{
				sprintf(tmp_string, "      B%d : in std_logic;\n", P);
				strcat (result_string, tmp_string);
			}

			sprintf(tmp_string, 
					"      WEB  :   IN   std_logic;\n"
					"      DVSE :   IN   std_logic;\n"
					"      DVS0, DVS1, DVS2:   IN   std_logic;\n"
					"      CKA, CKB   :   IN   std_logic;\n"
					"      CSAN, CSBN  :   IN   std_logic\n");
			strcat (result_string, tmp_string);
		}
	}
	else 
	{
		assert(0);
	}
}


void generate_umc65_2024_port_map_string (const char* mem_type,int addr_width, int data_width, char* result_string)
{
	int P;
	result_string[0] = 0;
	if(strcmp(mem_type,"DP") == 0)
	{
		char address_ports_string[4096];
		address_ports_string[0] = 0;
		for(P = 0; P < addr_width; P++)
		{
			char tmp_string[1024];
			sprintf(tmp_string,"       A%d => ADDR_0(%d), \n", P, P );
			strcat (address_ports_string, tmp_string);
		}
		strcat (result_string, address_ports_string);	

		address_ports_string[0] = 0;
		for(P = 0; P < addr_width; P++)
		{
			char tmp_string[1024];
			sprintf(tmp_string,"       B%d => ADDR_1(%d), \n", P, P );
			strcat (address_ports_string, tmp_string);
		}
		strcat (result_string, address_ports_string);	
		
		char data_in_a_ports_string[4096];
		data_in_a_ports_string[0] = 0;
		for(P = 0; P < data_width; P++)
		{
			char tmp_string[1024];
			sprintf(tmp_string,"       DIA%d => DATAIN_0(%d), \n", P, P );
			strcat (data_in_a_ports_string, tmp_string);
		}
		strcat (result_string, data_in_a_ports_string);	

		char data_in_b_ports_string[4096];
		data_in_b_ports_string[0] = 0;
		for(P = 0; P < data_width; P++)
		{
			char tmp_string[1024];
			sprintf(tmp_string,"       DIB%d => DATAIN_1(%d), \n", P, P );
			strcat (data_in_b_ports_string, tmp_string);
		}
		strcat (result_string, data_in_b_ports_string);	

		char data_out_a_ports_string[4096];
		data_out_a_ports_string[0] = 0;
		for(P = 0; P < data_width; P++)
		{
			char tmp_string[1024];
			sprintf(tmp_string,"       DOA%d => DATAOUT_0(%d), \n", P, P );
			strcat (data_out_a_ports_string, tmp_string);
		}
		strcat (result_string, data_out_a_ports_string);	

		char data_out_b_ports_string[4096];
		data_out_b_ports_string[0] = 0;
		for(P = 0; P < data_width; P++)
		{
			char tmp_string[1024];
			sprintf(tmp_string,"       DOB%d => DATAOUT_1(%d), \n", P, P );
			strcat (data_out_b_ports_string, tmp_string);
		}
		strcat (result_string, data_out_b_ports_string);	

		char other_ports[1024];

		sprintf(other_ports,"CKA => CLK, CKB => CLK, WEAN => WRITE_0_BAR, WEBN => WRITE_1_BAR, DVSE => TIE_LOW, DVS0 => TIE_LOW, DVS1 => TIE_LOW, DVS2 => TIE_LOW, DVS3 => TIE_LOW, CSAN => ENABLE_0_BAR, CSBN => ENABLE_1_BAR\n");
		strcat (result_string, other_ports);	
	}
	else if (strcmp(mem_type,"SP") == 0) 
	{
		char address_ports_string[4096];
		address_ports_string[0] = 0;

		for(P = 0; P < addr_width; P++)
		{
			char tmp_string[1024];
			sprintf(tmp_string,"       A%d => ADDR(%d), \n", P,P);
			strcat (address_ports_string, tmp_string);
		}
		strcat (result_string, address_ports_string);	

		char data_in_ports_string[4096];
		data_in_ports_string[0] = 0;
		for(P = 0; P < data_width; P++)
		{
			char tmp_string[1024];
			sprintf(tmp_string,"       DI%d => DATAIN(%d), \n", P,P);
			strcat (data_in_ports_string, tmp_string);
		}
		strcat (result_string, data_in_ports_string);	

		char data_out_ports_string[4096];
		data_out_ports_string[0] = 0;
		for(P = 0; P < data_width; P++)
		{
			char tmp_string[1024];
			sprintf(tmp_string,"       DO%d => DATAOUT(%d), \n", P, P);
			strcat (data_out_ports_string, tmp_string);
		}
		strcat (result_string, data_out_ports_string);	

		char other_ports[1024];
		
		if(strcmp(mem_type,"SP") == 0)
		{
			sprintf(other_ports," CK => CLK, WEB => WRITE_BAR, CSB => ENABLE_BAR,  DVSE => TIE_LOW, DVS0 => TIE_LOW, DVS1 => TIE_LOW, DVS2 => TIE_LOW");
		}
		strcat (result_string, other_ports);	
		
	}
	else if (strcmp(mem_type,"1R1W") == 0)
	{
		//
		// The memory cut has two ports A, B.
		// A is used for reading, and B for writing.
		//
		char address_ports_string[4096];
		address_ports_string[0] = 0;

		// 
		// Address A is for read, B is for write.
		//  A is tied to port 1, B is tied to port 0.
		for(P = 0; P < addr_width; P++)
		{
			char tmp_string[1024];
			sprintf(tmp_string,"       A%d => ADDR_1(%d), \n", P,P);
			strcat (address_ports_string, tmp_string);
		}

		for(P = 0; P < addr_width; P++)
		{
			char tmp_string[1024];
			sprintf(tmp_string,"       B%d => ADDR_0(%d), \n", P,P);
			strcat (address_ports_string, tmp_string);
		}
		strcat (result_string, address_ports_string);	

		char data_in_ports_string[4096];
		data_in_ports_string[0] = 0;
		for(P = 0; P < data_width; P++)
		{
			char tmp_string[1024];
			sprintf(tmp_string,"       DI%d => DATAIN_0(%d), \n", P,P);
			strcat (data_in_ports_string, tmp_string);
		}
		strcat (result_string, data_in_ports_string);	

		char data_out_ports_string[4096];
		data_out_ports_string[0] = 0;
		for(P = 0; P < data_width; P++)
		{
			char tmp_string[1024];
			sprintf(tmp_string,"       DO%d => DATAOUT_1(%d), \n", P, P);
			strcat (data_out_ports_string, tmp_string);
		}
		strcat (result_string, data_out_ports_string);	

		char other_ports[1024];

		// ports
		sprintf(other_ports," CKA => CLK, CKB => CLK,  WEB => ENABLE_0_BAR, CSAN => ENABLE_1_BAR, CSBN => ENABLE_0_BAR,  DVSE => TIE_LOW, DVS0 => TIE_LOW, DVS1 => TIE_LOW, DVS2 => TIE_LOW");
		strcat (result_string, other_ports);	
	}
	else 
	{
		assert(0);
	}
}

void generate_umc65_2024_reverse_port_map_string (const char* mem_type,
							int addr_width, int data_width, 
							char* result_string)
{
	int P;

	result_string[0] = 0;

	if(strcmp(mem_type,"DP") == 0)
	{
		char address_ports_string[4096];
		address_ports_string[0] = 0;

		for(P = 0; P < addr_width; P++)
		{
			char tmp_string[1024];
			sprintf(tmp_string,"       ADDR_0(%d)=> A%d, \n", P, P);
			strcat (address_ports_string, tmp_string);
		}
		strcat (result_string, address_ports_string);	

		address_ports_string[0] = 0;
		for(P = 0; P < addr_width; P++)
		{
			char tmp_string[1024];
			sprintf(tmp_string,"       ADDR_1(%d)=> B%d, \n", P, P);
			strcat (address_ports_string, tmp_string);
		}
		strcat (result_string, address_ports_string);	

		char data_ports_string[4096];
		data_ports_string[0] = 0;
		for(P = 0; P < data_width; P++)
		{
			char tmp_string[1024];
			sprintf(tmp_string,"       DATAIN_0(%d)=> DIA%d, \n", P, P);
			strcat (data_ports_string, tmp_string);
		}
		strcat (result_string, data_ports_string);	

		data_ports_string[0] = 0;
		for(P = 0; P < data_width; P++)
		{
			char tmp_string[1024];
			sprintf(tmp_string,"       DATAIN_1(%d)=> DIB%d, \n", P, P);
			strcat (data_ports_string, tmp_string);
		}
		strcat (result_string, data_ports_string);	

		data_ports_string[0] = 0;
		for(P = 0; P < data_width; P++)
		{
			char tmp_string[1024];
			sprintf(tmp_string,"       DATAOUT_0(%d)=> DOA%d, \n", P, P);
			strcat (data_ports_string, tmp_string);
		}
		strcat (result_string, data_ports_string);	

		data_ports_string[0] = 0;
		for(P = 0; P < data_width; P++)
		{
			char tmp_string[1024];
			sprintf(tmp_string,"       DATAOUT_1(%d)=> DOB%d, \n", P, P);
			strcat (data_ports_string, tmp_string);
		}
		strcat (result_string, data_ports_string);	

		char other_ports_string[1024];

		sprintf(other_ports_string," CLK => CKA,  WRITE_0_BAR => WEAN, WRITE_1_BAR => WEBN,   ENABLE_0_BAR => CSAN , ENABLE_1_BAR => CSBN");

		strcat (result_string, other_ports_string);	
	}
	else if(strcmp(mem_type,"SP") == 0) 
	{
		char address_ports_string[4096];

		address_ports_string[0] = 0;
		for(P = 0; P < addr_width; P++)
		{
			char tmp_string[1024];
			sprintf(tmp_string,"       ADDR(%d)=> A%d, \n", P, P);
			strcat (address_ports_string, tmp_string);
		}
		strcat (result_string, address_ports_string);	

		char data_ports_string[4096];
		data_ports_string[0] = 0;
		for(P = 0; P < data_width; P++)
		{
			char tmp_string[1024];
			sprintf(tmp_string,"       DATAIN(%d)=> DI%d, \n", P, P);
			strcat (data_ports_string, tmp_string);
		}
		strcat (result_string, data_ports_string);	

		data_ports_string[0] = 0;
		for(P = 0; P < data_width; P++)
		{
			char tmp_string[1024];
			sprintf(tmp_string,"       DATAOUT(%d)=> DO%d, \n", P, P);
			strcat (data_ports_string, tmp_string);
		}
		strcat (result_string, data_ports_string);	

		char other_ports_string[1024];
		sprintf(other_ports_string," CLK => CK, WRITE_BAR => WEB, ENABLE_BAR => CSB");
		strcat (result_string, other_ports_string);	
	}
	else if (strcmp(mem_type,"1R1W") == 0)
	{
		// port A is used for reading, port B
		// for writing.
		// 
		// In the base model, port 0 is used for
		// writing (thus tied to B)
		//
		char address_ports_string[4096];

		address_ports_string[0] = 0;
		for(P = 0; P < addr_width; P++)
		{
			char tmp_string[1024];
			sprintf(tmp_string,"       ADDR_1(%d)=> A%d, \n", P, P);
			strcat (address_ports_string, tmp_string);
		}
		for(P = 0; P < addr_width; P++)
		{
			char tmp_string[1024];
			sprintf(tmp_string,"       ADDR_0(%d)=> B%d, \n", P, P);
			strcat (address_ports_string, tmp_string);
		}

		strcat (result_string, address_ports_string);	

		char data_ports_string[4096];
		data_ports_string[0] = 0;
		for(P = 0; P < data_width; P++)
		{
			char tmp_string[1024];
			sprintf(tmp_string,"       DATAIN_0(%d)=> DI%d, \n", P, P);
			strcat (data_ports_string, tmp_string);
		}
		strcat (result_string, data_ports_string);	

		data_ports_string[0] = 0;
		for(P = 0; P < data_width; P++)
		{
			char tmp_string[1024];
			sprintf(tmp_string,"       DATAOUT_1(%d)=> DO%d, \n", P, P);
			strcat (data_ports_string, tmp_string);
		}
		strcat (result_string, data_ports_string);	

		char other_ports_string[1024];
		//
		// CLK, RESET, ENABLE_0_BAR, ENABLE_1_BAR,
		// 
		sprintf(other_ports_string," CLK => CKA,  ENABLE_0_BAR => WEB, ENABLE_1_BAR => CSAN");
		strcat (result_string, other_ports_string);	
	}
	else 
	{
		assert(0);
	}
}

void generate_sac_port_string (const char* mem_type,  int addr_width, int data_width, char* result_string)
{
	result_string[0] = 0;
	char tmp_string[16384];
	if((strcmp(mem_type,"DP") == 0) || (strcmp(mem_type,"1R1W") == 0))
	{
/*
      QA, QB                             :   OUT  std_logic_vector (31 downto 0);
      AA, AB                             :   IN   std_logic_vector (6 downto 0);
      DA, DB                             :   IN   std_logic_vector (31 downto 0);
      WEBA, WEBB                         :   IN   std_logic;
      CEBA, CEBB                         :   IN   std_logic;
      BWEBA, BWEBB
      CLKA, CLKB                         :   IN   std_logic;
      ----  unused ---------------------------------------------------
      SD, VG, VS                         :   IN   std_logic; ???
      SLP                                :   IN   std_logic; ???
      AWT,				 :   IN std_logic
      CEBMA, CEBMB			 :   IN   std_logic; ???
      WEBMA, WEBMB
      BWEBMA, BWEBMB
      AMA,  AMB, 
      DMA,  DMB,
      BIST,
      WTSEL
      RTSEL
*/
		sprintf(tmp_string, "      QA,QB : out std_logic_vector(%d downto 0);\n", data_width-1);
		strcat (result_string, tmp_string);

		sprintf(tmp_string, "      AA,AB,AMA,AMB : in std_logic_vector(%d downto 0) := TieHighSlvConstant(%d);\n", addr_width-1, addr_width);
		strcat (result_string, tmp_string);

		sprintf(tmp_string, "      DA,DB,DMA,DMB,BWEBA,BWEBB,BWEBMA,BWEBMB : in std_logic_vector(%d downto 0) := TieHighSlvConstant(%d);\n", data_width-1, data_width);
		strcat (result_string, tmp_string);

		sprintf(tmp_string, 
					"      SLP  :   IN   std_logic := '1'; --- ????? \n"
					"      SD, VG, VS  :   IN   std_logic := '1'; --- ????? \n"
					"      BIST  :   IN   std_logic := '1'; --- ????? \n"
					"      AWT:   IN   std_logic := '1'; --- ????? \n"
					"      WTSEL  :   IN   std_logic_vector(1 downto 0) := \"11\"; --- ????? \n"
					"      RTSEL  :   IN   std_logic_vector(1 downto 0) := \"11\"; --- ????? \n"
					"      CEBA, CEBB :   IN   std_logic := '1';\n"
					"      CEBMA, CEBMB :   IN   std_logic := '1';\n"
					"      WEBA, WEBB :   IN   std_logic := '1';\n"
					"      WEBMA, WEBMB :   IN   std_logic := '1';\n");
		strcat (result_string, tmp_string);


		sprintf(tmp_string, "      CLKA, CLKB, CLKM  :   IN   std_logic := '1'");
		strcat (result_string, tmp_string);
	}
	else if(strcmp(mem_type,"SP") == 0)
	{
/*
      Q                             :   OUT  std_logic_vector (31 downto 0);
      A                             :   IN   std_logic_vector (6 downto 0);
      D                             :   IN   std_logic_vector (31 downto 0);
      WEB                           :   IN   std_logic;
      CEB                           :   IN   std_logic;
      CLK                           :   IN   std_logic;
      SD                            :   IN   std_logic;
      SLP                           :   IN   std_logic ???
      ----  unused ---------------------------------------------------
            CEBM, 
	    WEBM,
            AWT,
            BWEB,
            AM, 
	    DM,
            BWEBM,
            BIST,
*/
		sprintf(tmp_string, "      Q : out std_logic_vector(%d downto 0);\n", data_width-1);
		strcat (result_string, tmp_string);

		sprintf(tmp_string, "      A, AM : in std_logic_vector(%d downto 0) := TieHighSlvConstant(%d);\n", addr_width-1, addr_width);
		strcat (result_string, tmp_string);

		sprintf(tmp_string, "      D, DM, BWEB, BWEBM : in std_logic_vector(%d downto 0) := TieHighSlvConstant(%d);\n", data_width-1, data_width);
		strcat (result_string, tmp_string);

		sprintf(tmp_string, 
					"      SLP  :   IN   std_logic := '1'; --- ????? \n"
					"      SD   :   IN   std_logic := '1'; --- ????? \n"
					"      WEB  :   IN   std_logic;\n"
					"      CEB  :   IN   std_logic;\n");
		strcat (result_string, tmp_string);

		sprintf(tmp_string, 
	    			        "      WEBM : in std_logic := '1'; --- ????? \n"
				        "      CEBM : in std_logic := '1'; --- ????? \n"
            				"      AWT  : in std_logic := '1'; --- ????? \n"
            				"      BIST : in std_logic := '1'; --- ????? \n");
		strcat (result_string, tmp_string);

		sprintf(tmp_string, "      CLK:   IN   std_logic");
		strcat (result_string, tmp_string);
	}
	else 
	{
		assert(0);
	}
}


void generate_sac_port_map_string (const char* mem_type,char* result_string)
{
	if(strcmp(mem_type,"DP") == 0)
	{
		sprintf(result_string,
			"AA => ADDR_0, AB => ADDR_1, CLKA => CLK, CLKB => CLK,"
			" WEBA => WRITE_0_BAR, WEBB => WRITE_1_BAR, CEBA => ENABLE_0_BAR,"
			" CEBB => ENABLE_1_BAR,  DA => DATAIN_0, DB => DATAIN_1,"
			" BWEBA => DATA_TIE_LOW, BWEBB => DATA_TIE_LOW,"
			" QA => DATAOUT_0, QB => DATAOUT_1, "
			" SLP => TIE_LOW, SD => TIE_LOW, VG => TIE_LOW, VS => TIE_LOW, AWT => TIE_LOW,"	
			" CEBMA => TIE_HIGH, CEBMB => TIE_HIGH, WEBMA => TIE_HIGH, WEBMB => TIE_HIGH, "
      			" BWEBMA => DATA_TIE_HIGH, BWEBMB => DATA_TIE_HIGH, AMA => ADDR_TIE_HIGH,  AMB => ADDR_TIE_HIGH, "
      			" DMA => DATA_TIE_HIGH,  DMB => DATA_TIE_HIGH, BIST => TIE_LOW, "
      			" WTSEL => TIE_LOW_2,  RTSEL => TIE_LOW_2"
		);
	}
	else if(strcmp(mem_type,"1R1W") == 0)
	{	// basically a DPRAM.... use port A for write, port B for read.
		sprintf(result_string,
			"AA => ADDR_0, AB => ADDR_1, CLKA => CLK, CLKB => CLK,"
			" WEBA => ENABLE_0_BAR, WEBB => TIE_HIGH, CEBA => ENABLE_0_BAR,"
			" CEBB => ENABLE_1_BAR,  DA => DATAIN_0, DB => DATA_TIE_LOW,"
			" BWEBA => DATA_TIE_LOW, BWEBB => DATA_TIE_LOW,"
			" QA => OPEN, QB => DATAOUT_1, "
			" SLP => TIE_LOW, SD => TIE_LOW, VG => TIE_LOW, VS => TIE_LOW, AWT => TIE_LOW,"	
			" CEBMA => TIE_HIGH, CEBMB => TIE_HIGH, WEBMA => TIE_HIGH, WEBMB => TIE_HIGH, "
      			" BWEBMA => DATA_TIE_HIGH, BWEBMB => DATA_TIE_HIGH, AMA => ADDR_TIE_HIGH,  AMB => ADDR_TIE_HIGH, "
      			" DMA => DATA_TIE_HIGH,  DMB => DATA_TIE_HIGH, BIST => TIE_LOW, "
      			" WTSEL => TIE_LOW_2,  RTSEL => TIE_LOW_2"
		);
	}
	else if(strcmp(mem_type,"SP") == 0)
	{
		sprintf(result_string,
                                " A => ADDR,  CLK => CLK, WEB => WRITE_BAR,"
				" BWEB => DATA_TIE_LOW, CEB => ENABLE_BAR, "
				" D => DATAIN, Q => DATAOUT, "
				" SLP => TIE_LOW, SD => TIE_LOW, CEBM => TIE_HIGH, WEBM => TIE_HIGH,"
                                " BWEBM => DATA_TIE_HIGH, AM => ADDR_TIE_HIGH, DM => DATA_TIE_HIGH, BIST  => TIE_LOW"
			);
	}
	else
	{
		assert(0);
	}
}

void generate_sac_reverse_port_map_string (const char* mem_type,char* result_string)
{
	if(strcmp(mem_type,"DP") == 0)
	{
		sprintf(result_string,"ADDR_0 => AA, ADDR_1 => AB, CLK => CLKA,  WRITE_0_BAR => WEBA, WRITE_1_BAR => WEBB,   ENABLE_0_BAR => CEBA , ENABLE_1_BAR => CEBB, DATAIN_0 => DA, DATAIN_1 => DB, DATAOUT_0 => QA, DATAOUT_1 => QB");
	}
	else if(strcmp(mem_type,"1R1W") == 0)
	{
		sprintf(result_string,"ADDR_0 => AA, ADDR_1 => AB, CLK => CLKA,  ENABLE_0_BAR => CEBA , ENABLE_1_BAR => CEBB, DATAIN_0 => DA, DATAOUT_1 => QB");
	}
	else if(strcmp(mem_type,"SP") == 0)
	{
		sprintf(result_string,"ADDR => A, CLK => CLK, WRITE_BAR => WEB, ENABLE_BAR => CEB, DATAIN => D,  DATAOUT => Q");
	}
	else
	{
		assert(0);
	}
}


int getWordSpec(int tech_flag, int addr_width)
{
	if(tech_flag == SCL180)
		return (addr_width);
	else if(tech_flag == UMC65)
		return (1 << addr_width);
	else if(tech_flag == UMC65_2024)
		return (1 << addr_width);
	else if(tech_flag == SAC)
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

void printDummyCutConstants(FILE* f, const char* prefix)
{
	fprintf(f,"   constant %s_cut_row_heights : IntegerArray(1 to 2) := (2,4);\n", prefix);
	fprintf(f,"   constant %s_cut_address_widths : IntegerArray(1 to 2) := (1,2);\n",prefix);
	fprintf(f,"   constant %s_cut_data_widths : IntegerArray(1 to 2) := (1,2);\n",prefix);
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
	char port_string[16384];
	char port_map_string[16384];

	// scl and umc indexing of word count is different.
	int aspec = getWordSpec(tech_flag, addr_width);

	if(strcmp(entity_postfix, "ignore") != 0)
	{
		if(tech_flag == SAC)
			sprintf(entity_name,"%s_%dX%d", entity_prefix, aspec, data_width);
		else
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
	else if(tech_flag == UMC65_2024)
	{
		generate_umc65_2024_port_string(mem_type, addr_width, data_width, port_string);
		generate_umc65_2024_port_map_string(mem_type,  addr_width, data_width, port_map_string);
	}
	else if(tech_flag == SAC)
	{
		generate_sac_port_string(mem_type, addr_width, data_width, port_string);
		generate_sac_port_map_string(mem_type,  port_map_string);
	}
	else
	{
		assert(0);
	}
	
	if(!((tech_flag == SAC) && (strcmp (mem_type,"1R1W") == 0)))
	{
		fprintf(comp_decls_file, "  component %s is\n   port( %s);\n  end component;\n", entity_name, port_string);
	}

	fprintf(arch_file, "  %s_gen: if (address_width = %d) and (data_width = %d) generate\n",
					entity_name, addr_width, data_width);

	fprintf(arch_file, "     mc: block \n");
	fprintf(arch_file, "            signal DATA_TIE_LOW  : std_logic_vector(%d downto 0); \n", data_width-1);
	fprintf(arch_file, "            signal DATA_TIE_HIGH : std_logic_vector(%d downto 0); \n", data_width-1);
	fprintf(arch_file, "            signal ADDR_TIE_LOW  : std_logic_vector(%d downto 0); \n", addr_width-1);
	fprintf(arch_file, "            signal ADDR_TIE_HIGH : std_logic_vector(%d downto 0); \n", addr_width-1);
	fprintf(arch_file, "         begin \n");
	fprintf(arch_file, "              DATA_TIE_LOW <= (others => '0'); \n");
	fprintf(arch_file, "              DATA_TIE_HIGH <= (others => '1'); \n");
	fprintf(arch_file, "              ADDR_TIE_LOW <= (others => '0'); \n");
	fprintf(arch_file, "              ADDR_TIE_HIGH <= (others => '1'); \n");
	fprintf(arch_file,"               inst: %s\n   port map (%s);\n", entity_name, port_map_string);
	fprintf(arch_file, "         end block;\n");
	fprintf(arch_file, "  end generate %s_gen;\n", entity_name);
}

void printWrapperEntity(int tech_flag, char* mem_type,
				FILE* f,
				char* entity_prefix,
				int addr_width, int data_width,
				char* entity_postfix)
{
	char entity_name[1024];
	char port_string[16384];
	char reverse_port_map_string[16384];

	// scl and umc indexing of word count is different.
	int aspec = getWordSpec(tech_flag, addr_width);

	if(strcmp(entity_postfix, "ignore") != 0)
	{
		if(tech_flag == SAC)
			sprintf(entity_name,"%s_%dX%d", entity_prefix, aspec, data_width);
		else
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
	else if(tech_flag == UMC65_2024)
	{
		generate_umc65_2024_port_string(mem_type, addr_width, data_width, port_string);
		generate_umc65_2024_reverse_port_map_string(mem_type,  addr_width, data_width,
								reverse_port_map_string);
	}
	else if(tech_flag == SAC)
	{
		generate_sac_port_string(mem_type, addr_width, data_width, port_string);
		generate_sac_reverse_port_map_string(mem_type,  reverse_port_map_string);
	}
	else
	{
		assert(0);
	}

	
	fprintf(f,"library ieee;\n");
	fprintf(f,"use ieee.std_logic_1164.all;\n");
	fprintf(f,"library ahir;\n");
	fprintf(f,"use ahir.mem_component_pack.all;\n");
	fprintf(f,"use ahir.types.all;\n");
	fprintf(f,"use ahir.utilities.all;\n");
	
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
	else if((tech_flag == UMC65) || (tech_flag == UMC65_2024))
	{
		if(strcmp(mem_type,"DP") == 0)
		{
			fprintf(f,"  %s_wrap_inst: dpram_generic_reverse_wrapper \n", entity_name);
		}
		else if(strcmp(mem_type,"SP") == 0)
		{
			fprintf(f,"  %s_wrap_inst: spram_generic_reverse_wrapper \n", entity_name);
		}
		else if (strcmp(mem_type,"1R1W") == 0)
		{
			fprintf(f,"  %s_wrap_inst: register_file_1w_1r_generic_reverse_wrapper \n", entity_name);
		}
		else
			assert(0);

		fprintf(f,"       generic map (address_width => %d, data_width => %d)\n",
						addr_width, data_width);
		fprintf(f,"   port map (%s);\n", reverse_port_map_string);
	}
	else if(tech_flag == SAC)
	{
		if(strcmp(mem_type,"DP") == 0)
		{
			fprintf(f,"  %s_wrap_inst: dpram_generic_reverse_wrapper \n", entity_name);
		}
		else if((strcmp(mem_type,"SP") == 0))
		{
			fprintf(f,"  %s_wrap_inst: spram_generic_reverse_wrapper \n", entity_name);
		}
		else  if(strcmp (mem_type,"1R1W") != 0)
		{
			assert(0);
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


				
