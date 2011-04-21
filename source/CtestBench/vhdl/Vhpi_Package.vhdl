-- author: Madhav P. Desai

package Vhpi_Package is

  -----------------------------------------------------------------------------
  -- constants
  -----------------------------------------------------------------------------
  constant c_word_length : integer := 32;
  constant c_vhpi_max_string_length : integer := 1024;
  
  -----------------------------------------------------------------------------
  -- types
  -----------------------------------------------------------------------------
  subtype VhpiString is string(1 to c_vhpi_max_string_length);
  subtype Word is bit_vector(c_word_length-1 downto 0);
  subtype Handle is integer; -- integer used to keep  context. 
  type VhpiPortType is array(natural range <>) of Word;
  type VhpiHandleArray is array(natural range <>) of Handle;

  -----------------------------------------------------------------------------
  -- utility functions
  -----------------------------------------------------------------------------
  function Minimum(x,y: integer) return integer; -- returns minimum
  function Pack_String(x: string) return VhpiString; -- converts x to null terminated string
  function Convert_To_String(val : natural) return STRING; -- convert val to string.
  function Pack_Word(x: bit_vector) return Word;  -- todo
  function Unpack_Word (x : Word; lgth: integer) return bit_vector;  -- todo
  

  -----------------------------------------------------------------------------
  -- foreign Vhpi function
  -----------------------------------------------------------------------------
  procedure  Vhpi_Initialize(x: in string(1 to 1024);
  attribute foreign of Vhpi_Initialize : procedure is "VHPIDIRECT Vhpi_Initialize";
  
  procedure Vhpi_Close(); -- close .
  attribute foreign of Vhpi_Close : procedure is "VHPIDIRECT Vhpi_Close";

  procedure Vhpi_Listen();
  attribute foreign of Vhpi_Listen : procedure is "VHPIDIRECT Vhpi_Listen";

  procedure Vhpi_Send(); 
  attribute foreign of Vhpi_Send : procedure is "VHPIDIRECT Vhpi_Send";

  procedure Vhpi_Set_Port_Value(port_name: in VhpiString; port_value: in Word);
  attribute foreign of Vhpi_Set_Port_Value: procedure is "VHPIDIRECT Vhpi_Set_Port_Value";
  
  procedure Vhpi_Get_Port_Value(port_name: in VhpiString; port_value : out Word);
  attribute foreign of Vhpi_Get_Port_Value : procedure is "VHPIDIRECT Vhpi_Get_Port_Value";
  
end Vhpi_Package;

package body Vhpi_Package is

  -----------------------------------------------------------------------------
  -- utility functions
  -----------------------------------------------------------------------------
  function Minimum(x,y: integer) return integer is
  begin
    if( x < y) then return x; else return y; end if;
  end Minimum;

  function Ceiling(x,y: integer) return integer is
    variable ret_var : integer;
  begin
    assert x /= 0 report "divide by zero in ceiling function" severity failure;
    ret_var := x/y;
    if(ret_var*y < x) then ret_var := ret_var + 1; end if;
    return(ret_var);
  end Ceiling;

  function Pack_String(x:  string) return VhpiString is
     alias lx: string(1 to x'length) is x;
     variable strlen: integer;
     variable ret_var : VhpiString;
  begin
	strlen := Minimum(c_vhpi_max_string_length-1,x'length);
	for I in 1 to strlen loop
		ret_var(I) := lx(I);
	end loop;
	ret_var(strlen+1) := nul;
	return(ret_var); 
  end Pack_String;

  -- Thanks to: D. Calvet calvet@hep.saclay.cea.fr
  function Convert_To_String(val : NATURAL) return STRING is
	variable result : STRING(10 downto 1) := (others => '0'); -- smallest natural, longest string
	variable pos    : NATURAL := 1;
	variable tmp, digit  : NATURAL;
  begin
	tmp := val;
	loop
		digit := abs(tmp MOD 10);
	    	tmp := tmp / 10;
	    	result(pos) := character'val(character'pos('0') + digit);
	    	pos := pos + 1;
	    	exit when tmp = 0;
	end loop;
	return result((pos-1) downto 1);
  end Convert_To_String;

  function Pack_Word(x: bit_vector) return Word is
    alias lx : bit_vector(1 to x'length) is x;
    variable ret_var : bit_vector(1 to Word'length);
  begin
    ret_var := (others => '0');
    for I in 1 to Minimum(lx'length,ret_var'length) loop
      ret_var(I) := lx(I);
    end loop;  -- I
  end Pack_Word;
  
  function Unpack_Word (x : Word; lgth: integer) return bit_vector is
    alias lx : bit_vector(1 to x'length) is x;
    variable ret_var : bit_vector(1 to lgth);
  begin
    ret_var := (others => '0');
    for I in 1 to Minimum(lx'length,ret_var'length) loop
      ret_var(I) := lx(I);
    end loop;  -- I    
  end Unpack_Word;

  -----------------------------------------------------------------------------
  -- subprogram bodies for foreign vhpi routines.  will never be called
  -----------------------------------------------------------------------------
  procedure  Vhpi_Initialize(x: in string(1 to 1024)) is
  begin
    assert false  report "fatal: this should never be called" severity failure;
    return 0;
  end Vhpi_Initialize;
  
  procedure Vhpi_Close() is
  begin
    assert false  report "fatal: this should never be called" severity failure;
  end Vhpi_Close;

  procedure Vhpi_Listen() is
  begin
    assert false  report "fatal: this should never be called" severity failure;
  end Vhpi_Listen;

  procedure Vhpi_Send() is
  begin
    assert false  report "fatal: this should never be called" severity failure;
  end Vhpi_Send;
  
  procedure Vhpi_Set_Port_Value(port_name: in VhpiString; port_value: in Word) is
  begin
    assert false  report "fatal: this should never be called" severity failure;
  end Vhpi_Set_Port_Value;    
  
  procedure  Vhpi_Get_Port_Value(port_name : in  VhpiString;  port_value: out Word)is
  begin
    assert false  report "fatal: this should never be called" severity failure;
  end Vhpi_Get_Port_Value;        

end Vhpi_Package;
