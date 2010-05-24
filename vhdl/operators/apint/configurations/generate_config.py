#! /usr/bin/python

def print_header():
	op_file = open("all_apint_configurations.vhd","w")
	lines = [" library ieee;\
        \n use ieee.std_logic_1164.all;\
        \n library ahir;\
        \n use ahir.Types.all;\
        \n use ahir.Components.all;\
        \n use ahir.BaseComponents.all;\
        \n "]
	op_file.writelines(lines)
	op_file.close()

# function for printing vhdl configurations
def print_vhd(operator,operator_id,entity,architecture,op_entity,op_architecture,zero_delay):
	op_file = open("all_apint_configurations.vhd", "a")
        lines = ["\n configuration ", operator, " of ", entity, " is\
        \n   for ",architecture,"\
        \n     for op : ",op_entity,"\
        \n       use entity ahir.",op_entity,"(",op_architecture,")\
        \n         generic map (\
        \n           colouring => colouring,\
        \n           const_operand => const_operand,\
        \n           operator_id => \"",operator_id,"\",\
        \n           use_constant => use_constant,\
        \n           suppress_immediate_ack => suppress_immediate_ack,\
        \n           zero_delay  => ",zero_delay,");\
        \n     end for;\
        \n   end for;\
        \n end ",operator,"; \n\n"]
	op_file.writelines(lines)
	op_file.close()
# end print_vhd

# main script starts here
print_header()
f = open('template.txt')
for line in f:
	if not(line.startswith("#")):  # ignoring comments in template.txt
		word = line.split()
		if (len(word) != 7):   # checking for number of arguements 
			print "error in :" ,line
		else :
			print_vhd(word[0], word[1], word[2], word[3], word[4], word[5], word[6]) 

