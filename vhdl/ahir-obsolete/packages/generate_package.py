#! /usr/bin/python

# function for printing header
def print_header():
	op_file = open("OperatorPackage.vhd", "w")
	lines =["library ieee;\
	\nuse ieee.std_logic_1164.all;\
	\nuse ieee.numeric_std.all;\
	\n\
	\nlibrary ahir;\
	\nuse ahir.Types.all;\
	\nuse ahir.Subprograms.all;\
	\n\
	\nlibrary ieee_proposed;\
	\nuse ieee_proposed.math_utility_pkg.all;\
	\nuse ieee_proposed.fixed_pkg.all;\
	\nuse ieee_proposed.float_pkg.all;\
	\n\n"]
	op_file.writelines(lines)
	op_file.close()
# end print_header

# prints package declaration
def print_package_declaration():
	op_file = open("OperatorPackage.vhd", "a")
	op_file.write("package OperatorPackage is\n\n")

	f = open('template.txt')
	for line in f:
		if not(line.startswith("#")):  # ignoring comments in template.txt
			meta_word = line.split('--')
	
			op_name_info = meta_word[0].split()
			proc_name = op_name_info[0] + "_proc"
	
			in_info = meta_word[1].split()

			if (len(in_info) == 3):
				line = ["  procedure " ,proc_name,"(l: in ",in_info[1],"; r : in ",in_info[2]]
			elif (len(in_info) == 2):
				line = ["  procedure " ,proc_name,"(l: in ",in_info[1] ]
			else:
				print "Error : Number of input operands should be 1 or 2"

			out_info = meta_word[2].split()
			if (len(out_info) == 2):
				line = line + ["; result : out ",out_info[1],");\n"]
			else:
				print "Error : Number of output operands should be 1 "

			op_file.writelines(line)
	
	
	op_file.write("\n  procedure TwoInputOperation(constant id    : in string; x, y : in IStdLogicVector; result : out IStdLogicVector);\n")
	op_file.write("  procedure SingleInputOperation(constant id : in string; x : in IStdLogicVector; result : out IStdLogicVector);\n\n")
	op_file.write("end package OperatorPackage;\n\n")

	op_file.close()
	f.close()
# package declaration ends here

# prints package body
def print_package_body():
	op_file = open("OperatorPackage.vhd", "a")
	op_file.write("package body OperatorPackage is\n\n")

	line_two_ip = ["\n   -----------------------------------------------------------------------------\
	\n  procedure TwoInputOperation(constant id : in string; x, y : in IStdLogicVector; result : out IStdLogicVector) is\
	\n    variable result_var : IStdLogicVector(result'high downto result'low);\
	\n  begin\n"]
	line_one_ip = ["\n  -----------------------------------------------------------------------------\n\
	\n  -----------------------------------------------------------------------------\
	\n  procedure SingleInputOperation(constant id : in string; x : in IStdLogicVector; result : out IStdLogicVector) is\
	\n    variable result_var : IStdLogicVector(result'high downto result'low);\
	\n  begin\n"]
	two_ip_flag = 0
	one_ip_flag = 0


	f = open('template.txt')
	for line in f:
		if not(line.startswith("#")):  # ignoring comments in template.txt
			meta_word = line.split('--')
	
			op_name_info = meta_word[0].split()
			proc_name = op_name_info[0] + "_proc"
			assertion_status = op_name_info[1]
	
			in_info = meta_word[1].split()
			out_info = meta_word[2].split()

			if (meta_word[3].startswith("operator")):
				operator_type = "operator"
				operator = meta_word[3].split("operator");
			elif (meta_word[3].startswith("string")):
				operator_type = "string"
				operator = meta_word[3].split("string")
			else :
				print "Error unknown operator type in line:", line

			# printing starts
			op_file.write("  -----------------------------------------------------------------------------\n")
			if (len(in_info) == 3 and len(out_info) == 2):
				line = ["  procedure " ,proc_name," (l : in ",in_info[1],"; r : in ",in_info[2],"; result : out ",out_info[1],") is\
					\n  begin\n"]
				if (assertion_status == "on"):
					line = line +["    assert (l'length = r'length) and (l'length = result'length)\
						     \n      report \"Length Mismatch in", proc_name,"\" severity error;\n"]
			
				if (operator_type == "operator"):
					line = line +["    result := To_ISLV(to_",in_info[1],"(to_signed(l) ",operator[1].rstrip()," to_signed(r)));\n"]
				elif (operator_type == "string"):
					line = line + [operator[1]]
			
				line = line + ["  end ",proc_name,"; \
				\n  ---------------------------------------------------------------------\n"]

				## for TwoInputOperation
				if (two_ip_flag == 0):
					line_two_ip = line_two_ip +["    if id = \"",op_name_info[0],"\" then\
					\n      ",proc_name,"(To_",in_info[1],"(x), To_",in_info[2],"(y), result_var);\n"]
					two_ip_flag = 1;
				elif (two_ip_flag == 1):
					line_two_ip = line_two_ip +["    elsif id = \"",op_name_info[0],"\" then\
					\n      ",proc_name,"(To_",in_info[1],"(x), To_",in_info[2],"(y), result_var);\n"]
			
			
			elif (len(in_info) == 2 and len(out_info) == 2):
				line = ["  procedure " ,proc_name," (l : in ",in_info[1],"; result : out ",out_info[1],") is\
					\n  begin\n"]
				if (assertion_status == "on"):
					line = line +["    assert (l'length = result'length)\
						     \n      report \"Length Mismatch in", proc_name,"\" severity error;\n"]
			
				if (operator_type == "operator"):
					line = line +["    result := To_ISLV(to_",in_info[1],"(",operator[1].rstrip()," to_signed(l)));\n"]
				elif (operator_type == "string"):
					line = line + [operator[1] ]
			
				line = line + ["  end ",proc_name,"; \
				\n  ---------------------------------------------------------------------\n"]
		
				## for SingleInputOperation
				if (one_ip_flag == 0):
					line_one_ip = line_one_ip +["    if id = \"",op_name_info[0],"\" then\
					\n      ",proc_name,"(To_",in_info[1],"(x), result_var);\n"]
					one_ip_flag = 1;
				elif (one_ip_flag == 1):
					line_one_ip = line_one_ip +["    elsif id = \"",op_name_info[0],"\" then\
					\n      ",proc_name,"(To_",in_info[1],"(x), result_var);\n"]
			
		
			op_file.writelines(line)	

	f.close()

	line_two_ip = line_two_ip + ["    else\
	\n      assert false report \"Unsupported operator-id \" & id severity failure;\
	\n    end if;\
	\n    result := result_var;\
	\n  end TwoInputOperation;\
			"]

	line_one_ip = line_one_ip + ["    else\
	\n      assert false report \"Unsupported operator-id \" & id severity failure;\
	\n    end if;\
	\n    result := result_var;\
	\n  end SingleInputOperation;\
	\n\
	\n\
	\nend package body OperatorPackage;\
	"]

	op_file.writelines(line_two_ip)
	op_file.writelines(line_one_ip)
	op_file.close()

# package body ends here

# main script starts here
print_header()
print_package_declaration()
print_package_body()

