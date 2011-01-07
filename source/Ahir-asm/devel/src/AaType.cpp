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
AaPointerType::AaPointerType(AaScope* p, unsigned int object_width): AaUintType(p,object_width) {};
AaPointerType::~AaPointerType() {};
void AaPointerType::Print(ostream& ofile)
{
  ofile << "$pointer<" << this->Get_Width() << "> ";
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
AaArrayType::AaArrayType(AaScope* p, AaScalarType* stype, vector<unsigned int>& dimensions): AaType(p) 
{
  this->_element_type = stype;
  for(unsigned int i = 0; i < dimensions.size(); i++)
    this->_dimension.push_back(dimensions[i]);
};
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
    ofile << "<" << this->Get_Dimension(i) << ">";
  ofile << " $of ";
  this->Get_Element_Type()->Print(ofile);
}






