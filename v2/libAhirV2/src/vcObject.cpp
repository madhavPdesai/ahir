#include <vcIncludes.hpp>
#include <vcRoot.hpp>
#include <vcType.hpp>
#include <vcValue.hpp>
#include <vcObject.hpp>

vcStorageObject::vcStorageObject(string id, vcType* t):vcRoot(id)
{
  assert(t);
  this->_type = t;
  this->_value = NULL;
  this->_base_address = NULL;
}

void vcStorageObject::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__OBJECT] << " [" << this->Get_Id() << "] : ";
  this->_type->Print(ofile);
  if(this->_value)
    {
      ofile << " := ";
      this->_value->Print(ofile);
    }
}
