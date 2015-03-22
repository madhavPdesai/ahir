#include <Value.hpp>
using namespace std;
using namespace _base_value_;

void __extract_uint32(string float_value, uint32_t& val)
{
        val = 0;
        int I; uint32_t J = 0;
        string raw_string;
        if(float_value[1] == 'b')
                raw_string = float_value;
        else if(float_value[1] == 'h')
                raw_string = Hex_To_Binary(float_value);
        for(I = raw_string.length()-1; I >= 0; I--)
        {
                if(raw_string[I] == '1')
                        val = val | (1 << J);
                J++;
                if(J==32) break;
        }
}

void __extract_uint64(string float_value, uint64_t& val)
{
        val = 0;
        int I; uint64_t J = 0;
        string raw_string;
        if(float_value[1] == 'b')
                raw_string = float_value;
        else if(float_value[1] == 'h')
                raw_string = Hex_To_Binary(float_value);
        for(I = raw_string.length()-1; I >= 0; I--)
        {
                if(raw_string[I] == '1')
                        val = val | (1 << J);
                J++;    
                if(J==64)
                        break;
                             
	}
}

#define __extract_uint__(N,float_value, val) {\
	val = 0;\
	uint32_t I; uint32_t J = 0;\
	string raw_string;\
	if(float_value[1] == 'b')\
	raw_string = float_value;\
	else if(float_value[1] == 'h')\
	raw_string = Hex_To_Binary(float_value);\
	for(I = raw_string.length()-1; I >= 0; I--)\
	{\
		if(raw_string[I] == '1') \
		val = val | (1 << J);\
		J++;	\
		if(J==N) break;\
	}}

Value::Value()
{
}

Unsigned::~Unsigned()
{
	if(this->_bit_field)
	{
		delete [] _bit_field;
		_bit_field = NULL;
	}
}

Unsigned::Unsigned():Value()
{
	this->_bit_field = NULL;
	this->_width = 0;
}

Unsigned::Unsigned(int n): Value()
{
	this->_bit_field = NULL;
	this->Reset_And_Clear(n);
}


void Unsigned::Reset_And_Clear(int n)
{
	assert(n > 0);
	_width = n;

	if(this->_bit_field)
		delete [] this->_bit_field;

	this->_bit_field = new UWord[(this->Array_Size())];
	for(int idx = 0; idx < this->Array_Size() ; idx++)
		this->_bit_field[idx] = 0;
}

//
// essentially convert the UWord array to a byte-array.
//
void Unsigned::Fill_Byte_Array(uint8_t* v_array, uint32_t v_array_size)
{
	uint32_t this_array_size = this->Array_Size();
	uint32_t v_j = 0;
	for(int i = 0, imax = this_array_size; i < imax; i++)
	{
		UWord cword = this->_bit_field[i];
		for(int j = 0; j < sizeof(UWord); j++)
		{
			v_array[v_j] = (uint8_t) (cword >> (8*j));
			v_j++;

			if(v_j == v_array_size)
				break;
		}
		if(v_j == v_array_size)
			break;
	}
}



void Unsigned::Slice(Unsigned& other, int hi, int li)
{
	if((hi < other._width) && (li >= 0) && (hi >= li))
	{
		if(this->_width != ((hi-li)+1))
			this->Reset_And_Clear((hi-li)+1);

		for(int idx = li; idx <= hi; idx++)
			this->Set_Bit(idx-li,other.Get_Bit(idx));
	}
}

void Unsigned::Bitmap(Unsigned& other, vector<pair<int,int> >& bitmap_vector)
{
	// default is to copy.
	this->Swap(other);

	// remap bits using the bitmap-vector.
	for(int idx = 0, fidx = bitmap_vector.size(); idx < fidx; idx++)
	{
		int ti = bitmap_vector[idx].first;
		int si = bitmap_vector[idx].second;
		this->Set_Bit(ti, other.Get_Bit(si));
	}
}
    
void Unsigned::Set_Bit_Field(int idx, UWord bf)
{
	if((idx >= 0) && (idx < this->Array_Size()))
		_bit_field[idx] = bf;
}

void Unsigned::Bit_Cast_Into(Unsigned& other)
{
	other.Reset_And_Clear(this->_width);
	for(int idx = 0, fidx = this->Array_Size(); idx < fidx; idx++)
		other.Set_Bit_Field(idx, this->_bit_field[idx]);
}

Unsigned::Unsigned(int n, string init_value)
{
	assert(n > 0);

	string format;
	if(init_value.size() > 2)
	{
		if((init_value[0] == '_') && (init_value[1] == 'b'))
			format = "binary";
		else if((init_value[0] == '_') && (init_value[1] == 'h'))
			format = "hexadecimal";
		else
			format = "decimal";
	}
	else
		format = "decimal";

	_width = n;
	_bit_field = new UWord[this->Array_Size()];

	for(int idx = 0; idx < this->Array_Size(); idx++)
		_bit_field[idx] = 0;

	if(format == "decimal")
	{
		if(n > 32)
		{
			cerr << "Warning: decimal format can be used for integers which are up to 32 bits wide" << endl;
			cerr << "          the initial value " << init_value << " will be truncated to 32 bits.. " << endl;
			_bit_field[0] = this->AtoI(init_value.c_str());
		}
		else
		{
			_bit_field[0] = this->AtoI(init_value.c_str());
		}
	}
	else if (format == "hexadecimal")
	{
		string binary_init_string = Hex_To_Binary(init_value);
		this->Initialize_From_Binary_String(binary_init_string);
	}
	else if(format == "binary")
	{
#ifdef DEBUG
		if(init_value.size()-2 > _width)
		{
			cerr << "Warning: binary initialization string is longer than integer width" << endl;
			cerr << "          the initial value will be truncated to the least-significant bits. " << endl;
		}
#endif

		this->Initialize_From_Binary_String(init_value);
	}

}

Unsigned::Unsigned(const Unsigned& v):Value()
{
	_width = v._width;
	_bit_field = new UWord[this->Array_Size()];
	for(int idx = 0; idx < this->Array_Size(); idx++)
		_bit_field[idx] = v._bit_field[idx];
}


UWord Unsigned::AtoI(string ival)
{
	return((UWord)(atoi(ival.c_str())));
}

void Unsigned::Initialize_From_Binary_String(string& init_value)
{
	int bit_count = 0;
	for(int idx = 2; idx < init_value.size(); idx++)
	{
		bit_count++;
		int actual_index = (init_value.size()-1) - idx;
		if(init_value[idx] == '1')
			this->Set_Bit(actual_index,true);
		else
			this->Set_Bit(actual_index,false);

		if(bit_count == _width)
			break;
	}
}

bool Unsigned::To_Boolean()
{
	bool ret_val = false;
	for(int idx = 0; idx < this->Array_Size(); idx++)
	{
		if(_bit_field[idx] != 0)
		{
			ret_val = true;
			break;
		}
	}
	return(ret_val);
}
UWord Unsigned::To_Uinteger()
{
	return(_bit_field[0]);
}

SWord Unsigned::To_Integer()
{
	SWord int_val;
	int_val = _bit_field[0]; // ugly but can it be done better?
	return(int_val);
}

string Unsigned::To_String()
{
	string ret_value;
	for(int idx = this->_width-1; idx >= 0; idx--)
	{
		ret_value.push_back((this->Get_Bit(idx) ? '1' : '0'));
	}
	return(ret_value);
}

string Unsigned::To_C_String()
{
	ostringstream string_stream(ostringstream::out);
	string_stream << this->_bit_field[0];
	return(string_stream.str());
}


Float Unsigned::To_Float(int characteristic, int mantissa)
{
	Float ret_val = Float(characteristic,mantissa);
	if(_width > 64)
	{
		cerr << "Error: int<->float conversion supported only for integers which are up to 64 bits wide" 
			<< endl;
		cerr << "          the initial value will be ignored " << endl;
		return(ret_val);
	}

	if(characteristic + mantissa == 31)
		ret_val.data._float_value = (float) _bit_field[0];
	else if(characteristic+mantissa == 63)
		ret_val.data._double_value = (double) _bit_field[0];

	return(ret_val);
}




void Unsigned::Swap(const Unsigned& v)
{

	// clean up
	if(_bit_field)
	{
		delete [] _bit_field;
		_bit_field = NULL;
	}


	_width = v._width;
	_bit_field = new UWord[this->Array_Size()];
	for(int idx = 0; idx < this->Array_Size(); idx++)
		_bit_field[idx] = 0;

	this->Assign((Unsigned&) v);
}

Unsigned& Unsigned::operator=(Unsigned v)
{

	this->Swap(v);
	return(*this);
}

Unsigned& Unsigned::operator=(Signed v)
{
	this->Swap(v);
	return(*this);
}


void Unsigned::Add(Unsigned& b)
{
	bool carry = false;
	assert(this->_width == b.Width());

	for(int idx = 0; idx < b.Width(); idx++)
	{
		bool abit = this->Get_Bit(idx);
		bool bbit = b.Get_Bit(idx);
		bool sum = (abit ^ bbit ^ carry);
		this->Set_Bit(idx,sum);
		carry = (abit & bbit) | ((abit | bbit) & carry);
	}

	this->Sign_Extend();
}

void Unsigned::Multiply(Unsigned& b )
{
	assert(this->_width == b.Width());

	if(b.Width() > 64)
	{
		cerr << "Error: multiply supported for integers which are up to 64 bits wide" << endl;
		cerr << "          will return junk " << endl;
		return;
	}

	this->_bit_field[0] = this->_bit_field[0] * b._bit_field[0];
}

void Unsigned::Subtract(Unsigned& b)
{
	assert(_width == b.Width());
	Unsigned one_val(b.Width(),"_b1");

	Unsigned tmp(b.Width());
	tmp = b;
	tmp.Complement();
	tmp.Add(one_val);

	this->Add(tmp);
}

void Unsigned::Divide(Unsigned& b)
{
	assert(_width == b.Width());
	if(_width > 64)
	{
		cerr << "Error: divide supported for integers which are up to 64 bits wide" << endl;
		cerr << "          will return junk " << endl;
		return;
	}

	this->_bit_field[0] = this->_bit_field[0] / b._bit_field[0];
}


// unsigned int <-> int type conversion
void Unsigned::Assign(Unsigned& v)
{
	for(int idx = 0; idx < this->Array_Size() ; idx++)
		this->_bit_field[idx] = 0;


	for(int idx = 0; idx < __MIN__(this->Array_Size(),v.Array_Size()); idx++)
		_bit_field[idx] = v._bit_field[idx];
}


void Unsigned::Assign(Signed& v)
{

	for(int idx = 0; idx < this->Array_Size() ; idx++)
		this->_bit_field[idx] = 0;

	bool sign_bit = v.Get_Bit(v.Width() - 1);
	if(!sign_bit)
	{
		// if v is negative, this will be 0.
		for(int idx = 0; idx < __MIN__(_width,v.Width()); idx++)
		{
			this->Set_Bit(idx, v.Get_Bit(idx));
		}
		for(int idx = v.Width(); idx < _width; idx++)
			this->Set_Bit(idx,false);
	}
}

bool Unsigned::Get_Bit(int idx)
{
	int word_index = idx/__WORD_SIZE__;
	int bit_index  = idx%__WORD_SIZE__;

	assert(word_index < this->Array_Size());

	UWord mask_bit = 1;
	if(_bit_field[word_index] & (mask_bit << bit_index))
		return(true);
	else
		return(false);
}


void Unsigned::Set_Bit(int idx, bool v)
{
	int word_index = idx/__WORD_SIZE__;
	int bit_index  = idx%__WORD_SIZE__;

	UWord bit_mask = 1;
	if(word_index < this->Array_Size())
	{
		bit_mask = (bit_mask << bit_index);
		UWord and_mask = ~bit_mask;
		_bit_field[word_index] = (_bit_field[word_index] &  and_mask) | (v ? bit_mask : 0);
	}
}


void Unsigned::Negate()
{
	Unsigned one_val(this->Width());
	one_val.Set_Bit(0,true);

	this->Complement();
	this->Add(one_val);
}

void Unsigned::Increment()
{
	Unsigned one_val(this->Width());
	one_val.Set_Bit(0,true);
	this->Add(one_val);
}

void Unsigned::Decrement()
{
	Unsigned one_val(this->Width());
	one_val.Set_Bit(0,true);
	this->Subtract(one_val);
}

void Unsigned::Complement()
{
	for(int idx = 0; idx < this->Array_Size(); idx++)
		_bit_field[idx] = ~(_bit_field[idx]);

}

void Unsigned::And(Unsigned& b)
{
	assert(this->Width() == b.Width());
	for(int idx = 0; idx < this->Array_Size(); idx++)
		this->_bit_field[idx] = (this->_bit_field[idx] & b._bit_field[idx]);
}

void Unsigned::Or(Unsigned& b)
{
	assert(this->Width() == b.Width());
	for(int idx = 0; idx < this->Array_Size(); idx++)
		this->_bit_field[idx] = (this->_bit_field[idx] | b._bit_field[idx]);
}

void Unsigned::Xor(Unsigned& b)
{
	assert(this->Width() == b.Width());
	for(int idx = 0; idx < this->Array_Size(); idx++)
		this->_bit_field[idx] = (this->_bit_field[idx] ^ b._bit_field[idx]);
}
void Unsigned::Nand(Unsigned& b)
{
	this->And(b);
	this->Complement();
}
void Unsigned::Nor(Unsigned& b)
{
	this->Or(b);
	this->Complement();
}
void Unsigned::Xnor(Unsigned& b)
{
	this->Xor(b);
	this->Complement();
}

void Unsigned::Concatenate(Unsigned& b)
{
	Unsigned tmp(_width + b._width);

	for(int idx = 0; idx < b.Width(); idx++)
	{
		tmp.Set_Bit(idx, (b.Get_Bit(idx) ? true : false));
	}
	for(int idx = 0; idx < this->_width; idx++)
	{
		tmp.Set_Bit(idx + b.Width(), (this->Get_Bit(idx) ? true : false));
	}

	this->Swap(tmp);
}

void Unsigned::Shift_Left()
{
	for(int idx = this->Width()-1; idx > 0; idx--)
		this->Set_Bit(idx,this->Get_Bit(idx-1));
	this->Set_Bit(0,false);
}

void Unsigned::Shift_Left(int idx)
{
	for(int i= 0; i < idx; i++)
		this->Shift_Left();
}

void Unsigned::Shift_Right()
{
	for(int idx = 0; idx < this->Width()-1; idx++)
		this->Set_Bit(idx,this->Get_Bit(idx+1));
	this->Set_Bit(this->Width()-1,false);
}
void Unsigned::Shift_Right(int idx)
{
	for(int i = 0; i < idx; i++)
		this->Shift_Right();
}


void Unsigned::Rotate_Left()
{
	bool high_bit = this->Get_Bit(this->Width()-1);
	this->Shift_Left();
	this->Set_Bit(0,high_bit);
}
void Unsigned::Rotate_Left(int idx)
{
	for(int i = 0; i < idx; i++)
		this->Rotate_Left(idx);
}
void Unsigned::Rotate_Right()
{
	bool low_bit = this->Get_Bit(0);
	this->Shift_Right();
	this->Set_Bit(this->Width()-1,low_bit);
}
void Unsigned::Rotate_Right(int idx)
{
	for(int i = 0; i < idx; i++)
		this->Rotate_Right(idx);
}

bool Unsigned::Greater(Unsigned& b)
{
	bool ret_val = true;
	assert(this->Width() == b.Width());
	for(int idx = this->Width()-1; idx >= 0; idx--)
	{
		if((!this->Get_Bit(idx) && b.Get_Bit(idx)))
		{
			ret_val = false;
			break;
		}
		else if(this->Get_Bit(idx) && !b.Get_Bit(idx))
			break;
	}

	return(ret_val);
}

bool Unsigned::Less_Than(Unsigned& b)
{
	return(b.Greater(*this));
}
bool Unsigned::Greater_Equal(Unsigned& b)
{
	return(this->Greater(b) && !b.Greater(*this));
}

bool Unsigned::Less_Equal(Unsigned& b)
{
	return(this->Less_Than(b) && !this->Greater(b));
}
bool Unsigned::Equal(Unsigned& b)
{
	return(!this->Greater(b) && !this->Less_Than(b));
}

Signed::~Signed()
{
}

Signed::Signed():Unsigned()
{
}

Signed::Signed(int n): Unsigned(n)
{
}


Signed::Signed(int n, string init_value):Unsigned(n,init_value)
{
}

Signed::Signed(const Signed& v):Unsigned(v._width)
{

	for(int idx = 0; idx < this->Array_Size(); idx++)
		_bit_field[idx] = v._bit_field[idx];

	this->Sign_Extend();
}

UWord Signed::AtoI(string ival)
{
	int u_word;
	int s_word;
	s_word = atoi(ival.c_str());
	u_word = *((UWord*)(&s_word));
	return(u_word);
}

void Signed::Sign_Extend()
{
	bool sign_bit = this->Get_Bit(_width-1);
	for(int idx = __WORD_SIZE__-1; idx >= _width; idx--)
		this->Set_Bit(idx,sign_bit);
}

void Signed::Fill_Byte_Array(uint8_t* v_array, uint32_t v_array_size) 
{
	this->Unsigned::Fill_Byte_Array(v_array,v_array_size);
}

string Signed::To_String()
{
	//bits are bits..
	return(this->Unsigned::To_String());
}
string Signed::To_C_String()
{
	SWord val = *((SWord*)(&(_bit_field[0])));
	ostringstream string_stream(ostringstream::out);
	string_stream << val;
	return(string_stream.str());
}

// unsigned int <-> int type conversion
void Signed::Assign(Unsigned& v)
{
	for(int idx = 0; idx < this->Array_Size(); idx++)
		_bit_field[idx] = 0;

	for(int idx = 0; idx < __MIN__(this->Array_Size(),v.Array_Size()); idx++)
		_bit_field[idx] = v._bit_field[idx];

	this->Sign_Extend();
}


void Signed::Assign(Signed& v)
{
	for(int idx = 0; idx < this->Array_Size(); idx++)
		_bit_field[idx] = 0;

	bool sign_bit = v.Get_Bit(v.Width() - 1);
	for(int idx = 0; idx < __MIN__(_width,v.Width()); idx++)
	{
		this->Set_Bit(idx, v.Get_Bit(idx));
	}
	// sign extend if necessary
	for(int idx = v.Width(); idx < _width; idx++)
		this->Set_Bit(idx,sign_bit);

	this->Sign_Extend();
}

//UWord Unsigned::To_Uinteger()

SWord Signed::To_Integer()
{
	SWord int_val = *((SWord*)(&_bit_field[0]));
	return(int_val);
}

UWord Signed::To_Uinteger()
{
	UWord int_val = *((UWord*) (&(_bit_field[0])));
	return(int_val);
}


bool Signed::Is_Negative()
{
	// top bit
	return(this->Get_Bit(this->_width-1));
}


void Signed::Swap(const Signed& v)
{
	if(_bit_field)
	{
		delete [] _bit_field;
		_bit_field = NULL;
	}
	_width = v._width;

	_bit_field = new UWord[this->Array_Size()];
	for(int idx = 0; idx < this->Array_Size(); idx++)
		_bit_field[idx] = 0;

	this->Assign((Signed&) v);
}

Signed& Signed::operator=(const Signed v)
{
	this->Swap((Signed&) v);
}

Signed& Signed::operator=(Unsigned v)
{

	if(_bit_field)
	{
		delete [] _bit_field;
		_bit_field = NULL;
	}
	_width = v._width;

	_bit_field = new UWord[this->Array_Size()];
	for(int idx = 0; idx < this->Array_Size(); idx++)
		_bit_field[idx] = 0;

	this->Assign((Unsigned&)v);
	return(*this);
}




void Signed::Shift_Right()
{
	bool sign_bit = this->Get_Bit(this->Width()-1);
	this->Unsigned::Shift_Right();
	this->Set_Bit(this->Width()-1,sign_bit);
}

bool Signed::Greater(Signed& other)
{
	if(this->Is_Negative() && !other.Is_Negative())
		return(false);
	else if(!this->Is_Negative() && other.Is_Negative())
		return(true);
	else if(this->Is_Negative())
		return(other.Unsigned::Greater(*this));
	else
		return(this->Unsigned::Greater(other));

}

bool Signed::Less_Than(Signed& b)
{
	return(b.Greater(*this));
}
bool Signed::Greater_Equal(Signed& b)
{
	return(this->Greater(b) && !b.Greater(*this));
}
bool Signed::Less_Equal(Signed& b)
{
	return(this->Less_Than(b) && !this->Greater(b));
}



Float Signed::To_Float(int characteristic, int mantissa_width)
{
	Float ret_val = Float(characteristic,mantissa_width);
	if(_width > 64)
	{
		cerr << "Error: int<->float conversion supported only for integers which are up to 64 bits wide" 
			<< endl;
		cerr << "          the initial value will be ignored " << endl;
		return(ret_val);
	}

	if(ret_val.Is_float32())
		ret_val.data._float_value = (float) ((SWord)(_bit_field[0]));
	else if(ret_val.Is_double64())
		ret_val.data._double_value = (double)((SWord)( _bit_field[0]));

	return(ret_val);
}

Float::Float(int characteristic_width, int mantissa_width):Value()
{
	if(characteristic_width + mantissa_width == 31)
		this->data._float_value = 0;
	else if(characteristic_width + mantissa_width == 63)
		this->data._double_value = 0;
	else
	{
		cerr << "Error: IEEE float and double precision are the only supported floating point formats" 
			<< endl;
	}

	_characteristic_width = characteristic_width;
	_mantissa_width = mantissa_width;

}

// float_value is either a normal float-string (e.g. 2.50 or 1.0e10) or
// a formatted binary string (e.g. _b1000...0) or a formatted
// hex-string (e.g. _h10abe01) etc.
Float::Float(int characteristic_width, int mantissa_width, string float_value):Value()
{

	_characteristic_width = characteristic_width;
	_mantissa_width = mantissa_width;

	bool is_bit_vector = (float_value[0] == '_') && ((float_value[1] == 'b') || (float_value[1] == 'h'));
	if(this->Is_float32())
	{

		if(!is_bit_vector)
		{
			this->data._float_value = atof(float_value.c_str());
		}
		else
		{
			float ext_val = 0.0;
			uint32_t* ptr = (uint32_t*) &ext_val;
			__extract_uint32(float_value, *ptr);
			this->data._float_value = ext_val;
		}

	}
	else if(this->Is_double64())
	{
		if(!is_bit_vector)
		{
			this->data._double_value = atof(float_value.c_str());
		}
		else
		{
			double ext_val = 0.0;
			uint64_t* ptr = (uint64_t*) &ext_val;
			__extract_uint64(float_value, *ptr);
			this->data._double_value = ext_val;
		}
	}
	else
	{
		cerr << "Error: IEEE float and double precision are the only supported floating point formats" 
			<< endl;
	}
}


// +=, *=, -=
void Float::Add(Float& v)
{
	assert((_characteristic_width == v._characteristic_width) && (_mantissa_width == v._mantissa_width));
	if(this->Is_float32())
		this->data._float_value += v.data._float_value;
	else   if(this->Is_double64())
		this->data._double_value += v.data._double_value;

}
void Float::Multiply(Float& v) 
{
	assert((_characteristic_width == v._characteristic_width) && (_mantissa_width == v._mantissa_width));
	if(this->Is_float32())
		this->data._float_value *= v.data._float_value;
	else   if(this->Is_double64())
		this->data._double_value *= v.data._double_value;
}

void Float::Subtract(Float& v)
{
	assert((_characteristic_width == v._characteristic_width) && (_mantissa_width == v._mantissa_width));
	if(this->Is_float32())
		this->data._float_value -= v.data._float_value;
	else   if(this->Is_double64())
		this->data._double_value -= v.data._double_value;
}

void Float::Divide(Float& v)
{
	assert((_characteristic_width == v._characteristic_width) && (_mantissa_width == v._mantissa_width));
	if(this->Is_float32())
		this->data._float_value /= v.data._float_value;
	else   if(this->Is_double64())
		this->data._double_value /= v.data._double_value;
}

void Float::Assign(Float& v)
{
	if(this->Is_float32())
	{
		if(v.Is_float32())
			this->data._float_value = v.data._float_value;
		else
			this->data._float_value = v.data._double_value;
	}
	else   if(this->Is_double64())
	{
		if(v.Is_float32())
			this->data._double_value = v.data._float_value;
		else 
			this->data._double_value = v.data._double_value;
	}
}

void Float::To_Unsigned(Unsigned& v)
{
	if(this->Is_float32())
		v._bit_field[0] = (UWord)(this->data._float_value);
	else   if(this->Is_double64())
		v._bit_field[0] = (UWord)(this->data._double_value);
}

void Float::To_Signed(Signed& v)
{
	SWord tmp;
	if(this->Is_float32())
	{
		tmp = (SWord) (this->data._float_value);
	}
	else   if(this->Is_double64())
	{
		tmp = (SWord) (this->data._double_value);
	}
	v._bit_field[0] = *((UWord*) (&tmp));
}

void Float::Bit_Cast_Into(Unsigned& other)
{
	void* tmp;
	int w = 64;
	UWord bfv = 0;
	if(this->Is_float32())
	{
		tmp = (void*) &(this->data._float_value);
		w = 32;
	}
	else   if(this->Is_double64())
	{
		tmp = (void*) &(this->data._double_value);
	}
	bfv = *((UWord*)tmp);
	other.Reset_And_Clear(w);

	for(int idx = 0; idx < __WORD_SIZE__; idx++)
	{
		other.Set_Bit(idx, (bfv & (1 << idx)));
	}
}

string Float::To_String()
{
	char buffer[1024];
	if(this->Is_float32())
		sprintf(buffer,"%e",this->data._float_value);
	else   if(this->Is_double64())
		sprintf(buffer,"%le",this->data._double_value);

	string ret_string = buffer;
	return(ret_string);
}

string Float::To_C_String()
{
	return(this->To_String());
}



bool Float::Greater(Float& t)
{
	bool ret_val;
	assert((this->_characteristic_width == t._characteristic_width) && (this->_mantissa_width == t._mantissa_width));
	if(this->Is_float32())
		ret_val = (this->data._float_value > t.data._float_value);
	else   if(this->Is_double64())
		ret_val = (this->data._float_value < t.data._float_value);
	return(ret_val);  

}
bool Float::Less_Than(Float& t)
{
	return(t.Greater(*this));
}
bool Float::Greater_Equal(Float& t)
{
	return (!this->Less_Than(t));
}
bool Float::Less_Equal(Float& t)
{
	return (!this->Greater(t));
}
bool Float::Equal(Float& t)
{
	return(!(this->Less_Than(t) || this->Greater(t)));
}



string _base_value_::Hex_To_Binary(string& hex_string)
{
	string binary_string  = "_b";
	for(int idx = 2; idx < hex_string.size(); idx++)
	{
		switch(hex_string[idx])
		{
			case '0':
				binary_string += "0000";
				break;
			case '1':
				binary_string += "0001";
				break;
			case '2':
				binary_string += "0010";
				break;
			case '3':
				binary_string += "0011";
				break;
			case '4':
				binary_string += "0100";
				break;
			case '5':
				binary_string += "0101";
				break;
			case '6':
				binary_string += "0110";
				break;
			case '7':
				binary_string += "0111";
				break;
			case '8':
				binary_string += "1000";
				break;
			case '9':
				binary_string += "1001";
				break;
			case 'a':;
			case 'A':
				binary_string += "1010";
				break;
			case 'b':; case 'B':
				binary_string += "1011";
				break;
			case 'c':; case 'C':
				binary_string += "1100";
				break;
			case 'd':; case 'D':
				binary_string += "1101";
				break;
			case 'e':; case 'E':
				binary_string += "1110";
				break;
			case 'f':; case 'F':
				binary_string += "1111";
				break;
			default:
				cerr << "Error: unknown character in hex string:  " << hex_string << endl;
				binary_string += "0000";
				break;
		}
	}
	return(binary_string);
}
