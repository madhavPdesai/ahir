#include <istream>
#include <ostream>
#include <assert.h>
#include <hierSystem.h>
#include <rtlEnums.h>
#include <Value.hpp>
#include <rtlValue.h>
#include <rtlType.h>
#include <rtlThread.h>

map <rtlType*, string> type_to_identifier_map;
map <string, rtlType*> identifier_to_type_map;

rtlType::rtlType():hierRoot()
{
}

void rtlType::Print(ostream& ofile)
{
	assert(0);
}

void rtlType::Print(ofstream& ofile)
{
  ostream *outstr = &ofile;
  this->Print(*outstr);
}

void rtlType::Print(string& ostring)
{
  ostringstream string_stream(ostringstream::out);
  this->Print(string_stream);
  ostring += string_stream.str();
}

	
string rtlType::Get_Name()
{
	string ret_val;	
	this->Print(ret_val);
	return(ret_val);
}

rtlIntegerType::rtlIntegerType(int low, int high): rtlType()
{
	assert (_low <= _high);

	_low = low;
	_high = high;
}
  	
  
void rtlIntegerType::Print_C_Struct_Field_Initialization(string prefix, rtlValue* v, ostream& ofile)
{
	ofile << prefix << " = " << ((v != NULL) ? v->To_Integer() : 0);
}

void rtlIntegerType::Print(ostream& ofile)
{
	ofile << " $integer " << _low << " to " << _high << " " ;
}

void rtlUnsignedType::Print_C_Struct_Field_Initialization(string prefix, rtlValue* v, ostream& ofile)
{
	// TODO.
	ofile << "init_bit_vector(&(" << prefix << "), " << this->Size() << ");" << endl;
	ofile << "bit_vector_clear(&(" << prefix << "));" << endl;
	if(v != NULL)
	{
		string init_string =  v->To_Bit_Vector_String();
		ofile << "bit_vector_assign_string(&(" << prefix << "),\"" << init_string << "\");" << endl;
	}
}



void rtlUnsignedType::Print(ostream& ofile)
{
	ofile << " $unsigned<" << _width << "> ";
}


void rtlSignedType::Print(ostream& ofile)
{
	ofile << " $signed<" << _width << "> ";
}

rtlArrayType::rtlArrayType( rtlType* element_type, vector<int>& dimensions): rtlType()
{
	_element_type = element_type;
	assert(_element_type->Is_Scalar_Type());
	_dimensions = dimensions;
}

void rtlArrayType::Print_C_Struct_Field_Initialization(string prefix, rtlValue* v, ostream& ofile) 
{
	string ele_type = this->Get_Element_Type()->Get_C_Name();
	ofile << "{" << endl;
	ofile << ele_type << "* __tmp_ptr = (" << ele_type << "*) &(" << prefix << ");" << endl;
	
	for(int I = 0, fI = this->Number_Of_Elements(); I < fI; I++)
	{
		string eprefix = "*(__tmp_ptr + " + IntToStr(I) + ")";
		rtlValue* ev = ((v != NULL) ?  v->Get_Value(I) : NULL);
		_element_type->Print_C_Struct_Field_Initialization(eprefix, ev, ofile);
	}
	ofile << "}" << endl;
}

  
void rtlArrayType::Print_C_Assignment_To_File(string dest, string src, ostream& ofile)
{
	string ele_type = this->Get_Element_Type()->Get_C_Name();
	ofile << "{" << endl;
	ofile << ele_type << "* __dest_ptr = (" << ele_type << "*) &(" << dest << ");" << endl;
	ofile << ele_type << "* __src_ptr  = (" << ele_type << "*) &(" << src << ");" << endl;
	
	for(int I = 0, fI = this->Number_Of_Elements(); I < fI; I++)
	{
		string dest_prefix = "*(__dest_ptr + " + IntToStr(I) + ")";
		string src_prefix  = "*(__src_ptr + " + IntToStr(I) + ")";
		Print_C_Assignment(dest_prefix, src_prefix, _element_type, ofile);
	}
	ofile << "}" << endl;
}

void rtlArrayType::Print(ostream& ofile)
{
	string ret_name =  string( "$array");
	for(int I = 0, fI = _dimensions.size();  I < fI; I++)
	{
		ret_name += "[" + IntToStr(_dimensions[I]) + "]";
	}
	ret_name += " $of ";
	ret_name += this->Get_Element_Type()->Get_Name();
	ofile << ret_name << " ";
}

rtlType* Find_Or_Make_Integer_Type(int low_val, int high_val)
{
	string lookup_id = "int_" + IntToStr(low_val) + "_to_" + IntToStr(high_val);
	rtlType* ret_type  = NULL;

	if(identifier_to_type_map.find(lookup_id) == identifier_to_type_map.end())
	{
		ret_type = new rtlIntegerType(low_val, high_val);
		identifier_to_type_map[lookup_id] = ret_type;
		type_to_identifier_map[ret_type] = lookup_id;
	}
	else
	{
		ret_type = identifier_to_type_map[lookup_id];
	}
	return(ret_type);
}

rtlType* Find_Or_Make_Unsigned_Type(int width)
{
	string lookup_id = "unsigned_" + IntToStr(width-1) + "_downto_0";
	rtlType* ret_type  = NULL;

	if(identifier_to_type_map.find(lookup_id) == identifier_to_type_map.end())
	{
		ret_type = new rtlUnsignedType(width);
		identifier_to_type_map[lookup_id] = ret_type;
		type_to_identifier_map[ret_type] = lookup_id;
	}
	else
	{
		ret_type = identifier_to_type_map[lookup_id];
	}
	return(ret_type);
}

rtlType* Find_Or_Make_Signed_Type(int width)
{
	string lookup_id = "signed_" + IntToStr(width-1) + "_downto_0";
	rtlType* ret_type  = NULL;

	if(identifier_to_type_map.find(lookup_id) == identifier_to_type_map.end())
	{
		ret_type = new rtlSignedType(width);
		identifier_to_type_map[lookup_id] = ret_type;
		type_to_identifier_map[ret_type] = lookup_id;
	}
	else
	{
		ret_type = identifier_to_type_map[lookup_id];
	}
	return(ret_type);
}


rtlType* Find_Or_Make_Array_Type(vector<int> dims, rtlType* element_type)
{
	string lookup_id = "array_";
	for(int I = 0, fI = dims.size(); I < fI; I++)
	{
		lookup_id += IntToStr(dims[I]) + "_";
	}
	lookup_id += Get_Type_Identifier(element_type);

	rtlType* ret_type  = NULL;

	if(identifier_to_type_map.find(lookup_id) == identifier_to_type_map.end())
	{
		ret_type = new rtlArrayType(element_type, dims);
		identifier_to_type_map[lookup_id] = ret_type;
		type_to_identifier_map[ret_type] = lookup_id;
	}
	else
	{
		ret_type = identifier_to_type_map[lookup_id];
	}
	return(ret_type);
}

// each type is assigned an identifier.
string   Get_Type_Identifier(rtlType* t)
{
	string ret_string = "";
	if(type_to_identifier_map.find(t) != type_to_identifier_map.end())
		ret_string = type_to_identifier_map[t];
	return(ret_string);	
}


void Print_Vhdl_Type_Declarations(string prefix, ostream& ofile)
{
	for(map<rtlType*, string>::iterator iter = type_to_identifier_map.begin(), fiter = type_to_identifier_map.end();
				iter != fiter; iter++)
	{
		rtlType* t = (*iter).first;
		string type_id = (*iter).second;

		if(t->Is("rtlIntegerType"))
		{
			rtlIntegerType* it = (rtlIntegerType*) t;
			ofile << "subtype " << type_id << " is integer range ";
			ofile << it->Get_Low() << " to " << it->Get_High() << ";" << endl;
		}
		else if(t->Is("rtlSignedType") || t->Is("rtlUnsignedType"))
		{
			rtlUnsignedType* ut = (rtlUnsignedType*) t;
			ofile << "subtype " << type_id << " is std_logic_vector("
							<< t->Size()-1 <<  " downto 0);" << endl;
		}
		else if(t->Is("rtlArrayType"))
		{
			rtlArrayType* at = (rtlArrayType*) t;
			ofile << "type " << type_id << "_unconstrained is " 
				<< "array (";
			for(int I = 0, fI = at->Get_Number_Of_Dimensions(); I < fI; I++)
			{
				ofile << " natural range";
				if(I < (fI -1))
					ofile << ", ";
			}
			ofile << ") of " << Get_Type_Identifier(at->Get_Element_Type()) << ";" << endl;
			ofile << "subtype " << type_id << " is " << type_id << " _unconstrained(";
			for(int I = 0, fI = at->Get_Number_Of_Dimensions(); I < fI; I++)
			{
				ofile << at->Get_Dimension(I)-1 << " downto 0";
				if(I < (fI -1))
					ofile << ", ";
			}
			ofile << ");" << endl;
		}
	}
}

