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

//---------------------------------------------------------------------
// AaRecordType
//---------------------------------------------------------------------
AaRecordType::AaRecordType(AaScope* s, string name):AaType(s)
{
  _record_type_name = name;
  _is_named = true;
}

AaType* AaRecordType::Get_Element_Type(int start_idx, vector<AaExpression*>& indices)
{
  AaExpression* expr = indices[start_idx];
  AaValue* v = NULL;
  if(expr->Is("AaConstantLiteralReference"))
    {
      int type_width = CeilLog2(this->Get_Number_Of_Elements()-1);
      v = Make_Aa_Value(this->Get_Scope(),
			AaProgram::Make_Uinteger_Type(type_width),
			((AaConstantLiteralReference*)expr)->Get_Literals());

      int idx = v->To_Integer();
      assert(idx >= 0 && idx < this->Get_Number_Of_Elements());

      if(start_idx == indices.size()-1)
	return(this->Get_Element_Type(idx));
      else
	return(this->Get_Element_Type(idx)->Get_Element_Type(start_idx+1,indices));
    }
  else
    {
      AaRoot::Error("Record index must be a literal constant",expr);
      return(NULL);
    }
}


