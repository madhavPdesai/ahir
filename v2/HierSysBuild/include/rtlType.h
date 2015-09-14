#ifndef _rtl_Type__
#define _rtl_Type__


class rtlType
{
  public:

  rtlType();

  virtual string Kind() {return("rtlType");}
  virtual int Size() {assert(0);}
  virtual bool Is_Integer_Type() {return(false);}
  virtual bool Is_Uinteger_Type() {return(false);}
  virtual bool Is_Array_Type() {return(false);}

  virtual string Get_Name() {assert(0);}
  virtual string Get_VHDL_Name() {assert(0);}

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
  virtual void Print(stringstream& ofile);

};


class rtlIntegerType: public rtlType
{
	public:
	rtlIntegerType();
	string Kind() {return("rtlInteger");}

  	virtual string Get_Name() {return("int");}
  	virtual string Get_VHDL_Name() {return("integer");}

  	void Print(ostream& ofile);

};


class rtlUnsigned: public rtlType
{
 protected:
  // width > 0
  unsigned int _width;

 public:
  virtual unsigned int Get_Width() {return(this->_width);}
  rtlUnsigned(unsigned int width):rtlType() {_width = width;}

  virtual string Kind() {return("rtlUnsigned");}
   
  virtual int Size() {return(this->_width);}
  virtual string Get_Name() {return("$uint<" + IntToStr(_width) + ">");}
  virtual string Get_VHDL_Name() {return("unsigned(" + IntToStr(_width-1) + " downto 0)");}
  void Print(ostream& ofile);
};


class rtlSigned: public rtlUnsigned
{
  // gets width from Unsigned

 public:

  rtlSigned(unsigned int width);
  void Print(ostream& ofile);
  virtual string Kind() {return("rtlSigned");}

  virtual string Get_Name() {return("$int<" + IntToStr(_width) + ">");}
  virtual string Get_VHDL_Name() {return("signed(" + IntToStr(_width-1) + " downto 0)");}

};

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

  virtual string Get_Name(ostream& ofile) 
  { 
    string ret_name =  string( "$array");
    for(int I = 0, fI = _dimensions.size();  I < fI; I++)
    {
	ret_name += "[" + IntToStr(_dimensions[I]) + "]";
    }
    ret_name += " ";
    ret_name += this->Get_Element_Type()->Get_Name();
    return(ret_name);
  }

  virtual string Get_VHDL_Name();
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
