#! /usr/bin/python

# function for printing header
def print_header():
	op_file = open ("TB_wrapper.vhd","w")
	lines = [" library ieee;\
        \n use ieee.std_logic_1164.all;\
        \n use ieee.numeric_std.all;\
        \n \
        \n library ahir;\
        \n use ahir.Types.all;\
        \n use ahir.Subprograms.all;\
        \n use ahir.Utilities.all;\
        \n use ahir.BaseComponents.all;\
        \n "]
	op_file.writelines(lines)
	op_file.close()

def print_entity():
	op_file = open ("TB_wrapper.vhd","a")
	lines = [" \n entity TB_wrapper is\
        \n   port\
        \n     (all_tests_succeeded : out boolean;\
        \n      all_tests_evaluated : out boolean);\
        \n end TB_wrapper;\
        \n "]
	op_file.writelines(lines)
	op_file.close()

def print_arch_dec(count):
	op_file = open ("TB_wrapper.vhd","a")
	lines = ["\n architecture Behave of TB_wrapper is\
        \n   signal done_flag    : BooleanArray(",str(3*count - 1)," downto 0);\
        \n   signal success_flag : BooleanArray(",str(3*count - 1)," downto 0);\
        \n \
        \n begin\
        \n "] 
	op_file.writelines(lines)
	op_file.close()

def print_arch_inst (operator, operator_id,operator_type,input_data_width,output_data_width,count):	
	op_file = open ("TB_wrapper.vhd","a")
	lines = [" \n   tb",str(count)," : ",operator_type,"_TB generic map(g_num_req           => 1,\
        \n                               g_input_data_width  => ",input_data_width,",\
        \n                               g_output_data_width => ",output_data_width,",\
        \n                               verbose_mode        => false,\
        \n                               operator_id         => \"",operator_id,"\",\
        \n                               tb_id               => \"",operator," num_req=1\"\
        \n                               )\
        \n     port map\
        \n     (all_tests_succeeded => success_flag(",str(count),"),\
        \n      all_tests_evaluated => done_flag(",str(count),"));\
        \n \
        \n   tb",str(count+1)," : ",operator_type,"_TB generic map(g_num_req           => 2,\
        \n                               g_input_data_width  => ",input_data_width,",\
        \n                               g_output_data_width => ",output_data_width,",\
        \n                               verbose_mode        => false,\
        \n                               operator_id         => \"",operator_id,"\",\
        \n                               tb_id               => \"",operator," num_req=2\"\
        \n                               )\
        \n     port map\
        \n     (all_tests_succeeded => success_flag(",str(count+1),"),\
        \n      all_tests_evaluated => done_flag(",str(count+1),"));\
        \n \
        \n   tb",str(count+2)," : ",operator_type,"_TB generic map(g_num_req           => 5,\
        \n                               g_input_data_width  => ",input_data_width,",\
        \n                               g_output_data_width => ",output_data_width,",\
        \n                               verbose_mode        => false,\
        \n                               operator_id         => \"",operator_id,"\",\
        \n                               tb_id               => \"",operator," num_req=5\"\
        \n                               )\
        \n     port map\
        \n     (all_tests_succeeded => success_flag(",str(count+2),"),\
        \n      all_tests_evaluated => done_flag(",str(count+2),"));\
        \n "] 
	op_file.writelines(lines)
	op_file.close()

def print_process ():
	op_file = open ("TB_wrapper.vhd","a")
	lines = [" \n   process(done_flag)\
        \n   begin\
        \n     if(AndReduce(done_flag))then\
        \n       all_tests_evaluated <= true;\
        \n       if(AndReduce(success_flag)) then\
        \n      assert false report \"All Tests Have Passed  \" severity note;\
        \n      all_tests_succeeded <= true;\
        \n       else\
        \n      assert false report \"Some Tests Have Failed \" severity error;\
        \n      all_tests_succeeded <= false;\
        \n       end if;\
        \n     else\
        \n       all_tests_evaluated <= false;\
        \n     end if;\
        \n   end process;\
        \n \
        \n end Behave;\
        \n \
        \n -------------------------------------------------------\
        \n configuration conf_TB of TB_wrapper is\
        \n \
        \n   for Behave"] 
	op_file.writelines(lines)
	op_file.close()

def print_config (operator, operator_id,operator_type,input_data_width,output_data_width,count):
	op_file = open ("TB_wrapper.vhd","a")
	lines = [" \n     for tb",str(count)," : ",operator_type,"_TB\
        \n       for Behave\
        \n         for op2 : ",operator_type,"\
        \n           use configuration ahir.",operator,";\
        \n         end for;\
        \n       end for;\
        \n     end for;\
	\n     for tb",str(count + 1)," : ",operator_type,"_TB\
        \n       for Behave\
        \n         for op2 : ",operator_type,"\
        \n           use configuration ahir.",operator,";\
        \n         end for;\
        \n       end for;\
        \n     end for;\
 	\n     for tb",str(count+2)," : ",operator_type,"_TB\
        \n       for Behave\
        \n         for op2 : ",operator_type,"\
        \n           use configuration ahir.",operator,";\
        \n         end for;\
        \n       end for;\
        \n     end for;"] 
	op_file.writelines(lines)
	op_file.close()

def print_config_closing ():
	op_file = open("TB_wrapper.vhd","a")
	lines = ["\n   end for;\
        \n \
        \n end conf_TB;"]
        op_file.writelines(lines)
        op_file.close()



# main script starts here
f = open('template.txt')
count = 0
for line in f:
	if not (line.startswith('#')):
		count = count + 1
f.close()

print_header()
print_entity()
print_arch_dec(count)

f = open('template.txt') 
count = 0
for line in f:
	if not(line.startswith("#")):  # ignoring comments in template.txt
		word = line.split()
		if (len(word) != 5):   # checking for number of arguements 
			print "error in :" ,line
		else :
			print_arch_inst(word[0], word[1], word[2], word[3], word[4],count) 
			count = count + 3
f.close()

print_process()

f = open('template.txt') 
count = 0
for line in f:
	if not(line.startswith("#")):  # ignoring comments in template.txt
		word = line.split()
		if (len(word) != 5):   # checking for number of arguements 
			print "error in :" ,line
		else :
			print_config(word[0], word[1], word[2], word[3], word[4],count) 
			count = count + 3
f.close()

print_config_closing()

