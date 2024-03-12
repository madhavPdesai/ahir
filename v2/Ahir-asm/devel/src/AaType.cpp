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
using namespace std;
#include <AaIncludes.h>
#include <AaEnums.h>
#include <AaUtil.h>
#include <AaRoot.h>
#include <AaScope.h>
#include <AaType.h>
#include <AaValue.h>
#include <AaExpression.h>
#include <AaObject.h>
#include <AaStatement.h>
#include <AaModule.h>
#include <AaProgram.h>


/*****************************************  TYPE ****************************/

//---------------------------------------------------------------------
// AaType
//---------------------------------------------------------------------
AaType::AaType(AaScope* p): AaRoot() {this->_scope = p;}
AaType::~AaType() {};

//---------------------------------------------------------------------
// AaScalarType
//---------------------------------------------------------------------
AaScalarType::AaScalarType(AaScope* p):AaType(p) {};
AaScalarType::~AaScalarType() {};

//---------------------------------------------------------------------
// AaUintType
//---------------------------------------------------------------------
AaUintType::AaUintType(AaScope* p, unsigned int width):AaScalarType(p) 
{
  this->_width = width;
}
AaUintType::~AaUintType() {};
void AaUintType::Print(ostream& ofile)
{
  ofile << "$uint<" << this->Get_Width() << ">";
}


//---------------------------------------------------------------------
// AaIntType
//---------------------------------------------------------------------
AaIntType::AaIntType(AaScope* p, unsigned int width):AaUintType(p, width) {};
AaIntType::~AaIntType() {};
void AaIntType::Print(ostream& ofile)
{
	ofile << "$int<" << this->Get_Width() << ">";
}

//---------------------------------------------------------------------
// AaPointerType: public AaUintType
//---------------------------------------------------------------------
AaPointerType::AaPointerType(AaScope* p, AaType* ref_type): AaUintType(p,AaProgram::_pointer_width) 
{
	_ref_type = ref_type;
};

AaPointerType::~AaPointerType() {};
void AaPointerType::Print(ostream& ofile)
{
	ofile << "$pointer< ";
	_ref_type->Print(ofile);
	ofile << " >";
}

AaType* AaPointerType::Get_Element_Type(int start_idx, vector<AaExpression*>& indices)
{
	AaType* ref_type = this->Get_Ref_Type();
	start_idx++;
	if(start_idx < indices.size())
	{
		ref_type = (ref_type->Get_Element_Type(start_idx,indices));
	}
	return(AaProgram::Make_Pointer_Type(ref_type));
}

void AaPointerType::Write_VC_Model(ostream& ofile)
{ 
	ofile << "$int<" << AaProgram::_pointer_width << "> " ;
}


//---------------------------------------------------------------------
//AaFloatType
//---------------------------------------------------------------------
AaFloatType::AaFloatType(AaScope* p, unsigned int characteristic, unsigned int mantissa):AaScalarType(p)
{
	this->_characteristic = characteristic;
	this->_mantissa = mantissa;
}
AaFloatType::~AaFloatType() {};
void AaFloatType::Print(ostream& ofile)
{
	ofile << "$float<" << this->Get_Characteristic() << "," << this->Get_Mantissa() << ">";
}

//---------------------------------------------------------------------
// AaArrayType
//---------------------------------------------------------------------
AaArrayType::AaArrayType(AaScope* p, AaType* stype, vector<unsigned int>& dimensions): AaType(p) 
{
	for(unsigned int i = 0; i < dimensions.size(); i++)
		this->_dimension.push_back(dimensions[i]);

	this->_element_type = stype;
}

AaArrayType::~AaArrayType() {};
unsigned int AaArrayType::Get_Dimension(unsigned int dim_id)
{
	unsigned int ret_value = 0;
	if(dim_id >= 0 && dim_id <= this->_dimension.size())
	{
		ret_value = this->_dimension[dim_id];
	}
	return(ret_value);
}
void AaArrayType::Print(ostream& ofile)
{
	ofile << "$array";
	for(unsigned int i = 0; i < this->Get_Number_Of_Dimensions(); i++)
		ofile << "[" << this->Get_Dimension(i) << "]";
  ofile << " $of ";
  this->Get_Element_Type()->Print(ofile);
}
AaType* AaArrayType::Get_Element_Type(int idx)
{
  assert(idx >= 0 && idx < _dimension.size());
  vector<unsigned int> edims;
  for(int i = idx+1; i < _dimension.size(); i++)
    {
      edims.push_back(_dimension[i]);
    }
  if(edims.size() > 0)
    return(AaProgram::Make_Array_Type(this->_element_type,edims));
  else
    return(this->_element_type);
}

AaType* AaArrayType::Get_Element_Type(int start_idx, vector<AaExpression*>& indices)
{
  // from indices[start_idx] to indices[indices.size()-1] 
  // is the depth of the  indexing.
  int depth = (indices.size() - start_idx);

  // if depth is less than or equal to the
  // dimension of the array type, then return
  // the element at depth-1
  if(depth <= this->_dimension.size())
    return(this->Get_Element_Type(depth-1));
  else
    // return the element of the element from start_idx + dim
    {
      return(this->Get_Element_Type()->Get_Element_Type(start_idx + this->_dimension.size(),
							indices));
    }
}

int AaArrayType::Get_Start_Bit_Offset(int start_index, vector<AaExpression*>& indices)
{
  assert(0);
}


//---------------------------------------------------------------------
// AaRecordType
//---------------------------------------------------------------------
AaRecordType::AaRecordType(AaScope* s, string name):AaType(s)
{
  _record_type_name = name;
  _is_named = true;
}

int AaRecordType::Get_Index_Value(AaExpression* expr)
{
  int idx = -1;
  AaValue* v = NULL;
  if(expr == NULL)
    return(-1);

  if(expr->Is("AaConstantLiteralReference"))
    {
      int type_width = CeilLog2(this->Get_Number_Of_Elements()-1);
      v = Make_Aa_Value(this->Get_Scope(),
			AaProgram::Make_Uinteger_Type(type_width),
			((AaConstantLiteralReference*)expr)->Get_Literals());

      idx = v->To_Integer();
    }
  else
    {
      expr->Evaluate();
      if(expr->Is_Constant())
	{
	  AaValue* val = expr->Get_Expression_Value();
	  if(val->Is_IntValue())
	    {
	      idx = val->To_Integer();
	    }
	  else
	    {
	      AaRoot::Error("Record index must be an integer",expr);
	    }
	}
      else
	AaRoot::Error("Record index must be a constant",expr);

    }

  return(idx);
}

AaType* AaRecordType::Get_Element_Type(int start_idx, vector<AaExpression*>& indices)
{
  AaExpression* expr = indices[start_idx];
  AaValue* v = NULL;
  int idx = this->Get_Index_Value(expr);
  
  if(idx >= 0 && idx < this->Get_Number_Of_Elements())
    {
      if(start_idx == indices.size()-1)
	return(this->Get_Element_Type(idx));
      else
	return(this->Get_Element_Type(idx)->Get_Element_Type(start_idx+1,indices));
    }
  else
    return(NULL);
}

AaType* AaRecordType::Get_Element_Type(AaExpression* expr)
{
  AaType* ret_type = NULL;
  int idx = this->Get_Index_Value(expr);
  if(idx >= 0 && idx < this->Get_Number_Of_Elements())
    ret_type = this->Get_Element_Type(idx);
  return(ret_type);
}

int AaRecordType::Get_Start_Bit_Offset(AaExpression* expr)
{
  AaValue* v = NULL;
  int ret_offset = 0;
  int idx = this->Get_Index_Value(expr);
  if(idx >= 0 && idx < this->Get_Number_Of_Elements())
    {
      for(int i=0; i < idx; i++)
	ret_offset += this->Get_Element_Type(i)->Size();
    }

  return(ret_offset);
}

int AaRecordType::Get_Start_Bit_Offset(int start_idx, vector<AaExpression*>& indices)
{
  int ret_offset = 0;

  AaExpression* expr = indices[start_idx];
  AaValue* v = NULL;
  int idx = this->Get_Index_Value(expr);
  if(idx >= 0 && idx < this->Get_Number_Of_Elements())
    {
      for(int i=0; i < idx; i++)
	ret_offset += this->Get_Element_Type(i)->Size();

      if(start_idx < indices.size()-1)
	ret_offset+= (this->Get_Element_Type(idx)->Get_Start_Bit_Offset(start_idx+1,indices));
    }
  else
    {
      AaRoot::Error("Record index must be a constant",expr);
      return(0);
    }
  return(ret_offset);
}

void AaRecordType::Print_Group_Function (ostream& ofile)
{
	if(!this->Is_Single_Level_Record_Type())
		return;

	ofile << "// Grouping function for record " << this->_record_type_name << endl;
	ofile << "$volatile $module [group_" << this->_record_type_name << "__ ] " << endl;
	ofile << "  $in (";

	int idx;
      	for(idx = 0; idx < _element_types.size(); idx++)
	{
		string fname = "f_" + IntToStr(idx);

		ofile << " " << fname << " : ";
		this->_element_types[idx]->Print(ofile);
		ofile << endl;

	}
	ofile << ")" << endl;
	ofile << "  $out ( ";
	ofile << "  r : " << this->_record_type_name << endl;
	ofile << ")" << endl;
	ofile << "$is  " << endl;
	ofile << "{" << endl;
	ofile << "r := ($bitcast (" << this->_record_type_name << ")" << endl;
	ofile << "        ($concat " << endl;
      	for(idx = _element_types.size()-1; idx >= 0; idx--)
	{
		string fname = "f_" + IntToStr(idx);
		ofile << "              ($bitcast ($uint<" 
			<< _element_types[idx]->Get_Width() << ">) " << fname << ")" 
			<< endl;
	}
	ofile << "         )" << endl;
	ofile << ") " << endl;

	ofile << "}" << endl;
}

void AaRecordType::Print_Ungroup_Function (ostream& ofile)
{
	if(!this->Is_Single_Level_Record_Type())
		return;

	ofile << "// Ungrouping function for record " << this->_record_type_name << endl;
	ofile << "$volatile $module [ungroup_" << this->_record_type_name << "__ ] " << endl;
	ofile << "  $in (r : " << this->_record_type_name << ") " << endl;
	ofile << "  $out ( ";
	int idx;
      	for(idx = 0; idx < _element_types.size(); idx++)
	{
		string fname = "f_" + IntToStr(idx);

		ofile << " " << fname << " : ";
		this->_element_types[idx]->Print(ofile);
		ofile << endl;

	}
	ofile << ")" << endl;
	ofile << "$is  " << endl;
	ofile << "{" << endl;
        ofile << "   $volatile ru := ($bitcast ($uint<" << this->Get_Width() << ">) r)" << endl;
	ofile << "   $volatile $split (ru " << endl;
      	for(idx = _element_types.size()-1; idx >= 0; idx--)
	{
		ofile << "                       " << this->_element_types[idx]->Get_Width() << endl;
	}
	ofile << ")" << endl;
	ofile << "(" << endl;
      	for(idx = _element_types.size()-1; idx >= 0; idx--)
	{
		string ufname = "uf_" + IntToStr(idx);
		ofile << "    " << ufname << endl;
	}
	ofile << ")" << endl;

      	for(idx = 0; idx < _element_types.size(); idx++)
	{
		string ufname = "uf_" + IntToStr(idx);
		string fname  = "f_" + IntToStr(idx);
		ofile << fname << " := ($bitcast (";
		this->_element_types[idx]->Print(ofile);
		ofile << ") " <<  ufname << ")" << endl;
	}
	ofile << "}" << endl;
}

unsigned int AaRecordType::Get_Width()
{
	unsigned int ret_val = 0;
      	for(int idx = 0; idx < _element_types.size(); idx++)
		ret_val += _element_types[idx]->Get_Width();

	return(ret_val);
}

