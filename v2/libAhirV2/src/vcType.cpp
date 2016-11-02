//
// Copyright (C) 2010-: Madhav P. Desai
// All Rights Reserved.
//  
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the
// "Software"), to deal with the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
//  * Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimers.
//  * Redistributions in binary form must reproduce the above
//    copyright notice, this list of conditions and the following
//    disclaimers in the documentation and/or other materials provided
//    with the distribution.
//  * Neither the names of the AHIR Team, the Indian Institute of
//    Technology Bombay, nor the names of its contributors may be used
//    to endorse or promote products derived from this Software
//    without specific prior written permission.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR
// ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS WITH THE SOFTWARE.
#include <vcType.hpp>
#include <vcMemorySpace.hpp>
#include <vcModule.hpp>
#include <vcSystem.hpp>

// global maps.
map<string, vcType*> _type_map;
vector<vcType*> _type_vector;


vcType::vcType(): vcRoot()
{
}
vcScalarTypeTemplate::vcScalarTypeTemplate(string width): vcType()
{
  this->_int_flag = true;
  this->_float_flag = false;
  this->_width = width;
}
vcScalarTypeTemplate::vcScalarTypeTemplate(string characteristic, string mantissa):vcType()
{
  this->_int_flag = false;
  this->_float_flag = true;
  this->_characteristic = characteristic;
  this->_mantissa = mantissa;
}

void vcScalarTypeTemplate::Print(ostream& ofile)
{
  if(this->_int_flag)
    ofile << vcLexerKeywords[__INT] << " <" << this->_width << "> ";
  else if(this->_float_flag)
    ofile << vcLexerKeywords[__FLOAT] << " <" << this->_characteristic << "," << this->_mantissa << "> ";
  else
    assert(0);
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

vcPointerType::vcPointerType(vcMemorySpace* ms):vcIntType(ms->Get_Address_Width())
{
  this->_memory_space = ms;
}
vcMemorySpace* vcPointerType::Get_Memory_Space()
{
  return(this->_memory_space);
}

void vcPointerType::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__POINTER] << "<";

  if(this->_memory_space->Get_Scope_Id() != "")
    ofile << this->_memory_space->Get_Scope_Id() << vcLexerKeywords[__SLASH];

  ofile << this->_memory_space->Get_Id() << "> ";
}

int vcPointerType::Size()
{
  return(this->_memory_space->Get_Address_Width());
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

vcArrayType::vcArrayType(vcType* stype, int dimension): vcType()
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
  for(int idx = 0; idx < this->_element_types.size(); idx++)
    {
      if(idx > 0) ofile << ", ";
      this->Get_Element_Type(idx)->Print(ofile);
    }
  ofile << "] ";
}


void Add_Type(string tid, vcType* t)
{
  _type_map[tid] = t;
  _type_vector.push_back(t);
  t->Set_Index(_type_vector.size());
}

vcIntType* Make_Integer_Type(unsigned int w)
{
  vcIntType* ret_type = NULL;
  string tid = "int<" + IntToStr(w) + ">";
  std::map<string,vcType*>::iterator titer = _type_map.find(tid);
  if(titer != _type_map.end())
    {
      assert((*titer).second->Is("vcIntType"));
      ret_type = (vcIntType*) (*titer).second;
    }
  else
    {
      ret_type = new vcIntType(w);
      Add_Type(tid,ret_type);
    }
  return(ret_type);
}

vcFloatType* Make_Float_Type(unsigned int c, unsigned int m)
{
  vcFloatType* ret_type = NULL;
  string tid = "float<" + IntToStr(c) + "," + IntToStr(m) + ">";
  std::map<string,vcType*>::iterator titer = _type_map.find(tid);
  if(titer != _type_map.end())
    {
      assert((*titer).second->Is("vcFloatType"));
      ret_type = (vcFloatType*) (*titer).second;
    }
  else
    {
      ret_type = new vcFloatType(Make_Integer_Type(c),Make_Integer_Type(m));
      Add_Type(tid,ret_type);
    }
  return(ret_type);
}
vcArrayType* Make_Array_Type(vcType* etype, unsigned int dim)
{
  vcArrayType* ret_type = NULL;
  string tid = "array<" + IntToStr(dim) + "> of " + IntToStr(etype->Get_Index());
  assert(etype->Get_Index() > 0);
  std::map<string,vcType*>::iterator titer = _type_map.find(tid);
  if(titer != _type_map.end())
    {
      assert((*titer).second->Is("vcArrayType"));
      ret_type = (vcArrayType*) (*titer).second;
    }
  else
    {
      ret_type = new vcArrayType(etype,dim);
      Add_Type(tid,ret_type);
    }
  return(ret_type);

}
vcRecordType* Make_Record_Type(vector<vcType*>& etypes)
{
  vcRecordType* ret_type = NULL;
  string tid = "record ";
  for(int idx = 0; idx < etypes.size(); idx++)
    {
      assert(etypes[idx]->Get_Index() > 0);
      tid += IntToStr(etypes[idx]->Get_Index()) + " ";
    }

  std::map<string,vcType*>::iterator titer = _type_map.find(tid);
  if(titer != _type_map.end())
    {
      assert((*titer).second->Is("vcRecordType"));
      ret_type = (vcRecordType*) (*titer).second;
    }
  else
    {
      ret_type = new vcRecordType(etypes);
      Add_Type(tid,ret_type);
    }
  return(ret_type);
}

vcPointerType* Make_Pointer_Type(vcSystem* sys, string scope_id, string space_id)
{
  vcPointerType* ret_type = NULL;
  string tid = "pointer " + scope_id + " " + space_id;

  std::map<string,vcType*>::iterator titer = _type_map.find(tid);
  if(titer != _type_map.end())
    {
      assert((*titer).second->Is("vcPointerType"));
      ret_type = (vcPointerType*) (*titer).second;
    }
  else
    {

      vcMemorySpace* ms = NULL;
      if(scope_id == "")
	ms = sys->Find_Memory_Space(space_id);
      else 
	{
	  vcModule* m = sys->Find_Module(scope_id);
	  if(m == NULL)
	    {
	      sys->Error("did not find module " + scope_id );
	    }
	  else
	    ms = m->Find_Memory_Space(space_id);
	}

      ret_type = new vcPointerType(ms);
      Add_Type(tid,ret_type);
    }
  return(ret_type);
}

