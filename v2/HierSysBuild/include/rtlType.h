#ifndef _rtl_Type__
#define _rtl_Type__


//
// types of rtl objects
//  
// base class
class rtlType
{
  public:

  rtlType(string id);

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
	rtlIntegerType(string id, int low, int high);
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
  rtlUnsignedType(string id, unsigned int width):rtlType(id) {_width = width;}

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

  rtlSignedType(string id, unsigned int width);
  rtlUnsignedType(string id, unsigned int width):rtlUnsignedType(id,width) {}
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

  rtlArrayType(string id, rtlType* element_type, vector<unsigned int>& dimensions);


  virtual int Size() 
  {
    int ret_val = this->Get_Element_Type()->Size();

    for(unsigned int i=0; i < this->Get_Number_Of_Dimensions(); i++)
      ret_val =  ret_val * this->_dimension[i];

    return(ret_val);
  }


  virtual int Number_Of_Elements()
  {
    int ret_val = 1;
    for(unsigned int i=0; i < this->Get_Number_Of_Dimensions(); i++)
      ret_val = ret_val*(this->_dimension[i]);
    return(ret_val);
  }

  virtual void Print(ostream& ofile);

};

//
// type manager... make types.
//
rtlType* Make_Uinteger_Type(int width);
rtlType* Make_Integer_Type(int width);
rtlType* Make_Array_Type(vector<int> dims, rtlType* element_type);

// each type is assigned an identifier.
string   Get_Type_Identifier(rtlType* t);

// print VHDL type declarations.
void     Print_VHDL_Type_Declarations(ostream& ofile);

#endif
