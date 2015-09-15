#ifndef _rtl_Type__
#define _rtl_Type__

class hierRoot;

//
// types of rtl objects
//  
// base class
class rtlType: public hierRoot
{
  public:

  rtlType();

  virtual string Kind() {return("rtlType");}
  virtual int Size() {assert(0);}

  virtual string Get_Name() {assert(0);}

  virtual rtlType* Get_Element_Type(int idx) 
  {
    assert(0);
  }
  virtual rtlType* Get_Element_Type(int start_idx, vector<int>& indices) 
  {
    assert(0);
  }

  void Print(ostream& ofile);
  virtual void Print(ofstream& ofile);
  virtual void Print(string& ostring);

};


//
// the 32 bit integer type.
// 
class rtlIntegerType: public rtlType
{
	int _low;
	int _high;
	public:
	rtlIntegerType(int low, int high);
	string Kind() {return("rtlInteger");}
  	virtual void Print(ostream& ofile);
};


//
// The arbitrary precision unsigned type
//
class rtlUnsignedType: public rtlType
{
 protected:
  // width > 0
  unsigned int _width;

 public:
  virtual unsigned int Get_Width() {return(this->_width);}
  rtlUnsignedType(unsigned int width):rtlType() {_width = width;}

  virtual string Kind() {return("rtlUnsignedType");}
   
  virtual int Size() {return(this->_width);}
  virtual void Print(ostream& ofile);
};


//
// the arbitrary precision signed type
//
class rtlSignedType: public rtlUnsignedType
{
  // gets width from Unsigned

 public:

  rtlSignedType(unsigned int width):rtlUnsignedType(width) {}
  void Print(ostream& ofile);
  virtual string Kind() {return("rtlSignedType");}

  virtual string Get_Name() {return("$int<" + IntToStr(_width) + ">");}
};

//
// the array type
//   (multi-dimensional array of elements).
//
class rtlArrayType: public rtlType
{
  // multi-dimensional array types are possible
  vector<unsigned int> _dimensions;
  
  // element type..
  rtlType* _element_type;
 
 public:

  virtual string Kind() {return("rtlArrayType");}

  unsigned int Get_Number_Of_Dimensions() {return(this->_dimensions.size());}
  unsigned int Get_Dimension(int I)
	{
		if( (I >= 0) && (I < _dimensions.size()))
		{
			return(_dimensions[I]);
		}
		else
			return(0);
	}

  virtual rtlType* Get_Element_Type() {return(this->_element_type);}
  virtual rtlType* Get_Element_Type(int idx) {return(this->_element_type);} 

  rtlArrayType(rtlType* element_type, vector<unsigned int>& dimensions);


  virtual int Size() 
  {
    int ret_val = this->Get_Element_Type()->Size();

    for(unsigned int i=0; i < this->Get_Number_Of_Dimensions(); i++)
      ret_val =  ret_val * this->_dimensions[i];

    return(ret_val);
  }


  virtual int Number_Of_Elements()
  {
    int ret_val = 1;
    for(unsigned int i=0; i < this->Get_Number_Of_Dimensions(); i++)
      ret_val = ret_val*(this->_dimensions[i]);
    return(ret_val);
  }

  virtual int Get_Index(vector<int> indices)
  {
	assert(indices.size() == _dimensions.size());

	int ret_val = 0;
	int S = 1;
	for(int I = _dimensions.size()-1; I >= 0; I--)
	{
		ret_val += (S*indices[I]);
		S = S*_dimensions[I];
	}
	return(ret_val);
  }

  virtual void Print(ostream& ofile);

};

//
// type manager... make types.
//
rtlType* Find_Or_Make_Integer_Type(int low_val, int high_val);
rtlType* Find_Or_Make_Unsigned_Type(int width);
rtlType* Find_Or_Make_Signed_Type(int width);
rtlType* Find_Or_Make_Array_Type(vector<int> dims, rtlType* element_type);

// each type is assigned an identifier.
string   Get_Type_Identifier(rtlType* t);

// print VHDL type declarations.
void     Print_VHDL_Type_Declarations(ostream& ofile);

#endif
