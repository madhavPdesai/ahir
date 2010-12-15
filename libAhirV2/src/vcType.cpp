#include <vcType.hpp>

vcType::vcType(): vcRoot()
{
}
vcScalarTypeTemplate::vcScalarTypeTemplate(string width): vcRoot()
{
  this->_int_flag = true;
  this->_float_flag = false;
  this->_width = width;
}
vcScalarTypeTemplate::vcScalarTypeTemplate(string characteristic, string mantissa):vcRoot()
{
  this->_int_flag = false;
  this->_float_flag = true;
  this->_characteristic = characteristic;
  this->_mantissa = mantissa;
}

vcScalarType::vcScalarType():vcType()
{
}

vcIntType::vcIntType(unsigned int width):vcScalarType()
{
  this->_width = width;
}

void vcIntType::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__INT] << " <" << this->Size() << "> ";
}

vcPointerType::vcPointerType(string mem_space_id):vcScalarType()
{
  this->_memory_space_name = mem_space_id;
  this->_memory_space = NULL;
}
void vcPointerType::Set_Memory_Space(vcRoot* ms)
{
  this->_memory_space = ms;
}
vcRoot* vcPointerType::Get_Memory_Space()
{
  return(this->_memory_space);
}

void vcPointerType::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__POINTER] << "<" << this->_memory_space_name << "> ";
}

int vcPointerType::Size()
{
  return(this->_memory_space->Get_Pointer_Size());
}

vcFloatType::vcFloatType(vcIntType* ctype, vcIntType* mtype):vcScalarType()
{
  this->_characteristic_type = ctype;
  this->_mantissa_type = mtype;
}
void vcFloatType::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__FLOAT] << "<" << this->Get_Characteristic_Width() << "," << this->Get_Mantissa_Width() << "> ";
}

vcArrayType::vcArrayType(vcScalarType* stype, int dimension): vcType()
{
  assert(stype);
  this->_dimension = dimension;
  this->_element_type = stype;
}

void  vcArrayType::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__ARRAY] << "[" << this->Get_Dimension() << "] " << vcLexerKeywords[__OF] << " ";
  this->Get_Element_Type()->Print(ofile);
  ofile << " ";
}

vcRecordType::vcRecordType(vector<vcType*>& element_types):vcType()
{
  for(int index = 0; index < element_types.size(); index++)
    this->_element_types.push_back(element_types[index]);
}

void vcRecordType::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__RECORD] << "[ " ;
  for(int idx = 0; idx < this->_element_types.size(); i++)
    {
      if(idx > 0) ofile << ", ";
      this->Get_Element_Type()->Print(ofile);
    }
  ofile << "] ";
}
