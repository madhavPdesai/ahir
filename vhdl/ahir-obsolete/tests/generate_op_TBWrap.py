#! /usr/bin/python

def print_header():
	op_file = open("tb_wrapper.vhd", "w")
	lines = ["library ieee;\
		\nuse ieee.std_logic_1164.all;\
		\nuse ieee.numeric_std.all;\
		\n\
		\nlibrary ahir;\
		\nuse ahir.Types.all;\
		\nuse ahir.Subprograms.all;\
		\nuse ahir.Utilities.all;\
		\nuse ahir.OperatorTBComponents.all;\n\n"
		]
	op_file.writelines(lines)
	op_file.close()
# end print_header

def print_entity():
	op_file = open("tb_wrapper.vhd","a")
	lines = ["entity tb_wrapper is\
		\n  port\
		\n    (all_tests_succeeded : out boolean;\
		\n     all_tests_evaluated : out boolean);\
		\nend tb_wrapper;\n\n"]
	op_file.writelines(lines)
	op_file.close()

def print_arch(count):
	op_file = open("tb_wrapper.vhd","a")
	count = count - 1
        line = ["architecture Behave of tb_wrapper is\
        	\n  signal done_flag    : BooleanArray(",str(count)," downto 0);\
        	\n  signal success_flag : BooleanArray(",str(count)," downto 0);\
        	\n\
        	\nbegin\n\n"]
	f = open('template.txt')
	count = 0
	for line_in in f:
		if not(line_in.startswith("#")):
			words = line_in.split("--")
			if (len(words) != 4):
				print "error in :",line_in
			else :
				word = words[0].split()
				input_file = word[0]
				op_id 	   = word[1]

				word = words[1].split()
				if (len(word) == 3):
					op_type = "two_operands"
					input_1 = word[1].split(",")
					input_2 = word[2].split(",")
				else :
					op_type = "single_operand"
					input_1 = word[1].split(",")

				word = words[2].split()
				output_1 = word[1].split(",")

		        	if (op_type == "two_operands"):
		        		line = line + ["  tb",str(count)," : tb_two_operands\
		        				\n    generic map(g_file_name   => \"",input_file,"\",\
		        				\n		g_input1_high => ",input_1[0],",\
		        				\n		g_input1_low  => ",input_1[1],",\
		        				\n		g_input2_high => ",input_2[0],",\
		        				\n		g_input2_low  => ",input_2[1],",\
		        				\n		g_operator_id => \"",op_id,"\",\
		        				\n		g_output_high => ",output_1[0],",\
		        				\n		g_output_low  => ",output_1[1],")\
		        				\n\
		        				\n    port map(all_tests_done   => done_flag(",str(count),"),\
		        				\n	     all_tests_passed => success_flag(",str(count),"));\n\n"]

		        	else :
		        		line = line + ["  tb",str(count)," : tb_single_operand\
		        				\n    generic map(g_file_name   => \"",input_file,"\",\
		        				\n		g_input1_high => ",input_1[0],",\
		        				\n		g_input1_low  => ",input_1[1],",\
		        				\n		g_operator_id => \"",op_id,"\",\
		        				\n		g_output_high => ",output_1[0],",\
		        				\n		g_output_low  => ",output_1[1],")\
		        				\n\
		        				\n    port map(all_tests_done   => done_flag(",str(count),"),\
		        				\n	     all_tests_passed => success_flag(",str(count),"));\n\n"]

				count = count +1
	
        line = line + ["  process(done_flag)\
        		\n  begin\
        		\n    if(AndReduce(done_flag))then\
        		\n      all_tests_evaluated <= true;\
        		\n      if(AndReduce(success_flag)) then\
        		\n	assert false report \"All Tests Have Passed  \" severity note;\
        		\n	all_tests_succeeded <= true;\
        		\n      else\
        		\n	assert false report \"Some Tests Have Failed \" severity error;\
        		\n	all_tests_succeeded <= false;\
        		\n      end if;\
        		\n    else\
        		\n      all_tests_evaluated <= false;\
        		\n    end if;\
        		\n  end process;\
        		\n\
        		\nend Behave;\n"]	
        op_file.writelines(line)
	op_file.close()

# main script starts here
f = open('template.txt')
count = 0
for line in f:
	if not(line.startswith("#")):  # ignoring comments in template.txt
		count = count + 1
f.close()
print_header()
print_entity()
print_arch(count)
