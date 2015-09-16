#include <istream>
#include <ostream>
#include <assert.h>
#include <hierSystem.h>
#include <rtlThread.h>
#include <rtlType.h>

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

	
rtlIntegerType::rtlIntegerType(int low, int high): rtlType()
{
	assert (_low <= _high);

	_low = low;
	_high = high;
}
  	
void rtlIntegerType::Print(ostream& ofile)
{
	ofile << " $integer " << _low << " to " << _high << " " << endl;
}

void rtlUnsignedType::Print(ostream& ofile)
{
	ofile << " $unsigned<" << _width << ">" << endl;
}

void rtlSignedType::Print(ostream& ofile)
{
	ofile << " $signed<" << _width << ">" << endl;
}

rtlArrayType::rtlArrayType( rtlType* element_type, vector<int>& dimensions): rtlType()
{
	_element_type = element_type;
	_dimensions = dimensions;
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
		rtlType* ret_type = new rtlIntegerType(low_val, high_val);
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
		rtlType* ret_type = new rtlUnsignedType(width);
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
		rtlType* ret_type = new rtlSignedType(width);
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
		rtlType* ret_type = new rtlArrayType(element_type, dims);
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
