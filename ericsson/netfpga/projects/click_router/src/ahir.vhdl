library ieee;
use ieee.std_logic_1164.all;

package Types is

  type ApInt is array(integer range <>) of std_logic;
  type ApIntArray is array(integer range <>, integer range <>) of std_logic;
 
  type ApFloat is array(integer range <>) of std_logic;
  type ApFloatArray is array(integer range <>, integer range <>) of std_logic;
  
  type BooleanArray is array(integer range <>) of boolean;
  type IntegerArray is array(integer range <>) of integer;
  type NaturalArray is array(integer range <>) of natural;

  type StdLogicArray2D is array (integer range <>,integer range <>) of std_logic;
  type IStdLogicVector is array (integer range <>) of std_logic; -- note: integer range


end package Types;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;

package Utilities is

  function Convert_To_String(val : integer) return STRING; -- convert val to string.
  function Convert_SLV_To_String(val : std_logic_vector) return STRING; -- convert val to string.
  function Convert_SLV_To_Hex_String(val : std_logic_vector) return STRING; -- convert val to string.  
  function To_Hex_Char (constant val: std_logic_vector)    return character;
  
  function Ceil (constant x, y : integer)   return integer;

  function Ceil_Log2( constant x : integer)  return integer;

  function Max (constant x : NaturalArray)    return natural;

  function Maximum(x,y: integer)   return integer;
  function Minimum(x,y: integer)   return integer;  
  
  function All_Entries_Same ( x : NaturalArray) return boolean;
  function Is_At_Most_One_Hot(x: BooleanArray) return Boolean;
  
end Utilities;


package body Utilities is

    -- Thanks to: D. Calvet calvet@hep.saclay.cea.fr
    -- modified to support negative values
  function Convert_To_String(val : integer) return STRING is
	variable result : STRING(11 downto 1) := (others => '0'); -- smallest natural, longest string
	variable pos    : NATURAL := 1;
	variable tmp : integer;
	variable digit  : NATURAL;
	variable is_negative : boolean;
  begin
	tmp := val;
	if val < 0 then
	  tmp := -val;
	end if;
	is_negative := val < 0;
	
	loop
		digit := abs(tmp MOD 10);
	    	tmp := tmp / 10;
	    	result(pos) := character'val(character'pos('0') + digit);
	    	pos := pos + 1;
	    	exit when tmp = 0;
	end loop;
	
	if is_negative then
	  result(pos) := '-';
	  pos := pos + 1;
	end if;
	
	return result((pos-1) downto 1);
  end Convert_To_String;
  
  function Convert_SLV_To_String(val : std_logic_vector) return STRING is
	alias lval: std_logic_vector(1 to val'length) is val;
        variable ret_var: string( 1 to lval'length);
   begin
        for I in lval'range loop
                if(lval(I) = '1') then
			ret_var(I) := '1';
		elsif (lval(I) = '0') then
			ret_var(I) := '0';
		else
			ret_var(I) := 'X';
		end if;
        end loop;
        return(ret_var);
   end Convert_SLV_To_String;
    

  function To_Hex_Char (constant val: std_logic_vector)   return character  is
    alias lval: std_logic_vector(1 to val'length) is val;
    variable tvar : std_logic_vector(1 to 4);
    variable ret_val : character;
  begin
    if(lval'length >= 4) then
      tvar := lval(1 to 4);
    else
      tvar := (others => '0');
      tvar(1 to lval'length) := lval;
    end if;

    case tvar is
      when "0000" => ret_val := '0';
      when "0001" => ret_val := '1';
      when "0010" => ret_val := '2';                     
      when "0011" => ret_val := '3';
      when "0100" => ret_val := '4';
      when "0101" => ret_val := '5';
      when "0110" => ret_val := '6';                     
      when "0111" => ret_val := '7';
      when "1000" => ret_val := '8';
      when "1001" => ret_val := '9';
      when "1010" => ret_val := 'a';                     
      when "1011" => ret_val := 'b';
      when "1100" => ret_val := 'c';
      when "1101" => ret_val := 'd';
      when "1110" => ret_val := 'e';                     
      when "1111" => ret_val := 'f';                                                               
      when others => ret_val := 'f';
    end case;

    return(ret_val);
  end To_Hex_Char;
        
  function Convert_SLV_To_Hex_String(val : std_logic_vector) return STRING is
    alias lval: std_logic_vector(val'length downto 1) is val;
    variable ret_var: string( 1 to Ceil(lval'length,4));
    variable hstr  : std_logic_vector(4 downto 1);
    variable I : integer;
  begin

    I := 0;

    while I < (lval'length/4) loop
      hstr := lval(4*(I+1) downto (4*I)+1);
      ret_var(ret_var'length - I) := To_Hex_Char(hstr);
      I := (I + 1);
    end loop;  -- I

    hstr := (others => '0');
    if(ret_var'length > (lval'length/4)) then
      hstr((lval'length-((lval'length/4)*4)) downto 1) := lval(lval'length downto (4*(lval'length/4))+1);
      ret_var(1) := To_Hex_Char(hstr);
    end if;

    return(ret_var);
  end Convert_SLV_To_Hex_String;
  
  function Ceil (
    constant x, y : integer)
    return integer is
    variable ret_var : integer;
  begin
    ret_var := x/y;
    if(ret_var*y < y) then
      ret_var := ret_var + 1;
    end if;
    return(ret_var);
  end Ceil;

  function Ceil_Log2
    ( constant x : integer)
    return integer is
    variable ret_var : integer;
  begin
    ret_var := 0;
    if(x > 1) then
      while((2**ret_var) < x) loop
        ret_var := ret_var + 1;
      end loop;
    end if;
    return(ret_var);
  end Ceil_Log2;

  function Max
    (constant x : NaturalArray)
    return natural is
    variable t, max_var : natural;
  begin
    max_var := 0;
    for I in x'low(1) to x'high(1) loop
      t := x(I);
      if( t > max_var) then
        max_var := t;
      end if;
    end loop;  -- I
    return(max_var);
  end function;

  function Maximum(x,y: integer)   return integer is
    begin
      if(x > y) then
        return x;
      else
        return y;
      end if;
    end function Maximum;
    
  function Minimum(x,y: integer)   return integer is
    begin
      if(x > y) then
        return y;
      else
        return x;
      end if;
    end function Minimum;
    

  function All_Entries_Same ( x : NaturalArray) return boolean is
    variable ret_var : boolean;
    variable t : natural;
    alias lx : NaturalArray(x'length - 1 downto 0) is x;
  begin
    ret_var := true;
    if(lx'length > 1) then
      t := lx(lx'high);
      for I in lx'high-1 downto lx'low loop
        if(t /= lx(I)) then
          ret_var := false;
          exit;
        end if;
      end loop;  -- I
    end if;
    return(ret_var);
  end All_Entries_Same;

  function Is_At_Most_One_Hot(x: BooleanArray) return Boolean is
    variable ret_var : boolean;
    alias lx : BooleanArray(1 to x'length) is x;
    variable count : integer;
  begin
    count := 0;
    for I  in lx'range loop
      if(lx(I)) then
        count := count + 1;
      end if;
    end loop;  -- I
    if(count > 1) then
      ret_var := false;
    else
      ret_var := true;
    end if;
    return(ret_var);
  end Is_At_Most_One_Hot;
  
end Utilities;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Utilities.all;

library ieee_proposed;
-- use ieee_proposed.math_utility_pkg.all;
use ieee_proposed.fixed_pkg.all;
use ieee_proposed.float_pkg.all;

package Subprograms is

  function ApIntZero( l: integer) return ApInt;
  function ApFloatZero( characteristic,mantissa: integer) return ApFloat;

  function To_Boolean ( inp : ApInt) return boolean;
  function To_Boolean (  x : std_logic) return Boolean;
  function To_BooleanArray( inp: std_logic_vector) return BooleanArray;
  function To_Std_Logic ( x : boolean)   return std_logic;

  function To_ApInt ( inp : boolean) return ApInt;
  function To_ApInt ( inp : signed) return ApInt;
  function To_Apint ( inp : unsigned) return ApInt;
  function To_ApInt ( inp : std_logic_vector) return ApInt;
  function To_ApInt ( inp : IStdLogicVector) return ApInt;

  function To_Float ( inp : ApFloat) return float;

  function To_Signed ( inp : ApInt) return signed;
  function To_Signed ( inp : std_logic_vector) return signed;
  function To_Unsigned ( inp : ApInt) return unsigned;
  function To_Unsigned ( inp : std_logic_vector) return unsigned;
  function To_Unsigned(constant W : in integer; inp : std_logic_vector) return unsigned;


  function To_SLV ( x: ApInt) return std_logic_vector;
  function To_SLV ( x: IStdLogicVector) return std_logic_vector;
  function To_SLV ( x: ApFloat) return std_logic_vector;
  function To_SLV( x : BooleanArray) return std_logic_vector;
  function To_SLV( x : Signed) return std_logic_vector;
  function To_SLV( x : Unsigned) return std_logic_vector;
  
  function To_SLV (x : StdLogicArray2D) return std_logic_vector; 
  function To_SLV_Shuffle(x : StdLogicArray2D) return std_logic_vector;

  function To_ISLV(inp: ApInt) return IStdLogicVector;
  function To_ISLV(inp: ApFloat) return IStdLogicVector;
  function To_ISLV(inp : BooleanArray) return IStdLogicVector;
  function To_ISLV(inp : std_logic_vector) return IStdLogicVector;
  function To_ISLV(inp: Float) return IStdLogicVector;
  
  function To_StdLogicArray2D( inp: ApIntArray) return StdLogicArray2D;
  function To_StdLogicArray2D( inp: ApFloatArray) return StdLogicArray2D;
  function To_StdLogicArray2D( inp: std_logic_vector) return StdLogicArray2D;
  function To_StdLogicArray2D( inp: std_logic_vector; word_size: integer) return StdLogicArray2D;

  function To_StdLogicArray2D_Shuffle( inp: std_logic_vector; word_size: integer) return StdLogicArray2D;

  function To_ApIntArray(inp : StdLogicArray2D) return ApIntArray;
  function To_ApIntArray (inp : ApInt)   return ApIntArray;
  function To_ApIntArray (inp : integer; width : integer)   return ApIntArray;

  function To_ApFloatArray(inp : StdLogicArray2D) return ApFloatArray;
  function To_ApFloatArray (inp : ApFloat)   return ApFloatArray;

  function "&" (x : ApInt; y : ApInt) return ApInt;
  function "&" (x : ApFloat; y : ApFloat) return ApFloat;
  -- function "&" (x : std_logic_vector; y : std_logic_vector) return std_logic_vector;

  procedure Unflatten (signal z : out ApIntArray; x : in  ApInt);
  procedure Unflatten (signal z : out ApFloatArray; x : in  ApFloat);
  procedure Unflatten (signal z : out StdLogicArray2D; x : in std_logic_vector);

  function zero_pad (x : IStdLogicVector; constant h, l : integer)
    return IStdLogicVector;

  function zero_pad (x : std_logic_vector; constant h, l : integer)
    return std_logic_vector;

  function zero_pad (x : ApInt; constant h, l : integer)
    return ApInt;

  function zero_pad (x : ApFloat; constant h, l : integer)
    return ApFloat;

  function Stack( x, y : StdLogicArray2D) return StdLogicArray2D;
  procedure Split(x : in  StdLogicArray2D; y, z : out StdLogicArray2D);

  function To_ApFloat( x : float)   return ApFloat;
  function To_ApFloat( x : std_logic_vector)   return ApFloat;
  function To_ApFloat( x : std_logic_vector;  characteristic, mantissa: integer)   return ApFloat;
  function To_ApFloat( x : ApInt;  characteristic, mantissa: integer)   return ApFloat;
  function To_ApFloat ( inp : IStdLogicVector) return ApFloat;
  function To_ApFloat (x : real; characteristic, mantissa : integer) return ApFloat;
  function To_ApFloat (x : integer; characteristic, mantissa : integer) return ApFloat;

  function Extract( x : StdLogicArray2D;  idx : integer) return std_logic_vector;
  function Extract( x: ApIntArray;  idx: integer) return ApInt;
  function Extract( x: ApFloatArray;  idx: integer) return ApFloat;


  procedure Extract(source: in std_logic_vector; index: in integer; target: out std_logic_vector);
  procedure Insert(target: out std_logic_vector; index: in integer; source: in std_logic_vector);


  procedure Insert(x: out StdLogicArray2D; idx: in integer; w: in std_logic_vector );
  procedure Insert(x: out ApIntArray; idx: in integer; w: in ApInt );
  procedure Insert(x: out ApFloatArray; idx: in integer; w: in ApFloat );

  function PriorityEncode(x: BooleanArray) return BooleanArray;
  function PriorityEncode(x: std_logic_vector) return std_logic_vector;

  function OrReduce(x: BooleanArray) return boolean;
  function OrReduce(x: std_logic_vector) return std_logic;

  function AndReduce(x: BooleanArray) return boolean;
  function AndReduce(x: std_logic_vector) return std_logic;

  function MuxOneHot (
    constant din : StdLogicArray2D;     -- input data
    constant sel : std_logic_vector)    -- select vector (one hot)
    return std_logic_vector;

  function MuxOneHot(x: std_logic_vector; sel: BooleanArray) return std_logic_vector;
  

  function Swap_Bytes(x: std_logic_vector) return std_logic_vector;

end package Subprograms;


package body Subprograms is

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function ApIntZero( l: integer) return ApInt is
    variable ret_var : ApInt(l-1 downto 0);
  begin
    ret_var := (others => '0');
    return(ret_var);
  end ApIntZero;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function ApFloatZero( characteristic,mantissa: integer) return ApFloat is
    variable ret_var : ApFloat(characteristic downto -mantissa);
  begin
    ret_var := (others => '0');
    return(ret_var);
  end ApFloatZero;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_Boolean ( inp : ApInt) return boolean is
  begin
    if(inp(inp'left) = '1') then
      return(true);
    else
      return(false);
    end if;
  end To_Boolean;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_Boolean (  x : std_logic) return Boolean is
  begin
    if( x = '1') then
      return(true);
    else
      return(false);
    end if;
  end To_Boolean;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_BooleanArray( inp: std_logic_vector) return BooleanArray is
    alias linp : std_logic_vector(1 to inp'length) is inp;
    variable ret_var : BooleanArray(1 to inp'length);
  begin
    for I in 1 to inp'length loop
      ret_var(I) := To_Boolean(linp(I));
    end loop;  -- I
    return(ret_var);
  end To_BooleanArray;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_Std_Logic ( x : boolean)   return std_logic is
  begin
    if(x) then
      return('1');
    else
      return('0');
    end if;
  end To_Std_Logic;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_ApInt ( inp : boolean) return ApInt is
    variable ret_var : ApInt(0 downto 0);
  begin
    if(inp) then
      ret_var(0) := '1';
    else
      ret_var(0) := '0';
    end if;
    return(ret_var);
  end To_ApInt;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_ApInt ( inp : signed) return ApInt is
    alias linp : signed(1 to inp'length) is inp;
    variable ret_var : ApInt(1 to inp'length);
  begin
    for I in 1 to inp'length loop
      ret_var(I) := linp(I);
    end loop;  -- I
    return(ret_var);
  end To_ApInt;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_Apint ( inp : unsigned) return ApInt is
    alias linp : unsigned(1 to inp'length) is inp;
    variable ret_var : ApInt(1 to inp'length);
  begin
    for I in 1 to inp'length loop
      ret_var(I) := linp(I);
    end loop;  -- I
    return(ret_var);
  end To_ApInt;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_ApInt ( inp : std_logic_vector) return ApInt is
    alias linp : std_logic_vector(1 to inp'length) is inp;
    variable ret_var : ApInt(1 to inp'length);
  begin
    for I in 1 to inp'length loop
      ret_var(I) := linp(I);
    end loop;  -- I
    return(ret_var);
  end To_ApInt;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_ApInt ( inp : IStdLogicVector) return ApInt is
    alias linp: IStdLogicVector(inp'high downto inp'low) is inp;
    variable ret_var :ApInt(inp'high downto inp'low);
  begin
    for I in linp'range loop
      ret_var(I) := linp(I);
    end loop;
    return(ret_var);
  end To_ApInt;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_Float ( inp : ApFloat) return float is
    -- note : Apfloat is always of the form (exp downto -mantessa)
    alias linp : ApFloat(inp'high downto inp'low) is inp;
    variable ret_var : float(inp'high downto inp'low);
  begin
    for I in inp'range loop
      ret_var(I) := linp(I);
    end loop;  -- I
    return(ret_var);
  end To_Float;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_Signed ( inp : ApInt) return signed is
    alias linp : ApInt(1 to inp'length) is inp;
    variable ret_var : signed(1 to inp'length);
  begin
    for I in 1 to inp'length loop
      ret_var(I) := linp(I);
    end loop;  -- I
    return(ret_var);
  end To_Signed;


  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_Signed ( inp : std_logic_vector) return signed is
    alias linp : std_logic_vector(1 to inp'length) is inp;
    variable ret_var : signed(1 to inp'length);
  begin
    for I in 1 to inp'length loop
      ret_var(I) := linp(I);
    end loop;  -- I
    return(ret_var);
  end To_Signed;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_Unsigned ( inp : ApInt) return unsigned is
    alias linp : ApInt(1 to inp'length) is inp;
    variable ret_var : unsigned(1 to inp'length);
  begin
    for I in 1 to inp'length loop
      ret_var(I) := linp(I);
    end loop;  -- I
    return(ret_var);
  end To_Unsigned;


  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_Unsigned ( inp : std_logic_vector) return unsigned is
    alias linp : std_logic_vector(1 to inp'length) is inp;
    variable ret_var : unsigned(1 to inp'length);
  begin
    for I in 1 to inp'length loop
      ret_var(I) := linp(I);
    end loop;  -- I
    return(ret_var);
  end To_Unsigned;


  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_Unsigned(constant W : in integer; inp : std_logic_vector) return unsigned is
    alias linp : std_logic_vector(inp'length downto 1) is inp;
    variable ret_var : unsigned(Minimum(W,inp'length) downto 1);
  begin
    for I in 1 to ret_var'length loop
      ret_var(I) := linp(I);
    end loop;  -- I
    return(ret_var);
  end To_Unsigned;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_SLV( x: ApInt) return std_logic_vector is
    alias lx: ApInt(x'length-1 downto 0) is x;
    variable rv: std_logic_vector(x'length-1 downto 0);
  begin
    for I in 1 to x'length loop
      rv(I-1) := lx(I-1);
    end loop;
    return(rv);
  end function To_SLV;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_SLV( x: IStdLogicVector) return std_logic_vector is
    alias lx: IStdLogicVector(x'length-1 downto 0) is x;
    variable rv: std_logic_vector(x'length-1 downto 0);
  begin
    for I in 1 to x'length loop
      rv(I-1) := lx(I-1);
    end loop;
    return(rv);
  end function To_SLV;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_SLV ( x: ApFloat) return std_logic_vector is
    alias lx: ApFloat(x'length-1 downto 0) is x;
    variable rv: std_logic_vector(x'length-1 downto 0);
  begin
    for I in 1 to x'length loop
      rv(I-1) := lx(I-1);
    end loop;
    return(rv);
  end function To_SLV;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_SLV ( x: BooleanArray) return std_logic_vector is
    alias lx: BooleanArray(x'length-1 downto 0) is x;
    variable rv: std_logic_vector(x'length-1 downto 0);
  begin
    for I in 1 to x'length loop
      if(lx(I-1)) then
        rv(I-1) := '1';
      else
        rv(I-1) := '0';
      end if;
    end loop;
    return(rv);
  end function To_SLV;


  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_SLV ( x: Signed) return std_logic_vector is
    alias lx: Signed(1 to x'length) is x;
    variable rv: std_logic_vector(1 to x'length);
  begin
    for I in 1 to x'length loop
      rv(I) := lx(I);
    end loop;
    return(rv);
  end function To_SLV;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_SLV ( x: Unsigned) return std_logic_vector is
    alias lx: Unsigned(1 to x'length) is x;
    variable rv: std_logic_vector(1 to x'length);
  begin
    for I in 1 to x'length loop
      rv(I) := lx(I);
    end loop;
    return(rv);
  end function To_SLV;


  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_ISLV(inp: ApInt) return IStdLogicVector is
    alias linp: ApInt(inp'high downto inp'low) is inp;
    variable ret_var :IStdLogicVector(inp'high downto inp'low);
  begin
    for I in linp'range loop
      ret_var(I) := linp(I);
    end loop;
    return(ret_var);
  end To_ISLV;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_ISLV(inp: ApFloat) return IStdLogicVector is
    alias linp: ApFloat(inp'high downto inp'low) is inp;
    variable ret_var :IStdLogicVector(inp'high downto inp'low);
  begin
    for I in linp'range loop
      ret_var(I) := linp(I);
    end loop;
    return(ret_var);
  end To_ISLV;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_ISLV(inp : BooleanArray) return IStdLogicVector is
    alias linp: BooleanArray(inp'high downto inp'low) is inp;
    variable ret_var :IStdLogicVector(inp'high downto inp'low);
  begin
    for I in linp'range loop
      ret_var(I) := To_Std_Logic(linp(I));
    end loop;
    return(ret_var);
  end To_ISLV;

    -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_ISLV(inp : std_logic_vector) return IStdLogicVector is
    alias linp: std_logic_vector(inp'high downto inp'low) is inp;
    variable ret_var :IStdLogicVector(inp'high downto inp'low);
  begin
    for I in linp'range loop
      ret_var(I) := linp(I);
    end loop;
    return(ret_var);
  end To_ISLV;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_ISLV(inp: Float) return IStdLogicVector is
    variable ret_var :IStdLogicVector(inp'high downto inp'low);
  begin
    for I in inp'range loop
      ret_var(I) := inp(I);
    end loop;
    return(ret_var);
  end To_ISLV;
  

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  -- purpose: convert a 2D array to SLV
  function To_SLV (
    x : StdLogicArray2D)
    return std_logic_vector is
    variable ret_var  : std_logic_vector((x'length(1)*x'length(2))-1 downto 0);
    variable lx : StdLogicArray2D(x'length(1)-1 downto 0, x'length(2)-1 downto 0);
  begin  -- To_SLV
    lx := x;
    for I in lx'range(1) loop
      for J in lx'range(2) loop
        ret_var((I*x'length(1))+J) := lx(I,J);
      end loop;  -- J
    end loop;  -- I
    return(ret_var);
  end To_SLV;
  
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_SLV_Shuffle(x : StdLogicArray2D) return std_logic_vector is
    variable ret_var  : std_logic_vector((x'length(1)*x'length(2))-1 downto 0);
    variable lx : StdLogicArray2D(x'length(1)-1 downto 0, x'length(2)-1 downto 0);
    variable I : integer;
  begin
    lx := x;
    I := 0;
    while I < lx'length(1)/2 loop
      for J in lx'high(2) downto lx'low(2) loop
        ret_var((2*I*x'length(2))+J) := lx(I,J);
        ret_var((((2*I)+1)*x'length(2))+J) := lx(I+(x'length(1)/2),J);
      end loop;  -- J
      I := I + 1;
    end loop;  -- I
    return(ret_var);
  end To_SLV_Shuffle;
  
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_StdLogicArray2D( inp: ApIntArray) return StdLogicArray2D is
    variable ret_var : StdLogicArray2D(inp'range(1), inp'range(2));
  begin
    for I in ret_var'range(1) loop
      for J in ret_var'range(2) loop
        ret_var(I,J) := inp(I,J);
      end loop;  -- J
    end loop;  -- I
    return(ret_var);
  end To_StdLogicArray2D;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_StdLogicArray2D( inp: ApFloatArray) return StdLogicArray2D is
    variable ret_var : StdLogicArray2D(inp'range(1), inp'range(2));
  begin
    for I in ret_var'range(1) loop
      for J in ret_var'range(2) loop
        ret_var(I,J) := inp(I,J);
      end loop;  -- J
    end loop;  -- I
    return(ret_var);
  end To_StdLogicArray2D;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_StdLogicArray2D( inp: std_logic_vector) return StdLogicArray2D is
    alias linp: std_logic_vector(inp'length-1 downto 0) is inp;
    variable ret_var : StdLogicArray2D(0 downto 0, inp'length-1 downto 0);
  begin
    for I in linp'range loop
      ret_var(0,I) := linp(I);
    end loop;
    return(ret_var);
  end To_StdLogicArray2D;
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------

  function To_StdLogicArray2D( inp: std_logic_vector; word_size: integer) return StdLogicArray2D is
    variable ret_var : StdLogicArray2D((inp'length/word_size)-1 downto 0, word_size-1 downto 0);
    alias linp : std_logic_vector(inp'length-1 downto 0) is inp;
  begin
    for I in ret_var'range(1) loop
      for J in word_size-1 downto 0 loop
        ret_var(I,J) := linp((I*word_size)+J);
      end loop;  -- J
    end loop;  -- I
    return(ret_var);
  end To_StdLogicArray2D;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  
  function To_StdLogicArray2D_Shuffle( inp: std_logic_vector; word_size: integer) return StdLogicArray2D is
    variable ret_var : StdLogicArray2D((inp'length/word_size)-1 downto 0, word_size-1 downto 0);
    alias linp : std_logic_vector(inp'length-1 downto 0) is inp;
    variable I : integer;
  begin
    I := 0;
    while I <  (ret_var'length(1)/2)-1 loop
      for J in word_size-1 downto 0 loop
        ret_var(I,J) := linp((2*I*word_size)+J);
        ret_var(I+ret_var'length(1),J) := linp((((2*I)+1)*word_size) + J);
      end loop;  -- J
      I := I + 1;
    end loop;  -- I
    return(ret_var);
  end To_StdLogicArray2D_Shuffle;


  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  
  function To_ApIntArray(inp : StdLogicArray2D) return ApIntArray is
    variable linp  : StdLogicArray2D(inp'high(1) downto inp'low(1), inp'high(2) downto inp'low(2));
    variable ret_var : ApIntArray(inp'high(1) downto inp'low(1), inp'high(2) downto inp'low(2));
  begin
    linp := inp;
    for I in linp'range(1) loop
      for J in linp'range(2) loop
        ret_var(I,J) := linp(I,J);
      end loop;  -- J
    end loop;  -- I
    return(ret_var);
  end To_ApIntArray;


  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_ApIntArray (inp : ApInt)   return ApIntArray is
    variable ret_var : ApIntArray(0 downto 0, inp'range);
  begin
    for I in inp'range loop
      ret_var(0,I) := inp(I);
    end loop;  -- I
    return(ret_var);
  end To_ApIntArray;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_ApIntArray(inp : integer; width: integer) return ApIntArray is
  begin
    return To_ApIntArray(To_ApInt(to_signed(inp, width)));
  end To_ApIntArray;

  -----------------------------------------------------------------------------
  function To_ApFloatArray(inp : StdLogicArray2D) return ApFloatArray is
    variable linp  : StdLogicArray2D(inp'high(1) downto inp'low(1), inp'high(2) downto inp'low(2));
    variable ret_var : ApFloatArray(inp'high(1) downto inp'low(1), inp'high(2) downto inp'low(2));
  begin
    linp := inp;
    for I in linp'range(1) loop
      for J in linp'range(2) loop
        ret_var(I,J) := linp(I,J);
      end loop;  -- J
    end loop;  -- I
    return(ret_var);
  end To_ApFloatArray;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_ApFloatArray (inp : ApFloat)   return ApFloatArray is
    variable ret_var : ApFloatArray(0 downto 0, inp'range);
  begin
    for I in inp'range loop
      ret_var(0,I) := inp(I);
    end loop;  -- I
    return(ret_var);
  end To_ApFloatArray;


  -----------------------------------------------------------------------------
  function Stack ( x, y : StdLogicArray2D) return StdLogicArray2D is
    variable lx  : StdLogicArray2D(x'length(1)-1 downto 0, x'high(2) downto x'low(2));
    variable ly  : StdLogicArray2D(y'length(1)-1 downto 0, y'high(2) downto y'low(2));
    variable ret_var:  StdLogicArray2D(x'length(1) + y'length(1) - 1 downto 0, x'high(2) downto x'low(2));
  begin
    lx := x;
    ly := y;
    assert x'high(2) = y'high(2) and x'low(2) = y'low(2) report "high/low index mismatch in Stack"
      severity error;

    for I in lx'range(1) loop
      for J  in x'high(2) downto x'low(2) loop
        ret_var(I,J) := lx(I,J);
      end loop;  -- J
    end loop;  -- I

    for I in ly'range(1) loop
      for J  in y'high(2) downto y'low(2) loop
        ret_var(I+x'length(1),J) := ly(I,J);
      end loop;  -- J
    end loop;  -- I
    return(ret_var);
  end Stack;



  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  procedure Split(x : in  StdLogicArray2D; y, z : out StdLogicArray2D) is
    variable lx  : StdLogicArray2D(x'length(1)-1 downto 0, x'high(2) downto x'low(2));
    variable ly  : StdLogicArray2D(y'length(1)-1 downto 0, y'high(2) downto y'low(2));
    variable lz  : StdLogicArray2D(z'length(1)-1 downto 0, z'high(2) downto z'low(2));
  begin
    assert x'length = (y'length + z'length) report "length mismatch in Split" severity error;
    assert x'high(2) = y'high(2) and x'high(2) = z'high(2) and x'low(2) = y'low(2) and x'low(2) = z'low(2)
      report "high/low mismatch in Split" severity error;

    lx := x;
    for I in ly'range(1) loop
      for J  in y'high(2) downto y'low(2) loop
        ly(I,J) := lx(I,J);
      end loop;  -- J
    end loop;  -- I

    for I in lz'range(1) loop
      for J  in z'high(2) downto z'low(2) loop
        lz(I,J) := lx(I+ly'length(1),J);
      end loop;  -- J
    end loop;  -- I

    y := ly;
    z := lz;
  end Procedure Split;

  -----------------------------------------------------------------------------
  -- Rearrange a really long ApInt into an ApIntArray.
  -- Used by the data-path along with the concatentation operator "&"
  -- to populate an ApIntArray using various ApInt's.
  -----------------------------------------------------------------------------
  procedure Unflatten_var (z : out StdLogicArray2D; x : in  std_logic_vector) is
    alias lx : std_logic_vector(0 to x'length - 1) is x;
    variable p : integer := 0;
  begin
    assert z'length(1) * z'length(2) = x'length
      report "z and x don't match"
      severity error;
    
    p := 0;
    
    for i in z'range(1) loop
      for j in z'range(2) loop
        z(i, j) := lx(p);
        p := p + 1;
      end loop;  -- j
    end loop;  -- i
  end procedure Unflatten_var;

  procedure Unflatten (signal z : out ApIntArray; x : in  ApInt) is
    variable lz : StdLogicArray2D(z'range(1), z'range(2));
  begin
    Unflatten_var(lz, To_SLV(x));
    z <= To_ApIntArray(lz);
  end procedure Unflatten;

  procedure Unflatten (signal z : out ApFloatArray; x : in  ApFloat) is
    variable lz : StdLogicArray2D(z'range(1), z'range(2));
  begin
    Unflatten_var(lz, To_SLV(x));
    z <= To_ApFloatArray(lz);
  end procedure Unflatten;

  procedure Unflatten (signal z : out StdLogicArray2D; x : in std_logic_vector) is
    variable lz : StdLogicArray2D(z'range(1), z'range(2));
  begin
    Unflatten_var(lz, x);
    z <= lz;
  end procedure Unflatten;
  -----------------------------------------------------------------------------
  
  -----------------------------------------------------------------------------
  -- Concatenation operator for ApInt
  -----------------------------------------------------------------------------
  --function "&" (x : std_logic_vector; y : std_logic_vector) return std_logic_vector is
    --variable z : std_logic_vector(0 to x'length + y'length - 1);
  --begin
    --z(0 to x'length - 1) := x;
    --z(x'length to z'length - 1) := y;
    --return z;
  --end function "&";

  function "&" (x : ApInt; y : ApInt) return ApInt is
  begin
    return To_ApInt(To_SLV(x) & To_SLV(y));
  end function "&";

  function "&" (x : ApFloat; y : ApFloat) return ApFloat is
  begin
    return To_ApFloat(To_SLV(x) & To_SLV(y));
  end function "&";
  -----------------------------------------------------------------------------
  
  -----------------------------------------------------------------------------
  -- pad a given value with zeroes on either side.
  -----------------------------------------------------------------------------
  function zero_pad_ascending (x : IStdLogicVector; constant h, l : integer)
    return IStdLogicVector is
    variable z : IStdLogicVector(l to h);
  begin
    assert x'ascending report "expected an SLV with ascending range" severity error;
    assert x'high <= h and x'low >= l report "input out of range" severity error;

    if z'low < x'low then
      z(z'low to x'low - 1) := (others => '0');
    end if;

    if z'high > x'high then
      z(x'high + 1 to z'high) := (others => '0');
    end if;

    z(x'low to x'high) := x;

    return z;
  end zero_pad_ascending;

  function zero_pad_descending (x : IStdLogicVector; constant h, l : integer)
    return IStdLogicVector is
    variable z : IStdLogicVector(h downto l);
  begin
    assert not x'ascending report "expected an SLV with descending range" severity error;
    assert x'high <= h and x'low >= l report "input out of range" severity error;

    if z'low < x'low then
      z(x'low - 1 downto z'low) := (others => '0');
    end if;

    if z'high > x'high then
      z(z'high downto x'high + 1) := (others => '0');
    end if;

    z(x'high downto x'low) := x;

    return z;
  end zero_pad_descending;

  function zero_pad (x : IStdLogicVector; constant h, l : integer)
    return IStdLogicVector is
  begin
    if x'ascending then
      return zero_pad_ascending(x, h, l);
    else
      return zero_pad_descending(x, h, l);
    end if;
  end zero_pad;
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  -- pad ApInt and ApFloat values
  -----------------------------------------------------------------------------
  function zero_pad (
    x             : ApInt;
    constant h, l : integer)
    return ApInt is
  begin
    return To_ApInt(zero_pad(To_ISLV(x), h, l));
  end zero_pad;
  
  function zero_pad (
    x             : ApFloat;
    constant h, l : integer)
    return ApFloat is
  begin
    return To_ApFloat(zero_pad(To_ISLV(x), h, l));
  end zero_pad;

  function zero_pad (
    x             : std_logic_vector;
    constant h, l : integer)
    return std_logic_vector is
  begin
    return To_SLV(zero_pad(To_ISLV(x), h, l));
  end zero_pad;
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_ApFloat( x : float)   return ApFloat is
    variable rv: ApFloat(x'high downto x'low);
  begin
    for I in x'range loop
      rv(I) := x(I);
    end loop;
    return(rv);
  end function To_ApFloat;


  -----------------------------------------------------------------------------
  function To_ApFloat( x : std_logic_vector)   return ApFloat is
    alias lx: std_logic_vector(0 to x'length-1) is x;
    variable rv: ApFloat(0 to x'length-1);
  begin
    for I in lx'range loop
      rv(I) := lx(I);
    end loop;
    return(rv);
  end function To_ApFloat;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_ApFloat( x : std_logic_vector;  characteristic, mantissa: integer)   return ApFloat is
    --alias lx: std_logic_vector(characteristic downto mantissa) is x;
    -- will not work because mantissa will be negative
    variable rv: ApFloat(characteristic downto mantissa);
    variable J: integer;
  begin
    assert (x'length = characteristic-mantissa+1)
      report "Length Mismatch in To_ApFloat" severity error;

    J := characteristic;
    for I  in x'range loop
      rv(J) := x(I);
      J := J-1;
    end loop;  -- I
    return(rv);
  end To_ApFloat;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_ApFloat( x : ApInt;  characteristic, mantissa: integer)   return ApFloat is
    alias lx: ApInt(characteristic downto mantissa) is x;
    variable rv: ApFloat(characteristic downto mantissa);
  begin
    for I  in lx'range loop
      rv(I) := lx(I);
    end loop;  -- I
    return(rv);
  end To_ApFloat;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_ApFloat ( inp : IStdLogicVector) return ApFloat is
    alias linp: IStdLogicVector(inp'high downto inp'low) is inp;
    variable ret_var :ApFloat(inp'high downto inp'low);
  begin
    for I in linp'range loop
      ret_var(I) := linp(I);
    end loop;
    return(ret_var);
  end To_ApFloat;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_ApFloat( x : real; characteristic, mantissa : integer)   return ApFloat is
  begin
    return to_apfloat(to_float(x, characteristic, mantissa));
  end function To_ApFloat;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function To_ApFloat( x : integer; characteristic, mantissa : integer)   return ApFloat is
  begin
    return to_apfloat(to_float(x, characteristic, mantissa));
  end function To_ApFloat;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function Extract( x : StdLogicArray2D;  idx : integer) return std_logic_vector is
    variable rv: IStdLogicVector(x'range(2));
  begin
    for I in x'range(2) loop
      rv(I) := x(idx,I);
    end loop;
    return To_SLV(rv);
  end function Extract;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function Extract( x: ApIntArray;  idx: integer) return ApInt is
    variable rv: ApInt(x'range(2));
  begin
    rv := To_ApInt(Extract(To_StdLogicArray2D(x),idx));
    return(rv);
  end function Extract;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function Extract( x: ApFloatArray;  idx: integer) return ApFloat is
    variable rv: ApFloat(x'range(2));
  begin
    rv := To_ApFloat(Extract(To_StdLogicArray2D(x),idx));
    return(rv);
  end function Extract;


  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  procedure Extract(source: in std_logic_vector; index: in integer; target: out std_logic_vector) is
  begin
    target := source(((index+1)*target'length)-1 downto (index*target'length));
  end procedure;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  procedure Insert(target: out std_logic_vector; index: in integer; source: in std_logic_vector) is
  begin
    target(((index+1)*source'length)-1 downto (index*source'length)) := source;
  end procedure;

  
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  procedure Insert(x: out StdLogicArray2D; idx: in integer; w: in std_logic_vector ) is
    alias lw: std_logic_vector(0 to w'length-1) is w;
    variable xI: integer;
  begin
    for I in lw'range loop
      if(x'ascending(2)) then
        xI := x'left(2) + I;
      else
        xI := x'left(2) - I;
      end if;
      x(idx,xI) := lw(I);
    end loop;
  end procedure Insert;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  procedure Insert(x: out ApIntArray; idx: in integer; w: in ApInt ) is
    alias lw: ApInt(0 to w'length-1) is w;
    variable xI: integer;
  begin
    for I in lw'range loop
      if(x'ascending(2)) then
        xI := x'left(2) + I;
      else
        xI := x'left(2) - I;
      end if;
      x(idx,xI) := lw(I);
    end loop;
  end procedure Insert;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  procedure Insert(x: out ApFloatArray; idx: in integer; w: in ApFloat ) is
    alias lw: ApFloat(0 to w'length-1) is w;
    variable xI: integer;
  begin
    for I in lw'range loop
      if(x'ascending(2)) then
        xI := x'left(2) + I;
      else
        xI := x'left(2) - I;
      end if;
      x(idx,xI) := lw(I);
    end loop;
  end procedure Insert;


  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function PriorityEncode(x: BooleanArray) return BooleanArray is
    alias lx  : BooleanArray(1 to x'length) is x;
    variable ret_var  : BooleanArray(1 to x'length);
  begin
    if(lx'length = 1) then
      ret_var(1) := lx(1);
    else
      ret_var := (others => false);
      if(OrReduce(lx(1 to (x'length/2)))) then
        ret_var(1 to (x'length/2)) := PriorityEncode(lx(1 to x'length/2));
      elsif(OrReduce(lx((x'length/2)+1 to x'length))) then
        ret_var((x'length/2)+1 to x'length) := PriorityEncode(lx((x'length/2)+1 to x'length));
      end if;
    end if;
    return(ret_var);
  end PriorityEncode;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function PriorityEncode(x: std_logic_vector) return std_logic_vector is
  begin
    return(To_SLV(PriorityEncode(To_BooleanArray(x))));
  end PriorityEncode;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function OrReduce(x: BooleanArray) return boolean is
    alias lx  : BooleanArray(1 to x'length) is x;
    variable ret_var  : Boolean;
  begin
    if(lx'length = 1) then
      ret_var := lx(1);
    else
      ret_var:= OrReduce(lx(1 to x'length/2)) or OrReduce(lx((x'length/2)+1 to x'length));
    end if;
    return(ret_var);
  end OrReduce;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function OrReduce(x: std_logic_vector) return std_logic is
  begin
    return(To_Std_Logic(OrReduce(To_BooleanArray(x))));
  end OrReduce;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function AndReduce(x: BooleanArray) return boolean is
    alias lx  : BooleanArray(1 to x'length) is x;
    variable ret_var  : Boolean;
  begin
    if(lx'length = 1) then
      ret_var := lx(1);
    else
      ret_var:= AndReduce(lx(1 to x'length/2)) and AndReduce(lx((x'length/2)+1 to x'length));
    end if;
    return(ret_var);
  end AndReduce;

  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  function AndReduce(x: std_logic_vector) return std_logic is
  begin
    return(To_Std_Logic(AndReduce(To_BooleanArray(x))));
  end AndReduce;

  -----------------------------------------------------------------------------
  -- sel is one-hot coded, build a balanced mux to
  -- pick row indicated by sel from din
  -----------------------------------------------------------------------------
  -- a utility function.
  function MuxOneHotBase (
    constant din  : StdLogicArray2D;
    constant sel  : std_logic_vector;
    constant h, l : integer)
    return std_logic_vector is
    variable ret_val : std_logic_vector(din'length(2)-1 downto 0);
    variable mid_point  : integer;
  begin
    ret_val := (others => '0');
    if(h > l) then
      mid_point := l + ((h-l)/2);
      ret_val := MuxOneHotBase(din,sel,h,mid_point+1) or
                 MuxOneHotBase(din,sel,mid_point,l);
    else
      if(sel(l) = '1') then 
      	ret_val := Extract(din,l);
      end if;
    end if;
    return(ret_val);
  end MuxOneHotBase;


  function MuxOneHot (
      constant din : StdLogicArray2D;     -- input data
      constant sel : std_logic_vector)    -- select vector (one hot)
      return std_logic_vector is
      variable ret_var : std_logic_vector(din'length(2)-1 downto 0);
      variable dinv : StdLogicArray2D(din'length(1)-1 downto 0, din'length(2)-1 downto 0);
      alias selv : std_logic_vector(sel'length-1 downto 0) is sel;
    begin
      dinv := din;
      assert sel'length = din'length(1) report "mismatched select and data dimensions" severity failure;
      ret_var := MuxOneHotBase(dinv,selv,dinv'high(1),dinv'low(1));
      return(ret_var);
    end MuxOneHot;

  function MuxOneHot(x: std_logic_vector; sel: BooleanArray) return std_logic_vector is
	variable ret_var : std_logic_vector(1 to ((x'length)/(sel'length)));
	variable mid_point : integer;
	alias lsel : BooleanArray(1 to sel'length) is sel;
	alias lx : std_logic_vector(1 to x'length) is x;
	constant word_size: integer := x'length/sel'length;
  begin
	assert( word_size*sel'length = x'length)
		report "word size not an integer" severity failure;

        if(sel'length = 1) then
		if(lsel(1)) then
            		ret_var := x;
		else
			ret_var := (others => '0');
		end if;
	else
		mid_point := sel'length/2;
		ret_var :=  MuxOneHot(lx(1 to (mid_point*word_size)), lsel(1 to mid_point)) or
                           MuxOneHot(lx((mid_point*word_size)+1 to x'length), lsel(mid_point+1 to sel'length));
	end if;
	return(ret_var);
  end MuxOneHot;
      
  function Swap_Bytes(x: std_logic_vector) return std_logic_vector is
     alias lx: std_logic_vector(1 to x'length) is x;
     variable ret_var: std_logic_vector(1 to x'length);
     variable J: integer;
     constant num_bytes: integer := (x'length/8);
  begin
     assert((x'length/8)*8 = x'length) report "Swap_Bytes argument length must be a multiple of 8" severity error;
     for I in 0 to num_bytes-1 loop
	J := (num_bytes-1) - I;
	ret_var((I*8)+1 to (I+1)*8) := lx((J*8)+1 to (J+1)*8);
     end loop;  
     return(ret_var);
  end Swap_Bytes;

end package body Subprograms;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;

package BaseComponents is

  -----------------------------------------------------------------------------
  -- control path components
  -----------------------------------------------------------------------------
  
  component place
    generic (
      marking : boolean := false;
      bypass: boolean := false);
    port (
      preds : in  BooleanArray;
      succs : in  BooleanArray;
      token : out boolean;
      clk   : in  std_logic;
      reset : in  std_logic); 
  end component;

  component transition
    port (
      preds      : in BooleanArray;
      symbol_in  : in boolean;
      symbol_out : out boolean); 
  end component;

  component out_transition
      port (preds      : in   BooleanArray;
              symbol_out : out  boolean);
  end component;

  component level_to_pulse 
    port (clk   : in  std_logic;
          reset : in  std_logic;
          lreq: in std_logic;
          lack: out std_logic;
          preq: out boolean;
          pack: in boolean);
  end component;
  
  component control_delay_element 
    generic (delay_value: integer := 0);
    port (
      req   : in Boolean;
      ack   : out Boolean;
      clk   : in  std_logic;
      reset : in  std_logic);
  end component;

  component pipeline_interlock 
    port (trigger: in boolean;
          enable : in boolean;
          symbol_out : out  boolean;
          clk: in std_logic;
          reset: in std_logic);
  end component;

  component join is
     port ( preds      : in   BooleanArray;
    	symbol_out : out  boolean;
	clk: in std_logic;
	reset: in std_logic);
  end component;

  component join2 
    port ( pred0, pred1      : in   Boolean;
           symbol_out : out  boolean;
           clk: in std_logic;
           reset: in std_logic);
  end component;

  component join_with_input is
     port ( preds      : in   BooleanArray;
    	symbol_in  : in   boolean;
    	symbol_out : out  boolean;
	clk: in std_logic;
	reset: in std_logic);
  end component;

  component auto_run 
  	generic (
    		use_delay : boolean);
          port (clk   : in  std_logic;
    	reset : in  std_logic;
	start_req: out std_logic;
        start_ack: in std_logic;
        fin_req: out std_logic;
        fin_ack: in std_logic);
  end component;

  -----------------------------------------------------------------------------
  -- miscellaneous
  -----------------------------------------------------------------------------
  component BypassRegister 
  generic(data_width: integer; enable_bypass: boolean); 
  port (
    clk, reset : in  std_logic;
    enable     : in  std_logic;
    data_in     : in  std_logic_vector(data_width-1 downto 0);
    data_out    : out std_logic_vector(data_width-1 downto 0));
  end component BypassRegister;


  -----------------------------------------------------------------------------
  -- operator base components
  -----------------------------------------------------------------------------
  component GenericCombinationalOperator 
  generic
    (
      operator_id   : string;          -- operator id
      input1_is_int : Boolean := true; -- false means float
      input1_characteristic_width : integer := 0; -- characteristic width if input1 is float
      input1_mantissa_width       : integer := 0; -- mantissa width if input1 is float
      iwidth_1      : integer;    -- width of input1
      input2_is_int : Boolean := true; -- false means float
      input2_characteristic_width : integer := 0; -- characteristic width if input2 is float
      input2_mantissa_width       : integer := 0; -- mantissa width if input2 is float
      iwidth_2      : integer;    -- width of input2
      num_inputs    : integer := 2;    -- can be 1 or 2.
      output_is_int : Boolean := true;  -- false means that the output is a float
      output_characteristic_width : integer := 0;
      output_mantissa_width       : integer := 0;
      owidth        : integer;          -- width of output.
      constant_operand : std_logic_vector; -- constant operand.. (it is always the second operand)
      constant_width: integer;
      use_constant  : boolean := false
      );
  port (
    data_in       : in  std_logic_vector(iwidth_1 + iwidth_2 - 1 downto 0);
    result      : out std_logic_vector(owidth-1 downto 0)
    );
  end component GenericCombinationalOperator;

  component UnsharedOperatorBase 
    generic
      (
        operator_id   : string;          -- operator id
        input1_is_int : Boolean := true; -- false means float
        input1_characteristic_width : integer := 0; -- characteristic width if input1 is float
        input1_mantissa_width       : integer := 0; -- mantissa width if input1 is float
        iwidth_1      : integer;    -- width of input1
        input2_is_int : Boolean := true; -- false means float
        input2_characteristic_width : integer := 0; -- characteristic width if input2 is float
        input2_mantissa_width       : integer := 0; -- mantissa width if input2 is float
        iwidth_2      : integer;    -- width of input2
        num_inputs    : integer := 2;    -- can be 1 or 2.
        output_is_int : Boolean := true;  -- false means that the output is a float
        output_characteristic_width : integer := 0;
        output_mantissa_width       : integer := 0;
        owidth        : integer;          -- width of output.
        constant_operand : std_logic_vector; -- constant operand.. (it is always the second operand)
        constant_width: integer;
        use_constant  : boolean := false;  -- if true, the second operand is
                                           -- assumed to be the generic
        zero_delay    : boolean := false;  -- if true, operator result is
                                           -- registered, but with a bypass, so
                                           -- that the result is available immediately.
        flow_through  : boolean := false  -- if true, operator is combinational
        );
    port (
      -- req -> ack follow pulse protocol
      reqL:  in Boolean;
      ackL : out Boolean;
      reqR : in Boolean;
      ackR:  out Boolean;
      -- operands.
      dataL      : in  std_logic_vector(iwidth_1 + iwidth_2 - 1 downto 0);
      dataR      : out std_logic_vector(owidth-1 downto 0);
      clk, reset : in  std_logic);
  end component UnsharedOperatorBase;

  component SplitOperatorBase
    generic
      (
        operator_id   : string;          -- operator id
        input1_is_int : Boolean := true; -- false means float
        input1_characteristic_width : integer := 0; -- characteristic width if input1 is float
        input1_mantissa_width       : integer := 0; -- mantissa width if input1 is float
        iwidth_1      : integer;    -- width of input1
        input2_is_int : Boolean := true; -- false means float
        input2_characteristic_width : integer := 0; -- characteristic width if input2 is float
        input2_mantissa_width       : integer := 0; -- mantissa width if input2 is float
        iwidth_2      : integer;    -- width of input2
        num_inputs    : integer := 2;    -- can be 1 or 2.
        output_is_int : Boolean := true;  -- false means that the output is a float
        output_characteristic_width : integer := 0;
        output_mantissa_width       : integer := 0;
        owidth        : integer;          -- width of output.
        constant_operand : std_logic_vector; -- constant operand.. (it is always the second operand)
        constant_width: integer;
        twidth        : integer;          -- tag width
        use_constant  : boolean := false;  -- if true, the second operand is
                                           -- provided by the generic.
        zero_delay    : boolean := false  -- if true, the result is registered,
                                          -- but with a bypass, so that it is
                                          -- available immediately.
        );
    port (
      -- req/ack follow level protocol
      reqR: out std_logic;
      ackR: in std_logic;
      reqL: in std_logic;
      ackL : out  std_logic;
      -- tagL is passed out to tagR
      tagL       : in  std_logic_vector(twidth-1 downto 0);
      -- input array consists of m sets of 1 or 2 possibly concatenated
      -- operands.
      dataL      : in  std_logic_vector(iwidth_1 + iwidth_2 - 1 downto 0);
      dataR      : out std_logic_vector(owidth-1 downto 0);
      -- tagR is received from tagL, concurrent
      -- with dataR
      tagR       : out std_logic_vector(twidth-1 downto 0);
      clk, reset : in  std_logic);
  end component SplitOperatorBase;


  component SplitOperatorShared
    generic
      (
        operator_id   : string;          -- operator id
        input1_is_int : Boolean := true; -- false means float
        input1_characteristic_width : integer := 0; -- characteristic width if input1 is float
        input1_mantissa_width       : integer := 0; -- mantissa width if input1 is float
        iwidth_1      : integer;    -- width of input1
        input2_is_int : Boolean := true; -- false means float
        input2_characteristic_width : integer := 0; -- characteristic width if input2 is float
        input2_mantissa_width       : integer := 0; -- mantissa width if input2 is float
        iwidth_2      : integer;    -- width of input2
        num_inputs    : integer := 2;    -- can be 1 or 2.
        output_is_int : Boolean := true;  -- false means that the output is a float
        output_characteristic_width : integer := 0;
        output_mantissa_width       : integer := 0;
        owidth        : integer;          -- width of output.
        constant_operand : std_logic_vector; -- constant operand.. (it is always the second operand)
        constant_width: integer;
        use_constant  : boolean := false;
        zero_delay    : boolean := false;
        no_arbitration: boolean := false;
        min_clock_period: boolean := false;
        num_reqs : integer  -- how many requesters?
        );

    port (
      -- req/ack follow level protocol
      reqL                     : in BooleanArray(num_reqs-1 downto 0);
      ackR                     : out BooleanArray(num_reqs-1 downto 0);
      ackL                     : out BooleanArray(num_reqs-1 downto 0);
      reqR                     : in  BooleanArray(num_reqs-1 downto 0);
      -- input data consists of concatenated pairs of ips
      dataL                    : in std_logic_vector(((iwidth_1 + iwidth_2)*num_reqs)-1 downto 0);
      -- output data consists of concatenated pairs of ops.
      dataR                    : out std_logic_vector((owidth*num_reqs)-1 downto 0);
      -- with dataR
      clk, reset              : in std_logic);
  end component SplitOperatorShared;


  component SplitOperatorSharedTB 
    generic
      ( g_num_req: integer := 2;
        operator_id: string := "ApIntSle";
        zero_delay : boolean := false;
        verbose_mode: boolean := false;
        input_data_width: integer := 8;
        output_data_width: integer := 1;
        num_ips : integer := 2;
        tb_id : string := "anonymous"
        );
  end component SplitOperatorSharedTB;

  -----------------------------------------------------------------------------
  -- register operator
  -----------------------------------------------------------------------------
  component RegisterBase 
      generic(in_data_width: integer; out_data_width : integer; flow_through: boolean);
      port(din: in std_logic_vector(in_data_width-1 downto 0);
           dout: out std_logic_vector(out_data_width-1 downto 0);
           req: in boolean;
           ack: out boolean;
           clk,reset: in std_logic);
  end component RegisterBase;

  -----------------------------------------------------------------------------
  -- queue
  -----------------------------------------------------------------------------
  
  component QueueBase 
    generic(queue_depth: integer := 2; data_width: integer := 32);
    port(clk: in std_logic;
         reset: in std_logic;
         data_in: in std_logic_vector(data_width-1 downto 0);
         push_req: in std_logic;
         push_ack: out std_logic;
         data_out: out std_logic_vector(data_width-1 downto 0);
         pop_ack : out std_logic;
         pop_req: in std_logic);
  end component QueueBase;

  -----------------------------------------------------------------------------
  -- pipe
  -----------------------------------------------------------------------------
  component PipeBase 
    
    generic (num_reads: integer;
             num_writes: integer;
             data_width: integer;
             depth: integer := 1);
    port (
      read_req       : in  std_logic_vector(num_reads-1 downto 0);
      read_ack       : out std_logic_vector(num_reads-1 downto 0);
      read_data      : out std_logic_vector((num_reads*data_width)-1 downto 0);
      write_req       : in  std_logic_vector(num_writes-1 downto 0);
      write_ack       : out std_logic_vector(num_writes-1 downto 0);
      write_data      : in std_logic_vector((num_writes*data_width)-1 downto 0);
      clk, reset : in  std_logic);
    
  end component PipeBase;


  -----------------------------------------------------------------------------
  -- phi,branch,select
  -----------------------------------------------------------------------------

  component PhiBase 
    generic (
      num_reqs   : integer;
      data_width : integer);
    port (
      req                 : in  BooleanArray(num_reqs-1 downto 0);
      ack                 : out Boolean;
      idata               : in  std_logic_vector((num_reqs*data_width)-1 downto 0);
      odata               : out std_logic_vector(data_width-1 downto 0);
      clk, reset          : in std_logic);
  end component PhiBase;


  component BranchBase
    generic (
      condition_width : integer);
    port (condition: in std_logic_vector(condition_width-1 downto 0);
          clk,reset: in std_logic;
          req: in Boolean;
          ack0: out Boolean;
          ack1: out Boolean);
  end component;

  component SelectBase 
    generic(data_width: integer);
    port(x,y: in std_logic_vector(data_width-1 downto 0);
         sel: in std_logic_vector(0 downto 0);
         req: in boolean;
         z: out std_logic_vector(data_width-1 downto 0);
         ack: out boolean;
         clk,reset: in std_logic);
  end component SelectBase;


  component Slicebase 
    generic(in_data_width : integer; high_index: integer; low_index : integer; zero_delay : boolean);
    port(din: in std_logic_vector(in_data_width-1 downto 0);
         dout: out std_logic_vector(high_index-low_index downto 0);
         req: in boolean;
         ack: out boolean;
         clk,reset: in std_logic);
  end component Slicebase;


  -----------------------------------------------------------------------------
  -- mux/demux
  -----------------------------------------------------------------------------
  
  component InputMuxBase 
    generic ( iwidth: integer;
              owidth: integer;
              twidth: integer;
              nreqs: integer;
              no_arbitration: Boolean;
              registered_output: Boolean);
    port (
      -- req/ack follow pulse protocol
      reqL                 : in  BooleanArray(nreqs-1 downto 0);
      ackL                 : out BooleanArray(nreqs-1 downto 0);
      dataL                : in  std_logic_vector(iwidth-1 downto 0);
      -- output side req/ack level protocol
      reqR                 : out std_logic;
      ackR                 : in  std_logic;
      dataR                : out std_logic_vector(owidth-1 downto 0);
      -- tag specifies the requester index 
      tagR                : out std_logic_vector(twidth-1 downto 0);
      clk, reset          : in std_logic);
  end component InputMuxBase;

  component InputMuxBaseNoData 
    generic ( twidth: integer;
              nreqs: integer;
              no_arbitration: Boolean);
    port (
      -- req/ack follow pulse protocol
      reqL                 : in  BooleanArray(nreqs-1 downto 0);
      ackL                 : out BooleanArray(nreqs-1 downto 0);
      -- output side req/ack level protocol
      reqR                 : out std_logic;
      ackR                 : in  std_logic;
      -- tag specifies the requester index 
      tagR                : out std_logic_vector(twidth-1 downto 0);
      clk, reset          : in std_logic);
  end component InputMuxBaseNoData;


  component OutputDeMuxBase 
    generic(iwidth: integer;
            owidth: integer;
            twidth: integer;
            nreqs: integer;
            no_arbitration: Boolean);
    port (
      -- req/ack follow level protocol
      reqL                 : in  std_logic;
      ackL                 : out std_logic;
      dataL                : in  std_logic_vector(iwidth-1 downto 0);
      -- tag identifies index to which demux
      -- should happen
      tagL                 : in std_logic_vector(twidth-1 downto 0);
      -- reqR/ackR follow pulse protocol
      -- and are of length n
      reqR                : in BooleanArray(nreqs-1 downto 0);
      ackR                : out  BooleanArray(nreqs-1 downto 0);
      -- dataR is array(n,m) 
      dataR               : out std_logic_vector(owidth-1 downto 0);
      clk, reset          : in std_logic);
  end component OutputDeMuxBase;

  component OutputDeMuxBaseNoData
    generic(twidth: integer;
            nreqs: integer;
            no_arbitration: Boolean);
    port (
      -- req/ack follow level protocol
      reqL                 : in  std_logic;
      ackL                 : out std_logic;
      -- tag identifies index to which demux
      -- should happen
      tagL                 : in std_logic_vector(twidth-1 downto 0);
      -- reqR/ackR follow pulse protocol
      -- and are of length n
      reqR                : in BooleanArray(nreqs-1 downto 0);
      ackR                : out  BooleanArray(nreqs-1 downto 0);
      clk, reset          : in std_logic);
  end component OutputDeMuxBaseNoData;


  -----------------------------------------------------------------------------
  -- call arbiters
  -- there are four forms for the four possibilities of the
  -- called function (in-args+out-args, in-args, out-args, no args)
  -----------------------------------------------------------------------------
  component CallArbiter
    generic(num_reqs: integer;
            call_data_width: integer;
            return_data_width: integer;
            tag_length: integer);
    port ( -- ready/ready handshake on all ports
      -- ports for the caller
      call_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
      call_acks   : out std_logic_vector(num_reqs-1 downto 0);
      call_data   : in  std_logic_vector((num_reqs*call_data_width)-1 downto 0);
      -- call port connected to the called module
      call_mreq   : out std_logic;
      call_mack   : in  std_logic;
      call_mdata  : out std_logic_vector(call_data_width-1 downto 0);
      call_mtag   : out std_logic_vector(tag_length-1 downto 0);
      -- similarly for return, initiated by the caller
      return_reqs : in  std_logic_vector(num_reqs-1 downto 0);
      return_acks : out std_logic_vector(num_reqs-1 downto 0);
      return_data : out std_logic_vector((num_reqs*return_data_width)-1 downto 0);
      -- return from function
      -- function to assert mreq arbiter to return mack
      -- ( NOTE: It has to be this way, the arbiter should
      -- accept the return value if it has room)
      return_mreq : in std_logic;
      return_mack : out std_logic;
      return_mdata : in  std_logic_vector(return_data_width-1 downto 0);
      return_mtag : in  std_logic_vector(tag_length-1 downto 0);
      clk: in std_logic;
      reset: in std_logic);
  end component CallArbiter;

  component CallArbiterNoInargs
    generic(num_reqs: integer;
            return_data_width: integer;
            tag_length: integer);
    port ( -- ready/ready handshake on all ports
      -- ports for the caller
      call_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
      call_acks   : out std_logic_vector(num_reqs-1 downto 0);
      -- call port connected to the called module
      call_mreq   : out std_logic;
      call_mack   : in  std_logic;
      call_mtag   : out std_logic_vector(tag_length-1 downto 0);
      -- similarly for return, initiated by the caller
      return_reqs : in  std_logic_vector(num_reqs-1 downto 0);
      return_acks : out std_logic_vector(num_reqs-1 downto 0);
      return_data : out std_logic_vector((num_reqs*return_data_width)-1 downto 0);
      -- return from function
      -- function to assert mreq arbiter to return mack
      -- ( NOTE: It has to be this way, the arbiter should
      -- accept the return value if it has room)
      return_mreq : in std_logic;
      return_mack : out std_logic;
      return_mdata : in  std_logic_vector(return_data_width-1 downto 0);
      return_mtag : in  std_logic_vector(tag_length-1 downto 0);
      clk: in std_logic;
      reset: in std_logic);
  end component CallArbiterNoInargs;

  component CallArbiterNoOutargs
    generic(num_reqs: integer;
            call_data_width: integer;
            tag_length: integer);
    port ( -- ready/ready handshake on all ports
      -- ports for the caller
      call_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
      call_acks   : out std_logic_vector(num_reqs-1 downto 0);
      call_data   : in  std_logic_vector((num_reqs*call_data_width)-1 downto 0);
      -- call port connected to the called module
      call_mreq   : out std_logic;
      call_mack   : in  std_logic;
      call_mdata  : out std_logic_vector(call_data_width-1 downto 0);
      call_mtag   : out std_logic_vector(tag_length-1 downto 0);
      -- similarly for return, initiated by the caller
      return_reqs : in  std_logic_vector(num_reqs-1 downto 0);
      return_acks : out std_logic_vector(num_reqs-1 downto 0);
      -- return from function
      -- function to assert mreq arbiter to return mack
      -- ( NOTE: It has to be this way, the arbiter should
      -- accept the return value if it has room)
      return_mreq : in std_logic;
      return_mack : out std_logic;
      return_mtag : in  std_logic_vector(tag_length-1 downto 0);
      clk: in std_logic;
      reset: in std_logic);
  end component CallArbiterNoOutargs;



  component CallArbiterNoInargsNoOutargs
    generic(num_reqs: integer;
            tag_length: integer);
    port ( -- ready/ready handshake on all ports
      -- ports for the caller
      call_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
      call_acks   : out std_logic_vector(num_reqs-1 downto 0);
      -- call port connected to the called module
      call_mreq   : out std_logic;
      call_mack   : in  std_logic;
      call_mtag   : out std_logic_vector(tag_length-1 downto 0);
      -- similarly for return, initiated by the caller
      return_reqs : in  std_logic_vector(num_reqs-1 downto 0);
      return_acks : out std_logic_vector(num_reqs-1 downto 0);
      -- return from function
      -- function to assert mreq arbiter to return mack
      -- ( NOTE: It has to be this way, the arbiter should
      -- accept the return value if it has room)
      return_mreq : in std_logic;
      return_mack : out std_logic;
      return_mtag : in  std_logic_vector(tag_length-1 downto 0);
      clk: in std_logic;
      reset: in std_logic);
  end component CallArbiterNoInargsNoOutargs;


  component CallArbiterUnitary
    generic(num_reqs: integer;
            call_data_width: integer;
            return_data_width: integer;
            caller_tag_length: integer;
            callee_tag_length: integer);
    port ( -- ready/ready handshake on all ports
      -- ports for the caller
      call_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
      call_acks   : out std_logic_vector(num_reqs-1 downto 0);
      call_data   : in  std_logic_vector((num_reqs*call_data_width)-1 downto 0);
      call_tag    : in  std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
      -- similarly for return, initiated by the caller
      return_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
      return_acks   : out std_logic_vector(num_reqs-1 downto 0);
      return_data   : out std_logic_vector((num_reqs*return_data_width)-1 downto 0);
      return_tag    : out  std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
      -- ports connected to the called module
      call_start   : out std_logic;
      call_fin   : in  std_logic;
      call_in_args  : out std_logic_vector(call_data_width-1 downto 0);
      call_in_tag   : out std_logic_vector(callee_tag_length-1 downto 0);
      -- from the called module
      call_out_args : in  std_logic_vector(return_data_width-1 downto 0);
      call_out_tag : in  std_logic_vector(callee_tag_length-1 downto 0);
      clk: in std_logic;
      reset: in std_logic);
  end component CallArbiterUnitary;


  component CallArbiterUnitaryNoInargs
    generic(num_reqs: integer;
            return_data_width: integer;
            caller_tag_length: integer;
            callee_tag_length: integer);
    port ( -- ready/ready handshake on all ports
      -- ports for the caller
      call_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
      call_acks   : out std_logic_vector(num_reqs-1 downto 0);
      call_tag    : in  std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
      -- similarly for return, initiated by the caller
      return_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
      return_acks   : out std_logic_vector(num_reqs-1 downto 0);
      return_data   : out std_logic_vector((num_reqs*return_data_width)-1 downto 0);
      return_tag    : out  std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
      -- ports connected to the called module
      call_start   : out std_logic;
      call_fin   : in  std_logic;
      call_in_tag   : out std_logic_vector(callee_tag_length-1 downto 0);
      -- from the called module
      call_out_args : in  std_logic_vector(return_data_width-1 downto 0);
      call_out_tag : in  std_logic_vector(callee_tag_length-1 downto 0);
      clk: in std_logic;
      reset: in std_logic);
  end component CallArbiterUnitaryNoInargs;

  component CallArbiterUnitaryNoOutargs
    generic(num_reqs: integer;
            call_data_width: integer;
            caller_tag_length: integer;
            callee_tag_length: integer);
    port ( -- ready/ready handshake on all ports
      -- ports for the caller
      call_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
      call_acks   : out std_logic_vector(num_reqs-1 downto 0);
      call_data   : in  std_logic_vector((num_reqs*call_data_width)-1 downto 0);
      call_tag    : in  std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
      -- similarly for return, initiated by the caller
      return_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
      return_acks   : out std_logic_vector(num_reqs-1 downto 0);
      return_tag    : out  std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
      -- ports connected to the called module
      call_start   : out std_logic;
      call_fin   : in  std_logic;
      call_in_args  : out std_logic_vector(call_data_width-1 downto 0);
      call_in_tag   : out std_logic_vector(callee_tag_length-1 downto 0);
      -- from the called module
      call_out_tag : in  std_logic_vector(callee_tag_length-1 downto 0);
      clk: in std_logic;
      reset: in std_logic);
  end component CallArbiterUnitaryNoOutargs;


  component CallArbiterUnitaryNoInargsNoOutargs
    generic(num_reqs: integer;
            caller_tag_length: integer;
            callee_tag_length: integer);
    port ( -- ready/ready handshake on all ports
      -- ports for the caller
      call_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
      call_acks   : out std_logic_vector(num_reqs-1 downto 0);
      call_tag    : in  std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
      -- similarly for return, initiated by the caller
      return_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
      return_acks   : out std_logic_vector(num_reqs-1 downto 0);
      return_tag    : out  std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
      -- ports connected to the called module
      call_start   : out std_logic;
      call_fin   : in  std_logic;
      call_in_tag   : out std_logic_vector(callee_tag_length-1 downto 0);
      -- from the called module
      call_out_tag : in  std_logic_vector(callee_tag_length-1 downto 0);
      clk: in std_logic;
      reset: in std_logic);
  end component CallArbiterUnitaryNoInargsNoOutargs;

  component CallMediator
    port (
      call_req: in std_logic;
      call_ack: out std_logic;
      enable_call_data: out std_logic;
      return_req: in std_logic;
      return_ack: out std_logic;
      enable_return_data: out std_logic;
      start: out std_logic;
      fin: in std_logic;
      clk: in std_logic;
      reset: in std_logic);
  end component CallMediator;

  -----------------------------------------------------------------------------
  -- split call arbiters..
  --   Modules will now have a split request-complete handshake
  --   (just like operators)
  -----------------------------------------------------------------------------
  component SplitCallArbiter
    generic(num_reqs: integer;
	  call_data_width: integer;
	  return_data_width: integer;
	  caller_tag_length: integer;
          callee_tag_length: integer);
    port ( -- ready/ready handshake on all ports
      -- ports for the caller
      call_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
      call_acks   : out std_logic_vector(num_reqs-1 downto 0);
      call_data   : in  std_logic_vector((num_reqs*call_data_width)-1 downto 0);
      call_tag    : in  std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
      -- call port connected to the called module
      call_mreq   : out std_logic;
      call_mack   : in  std_logic;
      call_mdata  : out std_logic_vector(call_data_width-1 downto 0);
      call_mtag   : out std_logic_vector(callee_tag_length-1 downto 0);
      -- similarly for return, initiated by the caller
      return_reqs : in  std_logic_vector(num_reqs-1 downto 0);
      return_acks : out std_logic_vector(num_reqs-1 downto 0);
      return_data : out std_logic_vector((num_reqs*return_data_width)-1 downto 0);
      return_tag  : out std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
      -- return from function
      return_mreq : out std_logic;
      return_mack : in std_logic;
      return_mdata : in  std_logic_vector(return_data_width-1 downto 0);
      return_mtag : in  std_logic_vector(callee_tag_length-1 downto 0);
      clk: in std_logic;
      reset: in std_logic);
  end component SplitCallArbiter;

  component SplitCallArbiterNoInargs
  generic(num_reqs: integer;
	  return_data_width: integer;
	  caller_tag_length: integer;
          callee_tag_length: integer);
  port ( -- ready/ready handshake on all ports
    -- ports for the caller
    call_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
    call_acks   : out std_logic_vector(num_reqs-1 downto 0);
    call_tag    : in  std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
    -- call port connected to the called module
    call_mreq   : out std_logic;
    call_mack   : in  std_logic;
    call_mtag   : out std_logic_vector(callee_tag_length-1 downto 0);
    -- similarly for return, initiated by the caller
    return_reqs : in  std_logic_vector(num_reqs-1 downto 0);
    return_acks : out std_logic_vector(num_reqs-1 downto 0);
    return_data : out std_logic_vector((num_reqs*return_data_width)-1 downto 0);
    return_tag  : out std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
    -- return from function
    return_mreq : out std_logic;
    return_mack : in std_logic;
    return_mdata : in  std_logic_vector(return_data_width-1 downto 0);
    return_mtag : in  std_logic_vector(callee_tag_length-1 downto 0);
    clk: in std_logic;
    reset: in std_logic);
  end component SplitCallArbiterNoInargs;

  component SplitCallArbiterNoOutargs
    generic(num_reqs: integer;
	  call_data_width: integer;
	  caller_tag_length: integer;
          callee_tag_length: integer);
  port ( -- ready/ready handshake on all ports
    -- ports for the caller
    call_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
    call_acks   : out std_logic_vector(num_reqs-1 downto 0);
    call_data   : in  std_logic_vector((num_reqs*call_data_width)-1 downto 0);
    call_tag    : in  std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
    -- call port connected to the called module
    call_mreq   : out std_logic;
    call_mack   : in  std_logic;
    call_mdata  : out std_logic_vector(call_data_width-1 downto 0);
    call_mtag   : out std_logic_vector(callee_tag_length-1 downto 0);
    -- similarly for return, initiated by the caller
    return_reqs : in  std_logic_vector(num_reqs-1 downto 0);
    return_acks : out std_logic_vector(num_reqs-1 downto 0);
    return_tag  : out std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
    -- return from function
    return_mreq : out std_logic;
    return_mack : in std_logic;
    return_mtag : in  std_logic_vector(callee_tag_length-1 downto 0);
    clk: in std_logic;
    reset: in std_logic);
  end component SplitCallArbiterNoOutargs;



  component SplitCallArbiterNoInargsNoOutargs
    generic(num_reqs: integer;
            caller_tag_length: integer;
            callee_tag_length: integer);
  port ( -- ready/ready handshake on all ports
    -- ports for the caller
    call_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
    call_acks   : out std_logic_vector(num_reqs-1 downto 0);
    call_tag    : in  std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
    -- call port connected to the called module
    call_mreq   : out std_logic;
    call_mack   : in  std_logic;
    call_mtag   : out std_logic_vector(callee_tag_length-1 downto 0);
    -- similarly for return, initiated by the caller
    return_reqs : in  std_logic_vector(num_reqs-1 downto 0);
    return_acks : out std_logic_vector(num_reqs-1 downto 0);
    return_tag  : out std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
    -- return from function
    return_mreq : out std_logic;
    return_mack : in std_logic;
    return_mtag : in  std_logic_vector(callee_tag_length-1 downto 0);
    clk: in std_logic;
    reset: in std_logic);
  end component SplitCallArbiterNoInargsNoOutargs;


  -----------------------------------------------------------------------------
  -- IO ports
  -----------------------------------------------------------------------------
  component InputPort
    generic (num_reqs: integer;
             data_width: integer;
             no_arbitration: boolean);
    port (
      -- pulse interface with the data-path
      req        : in  BooleanArray(num_reqs-1 downto 0);
      ack        : out BooleanArray(num_reqs-1 downto 0);
      data       : out std_logic_vector((num_reqs*data_width)-1 downto 0);
      -- ready/ready interface with outside world
      oreq       : out std_logic;
      oack       : in  std_logic;
      odata      : in  std_logic_vector(data_width-1 downto 0);
      clk, reset : in  std_logic);
  end component;

  component InputPortNoData
    generic (num_reqs: integer;
             no_arbitration: boolean);
    port (
      -- pulse interface with the data-path
      req        : in  BooleanArray(num_reqs-1 downto 0);
      ack        : out BooleanArray(num_reqs-1 downto 0);
      -- ready/ready interface with outside world
      oreq       : out std_logic;
      oack       : in  std_logic;
      clk, reset : in  std_logic);
  end component;


  component InputPortLevel
    generic (num_reqs: integer; 
             data_width: integer;  
             no_arbitration: boolean);
    port (
      -- ready/ready interface with the requesters
      req       : in  std_logic_vector(num_reqs-1 downto 0);
      ack       : out std_logic_vector(num_reqs-1 downto 0);
      data      : out std_logic_vector((num_reqs*data_width)-1 downto 0);
      -- ready/ready interface with outside world
      oreq       : out std_logic;
      oack       : in  std_logic;
      odata      : in  std_logic_vector(data_width-1 downto 0);
      clk, reset : in  std_logic);
  end component InputPortLevel;


  component InputPortLevelNoData 
    generic (num_reqs: integer; 
             no_arbitration: boolean);
    port (
      -- ready/ready interface with the requesters
      req       : in  std_logic_vector(num_reqs-1 downto 0);
      ack       : out std_logic_vector(num_reqs-1 downto 0);
      -- ready/ready interface with outside world
      oreq       : out std_logic;
      oack       : in  std_logic;
      clk, reset : in  std_logic);
  end component;


  component OutputPort
    generic(num_reqs: integer;
            data_width: integer;
            no_arbitration: boolean);
    port (
      req        : in  BooleanArray(num_reqs-1 downto 0);
      ack        : out BooleanArray(num_reqs-1 downto 0);
      data       : in  std_logic_vector((num_reqs*data_width)-1 downto 0);
      oreq       : out std_logic;
      oack       : in  std_logic;
      odata      : out std_logic_vector(data_width-1 downto 0);
      clk, reset : in  std_logic);
  end component;


  component OutputPortNoData
    generic(num_reqs: integer;
            no_arbitration: boolean);
    port (
      req        : in  BooleanArray(num_reqs-1 downto 0);
      ack        : out BooleanArray(num_reqs-1 downto 0);
      oreq       : out std_logic;
      oack       : in  std_logic;
      clk, reset : in  std_logic);
  end component;
  
  component OutputPortLevel
    generic(num_reqs: integer;
            data_width: integer;
            no_arbitration: boolean);
    port (
      req       : in  std_logic_vector(num_reqs-1 downto 0);
      ack       : out std_logic_vector(num_reqs-1 downto 0);
      data      : in  std_logic_vector((num_reqs*data_width)-1 downto 0);
      oreq       : out std_logic;
      oack       : in  std_logic;
      odata      : out std_logic_vector(data_width-1 downto 0);
      clk, reset : in  std_logic);
  end component;

  component OutputPortLevelNoData 
    generic(num_reqs: integer;
            no_arbitration: boolean);
    port (
      req       : in  std_logic_vector(num_reqs-1 downto 0);
      ack       : out std_logic_vector(num_reqs-1 downto 0);
      oreq       : out std_logic;
      oack       : in  std_logic;
      clk, reset : in  std_logic);
  end component;

  -----------------------------------------------------------------------------
  -- load/store
  -----------------------------------------------------------------------------
  component LoadReqShared
    generic
      (
	addr_width: integer;
      	num_reqs : integer; -- how many requesters?
	tag_length: integer;
	no_arbitration: Boolean;
        min_clock_period: Boolean
        );
    port (
      -- req/ack follow pulse protocol
      reqL                     : in BooleanArray(num_reqs-1 downto 0);
      ackL                     : out BooleanArray(num_reqs-1 downto 0);
      -- concatenated address corresponding to access
      dataL                    : in std_logic_vector((addr_width*num_reqs)-1 downto 0);
      -- address to memory
      maddr                   : out std_logic_vector(addr_width-1 downto 0);
      mtag                    : out std_logic_vector(tag_length-1 downto 0);
      mreq                    : out std_logic;
      mack                    : in std_logic;
      -- clock, reset (active high)
      clk, reset              : in std_logic);
  end component LoadReqShared;

  component StoreReqShared
    generic
      (
	addr_width: integer;
	data_width : integer;
      	num_reqs : integer; -- how many requesters?
	tag_length: integer;
        min_clock_period : boolean;
	no_arbitration: Boolean
        );
    port (
      -- req/ack follow pulse protocol
      reqL                     : in BooleanArray(num_reqs-1 downto 0);
      ackL                     : out BooleanArray(num_reqs-1 downto 0);
      -- address corresponding to access
      addr                    : in std_logic_vector((addr_width*num_reqs)-1 downto 0);
      data                    : in std_logic_vector((data_width*num_reqs)-1 downto 0);
      -- address to memory
      maddr                   : out std_logic_vector(addr_width-1 downto 0);
      mdata                   : out std_logic_vector(data_width-1 downto 0);
      mtag                    : out std_logic_vector(tag_length-1 downto 0);
      mreq                    : out std_logic;
      mack                    : in std_logic;
      -- clock, reset (active high)
      clk, reset              : in std_logic);
  end component StoreReqShared;


  component LoadCompleteShared
    generic
      (
        data_width: integer;
        tag_length:  integer;
        num_reqs : integer;
        no_arbitration: boolean
        );
    port (
      -- req/ack follow level protocol
      reqR                     : in BooleanArray(num_reqs-1 downto 0);
      ackR                     : out BooleanArray(num_reqs-1 downto 0);
      dataR                    : out std_logic_vector((data_width*num_reqs)-1 downto 0);
      -- output data consists of concatenated pairs of ops.
      mdata                    : in std_logic_vector(data_width-1 downto 0);
      mreq                     : out std_logic;
      mack                     : in  std_logic;
      mtag                     : in std_logic_vector(tag_length-1 downto 0);
      -- with dataR
      clk, reset              : in std_logic);
  end component LoadCompleteShared;

  component StoreCompleteShared
    generic (num_reqs: integer;
             tag_length: integer);
    port (
      -- in requester array, pulse protocol
      -- more than one requester can be active
      -- at any time
      reqR : in BooleanArray(num_reqs-1 downto 0);
      -- out ack array, pulse protocol
      -- more than one ack can be sent back
      -- at any time.
      --
      -- Note: req -> ack delay can be 0
      ackR : out BooleanArray(num_reqs-1 downto 0);
      -- mreq goes out to memory as 
      -- a response to mack.
      mreq : out std_logic;
      mack : in  std_logic;
      -- mtag to distinguish the 
      -- requesters.
      mtag : in std_logic_vector(tag_length-1 downto 0);
      -- rising edge of clock is used
      clk : in std_logic;
      -- synchronous reset, active high
      reset : in std_logic);
  end component StoreCompleteShared;


  -----------------------------------------------------------------------------
  -- protocol translation, priority encoding
  -----------------------------------------------------------------------------
  component Pulse_To_Level_Translate_Entity 
    port( rL : in boolean;
          rR : out std_logic;
          aL : out boolean;
          aR : in std_logic;
          clk : in std_logic;
          reset : in std_logic);
  end component;

  component Request_Priority_Encode_Entity
    generic (num_reqs : integer := 1);
    port (
      clk,reset : in std_logic;
      reqR : in std_logic_vector;
      ackR: out std_logic_vector;
      forward_enable: out std_logic_vector;
      req_s : out std_logic;
      ack_s : in std_logic);
  end component;


  -----------------------------------------------------------------------------
  -- BinaryEncoder: introduced because Xilinx ISE 13.1 barfs on To_Unsigned
  -----------------------------------------------------------------------------
  component BinaryEncoder
    generic (iwidth: integer := 3; owidth: integer := 3);
    port(din: in std_logic_vector(iwidth-1 downto 0);
         dout: out std_logic_vector(owidth-1 downto 0));
  end component;

end BaseComponents;
-- all component declarations necessary for the
-- vhdl generator
library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;

package Components is
end Components;
library ieee;	
use ieee.std_logic_1164.all;	
use ieee.numeric_std.all;	
	
library ahir;	
use ahir.Types.all;	
use ahir.Subprograms.all;	
use ahir.Utilities.all;
	
library ieee_proposed;	
use ieee_proposed.math_utility_pkg.all;	
use ieee_proposed.fixed_pkg.all;	
use ieee_proposed.float_pkg.all;	

package FloatOperatorPackage is
  
  procedure ApFloatResize_proc(l: in apfloat; result : out IStdLogicVector);
  procedure ApFloatAdd_proc(l: in apfloat; r : in apfloat; result : out IStdLogicVector);
  procedure ApFloatSub_proc(l: in apfloat; r : in apfloat; result : out IStdLogicVector);
  procedure ApFloatMul_proc(l: in apfloat; r : in apfloat; result : out IStdLogicVector);
  procedure ApFloatOeq_proc(l: in apfloat; r : in apfloat; result : out IStdLogicVector);
  procedure ApFloatOne_proc(l: in apfloat; r : in apfloat; result : out IStdLogicVector);
  procedure ApFloatOgt_proc(l: in apfloat; r : in apfloat; result : out IStdLogicVector);
  procedure ApFloatOge_proc(l: in apfloat; r : in apfloat; result : out IStdLogicVector);
  procedure ApFloatOlt_proc(l: in apfloat; r : in apfloat; result : out IStdLogicVector);
  procedure ApFloatOle_proc(l: in apfloat; r : in apfloat; result : out IStdLogicVector);
  procedure ApFloatOrd_proc(l: in apfloat; r : in apfloat; result : out IStdLogicVector);
  procedure ApFloatUno_proc(l: in apfloat; r : in apfloat; result : out IStdLogicVector);
  procedure ApFloatUeq_proc(l: in apfloat; r : in apfloat; result : out IStdLogicVector);
  procedure ApFloatUne_proc(l: in apfloat; r : in apfloat; result : out IStdLogicVector);
  procedure ApFloatUgt_proc(l: in apfloat; r : in apfloat; result : out IStdLogicVector);
  procedure ApFloatUge_proc(l: in apfloat; r : in apfloat; result : out IStdLogicVector);
  procedure ApFloatUlt_proc(l: in apfloat; r : in apfloat; result : out IStdLogicVector);
  procedure ApFloatUle_proc(l: in apfloat; r : in apfloat; result : out IStdLogicVector);
  procedure ApFloatToApIntSigned_proc(l: in apfloat; result : out IStdLogicVector);
  procedure ApFloatToApIntUnsigned_proc(l: in apfloat; result : out IStdLogicVector);
  procedure ApIntToApFloatSigned_proc(l: in apint; result : out IStdLogicVector);
  procedure ApIntToApFloatUnsigned_proc(l: in apint; result : out IStdLogicVector);

  -- TODO
  -- procedures ApFloatToApIntSigned_Proc, ApFloatToApIntUnsigned_Proc,
  --            ApIntSignedToApFloat_Proc, ApIntUnsignedToApFloat_Proc

  procedure TwoInputFloatOperation(constant id    : in string; x, y : in IStdLogicVector; result : out IStdLogicVector);
  procedure SingleInputFloatOperation(constant id : in string; x : in IStdLogicVector; result : out IStdLogicVector);

end package FloatOperatorPackage;

package body FloatOperatorPackage is

  -----------------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApFloatResize_proc (l : in apfloat; result : out IStdLogicVector) is					
  begin
     result := To_ISLV(to_apfloat(RESIZE(to_float(l), result'high, -result'low)));
  end ApFloatResize_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApFloatAdd_proc (l : in apfloat; r : in apfloat; result : out IStdLogicVector) is					
  begin
    assert (l'length = r'length) and (l'length = result'length)						     
      report "Length Mismatch inApFloatAdd_proc" severity error;
     result := To_ISLV(to_apfloat(to_float(l) + to_float(r)));  
  end ApFloatAdd_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApFloatSub_proc (l : in apfloat; r : in apfloat; result : out IStdLogicVector) is					
  begin
    assert (l'length = r'length) and (l'length = result'length)						     
      report "Length Mismatch inApFloatSub_proc" severity error;
     result := To_ISLV(to_apfloat(to_float(l) - to_float(r)));  
  end ApFloatSub_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApFloatMul_proc (l : in apfloat; r : in apfloat; result : out IStdLogicVector) is
    variable float_result  : float(l'left downto l'right);
  begin
    assert (l'length = r'length) and (l'length = result'length)						     
      report "Length Mismatch inApFloatMul_proc" severity error;
    float_result := to_float(l) * to_float(r);  
    result := To_ISLV(float_result);  
  end ApFloatMul_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApFloatOeq_proc (l : in apfloat; r : in apfloat; result : out IStdLogicVector) is					
  begin
     result := To_ISLV(to_apint(to_float(l) = to_float(r)));  
  end ApFloatOeq_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApFloatOne_proc (l : in apfloat; r : in apfloat; result : out IStdLogicVector) is					
  begin
     result := To_ISLV(to_apint(to_float(l) /= to_float(r)));  
  end ApFloatOne_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApFloatOgt_proc (l : in apfloat; r : in apfloat; result : out IStdLogicVector) is					
  begin
     result := To_ISLV(to_apint(to_float(l) > to_float(r)));  
  end ApFloatOgt_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApFloatOge_proc (l : in apfloat; r : in apfloat; result : out IStdLogicVector) is					
  begin
     result := To_ISLV(to_apint(to_float(l) >= to_float(r)));  
  end ApFloatOge_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApFloatOlt_proc (l : in apfloat; r : in apfloat; result : out IStdLogicVector) is					
  begin
     result := To_ISLV(to_apint(to_float(l) < to_float(r)));  
  end ApFloatOlt_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApFloatOle_proc (l : in apfloat; r : in apfloat; result : out IStdLogicVector) is					
  begin
     result := To_ISLV(to_apint(to_float(l) <= to_float(r))); 
  end ApFloatOle_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApFloatOrd_proc (l : in apfloat; r : in apfloat; result : out IStdLogicVector) is					
  begin
     result := To_ISLV(to_apint(not(Unordered (x => to_float(l),y => to_float(r))))); 
  end ApFloatOrd_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApFloatUno_proc (l : in apfloat; r : in apfloat; result : out IStdLogicVector) is					
  begin
     result := To_ISLV(to_apint( Unordered (x => to_float(l),y => to_float(r)))); 
  end ApFloatUno_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApFloatUeq_proc (l : in apfloat; r : in apfloat; result : out IStdLogicVector) is					
  begin
     result := To_ISLV(to_apint(eq(l => to_float(l), r => to_float(r), check_error => false) or Unordered (x => to_float(l),y => to_float(r)))); 
  end ApFloatUeq_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApFloatUne_proc (l : in apfloat; r : in apfloat; result : out IStdLogicVector) is					
  begin
     result :=  To_ISLV(to_apint(ne(l => to_float(l), r => to_float(r), check_error => false) or Unordered (x => to_float(l),y => to_float(r))));
  end ApFloatUne_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApFloatUgt_proc (l : in apfloat; r : in apfloat; result : out IStdLogicVector) is					
  begin
     result :=  To_ISLV(to_apint(gt(l => to_float(l), r => to_float(r), check_error => false) or Unordered (x => to_float(l),y => to_float(r))));
  end ApFloatUgt_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApFloatUge_proc (l : in apfloat; r : in apfloat; result : out IStdLogicVector) is					
  begin
     result :=  To_ISLV(to_apint(ge(l => to_float(l), r => to_float(r), check_error => false) or Unordered (x => to_float(l),y => to_float(r))));  
  end ApFloatUge_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApFloatUlt_proc (l : in apfloat; r : in apfloat; result : out IStdLogicVector) is					
  begin
     result :=  To_ISLV(to_apint(lt(l => to_float(l), r => to_float(r), check_error => false) or Unordered (x => to_float(l),y => to_float(r)))); 
  end ApFloatUlt_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApFloatUle_proc (l : in apfloat; r : in apfloat; result : out IStdLogicVector) is					
  begin
     result :=  To_ISLV(to_apint(le(l => to_float(l), r => to_float(r), check_error => false) or Unordered (x => to_float(l),y => to_float(r))));  
  end ApFloatUle_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApFloatToApIntSigned_proc (l : in apfloat; result : out IStdLogicVector) is					
  begin
     result := To_ISLV(to_apint(to_signed(to_float(l),result'length)));
  end ApFloatToApIntSigned_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApFloatToApIntUnsigned_proc (l : in apfloat; result : out IStdLogicVector) is					
  begin
     result := To_ISLV(to_apint(to_unsigned(to_float(l),result'length)));
  end ApFloatToApIntUnsigned_proc; 				

 ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntToApFloatSigned_proc (l : in apint; result : out IStdLogicVector) is
  begin
   result := To_ISLV(to_apfloat(to_float(to_signed(l),result'high,-result'low,round_zero)));
  end ApIntToApFloatSigned_proc;
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntToApFloatUnsigned_proc (l : in apint; result : out IStdLogicVector) is
  begin
   result := To_ISLV(to_apfloat(to_float(to_unsigned(l),result'high,-result'low,round_zero)));
  end ApIntToApFloatUnsigned_proc;
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------	
  procedure TwoInputFloatOperation(constant id : in string; x, y : in IStdLogicVector; result : out IStdLogicVector) is	
    variable result_var : IStdLogicVector(result'high downto result'low);	
    variable temp_int: integer;
  begin
    if id = "ApFloatAdd" then					
      ApFloatAdd_proc(To_apfloat(x), To_apfloat(y), result_var);
    elsif id = "ApFloatSub" then					
      ApFloatSub_proc(To_apfloat(x), To_apfloat(y), result_var);
    elsif id = "ApFloatMul" then					
      ApFloatMul_proc(To_apfloat(x), To_apfloat(y), result_var);
    elsif id = "ApFloatOeq" then					
      ApFloatOeq_proc(To_apfloat(x), To_apfloat(y), result_var);
    elsif id = "ApFloatOne" then					
      ApFloatOne_proc(To_apfloat(x), To_apfloat(y), result_var);
    elsif id = "ApFloatOgt" then					
      ApFloatOgt_proc(To_apfloat(x), To_apfloat(y), result_var);
    elsif id = "ApFloatOge" then					
      ApFloatOge_proc(To_apfloat(x), To_apfloat(y), result_var);
    elsif id = "ApFloatOlt" then					
      ApFloatOlt_proc(To_apfloat(x), To_apfloat(y), result_var);
    elsif id = "ApFloatOle" then					
      ApFloatOle_proc(To_apfloat(x), To_apfloat(y), result_var);
    elsif id = "ApFloatOrd" then					
      ApFloatOrd_proc(To_apfloat(x), To_apfloat(y), result_var);
    elsif id = "ApFloatUno" then					
      ApFloatUno_proc(To_apfloat(x), To_apfloat(y), result_var);
    elsif id = "ApFloatUeq" then					
      ApFloatUeq_proc(To_apfloat(x), To_apfloat(y), result_var);
    elsif id = "ApFloatUne" then					
      ApFloatUne_proc(To_apfloat(x), To_apfloat(y), result_var);
    elsif id = "ApFloatUgt" then					
      ApFloatUgt_proc(To_apfloat(x), To_apfloat(y), result_var);
    elsif id = "ApFloatUge" then					
      ApFloatUge_proc(To_apfloat(x), To_apfloat(y), result_var);
    elsif id = "ApFloatUlt" then					
      ApFloatUlt_proc(To_apfloat(x), To_apfloat(y), result_var);
    elsif id = "ApFloatUle" then					
      ApFloatUle_proc(To_apfloat(x), To_apfloat(y), result_var);
    else	
      assert false report "Unsupported float operator-id " & id severity failure;	
    end if;	
    result := result_var;	
  end TwoInputFloatOperation;			
  -----------------------------------------------------------------------------
	
  -----------------------------------------------------------------------------	
  procedure SingleInputFloatOperation(constant id : in string; x : in IStdLogicVector; result : out IStdLogicVector) is	
    variable result_var : IStdLogicVector(result'high downto result'low);	
  begin
    if id = "ApFloatResize" then					
      ApFloatResize_proc(To_apfloat(x), result_var);
    elsif id = "ApFloatToApIntSigned" then					
      ApFloatToApIntSigned_proc(To_apfloat(x), result_var);
    elsif id = "ApFloatToApIntUnsigned" then					
      ApFloatToApIntUnsigned_proc(To_apfloat(x), result_var);
    elsif id = "ApIntToApFloatSigned" then					
      ApIntToApFloatSigned_proc(To_apint(x), result_var);
    elsif id = "ApIntToApFloatUnsigned" then					
      ApIntToApFloatUnsigned_proc(To_apint(x), result_var);
    else	
      assert false report "Unsupported operator-id " & id severity failure;	
    end if;	
    result := result_var;	
  end SingleInputFloatOperation;	
	
	
end package body FloatOperatorPackage;	
library ieee;	
use ieee.std_logic_1164.all;	
use ieee.numeric_std.all;	
	
library ahir;	
use ahir.Types.all;	
use ahir.Subprograms.all;	
use ahir.Utilities.all;
	
package OperatorPackage is

  procedure ApIntNot_proc(l: in std_logic_vector; result : out std_logic_vector);
  procedure ApIntToApIntSigned_proc(l: in std_logic_vector; result : out std_logic_vector);
  procedure ApIntToApIntUnsigned_proc(l: in std_logic_vector; result : out std_logic_vector);
  procedure ApIntAdd_proc(l: in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector);
  procedure ApIntSub_proc(l: in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector);
  procedure ApIntAnd_proc(l: in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector);
  procedure ApIntOr_proc(l: in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector);
  procedure ApIntXor_proc(l: in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector);
  procedure ApIntMul_proc(l: in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector);
  procedure ApIntSHL_proc(l: in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector);
  procedure ApIntLSHR_proc(l: in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector);
  procedure ApIntASHR_proc(l: in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector);
  procedure ApIntEq_proc(l: in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector);
  procedure ApIntNe_proc(l: in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector);
  procedure ApIntUgt_proc(l: in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector);
  procedure ApIntUge_proc(l: in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector);
  procedure ApIntUlt_proc(l: in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector);
  procedure ApIntUle_proc(l: in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector);
  procedure ApIntSgt_proc(l: in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector);
  procedure ApIntSge_proc(l: in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector);
  procedure ApIntSlt_proc(l: in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector);
  procedure ApIntSle_proc(l: in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector);

  -- TODO
  -- procedures ApFloatToApIntSigned_Proc, ApFloatToApIntUnsigned_Proc,
  --            ApIntSignedToApFloat_Proc, ApIntUnsignedToApFloat_Proc

  procedure TwoInputOperation(constant id    : in string; x, y : in std_logic_vector; result : out std_logic_vector);
  procedure SingleInputOperation(constant id : in string; x : in std_logic_vector; result : out std_logic_vector);

end package OperatorPackage;

package body OperatorPackage is

  -----------------------------------------------------------------------------
  procedure ApIntNot_proc (l : in std_logic_vector; result : out std_logic_vector) is					
  begin
    assert (l'length = result'length)						     
      report "Length Mismatch inApIntNot_proc" severity error;
    result := To_SLV(not to_signed(l));
  end ApIntNot_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntToApIntSigned_proc (l : in std_logic_vector; result : out std_logic_vector) is					
  begin
     result := To_SLV(RESIZE(to_signed(l), result'length));
  end ApIntToApIntSigned_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntToApIntUnsigned_proc (l : in std_logic_vector; result : out std_logic_vector) is					
  begin
    result := To_SLV(RESIZE(to_unsigned(l), result'length));
  end ApIntToApIntUnsigned_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntAdd_proc (l : in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector) is					
  begin
    assert (l'length = r'length) and (l'length = result'length)						     
      report "Length Mismatch inApIntAdd_proc" severity error;
    result := To_SLV(to_signed(l)  + to_signed(r));
  end ApIntAdd_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntSub_proc (l : in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector) is					
  begin
    assert (l'length = r'length) and (l'length = result'length)						     
      report "Length Mismatch inApIntSub_proc" severity error;
    result := To_SLV(to_signed(l)  - to_signed(r));
  end ApIntSub_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntAnd_proc (l : in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector) is					
  begin
    assert (l'length = r'length) and (l'length = result'length)						     
      report "Length Mismatch inApIntAnd_proc" severity error;
    result := l and r;
  end ApIntAnd_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntOr_proc (l : in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector) is					
  begin
    assert (l'length = r'length) and (l'length = result'length)						     
      report "Length Mismatch inApIntOr_proc" severity error;
    result := l or r;
  end ApIntOr_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntXor_proc (l : in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector) is					
  begin
    assert (l'length = r'length) and (l'length = result'length)						     
      report "Length Mismatch inApIntXor_proc" severity error;
    result := l xor r;
  end ApIntXor_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntMul_proc (l : in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector) is					
  begin
    assert (l'length = r'length) and (l'length = result'length)						     
      report "Length Mismatch inApIntMul_proc" severity error;
     result := To_SLV(resize((to_unsigned(l)  * to_unsigned(r)),result'length));
  end ApIntMul_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntSHL_proc (l : in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector) is					
  begin
    result := To_SLV(to_unsigned(l) sll to_integer(to_unsigned(Ceil_Log2(l'length)+1, r)));
  end ApIntSHL_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntLSHR_proc (l : in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector) is					
  begin
     result := To_SLV(to_unsigned(l)  srl to_integer(to_unsigned(Ceil_Log2(l'length)+1, r)));
  end ApIntLSHR_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntASHR_proc (l : in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector) is					
  begin
     result := To_SLV(shift_right(to_signed(l), to_integer(to_unsigned(Ceil_Log2(l'length)+1,r)))); 
  end ApIntASHR_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntEq_proc (l : in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector) is					
  begin
    if l = r then
      result(result'low) := '1';
    else
      result(result'low) := '0';
    end if;
  end ApIntEq_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntNe_proc (l : in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector) is					
  begin
    if l = r then
      result(result'low) := '0';
    else
      result(result'low) := '1';
    end if;
  end ApIntNe_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntUgt_proc (l : in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector) is					
  begin
    if to_unsigned(l)  > to_unsigned(r) then
      result(result'low) := '1';
    else
      result(result'low) := '0';
    end if;
  end ApIntUgt_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntUge_proc (l : in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector) is					
  begin

    if to_unsigned(l)  >= to_unsigned(r) then
      result(result'low) := '1';      
    else
      result(result'low) := '0';
    end if;    

  end ApIntUge_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntUlt_proc (l : in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector) is					
  begin
    if to_unsigned(l)  < to_unsigned(r) then
      result(result'low) := '1';            
    else
      result(result'low) := '0';      
    end if;        

  end ApIntUlt_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntUle_proc (l : in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector) is					
  begin
    if to_unsigned(l)  <= to_unsigned(r) then
      result(result'low) := '1';            
    else
      result(result'low) := '0';            
    end if;        
  end ApIntUle_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntSgt_proc (l : in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector) is					
  begin
    if to_signed(l)  > to_signed(r) then
      result(result'low) := '1';            
    else
      result(result'low) := '0';                  
    end if;        
  end ApIntSgt_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntSge_proc (l : in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector) is					
  begin
    if to_signed(l)  >= to_signed(r) then
      result(result'low) := '1';            
    else
      result(result'low) := '0';                  
    end if;        

  end ApIntSge_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntSlt_proc (l : in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector) is					
  begin
    if to_signed(l) < to_signed(r) then
      result(result'low) := '1';                        
    else
      result(result'low) := '0';                              
    end if;        

  end ApIntSlt_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntSle_proc (l : in std_logic_vector; r : in std_logic_vector; result : out std_logic_vector) is					
  begin
    if to_signed(l) <= to_signed(r) then
      result(result'low) := '1';                              
    else
      result(result'low) := '0';                              
    end if;        
    
  end ApIntSle_proc;
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure TwoInputOperation(constant id : in string; x, y : in std_logic_vector; result : out std_logic_vector) is	
    variable result_var : std_logic_vector(result'high downto result'low);	
    variable temp_int: integer;
  begin
    if id = "ApConcat" then
      result_var := x & y;
    elsif id = "ApBitsel" then
      temp_int := To_Integer(To_Unsigned(Ceil_Log2(x'length)+1,y));
      result_var(result_var'low) := x(temp_int);
    elsif id = "ApIntAdd" then					
      ApIntAdd_proc(x,y, result_var);
    elsif id = "ApIntSub" then					
      ApIntSub_proc(x, y, result_var);
    elsif id = "ApIntAnd" then					
      ApIntAnd_proc(x, y, result_var);
    elsif id = "ApIntOr" then					
      ApIntOr_proc(x, y, result_var);
    elsif id = "ApIntXor" then					
      ApIntXor_proc(x, y, result_var);
    elsif id = "ApIntMul" then					
      ApIntMul_proc(x, y, result_var);
    elsif id = "ApIntSHL" then					
      ApIntSHL_proc(x, y, result_var);
    elsif id = "ApIntLSHR" then					
      ApIntLSHR_proc(x, y, result_var);
    elsif id = "ApIntASHR" then					
      ApIntASHR_proc(x, y, result_var);
    elsif id = "ApIntEq" then					
      ApIntEq_proc(x, y, result_var);
    elsif id = "ApIntNe" then					
      ApIntNe_proc(x, y, result_var);
    elsif id = "ApIntUgt" then					
      ApIntUgt_proc(x, y, result_var);
    elsif id = "ApIntUge" then					
      ApIntUge_proc(x, y, result_var);
    elsif id = "ApIntUlt" then					
      ApIntUlt_proc(x, y, result_var);
    elsif id = "ApIntUle" then					
      ApIntUle_proc(x, y, result_var);
    elsif id = "ApIntSgt" then					
      ApIntSgt_proc(x, y, result_var);
    elsif id = "ApIntSge" then					
      ApIntSge_proc(x, y, result_var);
    elsif id = "ApIntSlt" then					
      ApIntSlt_proc(x, y, result_var);
    elsif id = "ApIntSle" then					
      ApIntSle_proc(x, y, result_var);
    else	
      assert false report "Unsupported operator-id " & id severity failure;	
    end if;	
    result := result_var;	
  end TwoInputOperation;			
  -----------------------------------------------------------------------------
	
  -----------------------------------------------------------------------------	
  procedure SingleInputOperation(constant id : in string; x : in std_logic_vector; result : out std_logic_vector) is	
    variable result_var : std_logic_vector(result'high downto result'low);	
  begin
    if id = "ApIntNot" then					
      ApIntNot_proc(x, result_var);
    elsif id = "ApIntToApIntSigned" then					
      ApIntToApIntSigned_proc(x, result_var);
    elsif id = "ApIntToApIntUnsigned" then					
      ApIntToApIntUnsigned_proc(x, result_var);
    else	
      assert false report "Unsupported operator-id " & id severity failure;	
    end if;	
    result := result_var;	
  end SingleInputOperation;	
	
end package body OperatorPackage;	
library ieee;
use ieee.std_logic_1164.all;

package mem_component_pack is
component mem_demux 
  generic ( g_data_width: natural;
            g_id_width : natural;
            g_number_of_outputs: natural;
	    g_delay_count: natural);
  port(data_in: in std_logic_vector(g_data_width-1 downto 0);  -- data & id & time-stamp
       sel_in : in std_logic_vector(g_id_width-1 downto 0);
       req_in: in std_logic;
       ack_out : out std_logic;
       data_out: out std_logic_vector((g_number_of_outputs*g_data_width)-1 downto 0 );
       req_out: out std_logic_vector(g_number_of_outputs-1 downto 0);
       ack_in : in std_logic_vector(g_number_of_outputs-1 downto 0);
       clk: in std_logic;
       reset: in std_logic);
end component;

component mem_repeater 
    generic(g_data_width: natural);
    port(clk: in std_logic;
       reset: in std_logic;
       data_in: in std_logic_vector(g_data_width-1 downto 0);
       req_in: in std_logic;
       ack_out : out std_logic;
       data_out: out std_logic_vector(g_data_width-1 downto 0);
       req_out : out std_logic;
       ack_in: in std_logic);
end component mem_repeater;

component mem_shift_repeater
    generic(g_data_width: natural; g_number_of_stages: natural);
    port(clk: in std_logic;
       reset: in std_logic;
       data_in: in std_logic_vector(g_data_width-1 downto 0);
       req_in: in std_logic;
       ack_out : out std_logic;
       data_out: out std_logic_vector(g_data_width-1 downto 0);
       req_out : out std_logic;
       ack_in: in std_logic);
end component mem_shift_repeater;


component memory_bank 
   generic (
     g_addr_width: natural;
     g_data_width: natural;
     g_write_tag_width : natural;
     g_read_tag_width : natural;
     g_time_stamp_width: natural;
     g_base_bank_addr_width: natural;
     g_base_bank_data_width: natural
	);
   port (
     clk : in std_logic;
     reset: in std_logic;
     write_data     : in  std_logic_vector(g_data_width-1 downto 0);
     write_addr     : in std_logic_vector(g_addr_width-1 downto 0);
     write_tag      : in std_logic_vector(g_write_tag_width-1 downto 0);
     write_tag_out  : out std_logic_vector(g_write_tag_width-1 downto 0);
     write_enable   : in std_logic;
     write_ack   : out std_logic;
     write_result_accept : in std_logic;
     write_result_ready : out std_logic;
     read_data     : out  std_logic_vector(g_data_width-1 downto 0);
     read_addr     : in std_logic_vector(g_addr_width-1 downto 0);
     read_tag      : in std_logic_vector(g_read_tag_width-1 downto 0);
     read_tag_out  : out std_logic_vector(g_read_tag_width-1 downto 0);
     read_enable   : in std_logic;
     read_ack      : out std_logic;
     read_result_accept: in std_logic;
     read_result_ready: out std_logic
     );
end component memory_bank;

component memory_bank_base 
   generic ( g_addr_width: natural; 
	g_data_width : natural;
        g_base_bank_addr_width: natural;
        g_base_bank_data_width: natural);
   port (data_in : in std_logic_vector(g_data_width-1 downto 0);
         data_out: out std_logic_vector(g_data_width-1 downto 0);
         addr_in: in std_logic_vector(g_addr_width-1 downto 0);
         enable: in std_logic;
         write_bar : in std_logic;
         clk: in std_logic;
         reset : in std_logic
	);
end component memory_bank_base;

component base_bank 
   generic ( g_addr_width: natural; g_data_width : natural);
   port (datain : in std_logic_vector(g_data_width-1 downto 0);
         dataout: out std_logic_vector(g_data_width-1 downto 0);
         addrin: in std_logic_vector(g_addr_width-1 downto 0);
         enable: in std_logic;
         writebar : in std_logic;
         clk: in std_logic;
         reset : in std_logic);
end component base_bank;


component merge_box_with_repeater 
  generic (g_data_width: natural;
           g_number_of_inputs: natural;
           g_number_of_outputs: natural;
           g_time_stamp_width : natural;   -- width of timestamp
           g_tag_width : natural;  -- width of tag
           g_pipeline_flag: integer     -- if 0, dont add pipe-line stage
           );            

  port(data_left: in  std_logic_vector((g_data_width*g_number_of_inputs)-1 downto 0);
       req_in : in std_logic_vector(g_number_of_inputs-1 downto 0);
       ack_out : out std_logic_vector(g_number_of_inputs-1 downto 0);
       data_right: out std_logic_vector((g_data_width*g_number_of_outputs)-1 downto 0);
       req_out : out std_logic_vector(g_number_of_outputs-1 downto 0);
       ack_in : in std_logic_vector(g_number_of_outputs-1 downto 0);
       clock: in std_logic;
       reset: in std_logic);

end component merge_box_with_repeater;


component merge_tree 
  generic (
    g_number_of_inputs: natural;          
    g_data_width: natural;          -- total width of data
                                          -- (= actual-data & timestamp)
    g_time_stamp_width : natural;   -- width of timestamp
    g_tag_width : natural;          -- width of tag
    g_mux_degree :natural;         -- max-indegree of each pipeline-stage
    g_num_stages : natural;
    g_port_id_width: natural
    );       

  port (
    merge_data_in : in std_logic_vector((g_data_width*g_number_of_inputs)-1 downto 0);
    merge_req_in  : in std_logic_vector(g_number_of_inputs-1 downto 0);
    merge_ack_out : out std_logic_vector(g_number_of_inputs-1 downto 0);
    merge_data_out: out std_logic_vector(g_data_width-1 downto 0);
    merge_req_out : out std_logic;
    merge_ack_in  : in std_logic;
    clock: in std_logic;
    reset: in std_logic);
  
end component merge_tree;

component demerge_tree 
  
  generic (
    g_demux_degree: natural;
    g_number_of_outputs: natural;
    g_data_width: natural;              -- total width of data
                                        -- (= data & tag & port-id & timestamp)
    g_id_width: natural;
    g_stage_id: natural
    );       

  port (
    demerge_data_out : out std_logic_vector((g_data_width*g_number_of_outputs)-1 downto 0);
    demerge_ready_out  : out std_logic_vector(g_number_of_outputs-1 downto 0);
    demerge_accept_in   : in std_logic_vector(g_number_of_outputs-1 downto 0);
    demerge_data_in: in std_logic_vector(g_data_width-1 downto 0);
    demerge_ack_out : out std_logic;
    demerge_req_in  : in std_logic;
    demerge_sel_in: in std_logic_vector(g_id_width-1 downto 0);
    clock: in std_logic;
    reset: in std_logic);
  
end component demerge_tree;

component demerge_tree_wrap
  
  generic (
    g_demux_degree: natural;
    g_number_of_outputs: natural;
    g_data_width: natural;              -- total width of data
                                        -- (= data & tag & port-id & timestamp)
    g_id_width: natural;
    g_stage_id: natural
    );       

  port (
    demerge_data_out : out std_logic_vector((g_data_width*g_number_of_outputs)-1 downto 0);
    demerge_ready_out  : out std_logic_vector(g_number_of_outputs-1 downto 0);
    demerge_accept_in   : in std_logic_vector(g_number_of_outputs-1 downto 0);
    demerge_data_in: in std_logic_vector(g_data_width-1 downto 0);
    demerge_ack_out : out std_logic;
    demerge_req_in  : in std_logic;
    demerge_sel_in: in std_logic_vector(g_id_width-1 downto 0);
    clock: in std_logic;
    reset: in std_logic);
  
end component demerge_tree_wrap;

component combinational_merge 
  generic (
    g_data_width       : natural;
    g_number_of_inputs: natural;
    g_time_stamp_width : natural);
  port(
    in_data: in std_logic_vector((g_data_width*g_number_of_inputs)-1 downto 0);
    in_tstamp: in std_logic_vector((g_number_of_inputs*g_time_stamp_width)-1 downto 0);
    out_data: out std_logic_vector(g_data_width-1 downto 0);
    out_tstamp: out std_logic_vector(g_time_stamp_width-1 downto 0);
    in_req: in std_logic_vector(g_number_of_inputs-1 downto 0);
    in_ack: out std_logic_vector(g_number_of_inputs-1 downto 0);
    out_req: out std_logic;
    out_ack: in std_logic);
end component combinational_merge;


component memory_subsystem_core
  generic (
    num_loads       : natural;
    num_stores      : natural;
    addr_width      : natural;
    data_width      : natural;
    tag_width       : natural;
    time_stamp_width    : natural;
    number_of_banks : natural;
    mux_degree      : natural;
    demux_degree    : natural;
    base_bank_addr_width: natural;
    base_bank_data_width: natural);
  port (
    lr_addr_in  : in  std_logic_vector((num_loads*addr_width)-1 downto 0);
    lr_req_in   : in  std_logic_vector(num_loads-1 downto 0);
    lr_ack_out  : out std_logic_vector(num_loads-1 downto 0);
    lr_tag_in   : in  std_logic_vector((num_loads*tag_width)-1 downto 0);
    lr_time_stamp_in   : in  std_logic_vector((num_loads*time_stamp_width)-1 downto 0);
    lc_data_out : out std_logic_vector((num_loads*data_width)-1 downto 0);
    lc_req_in   : in  std_logic_vector(num_loads-1 downto 0);
    lc_ack_out  : out std_logic_vector(num_loads-1 downto 0);
    lc_tag_out  : out std_logic_vector((num_loads*tag_width)-1 downto 0);
    sr_addr_in  : in  std_logic_vector((num_stores*addr_width)-1 downto 0);
    sr_data_in  : in  std_logic_vector((num_stores*data_width)-1 downto 0);
    sr_req_in   : in  std_logic_vector(num_stores-1 downto 0);
    sr_ack_out  : out std_logic_vector(num_stores-1 downto 0);
    sr_tag_in   : in  std_logic_vector((num_stores*tag_width)-1 downto 0);
    sr_time_stamp_in   : in  std_logic_vector((num_stores*time_stamp_width)-1 downto 0);
    sc_req_in   : in  std_logic_vector(num_stores-1 downto 0);
    sc_ack_out  : out std_logic_vector(num_stores-1 downto 0);
    sc_tag_out  : out std_logic_vector((num_stores*tag_width)-1 downto 0);
    clock       : in  std_logic;
    reset       : in  std_logic);
end component;

end package mem_component_pack;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
                         
package mem_function_pack is
  function Ceil_Log ( x: natural; base: natural) return natural;
  function Ceil_Log2 ( x: natural) return natural;
  function Ceiling (constant x, y : integer) return integer;
  function IsGreaterThan(x, y: std_logic_vector) return boolean;
  function IncrementSLV(constant x : std_logic_vector) return std_logic_vector;
  function Bank_Match(BANK: natural;
                      log2_number_of_banks: natural;
                      addr_in: std_logic_vector)   return boolean;
  function To_Integer(x: std_logic_vector) return natural;
  function Minimum(x: integer; y: integer) return integer;
  function Maximum(x: integer; y: integer) return integer;
  function Natural_To_SLV (constant val, size : natural) return std_logic_vector;

  function Convert_To_String(val : natural) return STRING; -- convert val to string.
  function Convert_To_String(val : std_logic_vector) return STRING; -- convert signed to string.

end mem_function_pack;

package body mem_function_pack is
  function Ceil_Log ( x: natural; base: natural ) return natural is
    variable ret_var : integer := 0;
    variable tvar : natural;
  begin
    ret_var := 0;
    if(x > 0) then
      tvar := x;
      while(tvar > 1)loop
        tvar := tvar/base;
        ret_var := ret_var + 1;
      end loop;
      if(base**ret_var < x) then ret_var := ret_var + 1; end if;
    end if;
    return(ret_var);
  end function Ceil_Log;

  function Ceil_Log2 ( x: natural) return natural is
  begin
    return(Ceil_Log(x,2));
  end function Ceil_Log2;
    
  -- purpose: ceiling of x/y
  function Ceiling (
    constant x, y : integer)
    return integer is
    variable ratio : integer;
  begin  -- Ceiling
    ratio := x/y;
    if(y*ratio < x) then
      ratio := ratio + 1;
    end if;
    return ratio;
  end Ceiling;

    -- return true if x > y false otherwise
  function IsGreaterThan(x, y: std_logic_vector) return boolean is
    alias lx : std_logic_vector(1 to x'length) is x;
    alias ly : std_logic_vector(1 to x'length) is y;
    variable ret_val, still_equal : boolean;
  begin
    assert lx'length = ly'length report "mismatched lengths in IsGreaterThan" severity error;
    assert lx'length > 2 report "time-stamp length must be > 2 in IsGreaterThan" severity error;

    ret_val := false;
    
    if((lx(1 to 2) = "00" and ly(1 to 2) = "11") or
       (lx(1 to 2) = "01" and ly(1 to 2) = "00") or
       (lx(1 to 2) = "10" and ly(1 to 2) = "01") or
       (lx(1 to 2) = "11" and ly(1 to 2) = "10")) then
      ret_val := true;
    elsif(lx(1 to 2) = ly(1 to 2)) then
      still_equal := true;
      for I in 3 to lx'length loop
        if(still_equal and (lx(I) = '1') and (ly(I) = '0')) then
          ret_val := true;
          still_equal := false;
        elsif(still_equal and (lx(I) = '0' and ly(I) = '1')) then
          still_equal := false;
        end if;
      end loop;  -- I
    end if;
    return(ret_val);
  end function IsGreaterThan;

  function IncrementSLV(constant x : std_logic_vector) return std_logic_vector
  is
    alias lx : std_logic_vector(1 to x'length) is x;
    variable ret_var : std_logic_vector(1 to x'length);
    variable carry_bit, sum_bit : std_logic;
  begin
    carry_bit := '1';
    for I in x'length downto 1 loop
      sum_bit    := carry_bit xor lx(I);
      carry_bit  := carry_bit and lx(I);
      ret_var(I) := sum_bit;
    end loop;
    return(ret_var);
  end function  IncrementSLV;

  function Bank_Match(BANK: natural;
                      log2_number_of_banks: natural;
                      addr_in: std_logic_vector)
    return boolean is
    alias la : std_logic_vector(1 to addr_in'length) is addr_in;
    variable v : unsigned(1 to log2_number_of_banks);
    variable ret_val : boolean;
  begin
    assert addr_in'length > log2_number_of_banks report "inadequate address length in Bank_Match" severity error;
    ret_val := true;
    if(log2_number_of_banks > 0) then
      for I  in 1 to log2_number_of_banks loop
        v(I) := la((addr_in'length - log2_number_of_banks) + I);
      end loop;  -- I
      if(To_Integer(v) = BANK) then
        ret_val := true;
      else
        ret_val := false;
      end if;
    end if;
    return(ret_val);
  end Bank_Match;

  function To_Integer(x: std_logic_vector) return natural is
	alias lx: std_logic_vector(1 to x'length) is x;
	variable ret_var,two_power: natural;
  begin
        two_power := 1; 
        ret_var := 0;
	for I in x'length downto 1 loop
		if(lx(I) = '1') then
			ret_var := ret_var  + two_power;
		end if;
		two_power := 2*two_power;
	end loop;
	return(ret_var);
  end To_Integer;
  
  function Minimum(x: integer; y: integer) return integer is
       variable ret_var: integer;
    begin
       if(x < y) then ret_var := x; else ret_var := y; end if;
       return(ret_var);
  end Minimum; 

  function Maximum(x: integer; y: integer) return integer is
       variable ret_var: integer;
    begin
       if(x > y) then ret_var := x; else ret_var := y; end if;
       return(ret_var);
  end Maximum; 

  function Natural_To_SLV (constant val, size : natural) return std_logic_vector is
    variable ret_var  : std_logic_vector(size-1 downto 0);
    variable uret_var : unsigned(size-1 downto 0);
    variable scale_val : natural;
  begin
    scale_val := val mod (2**size);
    uret_var := TO_UNSIGNED(scale_val,size);
    for I in 0 to size-1 loop
      ret_var(I) := uret_var(I);
    end loop;  -- I
    return(ret_var);
  end Natural_To_SLV;

  function Convert_To_String(val : NATURAL) return STRING is
	variable result : STRING(10 downto 1) := (others => '0'); -- smallest natural, longest string
	variable pos    : NATURAL := 1;
	variable tmp, digit  : NATURAL;
  begin
    -- synopsys translate_off
	tmp := val;
	loop
		digit := abs(tmp MOD 10);
	    	tmp := tmp / 10;
	    	result(pos) := character'val(character'pos('0') + digit);
	    	pos := pos + 1;
	    	exit when tmp = 0;
	end loop;
    -- synopsys translate_on
	return result((pos-1) downto 1);
  end Convert_To_String;

  function Convert_To_String(val : std_logic_vector) return STRING is
        alias lval: std_logic_vector(1 to val'length) is val;
	variable result : STRING(1 to val'length) := (others => '0'); -- smallest natural, longest string
  begin
        for I in 1 to val'length loop
          if(lval(I) = '0') then result(I) := '0'; else result(I) := '1'; end if;
	end loop;
	return result;
  end Convert_To_String;

end mem_function_pack;

library ieee;
use ieee.std_logic_1164.all;

package memory_subsystem_package is

  component memory_subsystem
    generic (
      num_loads       : natural;
      num_stores      : natural;
      addr_width      : natural;
      data_width      : natural;
      tag_width       : natural;
      number_of_banks : natural; -- must be a power of 2!
      mux_degree      : natural;
      demux_degree    : natural;
      base_bank_addr_width: natural;
      base_bank_data_width: natural);
    port (
      lr_addr_in  : in  std_logic_vector((num_loads*addr_width)-1 downto 0);
      lr_req_in   : in  std_logic_vector(num_loads-1 downto 0);
      lr_ack_out  : out std_logic_vector(num_loads-1 downto 0);
      lr_tag_in   : in  std_logic_vector((num_loads*tag_width)-1 downto 0);
      lc_data_out : out std_logic_vector((num_loads*data_width)-1 downto 0);
      lc_req_in   : in  std_logic_vector(num_loads-1 downto 0);
      lc_ack_out  : out std_logic_vector(num_loads-1 downto 0);
      lc_tag_out  : out std_logic_vector((num_loads*tag_width)-1 downto 0);
      sr_addr_in  : in  std_logic_vector((num_stores*addr_width)-1 downto 0);
      sr_data_in  : in  std_logic_vector((num_stores*data_width)-1 downto 0);
      sr_req_in   : in  std_logic_vector(num_stores-1 downto 0);
      sr_ack_out  : out std_logic_vector(num_stores-1 downto 0);
      sr_tag_in   : in  std_logic_vector((num_stores*tag_width)-1 downto 0);
      sc_req_in   : in  std_logic_vector(num_stores-1 downto 0);
      sc_ack_out  : out std_logic_vector(num_stores-1 downto 0);
      sc_tag_out  : out std_logic_vector((num_stores*tag_width)-1 downto 0);
      clock       : in  std_logic;
      reset       : in  std_logic);
  end component;


  component register_bank 
    generic(num_loads             : natural := 5;
            num_stores            : natural := 10;
            addr_width            : natural := 9;
            data_width            : natural := 5;
            tag_width             : natural := 7;
            num_registers         : natural := 1);
    port(
      ------------------------------------------------------------------------------
      -- load request ports
      ------------------------------------------------------------------------------
      lr_addr_in : in std_logic_vector((num_loads*addr_width)-1 downto 0);

      -- req/ack pair:
      -- when both are asserted, time-stamp is set on load request.
      lr_req_in  : in  std_logic_vector(num_loads-1 downto 0);
      lr_ack_out : out std_logic_vector(num_loads-1 downto 0);

      -- tag for request, will be returned on completion.
      lr_tag_in : in std_logic_vector((num_loads*tag_width)-1 downto 0);

      ---------------------------------------------------------------------------
      -- load complete ports
      ---------------------------------------------------------------------------
      lc_data_out : out std_logic_vector((num_loads*data_width)-1 downto 0);

      -- req/ack pair:
      -- when both are asserted, user should latch data_out.
      lc_req_in  : in  std_logic_vector(num_loads-1 downto 0);
      lc_ack_out : out std_logic_vector(num_loads-1 downto 0);

      -- tag of completed request.
      lc_tag_out : out std_logic_vector((num_loads*tag_width)-1 downto 0);

      ------------------------------------------------------------------------------
      -- store request ports
      ------------------------------------------------------------------------------
      sr_addr_in : in std_logic_vector((num_stores*addr_width)-1 downto 0);
      sr_data_in : in std_logic_vector((num_stores*data_width)-1 downto 0);

      -- req/ack pair:
      -- when both are asserted, time-stamp is set on store request.
      sr_req_in  : in  std_logic_vector(num_stores-1 downto 0);
      sr_ack_out : out std_logic_vector(num_stores-1 downto 0);

      -- tag for request, will be returned on completion.
      sr_tag_in : in std_logic_vector((num_stores*tag_width)-1 downto 0);

      ---------------------------------------------------------------------------
      -- store complete ports
      ---------------------------------------------------------------------------
      -- req/ack pair:
      -- when both are asserted, user assumes that store is done.
      sc_req_in  : in  std_logic_vector(num_stores-1 downto 0);
      sc_ack_out : out std_logic_vector(num_stores-1 downto 0);

      -- tag of completed request.
      sc_tag_out : out std_logic_vector((num_stores*tag_width)-1 downto 0);

      ------------------------------------------------------------------------------
      -- clock, reset
      ------------------------------------------------------------------------------
      clock : in std_logic;  -- only rising edge is used to trigger activity.
      reset : in std_logic               -- active high.
      );
  end component register_bank;

  component  dummy_read_only_memory_subsystem 
  generic(num_loads             : natural := 5;
          addr_width            : natural := 9;
          data_width            : natural := 5;
          tag_width             : natural := 7);
  port(
    ------------------------------------------------------------------------------
    -- load request ports
    ------------------------------------------------------------------------------
    lr_addr_in : in std_logic_vector((num_loads*addr_width)-1 downto 0);

    -- req/ack pair:
    -- when both are asserted, time-stamp is set on load request.
    lr_req_in  : in  std_logic_vector(num_loads-1 downto 0);
    lr_ack_out : out std_logic_vector(num_loads-1 downto 0);

    -- tag for request, will be returned on completion.
    lr_tag_in : in std_logic_vector((num_loads*tag_width)-1 downto 0);

    ---------------------------------------------------------------------------
    -- load complete ports
    ---------------------------------------------------------------------------
    lc_data_out : out std_logic_vector((num_loads*data_width)-1 downto 0);

    -- req/ack pair:
    -- when both are asserted, user should latch data_out.
    lc_req_in  : in  std_logic_vector(num_loads-1 downto 0);
    lc_ack_out : out std_logic_vector(num_loads-1 downto 0);

    -- tag of completed request.
    lc_tag_out : out std_logic_vector((num_loads*tag_width)-1 downto 0);

    ------------------------------------------------------------------------------
    -- clock, reset
    ------------------------------------------------------------------------------
    clock : in std_logic;  -- only rising edge is used to trigger activity.
    reset : in std_logic               -- active high.
    );
   end component dummy_read_only_memory_subsystem;

   component dummy_write_only_memory_subsystem is
  	generic( num_stores            : natural := 10;
          addr_width            : natural := 9;
          data_width            : natural := 5;
          tag_width             : natural := 7);
  	port(
    ------------------------------------------------------------------------------
    -- store request ports
    ------------------------------------------------------------------------------
    sr_addr_in : in std_logic_vector((num_stores*addr_width)-1 downto 0);
    sr_data_in : in std_logic_vector((num_stores*data_width)-1 downto 0);

    -- req/ack pair:
    -- when both are asserted, time-stamp is set on store request.
    sr_req_in  : in  std_logic_vector(num_stores-1 downto 0);
    sr_ack_out : out std_logic_vector(num_stores-1 downto 0);

    -- tag for request, will be returned on completion.
    sr_tag_in : in std_logic_vector((num_stores*tag_width)-1 downto 0);

    ---------------------------------------------------------------------------
    -- store complete ports
    ---------------------------------------------------------------------------
    -- req/ack pair:
    -- when both are asserted, user assumes that store is done.
    sc_req_in  : in  std_logic_vector(num_stores-1 downto 0);
    sc_ack_out : out std_logic_vector(num_stores-1 downto 0);

    -- tag of completed request.
    sc_tag_out : out std_logic_vector((num_stores*tag_width)-1 downto 0);

    ------------------------------------------------------------------------------
    -- clock, reset
    ------------------------------------------------------------------------------
    clock : in std_logic;  -- only rising edge is used to trigger activity.
    reset : in std_logic               -- active high.
    );
    end component dummy_write_only_memory_subsystem;

end memory_subsystem_package;
library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.mem_function_pack.all;

package merge_functions is
  type NaturalArray is array (natural range <>) of natural;

  function Total_Intermediate_Width(constant x,y: natural) return natural;
  function Stage_Width (
    constant stage_id     : natural;
    constant mux_degree : natural;
    constant stage0_width : natural)
    return natural;
  function Left_Index (
    constant stage_id     : natural;
    constant mux_degree : natural;
    constant stage0_width : natural)
    return natural;
  function Right_Index (
    constant stage_id     : natural;
    constant mux_degree : natural;
    constant stage0_width : natural)
    return natural;
  
  --constant c_group_left_id : NaturalArray(0 to c_demux_degree-1) := Calculate_Group_Left_Ids(g_number_of_outputs,c_demux_degree);
  function Calculate_Group_Left_Ids (
    constant xwid : natural;
    constant x : natural;
    constant y : natural)
    return NaturalArray;
  
  --constant c_group_right_id : NaturalArray(0 to c_demux_degree-1) := Calculate_Group_Left_Ids(g_number_of_outputs,c_demux_degree);
  function Calculate_Group_Right_Ids (
    constant xwid : natural;
    constant x : natural;
    constant y : natural)
    return NaturalArray;
  
  --constant c_group_sizes : NaturalArray(0 to c_demux_degree-1) := Calculate_Group_Sizes(g_number_of_outputs,c_demux_degree);
  function Calculate_Group_Sizes (
    constant xwid : natural;
    constant x : natural;
    constant y : natural)
    return NaturalArray;

  function Nonzero_Count (
    constant x : NaturalArray)
    return natural;

  procedure Select_Best_Index(time_stamp_vector : in std_logic_vector;
                              data_vector: in std_logic_vector;
			      valid_vector      : in std_logic_vector;
			      best_time_stamp   : out std_logic_vector;
                              best_data : out std_logic_vector;
                              sel_vector: out std_logic_vector;
                              valid_flag: out std_logic);
end merge_functions;

package body merge_functions is

  function Total_Intermediate_Width(constant x,y: natural)
    return natural is
    variable ret_val,tval : natural;
  begin
    ret_val := x;
    tval := x;
    
    while tval > 1 loop
      tval := Ceiling(tval,y);
      ret_val := ret_val + tval;
    end loop;  -- I

    -- for the output.
    ret_val := ret_val + 1;
    return(ret_val);
  end function Total_Intermediate_Width;

  function Stage_Width (
    constant stage_id     : natural;
    constant mux_degree : natural;
    constant stage0_width : natural)
    return natural is
    variable ret_var,tval : natural;
  begin  -- Stage_Width
    ret_var := stage0_width;
    tval := mux_degree;
    if(stage_id > 0) then
      for I  in 1 to stage_id loop
        ret_var := Ceiling(ret_var,tval);
      end loop;  -- I
    end if;
    return(ret_var);
  end Stage_Width;
  
  -- index in intermediate array from which input to stage_id begins
  function Left_Index (
    constant stage_id     : natural;
    constant mux_degree : natural;
    constant stage0_width : natural)
    return natural is
    variable ret_var,offset,tval : natural;
  begin  
    if(stage_id = 0) then
      ret_var := 0;
    else
      ret_var := Right_Index(stage_id-1,mux_degree,stage0_width) + 1;
    end if;
    return(ret_var);
  end Left_Index;

  function Right_Index (
    constant stage_id     : natural;
    constant mux_degree : natural;
    constant stage0_width : natural)
    return natural is
    variable ret_var: natural;
  begin  
    ret_var := Left_Index(stage_id,mux_degree,stage0_width)  +
               Stage_Width(stage_id,mux_degree,stage0_width) - 1;
    return(ret_var);
  end Right_Index;

  function Calculate_Group_Left_Ids (
    constant xwid : natural;
    constant x : natural;
    constant y : natural)
    return NaturalArray is
    variable ret_var  : NaturalArray(0 to y-1);

    constant ysize : natural := Ceil_Log2(y);
    constant xsize : natural := Maximum(xwid,ysize);    

    variable index : natural;
    variable xbin: std_logic_vector(xsize-1 downto 0);
    variable ybin : std_logic_vector(ysize-1 downto 0);
  begin
--    assert false report "left-id called " & Convert_To_String(xwid) & " " &
--		Convert_To_String(x) & " " & Convert_To_String(y) severity note;
    ret_var := (others => x);
    if(xsize >= ysize) then
      for I in x-1 downto 0 loop
        xbin := Natural_To_SLV(I,xsize);
        ybin := xbin(xsize-1 downto xsize-ysize);
        index := To_Integer(ybin);
        if(ret_var(index) = x) then
          ret_var(index) := I;
        end if;
      end loop;  -- I
    end if;
--    for I in 0 to y-1 loop
--      assert false report "group-left-id " & Convert_To_String(ret_var(I)) severity note;
--    end loop;
    return(ret_var);
  end Calculate_Group_Left_Ids;
  

  function Calculate_Group_Right_Ids (
    constant xwid : natural;
    constant x : natural;
    constant y : natural)
    return NaturalArray is
    variable ret_var  : NaturalArray(0 to y-1);

    constant ysize : natural := Ceil_Log2(y);
    constant xsize : natural := Maximum(xwid,ysize);    

    variable index : natural;
    variable xbin: std_logic_vector(xsize-1 downto 0);
    variable ybin : std_logic_vector(ysize-1 downto 0);
  begin
--    assert false report "right-id called " & Convert_To_String(xwid) & " " &
--		Convert_To_String(x) & " " & Convert_To_String(y) severity note;
    ret_var := (others => x);
    if(xsize >= ysize) then
      for I in 0 to x-1 loop
        xbin := Natural_To_SLV(I,xsize);
        ybin := xbin(xsize-1 downto xsize-ysize);
        index := To_Integer(ybin);
        if(ret_var(index) = x) then
          ret_var(index) := I;
        end if;
      end loop;  -- I
    end if;
--    for I in 0 to y-1 loop
--      assert false report "group-right-id " & Convert_To_String(ret_var(I)) severity note;
--    end loop;
    return(ret_var);
  end Calculate_Group_Right_Ids;


  function Calculate_Group_Sizes (
    constant xwid : natural;
    constant x : natural;
    constant y : natural)
    return NaturalArray is
    variable ret_var  : NaturalArray(0 to y-1);

    constant ysize : natural := Ceil_Log2(y);
    constant xsize : natural := Maximum(xwid,ysize);

    variable index : natural;
    variable xbin: std_logic_vector(xsize-1 downto 0);
    variable ybin : std_logic_vector(ysize-1 downto 0);
  begin
--    assert false report "group-sizes called " & Convert_To_String(xwid) & " " &
--		Convert_To_String(x) & " " & Convert_To_String(y) severity note;
    ret_var := (others => 0);
    if(xsize >= ysize) then 
      for I in x-1 downto 0 loop
        xbin := Natural_To_SLV(I,xsize);
        ybin := xbin(xsize-1 downto xsize-ysize);
        index := To_Integer(ybin);
        ret_var(index) := ret_var(index) + 1;
      end loop;  -- I
    end if;
--    for I in 0 to y-1 loop
--      assert false report "group-size " & Convert_To_String(ret_var(I)) severity note;
--    end loop;
    return(ret_var);
  end Calculate_Group_Sizes;

  function Nonzero_Count (
    constant x : NaturalArray)
    return natural is
    variable ret_var : natural;
    alias lx : NaturalArray(1 to x'length) is x;
  begin
    ret_var := 0;
    for I in 1 to x'length loop
      if(lx(I) > 0) then
        ret_var := ret_var + 1;
      end if;
    end loop;  -- I
--    assert false report "non-zero-count " & Convert_To_String(ret_var) severity note;
    return(ret_var);
  end Nonzero_Count;
    
  procedure Select_Best_Index(time_stamp_vector : in std_logic_vector;
                              data_vector: in std_logic_vector;
			      valid_vector      : in std_logic_vector;
			      best_time_stamp   : out std_logic_vector;
                              best_data : out std_logic_vector;
                              sel_vector: out std_logic_vector;
                              valid_flag: out std_logic)
  is
	constant mid_point: integer := valid_vector'length / 2;
        constant time_stamp_width : integer := best_time_stamp'length;
        constant data_width : integer := best_data'length;
        
        alias ltv: std_logic_vector(1 to time_stamp_vector'length) is time_stamp_vector;
        alias ld: std_logic_vector(1 to data_vector'length) is data_vector;
	alias lv: std_logic_vector(1 to valid_vector'length) is valid_vector;

	variable uindex, hindex: integer;
	variable ubest, hbest: std_logic_vector(1 to time_stamp_width);
        variable ud, hd: std_logic_vector(1 to data_width);
        variable sv : std_logic_vector(1 to lv'length) ;
        variable uvalid,hvalid : std_logic;
  begin
        sv := (others => '0');
        valid_flag := '0';
	best_time_stamp := ltv(1 to time_stamp_width);
        best_data := ld(1 to data_width);

	if(valid_vector'length = 1) then
		if(lv(1) = '1') then
                        sv(1) := '1';
                        valid_flag := '1';
		end if;	
	elsif(valid_vector'length = 2) then
		if(lv(1) = '1' and lv(2) = '1') then
			if(IsGreaterThan(ltv(1 to time_stamp_width),ltv(time_stamp_width+1 to (2*time_stamp_width)))) then
				best_time_stamp := ltv(time_stamp_width+1 to 2*time_stamp_width);
                                best_data := ld(data_width+1 to 2*data_width);
                                sv(2) := '1';
			else
                                sv(1) := '1';
			end if;
                        valid_flag := '1';
		elsif(lv(1) = '1') then
                        sv(1) := '1';
                        valid_flag := '1';
		elsif(lv(2) = '1') then
			best_time_stamp := ltv(time_stamp_width+1 to 2*time_stamp_width);
                        best_data := ld(data_width+1 to 2*data_width);
                        sv(2) := '1';
                        valid_flag := '1';
		end if;
	else
		Select_Best_Index(ltv(1 to mid_point*time_stamp_width),
                                  ld(1 to mid_point*data_width),
                                  lv(1 to mid_point),
                                  ubest,
                                  ud,
                                  sv(1 to mid_point),
                                  uvalid);
                
		Select_Best_Index(ltv((mid_point*time_stamp_width)+1 to ltv'length),
                                  ld((mid_point*data_width)+1 to ld'length),
                                  lv(mid_point+1 to lv'length),
                                  hbest,
                                  hd,
                                  sv(mid_point+1 to sv'length),
                                  hvalid);
                
		if(uvalid = '1' and hvalid = '1') then
			if(IsGreaterThan(hbest,ubest)) then
				best_time_stamp := ubest;
                                best_data := ud;
                                sv(mid_point + 1 to sv'length) := (others => '0');
			else
				best_time_stamp := hbest;
                                best_data := hd;
                                sv(1 to mid_point) := (others => '0');
			end if;
                        valid_flag := '1';
		elsif (hvalid = '1' ) then
			best_time_stamp := hbest;
                        best_data := hd;
                        sv(1 to mid_point) := (others => '0');
                        valid_flag := '1';
		elsif(uvalid = '1') then
			best_time_stamp := ubest;
                        best_data := ud;
                        sv(mid_point + 1 to sv'length) := (others => '0');
                        valid_flag := '1';
		end if;
	end if;
        sel_vector := sv;
  end Select_Best_Index;
end merge_functions;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity base_bank is
   generic ( g_addr_width: natural := 10; g_data_width : natural := 16);
   port (datain : in std_logic_vector(g_data_width-1 downto 0);
         dataout: out std_logic_vector(g_data_width-1 downto 0);
         addrin: in std_logic_vector(g_addr_width-1 downto 0);
         enable: in std_logic;
         writebar : in std_logic;
         clk: in std_logic;
         reset : in std_logic);
end entity base_bank;


architecture XilinxBramInfer of base_bank is
  type MemArray is array (natural range <>) of std_logic_vector(g_data_width-1 downto 0);
  signal mem_array : MemArray((2**g_addr_width)-1 downto 0) := (others => (others => '0'));
  signal addr_reg : std_logic_vector(g_addr_width-1 downto 0);
  signal rd_enable_reg : std_logic;
begin  -- XilinxBramInfer

  -- read/write process
  process(clk,addrin,enable,writebar)
  begin

    -- synch read-write memory
    if(clk'event and clk ='1') then

     	-- register the address
	-- and use it in a separate assignment
	-- for the delayed read.
      addr_reg <= addrin;

	-- generate a registered read enable
      if(reset = '1') then
	rd_enable_reg <= '0';
      else
	rd_enable_reg <= enable and writebar;
      end if;

      if(enable = '1' and writebar = '0') then
        mem_array(To_Integer(unsigned(addrin))) <= datain;
      end if;
    end if;
  end process;
      	
	-- use the registered read enable with the registered address to 
	-- describe the read
  dataout <= mem_array(To_Integer(unsigned(addr_reg))) when (rd_enable_reg = '1') else (others => '0');

end XilinxBramInfer;
library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.mem_function_pack.all;
use ahir.merge_functions.all;

entity combinational_merge is
  generic (
    g_data_width       : natural;
    g_number_of_inputs: natural;
    g_time_stamp_width : natural);
  port(
    in_data: in std_logic_vector((g_data_width*g_number_of_inputs)-1 downto 0);
    in_tstamp: in std_logic_vector((g_number_of_inputs*g_time_stamp_width)-1 downto 0);
    out_data: out std_logic_vector(g_data_width-1 downto 0);
    out_tstamp: out std_logic_vector(g_time_stamp_width-1 downto 0);
    in_req: in std_logic_vector(g_number_of_inputs-1 downto 0);
    in_ack: out std_logic_vector(g_number_of_inputs-1 downto 0);
    out_req: out std_logic;
    out_ack: in std_logic);
end combinational_merge;

architecture combinational_merge of combinational_merge is

  signal sel_vector : std_logic_vector(g_number_of_inputs-1 downto 0);
  
begin  -- combinational_merge

  process(in_tstamp,in_data,in_req)
    variable best_tstamp_var : std_logic_vector(1 to g_time_stamp_width);
    variable best_data : std_logic_vector(1 to g_data_width);
    variable sel_var : std_logic_vector(g_number_of_inputs-1 downto 0);
    variable vflag : std_logic;
  begin
    Select_Best_Index(in_tstamp,in_data, in_req,best_tstamp_var,best_data,sel_var,vflag);
    if(vflag = '1') then
      out_tstamp <= best_tstamp_var;
      out_data <= best_data;
      sel_vector <= sel_var;
      out_req <= '1';
    else
      out_tstamp <= (others => '0');
      out_data <= (others => '0');
      sel_vector <= (others => '0');
      out_req <= '0';
    end if;
  end process;
  
  AckGen: for I in 0 to g_number_of_inputs-1 generate
    in_ack(I) <= '1' when (sel_vector(I) = '1'  and out_ack = '1' and in_req(I) = '1') else '0';
  end generate AckGen;
  
end combinational_merge;
library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.mem_function_pack.all;
use ahir.merge_functions.all;
use ahir.mem_component_pack.all;

entity demerge_tree is
  generic (
    g_demux_degree: natural := 10;
    g_number_of_outputs: natural := 5;
    g_data_width: natural := 8;
    g_id_width: natural := 3;
    g_stage_id: natural := 0
    );       

  port (
    demerge_data_out : out std_logic_vector((g_data_width*g_number_of_outputs)-1 downto 0);
    demerge_ready_out  : out std_logic_vector(g_number_of_outputs-1 downto 0);
    demerge_accept_in   : in std_logic_vector(g_number_of_outputs-1 downto 0);
    demerge_data_in: in std_logic_vector(g_data_width-1 downto 0);
    demerge_ack_out : out std_logic;
    demerge_req_in  : in std_logic;
    demerge_sel_in: in std_logic_vector(g_id_width-1 downto 0);
    clock: in std_logic;
    reset: in std_logic);
end demerge_tree;

-- a much simpler architecture, which is likely to be equally
-- effective.
architecture Simple of demerge_tree is
  constant inserted_delay  : integer := Maximum(1,Ceil_Log2(g_number_of_outputs/g_demux_degree));
begin  -- Simple

  demux : mem_demux generic map (
    g_data_width        => g_data_width,
    g_id_width          => g_id_width,
    g_number_of_outputs => g_number_of_outputs,
    g_delay_count => inserted_delay)
    port map (
      data_in  => demerge_data_in,
      sel_in   => demerge_sel_in,
      req_in   => demerge_req_in,
      ack_out  => demerge_ack_out,
      data_out => demerge_data_out,
      req_out  => demerge_ready_out,
      ack_in   => demerge_accept_in,
      clk      => clock,
      reset    => reset);
end Simple;




library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.mem_function_pack.all;
use ahir.merge_functions.all;
use ahir.mem_component_pack.all;

entity demerge_tree_wrap is
  generic (
    g_demux_degree: natural;
    g_number_of_outputs: natural;
    g_data_width: natural;
    g_id_width: natural;
    g_stage_id: natural
    );       

  port (
    demerge_data_out : out std_logic_vector((g_data_width*g_number_of_outputs)-1 downto 0);
    demerge_ready_out  : out std_logic_vector(g_number_of_outputs-1 downto 0);
    demerge_accept_in   : in std_logic_vector(g_number_of_outputs-1 downto 0);
    demerge_data_in: in std_logic_vector(g_data_width-1 downto 0);
    demerge_ack_out : out std_logic;
    demerge_req_in  : in std_logic;
    demerge_sel_in: in std_logic_vector(g_id_width-1 downto 0);
    clock: in std_logic;
    reset: in std_logic);
  
end demerge_tree_wrap;



architecture wrapper of demerge_tree_wrap is
begin
      
      demTree: component demerge_tree
        generic map (
          g_data_width => g_data_width,
          g_id_width   => g_id_width,
          g_number_of_outputs => g_number_of_outputs,
          g_stage_id => g_stage_id,
          g_demux_degree => g_demux_degree)
        port map (
          demerge_data_out => demerge_data_out,
          demerge_ready_out => demerge_ready_out,
          demerge_accept_in => demerge_accept_in,
          demerge_data_in   => demerge_data_in,
          demerge_req_in  => demerge_req_in,
          demerge_ack_out => demerge_ack_out,
          demerge_sel_in  => demerge_sel_in,
          clock => clock,
          reset => reset);
end wrapper;




library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.mem_function_pack.all;
use ahir.merge_functions.all;
use ahir.mem_component_pack.all;


-- a dummy ROM  which is never initialized.
-- any load to it returns 0.
entity dummy_read_only_memory_subsystem is
  generic(num_loads             : natural := 5;
          addr_width            : natural := 9;
          data_width            : natural := 5;
          tag_width             : natural := 7);
  port(
    ------------------------------------------------------------------------------
    -- load request ports
    ------------------------------------------------------------------------------
    lr_addr_in : in std_logic_vector((num_loads*addr_width)-1 downto 0);

    -- req/ack pair:
    -- when both are asserted, time-stamp is set on load request.
    lr_req_in  : in  std_logic_vector(num_loads-1 downto 0);
    lr_ack_out : out std_logic_vector(num_loads-1 downto 0);

    -- tag for request, will be returned on completion.
    lr_tag_in : in std_logic_vector((num_loads*tag_width)-1 downto 0);

    ---------------------------------------------------------------------------
    -- load complete ports
    ---------------------------------------------------------------------------
    lc_data_out : out std_logic_vector((num_loads*data_width)-1 downto 0);

    -- req/ack pair:
    -- when both are asserted, user should latch data_out.
    lc_req_in  : in  std_logic_vector(num_loads-1 downto 0);
    lc_ack_out : out std_logic_vector(num_loads-1 downto 0);

    -- tag of completed request.
    lc_tag_out : out std_logic_vector((num_loads*tag_width)-1 downto 0);

    ------------------------------------------------------------------------------
    -- clock, reset
    ------------------------------------------------------------------------------
    clock : in std_logic;  -- only rising edge is used to trigger activity.
    reset : in std_logic               -- active high.
    );
end entity dummy_read_only_memory_subsystem;


architecture Default of dummy_read_only_memory_subsystem is
begin

     lc_data_out <= (others => '0');
     lc_ack_out <= (others => '1');

     -- ack after one tick..
     process(clock)
     begin
	if(clock'event and clock = '1') then
		if(reset = '1') then
			lr_ack_out <= (others => '0');
		else
			for I in 0 to num_loads-1 loop
				if(lr_req_in(I) = '1') then
					lc_tag_out(((I+1)*tag_width)-1 downto I*tag_width) 
						<= 
						lr_tag_in(((I+1)*tag_width)-1 downto I*tag_width);
					lr_ack_out(I) <= '1';
				else
					lr_ack_out(I) <= '0';
				end if;
			end loop;
		end if;
	end if;
     end process;

end Default;

library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.mem_function_pack.all;
use ahir.merge_functions.all;
use ahir.mem_component_pack.all;

-- a dummy write-only memory (perfectly useless,
-- but plug-in for corner cases).
entity dummy_write_only_memory_subsystem is
  generic( num_stores            : natural := 10;
          addr_width            : natural := 9;
          data_width            : natural := 5;
          tag_width             : natural := 7);
  port(
    ------------------------------------------------------------------------------
    -- store request ports
    ------------------------------------------------------------------------------
    sr_addr_in : in std_logic_vector((num_stores*addr_width)-1 downto 0);
    sr_data_in : in std_logic_vector((num_stores*data_width)-1 downto 0);

    -- req/ack pair:
    -- when both are asserted, time-stamp is set on store request.
    sr_req_in  : in  std_logic_vector(num_stores-1 downto 0);
    sr_ack_out : out std_logic_vector(num_stores-1 downto 0);

    -- tag for request, will be returned on completion.
    sr_tag_in : in std_logic_vector((num_stores*tag_width)-1 downto 0);

    ---------------------------------------------------------------------------
    -- store complete ports
    ---------------------------------------------------------------------------
    -- req/ack pair:
    -- when both are asserted, user assumes that store is done.
    sc_req_in  : in  std_logic_vector(num_stores-1 downto 0);
    sc_ack_out : out std_logic_vector(num_stores-1 downto 0);

    -- tag of completed request.
    sc_tag_out : out std_logic_vector((num_stores*tag_width)-1 downto 0);

    ------------------------------------------------------------------------------
    -- clock, reset
    ------------------------------------------------------------------------------
    clock : in std_logic;  -- only rising edge is used to trigger activity.
    reset : in std_logic               -- active high.
    );
end entity dummy_write_only_memory_subsystem;


-- architecture: synchronous R/W.
--               on destination conflict, writer with lowest index wins.
architecture Default of dummy_write_only_memory_subsystem is
begin

     -- you are always done..
     sc_ack_out <= (others => '1');

     -- ack after one tick..
     process(clock)
     begin
	if(clock'event and clock = '1') then
		if(reset = '1') then
			sr_ack_out <= (others => '0');
		else
			for I in 0 to num_stores-1 loop
				if(sr_req_in(I) = '1') then
					sc_tag_out(((I+1)*tag_width)-1 downto I*tag_width) 
						<= 
						sr_tag_in(((I+1)*tag_width)-1 downto I*tag_width);
					sr_ack_out(I) <= '1';
				else
					sr_ack_out(I) <= '0';
				end if;
			end loop;
		end if;
	end if;
     end process;

end Default;

library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.mem_function_pack.all;
use ahir.merge_functions.all;
use ahir.mem_component_pack.all;

entity mem_demux is
  generic ( g_data_width: natural := 10;
            g_id_width : natural := 3;
            g_number_of_outputs: natural := 8;
	    g_delay_count: natural := 1);
  port(data_in: in std_logic_vector(g_data_width-1 downto 0);  -- data & id & time-stamp
       sel_in : in std_logic_vector(g_id_width-1 downto 0);
       req_in: in std_logic;
       ack_out : out std_logic;
       data_out: out std_logic_vector((g_number_of_outputs*g_data_width)-1 downto 0 );
       req_out: out std_logic_vector(g_number_of_outputs-1 downto 0);
       ack_in : in std_logic_vector(g_number_of_outputs-1 downto 0);
       clk: in std_logic;
       reset: in std_logic);
end entity;

architecture behave of mem_demux is
  type SigArrayType is array (natural range <>) of std_logic_vector(g_data_width-1 downto 0);

  signal data_out_sig,repeater_out_sig : SigArrayType(g_number_of_outputs-1 downto 0);
  signal req_out_sig, ack_in_sig : std_logic_vector(g_number_of_outputs-1 downto 0);

begin  -- behave


  process(ack_in_sig)
    variable ack_out_var : std_logic;
  begin
    ack_out_var := '0';
    for I in 0 to g_number_of_outputs-1 loop
      ack_out_var := ack_out_var or ack_in_sig(I);
    end loop;  -- I
    ack_out <= ack_out_var;
  end process;
    
  gen: for I in 0 to g_number_of_outputs-1 generate

    data_out_sig(I) <= data_in;
    
    process(data_in, sel_in, req_in)
      variable port_index : natural;
    begin
      port_index := To_Integer(sel_in);
      req_out_sig(I) <= '0';
      if(req_in = '1' and port_index = I) then
        req_out_sig(I) <= req_in;
      end if;
    end process;
      
    Repeater : mem_shift_repeater generic map(g_data_width => g_data_width, g_number_of_stages => g_delay_count)
    port map (
      clk      => clk,
      reset    => reset,
      data_in  => data_out_sig(I),
      req_in   => req_out_sig(I),
      ack_out  => ack_in_sig(I),
      data_out => repeater_out_sig(I),
      req_out  => req_out(I),
      ack_in   => ack_in(I));

    data_out((I+1)*g_data_width -1 downto I*g_data_width) <= repeater_out_sig(I);
  end generate gen;

end behave;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.memory_subsystem_package.all;
use ahir.mem_function_pack.all;
use ahir.mem_component_pack.all;

entity memory_bank_base is
   generic ( g_addr_width: natural; 
	g_data_width : natural;
        g_base_bank_addr_width: natural;
        g_base_bank_data_width: natural);
   port (data_in : in std_logic_vector(g_data_width-1 downto 0);
         data_out: out std_logic_vector(g_data_width-1 downto 0);
         addr_in: in std_logic_vector(g_addr_width-1 downto 0);
         enable: in std_logic;
         write_bar : in std_logic;
         clk: in std_logic;
         reset : in std_logic);
end entity memory_bank_base;


architecture structural of memory_bank_base is
  constant bank_array_width : natural := Ceiling(g_data_width,g_base_bank_data_width);
  constant bank_array_height : natural := 2**(Maximum(0,g_addr_width-g_base_bank_addr_width));

  type BankArrayDataArray is array (0 to bank_array_height-1, 0 to bank_array_width -1) of std_logic_vector(g_base_bank_data_width-1 downto 0);
  signal data_in_array, data_out_array : BankArrayDataArray;
  

  type BankArrayControlArray is array (0 to bank_array_height-1, 0 to bank_array_width -1) of std_logic;
  signal enable_array,enable_array_reg: BankArrayControlArray;
  
  signal padded_data_in,padded_data_out : std_logic_vector(bank_array_width*g_base_bank_data_width -1 downto 0);
  signal base_addr_in : std_logic_vector(g_base_bank_addr_width -1 downto 0);
  
  signal write_bar_reg: std_logic;
begin  -- structural

   -- register write_bar_reg because memory read will finish after one clock.
    process(clk,reset)
    begin
        if(clk'event and clk = '1') then
		if(reset = '1') then
			write_bar_reg <= '0';
		else
			write_bar_reg <= write_bar;
		end if;
	end if;
    end process;

process(addr_in)
        constant l_index: natural := Minimum(g_addr_width-1, g_base_bank_addr_width-1);
    begin
        base_addr_in <= (others => '0');
        base_addr_in(l_index downto 0) <= addr_in(l_index downto 0);
    end process;
    
process(data_in)
    begin
        padded_data_in <= (others => '0');
        padded_data_in(g_data_width-1 downto 0) <= data_in;
    end process;
    
  data_out <= padded_data_out(g_data_width-1 downto 0);

  -- pack/unpack
  ColGen: for COL in 0 to bank_array_width-1 generate
    
    RowGen: for ROW in 0 to bank_array_height-1 generate
      process(addr_in, enable)
      begin
        enable_array(ROW,COL) <= '0';
        if(bank_array_height > 1) then
          if(enable = '1') then
            if(ROW = To_Integer(addr_in(g_addr_width - 1 downto g_base_bank_addr_width))) then
              enable_array(ROW,COL) <= '1';
            end if;
          end if;
        else
          enable_array(ROW,COL) <= enable;
        end if;
      end process;

      process(clk,reset)
      begin
	if(clk'event and clk = '1') then
		if(reset = '1') then
			enable_array_reg(ROW,COL) <= '0';
		else
			enable_array_reg(ROW,COL) <= enable_array(ROW,COL);
		end if;
	end if;
      end process;

      process(padded_data_in)
      begin
        data_in_array(ROW,COL) <= padded_data_in((COL+1)*g_base_bank_data_width - 1 downto COL*g_base_bank_data_width);
      end process;

      baseMem : base_bank generic map (
        g_addr_width => g_base_bank_addr_width,
        g_data_width => g_base_bank_data_width)
        port map (
          datain => data_in_array(ROW, COL),
          addrin => base_addr_in,
          enable => enable_array(ROW,COL),
          writebar => write_bar,
          dataout => data_out_array(ROW,COL),
          clk => clk,
          reset => reset);
      
    end generate RowGen;
    
    process(data_out_array,enable_array, write_bar)
    begin
      padded_data_out((COL+1)*g_base_bank_data_width -1 downto (COL*g_base_bank_data_width)) <= (others => '0');
      for ROW in 0 to bank_array_height-1 loop
	-- use delayed version of enable and write_bar to pass read data
        if(enable_array_reg(ROW,COL) = '1' and write_bar_reg = '1') then
          padded_data_out((COL+1)*g_base_bank_data_width -1 downto (COL*g_base_bank_data_width)) <= data_out_array(ROW,COL);
        end if;
      end loop;  -- ROW
    end process;
    
  end generate ColGen;

end structural;
library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.mem_function_pack.all;
use ahir.mem_component_pack.all;

entity memory_bank is
   generic (
     g_addr_width: natural;
     g_data_width: natural;
     g_write_tag_width : natural;
     g_read_tag_width : natural;
     g_time_stamp_width: natural;
	g_base_bank_addr_width: natural;
	g_base_bank_data_width: natural
	);
   port (
     clk : in std_logic;
     reset: in std_logic;
     write_data     : in  std_logic_vector(g_data_width-1 downto 0);
     write_addr     : in std_logic_vector(g_addr_width-1 downto 0);
     write_tag      : in std_logic_vector(g_write_tag_width-1 downto 0);
     write_tag_out  : out std_logic_vector(g_write_tag_width-1 downto 0);
     write_enable   : in std_logic;
     write_ack   : out std_logic;
     write_result_accept : in std_logic;
     write_result_ready : out std_logic;
     read_data     : out std_logic_vector(g_data_width-1 downto 0);
     read_addr     : in std_logic_vector(g_addr_width-1 downto 0);
     read_tag      : in std_logic_vector(g_read_tag_width-1 downto 0);
     read_tag_out  : out std_logic_vector(g_read_tag_width-1 downto 0);
     read_enable   : in std_logic;
     read_ack      : out std_logic;
     read_result_accept: in std_logic;
     read_result_ready: out std_logic
     );
end entity memory_bank;


architecture SimModel of memory_bank is

  signal write_done, read_done, write_has_priority: std_logic;
  signal write_address_sig, read_address_sig : natural range 0 to (2**g_addr_width)-1;
  signal read_time_stamp, write_time_stamp: std_logic_vector(g_time_stamp_width-1 downto 0);
  signal state_sig: std_logic;
  signal enable_base,enable_sig, write_enable_base, read_enable_base: std_logic;

  signal addr_base : std_logic_vector(g_addr_width-1 downto 0);
  signal block_write_ack, block_read_ack: std_logic;
  
  
begin  -- behave
  read_time_stamp <= read_tag(g_time_stamp_width-1 downto 0);
  write_time_stamp <= write_tag(g_time_stamp_width-1 downto 0);

  process(read_time_stamp,write_time_stamp, read_enable, write_enable)
  begin
      if(write_enable = '1' and read_enable = '1') then
	if(IsGreaterThan(read_time_stamp,write_time_stamp)) then
        	write_has_priority <=   '1';
	else
		write_has_priority <= '0';
	end if;
      elsif(write_enable = '1') then
	write_has_priority <= '1';
      elsif(read_enable = '1') then
	write_has_priority <= '0';
      else
	write_has_priority <= '1';
      end if;
  end process;


  -- basically, the enable/ack pair and the ready/accept pair
  -- have to be coordinated: in one complete cycle, the
  -- following sequence must be followed
  --  enable -> ready -> accept -> ack.
  process(reset,write_enable,write_has_priority,read_enable,clk, write_tag, read_tag)
  begin
    if clk'event and clk = '1' then

      -- one cycle delay through memory bank
      write_tag_out <= write_tag;
      read_tag_out  <= read_tag;
      
      if(reset = '1') then
        write_done <= '0';
        read_done <= '0';
      else
        if(write_enable = '1' and ( write_has_priority = '1' or read_enable = '0')) then
          write_done <= '1';
        else
          write_done <= '0';
        end if; 
        if(read_enable = '1' and ( write_has_priority = '0' or write_enable = '0')) then
          read_done <= '1';
        else
          read_done <= '0';
        end if;
      end if;
    end if;
  end process;

  -- ack when done 
  block_write_ack <= '1' when (write_done = '1' and write_result_accept = '0') else '0';
  write_ack <= '1' when (write_enable = '1' and write_has_priority = '1' and  block_write_ack = '0') else '0';
  write_result_ready <= write_done;
  
  -- ack to read only when result is also enabled
  block_read_ack <= '1' when (read_done = '1' and read_result_accept = '0') else '0';
  read_ack <= '1' when (read_enable = '1' and write_has_priority = '0' and  block_read_ack = '0') else '0';
  read_result_ready <= read_done;  


  process(write_enable, write_has_priority, block_write_ack)
  begin  -- process
      if(write_enable = '1' and write_has_priority = '1' and block_write_ack = '0') then
	write_enable_base <= '1';
      else
	write_enable_base <= '0';
      end if;
  end process;

  
  process(read_enable,  write_has_priority, block_read_ack)
  begin
    if(read_enable = '1' and write_has_priority = '0' and block_read_ack = '0') then
	read_enable_base <= '1';
    else
	read_enable_base <= '0';
    end if;
  end process;

  addr_base <= write_addr when write_enable_base = '1' else read_addr when read_enable_base = '1' else (others => '0');
  enable_sig <= write_enable_base or read_enable_base;
  
  memBase: memory_bank_base generic map(g_addr_width => g_addr_width,
                                        g_data_width => g_data_width,
					g_base_bank_addr_width => g_base_bank_addr_width,
					g_base_bank_data_width => g_base_bank_data_width)
    port map(data_in => write_data,
             addr_in => addr_base,
             data_out => read_data,
             enable => enable_sig,
             write_bar => read_enable_base,
             clk => clk,
             reset => reset);
  
end SimModel;

library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.mem_function_pack.all;
use ahir.merge_functions.all;
use ahir.mem_component_pack.all;

-- memory subsystem guarantees that accesses to the same location
-- will take place in the order of the time-stamp assigned to each
-- access (tie breaks will be random). Time-stamp is set at the
-- point of acceptance of an access request.

entity memory_subsystem_core is
  generic(num_loads             : natural := 5;
          num_stores            : natural := 10;
          addr_width            : natural := 9;
          data_width            : natural := 5;
          tag_width             : natural := 7;
          time_stamp_width      : natural := 11;
          number_of_banks       : natural := 1;
          mux_degree            : natural := 10;
          demux_degree          : natural := 10;
	  base_bank_addr_width  : natural := 8;
	  base_bank_data_width  : natural := 8);
  port(
    ------------------------------------------------------------------------------
    -- load request ports
    ------------------------------------------------------------------------------
    lr_addr_in : in std_logic_vector((num_loads*addr_width)-1 downto 0);

    -- req/ack pair:
    -- when both are asserted, time-stamp is set on load request.
    lr_req_in  : in  std_logic_vector(num_loads-1 downto 0);
    lr_ack_out : out std_logic_vector(num_loads-1 downto 0);

    -- tag for request, will be returned on completion.
    lr_tag_in : in std_logic_vector((num_loads*tag_width)-1 downto 0);

    -- time-stamp for request: will be used for all ordering inside
    -- the subsystem
    lr_time_stamp_in   : in  std_logic_vector((num_loads*time_stamp_width)-1 downto 0);
    
    ---------------------------------------------------------------------------
    -- load complete ports
    ---------------------------------------------------------------------------
    lc_data_out : out std_logic_vector((num_loads*data_width)-1 downto 0);

    -- req/ack pair:
    -- when both are asserted, user should latch data_out.
    lc_req_in  : in  std_logic_vector(num_loads-1 downto 0);
    lc_ack_out : out std_logic_vector(num_loads-1 downto 0);

    -- tag of completed request.
    lc_tag_out : out std_logic_vector((num_loads*tag_width)-1 downto 0);

    ------------------------------------------------------------------------------
    -- store request ports
    ------------------------------------------------------------------------------
    sr_addr_in : in std_logic_vector((num_stores*addr_width)-1 downto 0);
    sr_data_in : in std_logic_vector((num_stores*data_width)-1 downto 0);

    -- req/ack pair:
    -- when both are asserted, time-stamp is set on store request.
    sr_req_in  : in  std_logic_vector(num_stores-1 downto 0);
    sr_ack_out : out std_logic_vector(num_stores-1 downto 0);

    -- tag for request, will be returned on completion.
    sr_tag_in : in std_logic_vector((num_stores*tag_width)-1 downto 0);

    -- time-stamp for request: will be used for all ordering inside
    -- the subsystem
    sr_time_stamp_in   : in  std_logic_vector((num_stores*time_stamp_width)-1 downto 0);
    
    ---------------------------------------------------------------------------
    -- store complete ports
    ---------------------------------------------------------------------------
    -- req/ack pair:
    -- when both are asserted, user assumes that store is done.
    sc_req_in  : in  std_logic_vector(num_stores-1 downto 0);
    sc_ack_out : out std_logic_vector(num_stores-1 downto 0);

    -- tag of completed request.
    sc_tag_out : out std_logic_vector((num_stores*tag_width)-1 downto 0);

    ------------------------------------------------------------------------------
    -- clock, reset
    ------------------------------------------------------------------------------
    clock : in std_logic;  -- only rising edge is used to trigger activity.
    reset : in std_logic               -- active high.
    );
end entity memory_subsystem_core;


architecture pipelined of memory_subsystem_core is

  -----------------------------------------------------------------------------
  -- configuration constants.  These should be determined by the
  -- implementation itself based on the input generics.  For the moment
  -- these are hardwired.
  -----------------------------------------------------------------------------
  constant c_mux_degree : natural :=  mux_degree;
  constant c_demux_degree : natural := demux_degree;
  constant log2_number_of_banks : natural := Ceil_Log2(number_of_banks);  --  
  constant bank_addr_width : natural := addr_width - log2_number_of_banks;
  constant c_load_merge_stages : natural := Maximum(1, Ceil_Log(num_loads,c_mux_degree));
  constant c_store_merge_stages : natural := Maximum(1,Ceil_Log(num_stores,c_mux_degree));
  constant c_number_of_merge_stages : natural := Maximum(c_load_merge_stages,c_store_merge_stages);
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  -- useful constants
  constant c_number_of_inputs : natural := num_loads + num_stores;
  constant c_log2_number_of_inputs : natural := Ceil_Log2(num_loads + num_stores);
  -----------------------------------------------------------------------------

  type LoadDataArray is array (natural range <>) of std_logic_vector(data_width-1 downto 0);
  type LoadDataTagArray is array (natural range <>) of std_logic_vector(data_width+tag_width-1 downto 0);
  signal load_port_data : LoadDataTagArray(0 to num_loads-1);
  
  -----------------------------------------------------------------------------
  -- Todo: create an array of port id tags to keep track of the
  --       input port
  -----------------------------------------------------------------------------
  constant c_load_port_id_width : natural := Maximum(1,Ceil_Log2(num_loads));
  constant c_store_port_id_width : natural := Maximum(1,Ceil_Log2(num_stores));

  type LoadPortIdArray is array (natural range <>) of std_logic_vector(c_load_port_id_width-1 downto 0);
  type StorePortIdArray is array (natural range <>) of std_logic_vector(c_store_port_id_width-1 downto 0);
  
  type TimeStampArray is array (natural range<>) of std_logic_vector(time_stamp_width-1 downto 0);
  function StorePortIdGen (
    constant x : natural;
    constant width : natural
    )
    return StorePortIdArray
  is
    variable ret_var : StorePortIdArray(0 to x-1);
    variable curr_value : std_logic_vector(width-1 downto 0);
  begin
    curr_value := (others => '0');
    ret_var := (others => (others => '0'));
    for I  in 0 to x-1 loop
      ret_var(I) := curr_value;
      curr_value := IncrementSLV(curr_value);
    end loop;  -- I
    return(ret_var);
  end function StorePortIdGen;

  function LoadPortIdGen (
    constant x : natural;
    constant width : natural
    )
    return LoadPortIdArray
  is
    variable ret_var : LoadPortIdArray(0 to x-1);
    variable curr_value : std_logic_vector(width-1 downto 0);
  begin
    curr_value := (others => '0');
    ret_var := (others => (others => '0'));
    for I  in 0 to x-1 loop
      ret_var(I) := curr_value;
      curr_value := IncrementSLV(curr_value);
    end loop;  -- I
    return(ret_var);
  end function LoadPortIdGen;


  constant c_load_port_id_array : LoadPortIdArray := LoadPortIdGen(num_loads, c_load_port_id_width);
  signal s_load_port_id_array : LoadPortIdArray(0 to num_loads-1) := c_load_port_id_array;


  constant c_store_port_id_array : StorePortIdArray := StorePortIdGen(num_stores, c_store_port_id_width);
  signal s_store_port_id_array : StorePortIdArray(0 to num_stores-1) := c_store_port_id_array;
  
  constant c_load_merge_data_width : natural := (bank_addr_width) + tag_width + c_load_port_id_width + time_stamp_width;
  constant c_load_demerge_data_width : natural := data_width + tag_width + c_load_port_id_width + time_stamp_width;
  
  constant c_store_merge_data_width : natural := (bank_addr_width) + data_width + tag_width + c_store_port_id_width + time_stamp_width;
  constant c_store_demerge_data_width : natural := tag_width + c_store_port_id_width + time_stamp_width;
  

  signal load_time_stamp : TimeStampArray(num_loads-1 downto 0);
  signal store_complete_time_stamp,store_time_stamp : TimeStampArray(num_stores-1 downto 0);

  type LoadMergeArray is array(0 to number_of_banks-1) of std_logic_vector(num_loads*c_load_merge_data_width-1 downto 0);
  type StoreMergeArray is array(0 to number_of_banks-1) of std_logic_vector(num_stores*c_store_merge_data_width-1 downto 0);
  type LoadControlArray is array(0 to number_of_banks-1) of std_logic_vector(num_loads-1 downto 0);
  
  type LoadDemergeArray is array(0 to number_of_banks-1) of std_logic_vector(num_loads*c_load_demerge_data_width-1 downto 0);
  type StoreDemergeArray is array(0 to number_of_banks-1) of std_logic_vector(num_stores*c_store_demerge_data_width-1 downto 0);
  type StoreControlArray is array(0 to number_of_banks-1) of std_logic_vector(num_stores-1 downto 0);
  
  signal load_merge_data_in : LoadMergeArray;
  signal load_merge_data_out : std_logic_vector((number_of_banks*c_load_merge_data_width)-1 downto 0);

  -- port side load merge control
  signal load_merge_from_port_req, load_merge_to_port_ack : LoadControlArray;

  -- bank side load merge control
  signal load_merge_to_bank_req, load_merge_from_bank_ack : std_logic_vector(number_of_banks-1 downto 0);
  
  signal load_demerge_data_in : std_logic_vector((number_of_banks*c_load_demerge_data_width)-1 downto 0);
  signal load_demerge_data_out : LoadDemergeArray;

  -- port side load demerge control
  signal load_demerge_to_port_req, load_demerge_from_port_ack :LoadControlArray;

  -- bank side load demerge control
  signal load_demerge_from_bank_req, load_demerge_to_bank_ack : std_logic_vector(number_of_banks-1 downto 0);
    
  signal store_merge_data_in : StoreMergeArray;
  signal store_merge_data_out : std_logic_vector((number_of_banks*c_store_merge_data_width)-1 downto 0);

  -- port side store merge control
  signal store_merge_from_port_req, store_merge_to_port_ack : StoreControlArray;
  
  -- bank side store merge control
  signal store_merge_to_bank_req, store_merge_from_bank_ack : std_logic_vector(number_of_banks-1 downto 0);
  signal store_demerge_data_in : std_logic_vector((number_of_banks*c_store_demerge_data_width)-1 downto 0);
  signal store_demerge_data_out : StoreDemergeArray;

  -- port side store demerge control
  signal store_demerge_to_port_req, store_demerge_from_port_ack : StoreControlArray;

  -- bank side store demerge control
  signal store_demerge_from_bank_req, store_demerge_to_bank_ack : std_logic_vector(number_of_banks-1 downto 0);

  signal load_req_state : std_logic_vector(num_loads-1 downto 0);
  signal store_req_state : std_logic_vector(num_stores-1 downto 0);

  type BankDataArray is array(natural range <>) of std_logic_vector(number_of_banks*(data_width+tag_width)-1 downto 0);
  type BankTagArray is array(natural range <>) of std_logic_vector(number_of_banks*tag_width-1 downto 0);
  type BankStorePortIdArray is array(natural range <>) of std_logic_vector(number_of_banks*c_store_port_id_width-1 downto 0);
  type BankTimestampArray is array(natural range <>) of std_logic_vector(number_of_banks*time_stamp_width-1 downto 0);
  type BankControlArray is array(natural range <>) of std_logic_vector(number_of_banks-1 downto 0);

  signal load_data_from_banks : BankDataArray(0 to num_loads-1);
  signal load_tstamp_from_banks : BankTimestampArray(0 to num_loads-1);
  signal load_data_req_from_banks, load_data_ack_to_banks : BankControlArray(0 to num_loads-1);
  signal store_tstamp_from_banks : BankTimestampArray(0 to num_stores-1);
  signal store_port_id_from_banks : BankStorePortIdArray(0 to num_stores-1);
  signal store_tag_from_banks : BankTagArray(0 to num_stores-1);
  signal store_data_req_from_banks, store_data_ack_to_banks : BankControlArray(0 to num_stores-1);

  type BankMemDataArray is array (natural range <>) of std_logic_vector(data_width-1 downto 0);
  type BankMemTagArray is array (natural range <>) of std_logic_vector(tag_width-1 downto 0);
  type BankMemLoadTagArray is array (natural range <>) of std_logic_vector((tag_width+c_load_port_id_width+time_stamp_width)-1 downto 0);
  type BankMemStoreTagArray is array (natural range <>) of std_logic_vector((tag_width+c_store_port_id_width+time_stamp_width)-1 downto 0);
  type BankMemStorePortIdArray is array(natural range <>) of std_logic_vector(c_store_port_id_width-1 downto 0);
  type BankMemAddressArray is array (natural range <>) of std_logic_vector(bank_addr_width-1 downto 0);
  signal bank_mem_read_addr, bank_mem_write_addr: BankMemAddressArray(0 to number_of_banks-1);
  signal bank_mem_read_data, bank_mem_write_data : BankMemDataArray(0 to number_of_banks-1);
  signal bank_mem_read_tag : BankMemLoadTagArray(0 to number_of_banks-1);
  signal bank_mem_read_tag_out: BankMemLoadTagArray(0 to number_of_banks-1);
  signal bank_mem_write_tag : BankMemStoreTagArray(0 to number_of_banks-1);
  signal bank_mem_write_tag_out : BankMemStoreTagArray(0 to number_of_banks-1);
  signal bank_mem_store_port_id_out: BankMemStorePortIdArray(0 to number_of_banks-1);
  signal bank_mem_store_tag_out: BankMemTagArray(0 to number_of_banks-1);
  signal bank_mem_write_enable, bank_mem_write_ack, bank_mem_read_enable, bank_mem_read_ack : std_logic_vector(0 to number_of_banks-1);
  signal bank_mem_write_result_ready, bank_mem_write_result_accept, bank_mem_read_result_ready, bank_mem_read_result_accept : std_logic_vector(0 to number_of_banks-1);
  

begin

  -----------------------------------------------------------------------------
  -- load merge logic
  -----------------------------------------------------------------------------
  LoadMergeGen: for I in 0 to num_loads-1 generate

    load_time_stamp(I) <= lr_time_stamp_in((I+1)*time_stamp_width -1 downto I*time_stamp_width);

    ---------------------------------------------------------------------------
    -- lr_ack
    ---------------------------------------------------------------------------
    process(load_merge_to_port_ack)
      variable sig_var : std_logic;
    begin
      sig_var := '0';
      for BANK in 0 to number_of_banks-1 loop
        sig_var := sig_var or load_merge_to_port_ack(BANK)(I);
      end loop;  -- BANK
      lr_ack_out(I) <= sig_var;
    end process;


    ---------------------------------------------------------------------------
    -- address & tag & port-id & time-stamp
    BankGen: for BANK in 0 to number_of_banks-1 generate

      -------------------------------------------------------------------------
      -- distribution of data to banks
      -------------------------------------------------------------------------
      
      -- data-in to merge tree for BANK. (from Ith port)
      load_merge_data_in(BANK)((I+1)*c_load_merge_data_width - 1 downto I*c_load_merge_data_width)
        <= lr_addr_in((I+1)*addr_width-1 downto (I*addr_width) + log2_number_of_banks) &
        lr_tag_in((I+1)*tag_width-1 downto I*tag_width) & c_load_port_id_array(I) & load_time_stamp(I);

      -- handshake between ports and load-merge
      load_merge_from_port_req(BANK)(I) <=
        lr_req_in(I) when Bank_Match(BANK,log2_number_of_banks,lr_addr_in((I+1)*addr_width-1 downto I*addr_width)) else '0';
      -- ack through lr_ack process.

      -------------------------------------------------------------------------
      -- reverse data from banks
      -------------------------------------------------------------------------
      
      -- data & tag &  port-id & time-stamp
      load_data_from_banks(I)((BANK+1)*(tag_width+data_width)-1 downto BANK*(tag_width+data_width)) 
        <= 
        load_demerge_data_out(BANK)((I+1)*(c_load_demerge_data_width)-1 downto ((I+1)*(c_load_demerge_data_width)-data_width)-tag_width);

      load_tstamp_from_banks(I)((BANK+1)*(time_stamp_width)-1 downto BANK*time_stamp_width)
        <=
        load_demerge_data_out(BANK)((I*c_load_demerge_data_width)+(time_stamp_width-1) downto 
                                    ((I*c_load_demerge_data_width)));

      -------------------------------------------------------------------------
      -- port-side handshake
      --  Ports   -> req    Merge  -> req   Bank
      --          <- ack           <- ack
      -------------------------------------------------------------------------
      load_data_req_from_banks(I)(BANK) <= load_demerge_to_port_req(BANK)(I);
      load_demerge_from_port_ack(BANK)(I) <=  load_data_ack_to_banks(I)(BANK);

    end generate BankGen;


    ---------------------------------------------------------------------------
    -- merge for load-complete
    ---------------------------------------------------------------------------
    mergeComplete : combinational_merge generic map (
      g_data_width       => data_width + tag_width,
      g_number_of_inputs => number_of_banks,
      g_time_stamp_width => time_stamp_width)
      port map (in_data => load_data_from_banks(I),
                in_tstamp => load_tstamp_from_banks(I),
                out_data => load_port_data(I),
                out_tstamp => open,
                in_req => load_data_req_from_banks(I),
                in_ack => load_data_ack_to_banks(I),
                out_req => lc_ack_out(I),
                out_ack => lc_req_in(I));

    lc_data_out((I+1)*data_width-1 downto I*data_width) <= load_port_data(I)(data_width+tag_width-1 downto tag_width);
    lc_tag_out((I+1)*tag_width -1 downto I*tag_width) <= load_port_data(I)(tag_width-1 downto 0);
    
  end generate LoadMergeGen;

  -----------------------------------------------------------------------------
  -- store merge
  -----------------------------------------------------------------------------
  StoreMergeGen: for I in 0 to num_stores-1 generate
    
    store_time_stamp(I) <= sr_time_stamp_in((I+1)*time_stamp_width -1 downto I*time_stamp_width);

    ---------------------------------------------------------------------------
    -- sr_ack
    ---------------------------------------------------------------------------
    process(store_merge_to_port_ack)
      variable sig_var : std_logic;
    begin
      sig_var := '0';
      for BANK in 0 to number_of_banks-1 loop
        sig_var := sig_var or store_merge_to_port_ack(BANK)(I);
      end loop;  -- BANK
      sr_ack_out(I) <= sig_var;
    end process;


    BankGen: for BANK in 0 to number_of_banks-1 generate
      
      -------------------------------------------------------------------------
      -- distribution of data to banks
      -------------------------------------------------------------------------
      -- address & data & tag & port_id & time_stamp
      
      store_merge_data_in(BANK)((I+1)*c_store_merge_data_width - 1 downto I*c_store_merge_data_width)
        <= sr_addr_in((I+1)*addr_width-1 downto I*addr_width + log2_number_of_banks) &
        sr_data_in((I+1)*data_width-1 downto I*data_width) & 
        sr_tag_in((I+1)*tag_width-1 downto I*tag_width) &  c_store_port_id_array(I) & store_time_stamp(I);

      store_merge_from_port_req(BANK)(I) <=
        sr_req_in(I) when Bank_Match(BANK,log2_number_of_banks,sr_addr_in((I+1)*addr_width-1 downto I*addr_width)) else '0';

      -------------------------------------------------------------------------
      -- reverse data from banks (tag only).
      -------------------------------------------------------------------------
      -- tag & port-id & time-stamp
      store_tag_from_banks(I)((BANK+1)*(tag_width)-1 downto BANK*(tag_width)) 
        <= 
        store_demerge_data_out(BANK)((I+1)*(c_store_demerge_data_width)-1 downto ((I+1)*(c_store_demerge_data_width)-tag_width));

      store_tstamp_from_banks(I)((BANK+1)*(time_stamp_width)-1 downto BANK*time_stamp_width)
        <=
        store_demerge_data_out(BANK)(I*c_store_demerge_data_width+(time_stamp_width-1) downto
                                    (I*c_store_demerge_data_width));

      store_port_id_from_banks(I)((BANK+1)*c_store_port_id_width -1 downto BANK*c_store_port_id_width)
	<=
        store_demerge_data_out(BANK)((I+1)*(c_store_demerge_data_width)-(tag_width+1) downto ((I+1)*(c_store_demerge_data_width)-(c_store_port_id_width + tag_width)));
	
      -- port side handshake
      store_data_req_from_banks(I)(BANK) <= store_demerge_to_port_req(BANK)(I);
      store_demerge_from_port_ack(BANK)(I) <=  store_data_ack_to_banks(I)(BANK);

    end generate BankGen;


    ---------------------------------------------------------------------------
    -- merge for store-complete
    ---------------------------------------------------------------------------
    mergeComplete : combinational_merge generic map (
      g_data_width       => tag_width,
      g_number_of_inputs => number_of_banks,
      g_time_stamp_width => time_stamp_width)
      port map (in_data => store_tag_from_banks(I),
                in_tstamp => store_tstamp_from_banks(I),
                out_data => sc_tag_out((I+1)*tag_width-1 downto I*tag_width),
                out_tstamp => store_complete_time_stamp(I),
                in_req => store_data_req_from_banks(I),
                in_ack => store_data_ack_to_banks(I),
                out_req => sc_ack_out(I),
                out_ack => sc_req_in(I));

  end generate StoreMergeGen;


  -----------------------------------------------------------------------------
  -- now the banks
  -----------------------------------------------------------------------------
  BankGen: for BANK in 0 to number_of_banks-1 generate

    ---------------------------------------------------------------------------
    -- todo: instantiate merge trees for load and store
    ---------------------------------------------------------------------------
    loadMerge : merge_tree
      generic map(g_mux_degree => c_mux_degree,
                  g_number_of_inputs => num_loads,
                  g_data_width => c_load_merge_data_width,
                  g_time_stamp_width => time_stamp_width,
                  g_num_stages => c_number_of_merge_stages,
                  g_port_id_width => c_load_port_id_width,
                  g_tag_width => tag_width)
      port map (merge_data_in  => load_merge_data_in(BANK),
                merge_req_in   => load_merge_from_port_req(BANK),
                merge_ack_out  => load_merge_to_port_ack(BANK),
                merge_data_out => load_merge_data_out((BANK+1)*c_load_merge_data_width-1 downto BANK*c_load_merge_data_width),
                merge_req_out  => load_merge_to_bank_req(BANK),
                merge_ack_in   => load_merge_from_bank_ack(BANK),
                clock => clock,
                reset => reset);

    ---------------------------------------------------------------------------
    -- store merge (from ports to bank)
    ---------------------------------------------------------------------------
    storeMerge : merge_tree
      generic map(g_mux_degree => c_mux_degree,
                  g_number_of_inputs => num_stores,
                  g_data_width => c_store_merge_data_width,
                  g_num_stages => c_number_of_merge_stages,
                  g_time_stamp_width => time_stamp_width,
                  g_port_id_width => c_store_port_id_width,
                  g_tag_width => tag_width)
      port map (merge_data_in => store_merge_data_in(BANK),
                merge_req_in => store_merge_from_port_req(BANK),
                merge_ack_out => store_merge_to_port_ack(BANK),
                merge_data_out => store_merge_data_out((BANK+1)*c_store_merge_data_width-1 downto BANK*c_store_merge_data_width),
                merge_req_out => store_merge_to_bank_req(BANK),
                merge_ack_in => store_merge_from_bank_ack(BANK),
                clock => clock,
                reset => reset);
    
    
    ---------------------------------------------------------------------------
    -- connections to memory bank
    ---------------------------------------------------------------------------

    -- write side
    bank_mem_write_addr(BANK) <= store_merge_data_out((BANK+1)*c_store_merge_data_width-1 downto
                                                      (BANK+1)*c_store_merge_data_width - bank_addr_width);
    bank_mem_write_data(BANK) <= store_merge_data_out((BANK+1)*c_store_merge_data_width-(bank_addr_width+1)
                                                      downto
                                                      (BANK+1)*c_store_merge_data_width -
                                                      (bank_addr_width + data_width));
    bank_mem_write_tag(BANK) <=
      store_merge_data_out(
        (BANK+1)*c_store_merge_data_width-(bank_addr_width+data_width+1) downto
        (BANK*c_store_merge_data_width));

    -- write handshake (push all the way)
    bank_mem_write_enable(BANK) <=  store_merge_to_bank_req(BANK);
    store_merge_from_bank_ack(BANK) <= bank_mem_write_ack(BANK);

    -- read side
    bank_mem_read_addr(BANK) <= load_merge_data_out((BANK+1)*c_load_merge_data_width-1 downto
                                                      (BANK+1)*c_load_merge_data_width - bank_addr_width);
    bank_mem_read_tag(BANK) <=
      load_merge_data_out(
        (BANK+1)*c_load_merge_data_width-(bank_addr_width+1) downto
        (BANK*c_load_merge_data_width));

    -- read handshake (push all the way)
    bank_mem_read_enable(BANK) <=  load_merge_to_bank_req(BANK);
    load_merge_from_bank_ack(BANK) <= bank_mem_read_ack(BANK);

                                                    
    memBank : memory_bank generic map (
      g_data_width       => data_width,
      g_read_tag_width        => tag_width+c_load_port_id_width+time_stamp_width,
      g_write_tag_width        => tag_width+c_store_port_id_width+time_stamp_width,
      g_addr_width    => bank_addr_width,
      g_time_stamp_width => time_stamp_width,
      g_base_bank_addr_width => base_bank_addr_width,
      g_base_bank_data_width => base_bank_data_width)
      port map (
        clk => clock,
        reset => reset,
        write_data => bank_mem_write_data(BANK),
        write_addr => bank_mem_write_addr(BANK),
        write_enable => bank_mem_write_enable(BANK),
        write_tag => bank_mem_write_tag(BANK),
        write_tag_out => bank_mem_write_tag_out(BANK),
        write_ack => bank_mem_write_ack(BANK),
        write_result_ready => bank_mem_write_result_ready(BANK),
        write_result_accept => bank_mem_write_result_accept(BANK),
        read_data => bank_mem_read_data(BANK),
        read_addr => bank_mem_read_addr(BANK),
        read_enable => bank_mem_read_enable(BANK),
        read_ack => bank_mem_read_ack(BANK),
        read_result_ready => bank_mem_read_result_ready(BANK),
        read_result_accept => bank_mem_read_result_accept(BANK),
        read_tag => bank_mem_read_tag(BANK),
        read_tag_out => bank_mem_read_tag_out(BANK));

    bank_mem_store_port_id_out(BANK) <= bank_mem_write_tag_out(BANK)(c_store_port_id_width + time_stamp_width-1 downto 
				time_stamp_width);
    bank_mem_store_tag_out(BANK) <=  bank_mem_write_tag_out(BANK)(c_store_port_id_width + time_stamp_width + tag_width-1 downto time_stamp_width + c_store_port_id_width); 

    ---------------------------------------------------------------------------
    -- connections to store demerge tree
    ---------------------------------------------------------------------------
    store_demerge_data_in((BANK+1)*c_store_demerge_data_width -1 downto (BANK*c_store_demerge_data_width))
      <= bank_mem_write_tag_out(BANK);

    bank_mem_write_result_accept(BANK) <= store_demerge_to_bank_ack(BANK);
    store_demerge_from_bank_req(BANK) <= bank_mem_write_result_ready(BANK);

    ---------------------------------------------------------------------------
    -- store demerge tree
    ---------------------------------------------------------------------------
    
    storeDemerge: demerge_tree
      generic map (g_demux_degree => c_demux_degree,
                   g_number_of_outputs => num_stores,
                   g_data_width => c_store_demerge_data_width,
                   g_id_width => c_store_port_id_width,
                   g_stage_id => 0)
      port map (demerge_data_out => store_demerge_data_out(BANK),
                demerge_ack_out => store_demerge_to_bank_ack(BANK),
                demerge_req_in => store_demerge_from_bank_req(BANK),
                demerge_data_in => store_demerge_data_in((BANK+1)*c_store_demerge_data_width-1 downto BANK*c_store_demerge_data_width),
                demerge_ready_out => store_demerge_to_port_req(BANK),
                demerge_accept_in =>  store_demerge_from_port_ack(BANK),
                demerge_sel_in => bank_mem_write_tag_out(BANK)(time_stamp_width+c_store_port_id_width-1 downto time_stamp_width),
                clock => clock,
                reset => reset);

    ---------------------------------------------------------------------------
    -- data/control connections to load demerge tree
    ---------------------------------------------------------------------------
    load_demerge_data_in((BANK+1)*c_load_demerge_data_width -1 downto (BANK*c_load_demerge_data_width))
      <= bank_mem_read_data(BANK) & bank_mem_read_tag_out(BANK);
    
    bank_mem_read_result_accept(BANK) <= load_demerge_to_bank_ack(BANK);
    load_demerge_from_bank_req(BANK) <= bank_mem_read_result_ready(BANK);
    
    ---------------------------------------------------------------------------
    -- load demerge tree
    ---------------------------------------------------------------------------
    loadDemerge: demerge_tree
      generic map (g_demux_degree => c_demux_degree,
                   g_number_of_outputs => num_loads,
                   g_data_width => c_load_demerge_data_width,
                   g_id_width => c_load_port_id_width,
                   g_stage_id => 0)
      port map (demerge_data_out => load_demerge_data_out(BANK),
                demerge_ack_out => load_demerge_to_bank_ack(BANK),
                demerge_req_in => load_demerge_from_bank_req(BANK),
                demerge_data_in => load_demerge_data_in((BANK+1)*c_load_demerge_data_width-1 downto BANK*c_load_demerge_data_width),
                demerge_ready_out => load_demerge_to_port_req(BANK),
                demerge_accept_in =>  load_demerge_from_port_ack(BANK),
                demerge_sel_in => bank_mem_read_tag_out(BANK)(time_stamp_width+c_load_port_id_width-1 downto time_stamp_width),
                clock => clock,
                reset => reset);

  end generate BankGen;
end pipelined;

library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.mem_function_pack.all;
use ahir.merge_functions.all;
use ahir.mem_component_pack.all;

-- memory subsystem guarantees that accesses to the same location
-- will take place in the order of the time-stamp assigned to each
-- access (tie breaks will be random). Time-stamp is set at the
-- point of acceptance of an access request.

entity memory_subsystem is
  generic(num_loads             : natural := 5;
          num_stores            : natural := 10;
          addr_width            : natural := 9;
          data_width            : natural := 5;
          tag_width             : natural := 7;
          number_of_banks       : natural := 1;
          mux_degree            : natural := 10;
          demux_degree          : natural := 10;
	  base_bank_addr_width  : natural := 8;
	  base_bank_data_width  : natural := 8);
  port(
    ------------------------------------------------------------------------------
    -- load request ports
    ------------------------------------------------------------------------------
    lr_addr_in : in std_logic_vector((num_loads*addr_width)-1 downto 0);

    -- req/ack pair:
    -- when both are asserted, time-stamp is set on load request.
    lr_req_in  : in  std_logic_vector(num_loads-1 downto 0);
    lr_ack_out : out std_logic_vector(num_loads-1 downto 0);

    -- tag for request, will be returned on completion.
    lr_tag_in : in std_logic_vector((num_loads*tag_width)-1 downto 0);

    ---------------------------------------------------------------------------
    -- load complete ports
    ---------------------------------------------------------------------------
    lc_data_out : out std_logic_vector((num_loads*data_width)-1 downto 0);

    -- req/ack pair:
    -- when both are asserted, user should latch data_out.
    lc_req_in  : in  std_logic_vector(num_loads-1 downto 0);
    lc_ack_out : out std_logic_vector(num_loads-1 downto 0);

    -- tag of completed request.
    lc_tag_out : out std_logic_vector((num_loads*tag_width)-1 downto 0);

    ------------------------------------------------------------------------------
    -- store request ports
    ------------------------------------------------------------------------------
    sr_addr_in : in std_logic_vector((num_stores*addr_width)-1 downto 0);
    sr_data_in : in std_logic_vector((num_stores*data_width)-1 downto 0);

    -- req/ack pair:
    -- when both are asserted, time-stamp is set on store request.
    sr_req_in  : in  std_logic_vector(num_stores-1 downto 0);
    sr_ack_out : out std_logic_vector(num_stores-1 downto 0);

    -- tag for request, will be returned on completion.
    sr_tag_in : in std_logic_vector((num_stores*tag_width)-1 downto 0);

    ---------------------------------------------------------------------------
    -- store complete ports
    ---------------------------------------------------------------------------
    -- req/ack pair:
    -- when both are asserted, user assumes that store is done.
    sc_req_in  : in  std_logic_vector(num_stores-1 downto 0);
    sc_ack_out : out std_logic_vector(num_stores-1 downto 0);

    -- tag of completed request.
    sc_tag_out : out std_logic_vector((num_stores*tag_width)-1 downto 0);

    ------------------------------------------------------------------------------
    -- clock, reset
    ------------------------------------------------------------------------------
    clock : in std_logic;  -- only rising edge is used to trigger activity.
    reset : in std_logic               -- active high.
    );
end entity memory_subsystem;


architecture bufwrap of memory_subsystem is

  constant time_stamp_width : natural := 2 + Ceil_Log2(num_loads + num_stores);   --  two msb bits for identification
  
  signal lr_addr_in_core :std_logic_vector((num_loads*addr_width)-1 downto 0);
  signal lr_req_in_core  :std_logic_vector(num_loads-1 downto 0);
  signal lr_ack_out_core :std_logic_vector(num_loads-1 downto 0);
  signal lr_tag_in_core :std_logic_vector((num_loads*tag_width)-1 downto 0);
  signal lr_time_stamp_in_core :std_logic_vector((num_loads*time_stamp_width)-1 downto 0);  

  signal sr_addr_in_core :std_logic_vector((num_stores*addr_width)-1 downto 0);
  signal sr_data_in_core :std_logic_vector((num_stores*data_width)-1 downto 0);
  signal sr_req_in_core  : std_logic_vector(num_stores-1 downto 0);
  signal sr_ack_out_core : std_logic_vector(num_stores-1 downto 0);
  signal sr_tag_in_core :std_logic_vector((num_stores*tag_width)-1 downto 0);
  signal sr_time_stamp_in_core :std_logic_vector((num_stores*time_stamp_width)-1 downto 0);
  

  type LoadRepeaterData is array (natural range <> ) of std_logic_vector(time_stamp_width+addr_width+tag_width - 1 downto 0);
  type StoreRepeaterData is array (natural range <> ) of std_logic_vector(time_stamp_width+data_width+addr_width+tag_width - 1 downto 0);
  signal load_repeater_data_in, load_repeater_data_out: LoadRepeaterData(0 to num_loads-1);
  signal store_repeater_data_in, store_repeater_data_out: StoreRepeaterData(0 to num_stores-1);

  signal raw_time_stamp: std_logic_vector(time_stamp_width-1 downto 0);

begin

  -----------------------------------------------------------------------------
  -- time-stamp generation
  -----------------------------------------------------------------------------

  process(clock,reset)
  begin

    if clock'event and clock = '1' then
      if(reset = '1') then
        raw_time_stamp <= (others => '0');
      else
        raw_time_stamp <= IncrementSLV(raw_time_stamp);
      end if;
    end if;
  end process;

  -- instantiate repeaters for each load and store input
  LoadRepGen: for LOAD in 0 to num_loads-1 generate

    load_repeater_data_in(LOAD) <= raw_time_stamp &
                                   lr_addr_in((LOAD+1)*addr_width-1 downto LOAD*addr_width) &
                                   lr_tag_in((LOAD+1)*tag_width - 1 downto LOAD*tag_width);

    lr_time_stamp_in_core((LOAD+1)*time_stamp_width -1 downto LOAD*time_stamp_width) <=
      load_repeater_data_out(LOAD)(time_stamp_width+addr_width+tag_width-1 downto addr_width+tag_width);
    
    lr_addr_in_core((LOAD+1)*addr_width -1 downto LOAD*addr_width) <=
      load_repeater_data_out(LOAD)(addr_width+tag_width-1 downto tag_width);
    lr_tag_in_core((LOAD+1)*tag_width-1 downto LOAD*tag_width) <= load_repeater_data_out(LOAD)(tag_width-1 downto 0);
    
    Rptr : mem_shift_repeater generic map (
      g_data_width => time_stamp_width+ addr_width + tag_width,
	g_number_of_stages => 0)
      port map (
        clk      => clock,
        reset    => reset,
        data_in  => load_repeater_data_in(LOAD),
        req_in   => lr_req_in(LOAD),
        ack_out  => lr_ack_out(LOAD),
        data_out => load_repeater_data_out(LOAD),
        req_out  => lr_req_in_core(LOAD),
        ack_in   => lr_ack_out_core(LOAD));
    
  end generate LoadRepGen;


  StoreRepGen: for STORE in 0 to num_stores-1 generate
    store_repeater_data_in(STORE) <= raw_time_stamp &
                                     sr_data_in((STORE+1)*data_width-1 downto STORE*data_width) &
                                     sr_addr_in((STORE+1)*addr_width-1 downto STORE*addr_width) &
                                     sr_tag_in((STORE+1)*tag_width - 1 downto STORE*tag_width);

    sr_time_stamp_in_core((STORE+1)*time_stamp_width -1 downto STORE*time_stamp_width) <=
      store_repeater_data_out(STORE)(time_stamp_width+data_width+addr_width+tag_width-1 downto data_width+addr_width+tag_width);
    sr_data_in_core((STORE+1)*data_width -1 downto STORE*data_width) <=
          store_repeater_data_out(STORE)(data_width+addr_width+tag_width-1 downto addr_width+tag_width);
    sr_addr_in_core((STORE+1)*addr_width -1 downto STORE*addr_width) <=
      store_repeater_data_out(STORE)(addr_width+tag_width-1 downto tag_width);
    sr_tag_in_core((STORE+1)*tag_width-1 downto STORE*tag_width) <= store_repeater_data_out(STORE)(tag_width-1 downto 0);
    
    Rptr : mem_shift_repeater generic map (
      g_data_width => time_stamp_width+data_width + addr_width + tag_width,
      g_number_of_stages => 0)
      port map (
        clk      => clock,
        reset    => reset,
        data_in  => store_repeater_data_in(STORE),
        req_in   => sr_req_in(STORE),
        ack_out  => sr_ack_out(STORE),
        data_out => store_repeater_data_out(STORE),
        req_out  => sr_req_in_core(STORE),
        ack_in   => sr_ack_out_core(STORE));
    
  end generate StoreRepGen;

  core: memory_subsystem_core
    generic map (
      num_loads            => num_loads,
      num_stores           => num_stores,
      addr_width           => addr_width,
      data_width           => data_width,
      tag_width            => tag_width,
      time_stamp_width     => time_stamp_width,
      number_of_banks      => number_of_banks,
      mux_degree           => mux_degree,
      demux_degree         => demux_degree,
      base_bank_addr_width => base_bank_addr_width,
      base_bank_data_width => base_bank_data_width)
    port map (
      lr_addr_in  => lr_addr_in_core,
      lr_req_in   => lr_req_in_core,
      lr_ack_out  => lr_ack_out_core,
      lr_tag_in   => lr_tag_in_core,
      lr_time_stamp_in => lr_time_stamp_in_core,
      lc_data_out => lc_data_out,
      lc_req_in   => lc_req_in,
      lc_ack_out  => lc_ack_out,
      lc_tag_out  => lc_tag_out,
      sr_addr_in  => sr_addr_in_core,
      sr_data_in  => sr_data_in_core,
      sr_req_in   => sr_req_in_core,
      sr_ack_out  => sr_ack_out_core,
      sr_tag_in   => sr_tag_in_core,
      sr_time_stamp_in => sr_time_stamp_in_core,      
      sc_ack_out  => sc_ack_out,
      sc_req_in   => sc_req_in,
      sc_tag_out  => sc_tag_out,
      clock       => clock,
      reset       => reset);    
end bufwrap;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- effectively a two entry queue.
-- used to break combinational paths
-- at the cost of a single cycle delay from input
-- to output.
entity mem_repeater is
    generic(g_data_width: integer := 32);
    port(clk: in std_logic;
       reset: in std_logic;
       data_in: in std_logic_vector(g_data_width-1 downto 0);
       req_in: in std_logic;
       ack_out : out std_logic;
       data_out: out std_logic_vector(g_data_width-1 downto 0);
       req_out : out std_logic;
       ack_in: in std_logic);
end entity mem_repeater;

architecture behave of mem_repeater is

  signal stage0, stage1: std_logic_vector(g_data_width-1 downto 0);
  signal top_pointer, bottom_pointer : std_logic;
  
  signal queue_size : unsigned(1 downto 0);

  signal queue_full_sig, queue_empty_sig: std_logic;
  signal incr_q_size, decr_q_size : std_logic;
  
begin  -- SimModel

  queue_full_sig <= '1' when queue_size = 2 else '0';
  queue_empty_sig <= '1' when queue_size = 0 else '0';

  -- size manipulation
  process(clk)
  begin
    if(clk'event and clk = '1') then
      if(reset = '1') then
        queue_size <= (others => '0');
        top_pointer <= '0';
        bottom_pointer <= '0';
      else

        if(incr_q_size = '1' and (decr_q_size = '0')) then
          queue_size <= queue_size + 1;
        elsif((incr_q_size = '0') and decr_q_size = '1') then
          queue_size <= queue_size - 1;
        end if;

        -- increment mod 2
        if(incr_q_size = '1') then
          top_pointer <= not top_pointer;
        end if;

        -- increment mod 2
        if(decr_q_size = '1') then
          bottom_pointer <= not bottom_pointer;
        end if;
      end if;
    end if;
  end process;

  ack_out <= incr_q_size;
  incr_q_size <= req_in and (not queue_full_sig);
  
  -- write
  process(clk)
  begin
    if(clk'event and clk = '1') then
      if incr_q_size = '1' then
        if(top_pointer = '1') then
          stage1 <= data_in;
        else
          stage0 <= data_in;
        end if;
      end if;
    end if;
  end process;

  decr_q_size <= (not queue_empty_sig) and  ack_in;
  req_out     <= (not queue_empty_sig);
  
  data_out <= stage1 when bottom_pointer = '1' else stage0;

end behave;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.mem_component_pack.all;

entity mem_shift_repeater is
    generic(g_data_width: integer := 32; g_number_of_stages: natural := 16);
    port(clk: in std_logic;
       reset: in std_logic;
       data_in: in std_logic_vector(g_data_width-1 downto 0);
       req_in: in std_logic;
       ack_out : out std_logic;
       data_out: out std_logic_vector(g_data_width-1 downto 0);
       req_out : out std_logic;
       ack_in: in std_logic);
end entity mem_shift_repeater;

architecture behave of mem_shift_repeater is

  type DataArray is array (natural range <>) of std_logic_vector(g_data_width-1 downto 0);
  signal idata : DataArray(0 to g_number_of_stages);
  signal ireq,iack : std_logic_vector(0 to g_number_of_stages);

begin  -- SimModel

  idata(0) <= data_in;
  ireq(0)  <= req_in;
  ack_out <= iack(0);

  data_out <= idata(g_number_of_stages);
  req_out <= ireq(g_number_of_stages);
  iack(g_number_of_stages) <= ack_in;

  ifGen: if g_number_of_stages > 0 generate

    RepGen: for I in 0 to g_number_of_stages-1 generate
      rptr : mem_repeater generic map (
        g_data_width => g_data_width)
        port map (
          clk      => clk,
          reset    => reset,
          data_in  => idata(I),
          req_in   => ireq(I),
          ack_out  => iack(I),
          data_out => idata(I+1),
          req_out  => ireq(I+1),
          ack_in   => iack(I+1));
    end generate RepGen;
  end generate ifGen; 

end behave;
library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.mem_function_pack.all;
use ahir.merge_functions.all;
use ahir.mem_component_pack.all;
-- TODO: some bug here.

entity merge_box_with_repeater is 
  generic (g_data_width: natural := 10;
           g_number_of_inputs: natural := 8;
           g_number_of_outputs: natural := 1;
           g_time_stamp_width : natural := 3;   -- width of timestamp
           g_tag_width : natural := 3;  -- width of tag
           g_pipeline_flag: integer := 1     -- if 0, dont add pipe-line stage
           );            

  port(data_left: in  std_logic_vector((g_data_width*g_number_of_inputs)-1 downto 0);
       req_in : in std_logic_vector(g_number_of_inputs-1 downto 0);
       ack_out : out std_logic_vector(g_number_of_inputs-1 downto 0);
       data_right: out std_logic_vector((g_data_width*g_number_of_outputs)-1 downto 0);
       req_out : out std_logic_vector(g_number_of_outputs-1 downto 0);
       ack_in : in std_logic_vector(g_number_of_outputs-1 downto 0);
       clock: in std_logic;
       reset: in std_logic);

end merge_box_with_repeater;

architecture behave of merge_box_with_repeater is

  constant c_actual_data_width  : natural := g_data_width - g_time_stamp_width;
  constant c_num_inputs_per_tree : natural := Ceiling(g_number_of_inputs,g_number_of_outputs);
  constant c_residual_num_inputs_per_tree : natural := (g_number_of_inputs - ((g_number_of_outputs-1)*c_num_inputs_per_tree));
  
  signal in_data : std_logic_vector((c_actual_data_width*g_number_of_inputs)-1 downto 0);
  signal in_tstamp : std_logic_vector((g_time_stamp_width*g_number_of_inputs)-1 downto 0);
  signal in_req,in_ack : std_logic_vector(g_number_of_inputs-1 downto 0);
  signal out_req,out_ack : std_logic_vector(g_number_of_outputs-1 downto 0);
  signal out_data : std_logic_vector((g_number_of_outputs*c_actual_data_width)-1 downto 0);
  signal out_tstamp : std_logic_vector((g_number_of_outputs*g_time_stamp_width)-1 downto 0);
  
  signal repeater_in, repeater_out : std_logic_vector((g_number_of_outputs*g_data_width)-1 downto 0);
  signal repeater_in_req,repeater_in_ack,repeater_out_req,repeater_out_ack : std_logic_vector(g_number_of_outputs-1 downto 0);

  function RepeaterShiftDelay (constant x : integer)
    return integer is
    variable ret_var :integer;
  begin
    ret_var := 0;
    if(x > 0) then
      ret_var := 1;
    end if;
    return(ret_var);
  end RepeaterShiftDelay;
  constant shift_delay : integer := RepeaterShiftDelay(g_pipeline_flag);
  
begin  -- behave

  assert g_number_of_inputs > 0 and g_number_of_outputs > 0 report "at least one i/p and o/p needed in merge-box with repeater" severity error;
  
  -- unpack input-side signals.
  genIn: for I in 0 to g_number_of_inputs-1 generate
    in_data((c_actual_data_width*(I+1))-1 downto (c_actual_data_width*I)) <=
      data_left((g_data_width*(I+1) -1) downto ((g_data_width*(I+1))-c_actual_data_width));
    in_tstamp((g_time_stamp_width*(I+1))-1 downto (g_time_stamp_width*I)) <=
      data_left(((g_data_width*(I+1) - c_actual_data_width) - 1) downto (g_data_width*I));
    in_req(I) <= req_in(I);
    ack_out(I) <= in_ack(I);
  end generate genIn;

  -- unpack output side signals.
  genOut: for I in 0 to g_number_of_outputs-1 generate
    repeater_in((g_data_width)*(I+1)-1 downto ((g_data_width)*I))
      <= out_data((c_actual_data_width*(I+1))-1 downto (c_actual_data_width*I)) &
           out_tstamp((g_time_stamp_width*(I+1))-1 downto (g_time_stamp_width*I));

    repeater_in_req(I) <= out_req(I);
    out_ack(I) <= repeater_in_ack(I);
    
    data_right((g_data_width*(I+1))-1 downto (g_data_width*I)) <=
          repeater_out((g_data_width)*(I+1)-1 downto ((g_data_width)*I));
    req_out(I) <= repeater_out_req(I);
    repeater_out_ack(I) <= ack_in(I);
  end generate genOut;

  -- now instantiate the comb.merge block followed by the
  -- repeater.
  ifgen: if g_number_of_outputs > 1 generate
    
    genLogic: for J in 0 to g_number_of_outputs-2 generate

      cmerge: combinational_merge
        generic map(g_data_width        => c_actual_data_width,
                    g_number_of_inputs  => c_num_inputs_per_tree,
                    g_time_stamp_width  => g_time_stamp_width)
        port map(in_data    => in_data    (((J+1)*c_num_inputs_per_tree*c_actual_data_width)-1
                                           downto
                                           (J*c_num_inputs_per_tree*c_actual_data_width)),
                 in_tstamp  => in_tstamp  (((J+1)*c_num_inputs_per_tree*g_time_stamp_width)-1
                                           downto
                                           (J*c_num_inputs_per_tree*g_time_stamp_width)),
                 out_data   => out_data   ((J+1)*(c_actual_data_width)-1 downto (J*c_actual_data_width)),
                 out_tstamp => out_tstamp ((J+1)*(g_time_stamp_width)-1 downto (J*g_time_stamp_width)),
                 in_req     => in_req     (((J+1)*c_num_inputs_per_tree)-1 downto (J*c_num_inputs_per_tree)),
                 in_ack     => in_ack     (((J+1)*c_num_inputs_per_tree)-1 downto (J*c_num_inputs_per_tree)),
                 out_req    => out_req    (J),
                 out_ack    => out_ack    (J));

      Rptr: mem_shift_repeater generic map(g_data_width => g_data_width, g_number_of_stages => shift_delay)
        port map(clk      => clock,
                 reset    => reset,
                 data_in  => repeater_in      ((J+1)*(g_data_width) -1 downto (J*(g_data_width))),
                 req_in   => repeater_in_req  (J),
                 ack_out  => repeater_in_ack  (J),
                 data_out => repeater_out     ((J+1)*(g_data_width) -1 downto (J*(g_data_width))),
                 req_out  => repeater_out_req (J),
                 ack_in   => repeater_out_ack (J));
      
    end generate genLogic;
  end generate ifgen;


  -- residual block
  cmerge: combinational_merge
    generic map(g_data_width        => c_actual_data_width,
                g_number_of_inputs  => c_residual_num_inputs_per_tree,
                g_time_stamp_width  => g_time_stamp_width)
    port map(in_data    => in_data    ((g_number_of_inputs*c_actual_data_width-1) downto
                                       ((g_number_of_inputs*c_actual_data_width) -
                                        (c_residual_num_inputs_per_tree*c_actual_data_width))),
             in_tstamp  => in_tstamp  ((g_number_of_inputs*g_time_stamp_width-1) downto
                                       ((g_number_of_inputs*g_time_stamp_width) -
                                        (c_residual_num_inputs_per_tree*g_time_stamp_width))),
             out_data   => out_data   ((g_number_of_outputs)*(c_actual_data_width)-1 downto
                                       ((g_number_of_outputs-1)*c_actual_data_width)),
             out_tstamp => out_tstamp ((g_number_of_outputs)*(g_time_stamp_width)-1 downto
                                       ((g_number_of_outputs-1)*g_time_stamp_width)),
             in_req     => in_req     (g_number_of_inputs-1 downto
                                       (g_number_of_inputs - c_residual_num_inputs_per_tree)),
             in_ack     => in_ack     (g_number_of_inputs-1 downto
                                       (g_number_of_inputs - c_residual_num_inputs_per_tree)),
             out_req    => out_req    (g_number_of_outputs-1),
             out_ack    => out_ack    (g_number_of_outputs-1));

  -- residual repeater
  Rptr: mem_shift_repeater generic map(g_data_width => g_data_width, g_number_of_stages => shift_delay)
    port map(clk      => clock,
             reset    => reset,
             data_in  => repeater_in      ((g_number_of_outputs)*(g_data_width) -1 downto ((g_number_of_outputs-1)*(g_data_width))),
             req_in   => repeater_in_req  (g_number_of_outputs-1),
             ack_out  => repeater_in_ack  (g_number_of_outputs-1),
             data_out => repeater_out     ((g_number_of_outputs)*(g_data_width) -1 downto ((g_number_of_outputs-1)*(g_data_width))),
             req_out  => repeater_out_req (g_number_of_outputs-1),
             ack_in   => repeater_out_ack (g_number_of_outputs-1));

end behave;
library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.mem_function_pack.all;
use ahir.merge_functions.all;
use ahir.mem_component_pack.all;

entity merge_tree is
  generic (
    g_number_of_inputs: natural;          
    g_data_width: natural;          -- total width of data
                                        -- (= actual-data & timestamp)
    g_time_stamp_width : natural ;   -- width of timestamp
    g_tag_width : natural;          -- width of tag
    g_mux_degree :natural;         -- max-indegree of each pipeline-stage
    g_num_stages: natural ;
    g_port_id_width: natural
    );       

  port (
    merge_data_in : in std_logic_vector((g_data_width*g_number_of_inputs)-1 downto 0);
    merge_req_in  : in std_logic_vector(g_number_of_inputs-1 downto 0);
    merge_ack_out : out std_logic_vector(g_number_of_inputs-1 downto 0);
    merge_data_out: out std_logic_vector(g_data_width-1 downto 0);
    merge_req_out : out std_logic;
    merge_ack_in  : in std_logic;
    clock: in std_logic;
    reset: in std_logic);
  
end merge_tree;


architecture pipelined of merge_tree is
  constant c_number_of_stages : integer := Maximum(1,Ceil_Log(g_number_of_inputs, g_mux_degree));
  constant c_residual_num_stages : integer := Maximum(0,g_num_stages - c_number_of_stages);
  constant c_total_intermediate_width : natural := Total_Intermediate_Width(g_number_of_inputs,g_mux_degree);

  -- intermediate signals used to cross levels.
  signal intermediate_vector : std_logic_vector(0 to ((g_data_width)*c_total_intermediate_width)-1);  
  signal intermediate_req_vector : std_logic_vector(0 to (c_total_intermediate_width)-1);
  signal intermediate_ack_vector : std_logic_vector(0 to (c_total_intermediate_width)-1);

begin  -- behave
  assert g_num_stages >= c_number_of_stages report "requested number of stages should be >= number of stages implied by mux-degree" severity error;
  assert Stage_Width(c_number_of_stages,g_mux_degree, g_number_of_inputs) = 1 report "last stage should have one input!" severity error;
  
  intermediate_vector(
    Left_Index(0,g_mux_degree,g_number_of_inputs)*g_data_width to
    ((Right_Index(0,g_mux_degree,g_number_of_inputs)+1)*g_data_width)-1)
    <= merge_data_in;

  intermediate_req_vector(
    Left_Index(0,g_mux_degree,g_number_of_inputs) to
    Right_Index(0,g_mux_degree,g_number_of_inputs))
    <= merge_req_in;

  merge_ack_out <=
    intermediate_ack_vector(
      Left_Index(0,g_mux_degree,g_number_of_inputs) to
      Right_Index(0,g_mux_degree,g_number_of_inputs));

  PipelineGen:  for LEVEL  in 0 to c_number_of_stages-1  generate

    -- mbox with repeater has multiple outputs, with tree driving
    -- each output and repeater present at each output.
    mBoxPipeStage : merge_box_with_repeater generic map (
      g_data_width => g_data_width,
      g_number_of_inputs => Stage_Width(LEVEL,g_mux_degree,g_number_of_inputs),
      g_number_of_outputs => Stage_Width(LEVEL+1,g_mux_degree,g_number_of_inputs),
      g_time_stamp_width => g_time_stamp_width,
      g_tag_width => g_tag_width,
      g_pipeline_flag => c_number_of_stages-1 )
      port map ( data_left =>
                 intermediate_vector(
                   Left_Index(LEVEL,g_mux_degree,g_number_of_inputs)*g_data_width to
                   ((Right_Index(LEVEL,g_mux_degree,g_number_of_inputs)+1)*g_data_width)-1),
                 req_in =>
                 intermediate_req_vector(
                   Left_Index(LEVEL,g_mux_degree,g_number_of_inputs) to
                   Right_Index(LEVEL,g_mux_degree,g_number_of_inputs)),
                 ack_out =>
                   intermediate_ack_vector(
                     Left_Index(LEVEL,g_mux_degree,g_number_of_inputs) to
                     Right_Index(LEVEL,g_mux_degree,g_number_of_inputs)),
                 data_right =>
                 intermediate_vector(
                   Left_Index(LEVEL+1,g_mux_degree,g_number_of_inputs)*g_data_width to
                   ((Right_Index(LEVEL+1,g_mux_degree,g_number_of_inputs)+1)*g_data_width)-1),
                 req_out =>
                 intermediate_req_vector(
                   Left_Index(LEVEL+1,g_mux_degree,g_number_of_inputs) to
                   Right_Index(LEVEL+1,g_mux_degree,g_number_of_inputs)),
                 ack_in =>
                   intermediate_ack_vector(
                     Left_Index(LEVEL+1,g_mux_degree,g_number_of_inputs) to
                     Right_Index(LEVEL+1,g_mux_degree,g_number_of_inputs)),
                 clock => clock,
                 reset => reset);
                   
  end generate;  -- PipelineGen

  -- to the right (pad the required number of shifts)
  finalRptr : mem_shift_repeater generic map (
    g_data_width => g_data_width,
    g_number_of_stages => c_residual_num_stages)
    port map (
      clk     => clock,
      reset   => reset,
      data_in => intermediate_vector(
        Left_Index(c_number_of_stages,g_mux_degree,g_number_of_inputs)*g_data_width to
        ((Right_Index(c_number_of_stages,g_mux_degree,g_number_of_inputs)+1)*g_data_width)-1),
      req_in => intermediate_req_vector(Left_Index(c_number_of_stages,g_mux_degree, g_number_of_inputs)),
      ack_out =>   intermediate_ack_vector(Left_Index(c_number_of_stages,g_mux_degree, g_number_of_inputs)),
      data_out => merge_data_out,
      req_out => merge_req_out,
      ack_in => merge_ack_in);
end pipelined;

-- architecture combinational of merge_tree is
--   constant actual_data_width : natural := g_data_width - (g_time_stamp_width);
--   signal data_sig : std_logic_vector(g_number_of_inputs*actual_data_width-1 downto 0);

--   signal out_data_sig : std_logic_vector(actual_data_width-1 downto 0);
--   signal out_tstamp_sig : std_logic_vector(g_time_stamp_width-1 downto 0);
--   signal tstamp_sig : std_logic_vector(g_number_of_inputs*g_time_stamp_width -1  downto 0);
  
-- begin  -- combinational
--   assert g_data_width > g_time_stamp_width report "data width smaller than time-stamp in merge?" severity error;
--   packGen: for P in 0 to g_number_of_inputs-1 generate
--     data_sig((P+1)*actual_data_width-1 downto P*actual_data_width) <=
--       merge_data_in((P+1)*g_data_width-1 downto (P+1)*g_data_width - (actual_data_width));
--     tstamp_sig((P+1)*g_time_stamp_width-1 downto P*g_time_stamp_width) <=
--       merge_data_in((P*g_data_width)+g_time_stamp_width-1 downto P*g_data_width);
--   end generate packGen;

--   cMerge : combinational_merge generic map (
--     g_data_width       => actual_data_width,
--     g_number_of_inputs => g_number_of_inputs,
--     g_time_stamp_width => g_time_stamp_width)
--     port map (
--       in_data    => data_sig,
--       out_data   => out_data_sig,
--       in_tstamp  => tstamp_sig,
--       out_tstamp => out_tstamp_sig,
--       in_req     => merge_req_in,
--       in_ack     => merge_ack_out,
--       out_req    => merge_req_out,
--       out_ack    => merge_ack_in);

--   merge_data_out <= out_data_sig & out_tstamp_sig;
-- end combinational;
  
library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.mem_function_pack.all;
use ahir.merge_functions.all;
use ahir.mem_component_pack.all;

-------------------------------------------------------------------------------
-- a simplified version of the memory subsystem to be used
-- when the number of storage locations is small..
--
-- this is equivalent to a num_loads read-port, num_stores write_port
-- register bank.
-------------------------------------------------------------------------------

entity register_bank is
  generic(num_loads             : natural := 5;
          num_stores            : natural := 10;
          addr_width            : natural := 9;
          data_width            : natural := 5;
          tag_width             : natural := 7;
          num_registers         : natural := 1);
  port(
    ------------------------------------------------------------------------------
    -- load request ports
    ------------------------------------------------------------------------------
    lr_addr_in : in std_logic_vector((num_loads*addr_width)-1 downto 0);

    -- req/ack pair:
    -- when both are asserted, time-stamp is set on load request.
    lr_req_in  : in  std_logic_vector(num_loads-1 downto 0);
    lr_ack_out : out std_logic_vector(num_loads-1 downto 0);

    -- tag for request, will be returned on completion.
    lr_tag_in : in std_logic_vector((num_loads*tag_width)-1 downto 0);

    ---------------------------------------------------------------------------
    -- load complete ports
    ---------------------------------------------------------------------------
    lc_data_out : out std_logic_vector((num_loads*data_width)-1 downto 0);

    -- req/ack pair:
    -- when both are asserted, user should latch data_out.
    lc_req_in  : in  std_logic_vector(num_loads-1 downto 0);
    lc_ack_out : out std_logic_vector(num_loads-1 downto 0);

    -- tag of completed request.
    lc_tag_out : out std_logic_vector((num_loads*tag_width)-1 downto 0);

    ------------------------------------------------------------------------------
    -- store request ports
    ------------------------------------------------------------------------------
    sr_addr_in : in std_logic_vector((num_stores*addr_width)-1 downto 0);
    sr_data_in : in std_logic_vector((num_stores*data_width)-1 downto 0);

    -- req/ack pair:
    -- when both are asserted, time-stamp is set on store request.
    sr_req_in  : in  std_logic_vector(num_stores-1 downto 0);
    sr_ack_out : out std_logic_vector(num_stores-1 downto 0);

    -- tag for request, will be returned on completion.
    sr_tag_in : in std_logic_vector((num_stores*tag_width)-1 downto 0);

    ---------------------------------------------------------------------------
    -- store complete ports
    ---------------------------------------------------------------------------
    -- req/ack pair:
    -- when both are asserted, user assumes that store is done.
    sc_req_in  : in  std_logic_vector(num_stores-1 downto 0);
    sc_ack_out : out std_logic_vector(num_stores-1 downto 0);

    -- tag of completed request.
    sc_tag_out : out std_logic_vector((num_stores*tag_width)-1 downto 0);

    ------------------------------------------------------------------------------
    -- clock, reset
    ------------------------------------------------------------------------------
    clock : in std_logic;  -- only rising edge is used to trigger activity.
    reset : in std_logic               -- active high.
    );
end entity register_bank;


-- architecture: synchronous R/W.
--               on destination conflict, writer with lowest index wins.
architecture Default of register_bank is
  type DataArray is array (natural range <>) of std_logic_vector(data_width-1 downto 0);
  type AddrArray is array (natural range <>) of std_logic_vector(addr_width-1 downto 0);

  signal register_array : DataArray(num_registers-1 downto 0) := (others => (others => '0'));

  signal lr_ack_flag: std_logic_vector(num_loads-1 downto 0);
  signal sr_ack_flag : std_logic_vector(num_stores-1 downto 0);
  
  signal lc_ack_flag : std_logic_vector(num_loads-1 downto 0);
  signal sc_ack_flag : std_logic_vector(num_stores-1 downto 0);

  signal lc_data_out_sig : std_logic_vector((num_loads*data_width)-1 downto 0);
  signal sc_tag_out_sig : std_logic_vector((num_stores*tag_width)-1 downto 0);
  signal lc_tag_out_sig : std_logic_vector((num_loads*tag_width)-1 downto 0);

  constant zero_addr : std_logic_vector(addr_width-1 downto 0) := (others => '0');
                                                                 
    
begin

  assert(2**addr_width >= num_registers) report "not enough address bits" severity failure;


  -- the read process. fully parallel reads.
  ReadGen: for R in 0 to num_loads-1 generate

    process(clock,lr_req_in,lc_ack_flag,reset,lr_addr_in)
      variable ack_var : std_logic;
      variable index : integer;
                                 
    begin
      ack_var := '0';
      index := 0;
      
      if(lr_req_in(R) = '1') then
        index := To_Integer(lr_addr_in(((R+1)*addr_width)-1 downto R*addr_width));
      end if;
      
      if(lr_req_in(R) = '1' and lc_ack_flag(R) = '0') then
        ack_var := '1';
      end if;
      
      lr_ack_out(R) <= ack_var;
      
      if(clock'event and clock = '1') then
        if(ack_var = '1') then
          assert (index < num_registers) report "index overflow." severity error;
          assert (index >= 0) report "index underflow" severity error;
          
          lc_data_out_sig(((R+1)*data_width)-1 downto R*data_width) <= register_array(index);
          lc_tag_out_sig(((R+1)*tag_width)-1 downto R*tag_width) <=
            lr_tag_in(((R+1)*tag_width)-1 downto R*tag_width);
          
        end if;
        
        if(reset = '1') then
          lc_ack_flag(R) <= '0';
        else
          if(ack_var = '1') then
            lc_ack_flag(R) <= '1';
          elsif lc_ack_flag(R) = '1' and lc_req_in(R) = '1' then
            lc_ack_flag(R) <= '0';
          end if;
        end if;
      end if;
    end process;
    
  end generate ReadGen;
  
  -- the write process
  -- for each register. loop across those who want to write in
  -- and find the lowest index which wins.
  process(clock,
	  reset,
          sr_req_in,
          sr_addr_in,
          sr_data_in,
          sr_tag_in,
          sc_req_in,
          sc_ack_flag,
	  sc_tag_out_sig,
          register_array)
    
    variable sc_ack_set, sc_ack_clear: std_logic_vector(num_stores-1 downto 0);
    variable sr_pending : std_logic_vector(num_registers-1 downto 0);
    
    variable sc_tag_out_var : std_logic_vector((num_stores*tag_width)-1 downto 0);
    variable register_array_var : DataArray(num_registers-1 downto 0);
    
  begin


    sc_ack_set := (others => '0');
    sc_ack_clear := (others => '0');
    sr_pending := (others => '0');

    sc_tag_out_var := sc_tag_out_sig;

    register_array_var := register_array;
    
    
    if(reset = '1') then
      sc_ack_clear := (others => '1');
    end if;
      
    -- for each register.
    for REG  in 0 to num_registers-1 loop
      
      -- writes: for each reg, lowest index succeeds.
      for W in 0 to num_stores-1 loop
        
        -- if W is a store request to this register
        -- and no j
        if(sr_pending(REG) = '0' and
           sr_req_in(W) = '1' and
           sc_ack_flag(W) = '0' and 
           (sr_addr_in(((W+1)*addr_width)-1 downto W*addr_width) = Natural_To_SLV(REG,addr_width)))
        then
          sr_pending(REG) := '1';
          sc_ack_set(W) := '1';
          register_array_var(REG) := sr_data_in(((W+1)*data_width)-1 downto W*data_width);
          sc_tag_out_var(((W+1)*tag_width)-1 downto W*tag_width) :=
            sr_tag_in(((W+1)*tag_width)-1 downto W*tag_width);
          
          exit;
        end if;
      end loop;  -- W
    end loop;  -- REG
    
    -- output latches and registers
    if(clock'event and clock = '1') then
      register_array <= register_array_var;
      sc_tag_out_sig <= sc_tag_out_var;
    end if;
  
    -- lc/sc ack clears.
    if(clock'event and clock = '1') then                
      for W in 0 to num_stores-1 loop
        
        -- if ack and req are both asserted, clear
        -- it unless asked to set it.
        if(sc_ack_flag(W) = '1' and sc_req_in(W) = '1') then
          sc_ack_clear(W) := '1';
        end if;
        
        -- set dominant!
        if(sc_ack_set(W) = '1') then
          sc_ack_flag(W) <= '1';
        elsif (sc_ack_clear(W) = '1') then
          sc_ack_flag(W) <= '0';
        end if;
      end loop;
    end if;      

    sr_ack_out <= sc_ack_set;
  end process;

  sc_ack_out <= sc_ack_flag;
  lc_ack_out <= lc_ack_flag;
  lc_data_out <= lc_data_out_sig;
  lc_tag_out <= lc_tag_out_sig;
  sc_tag_out <= sc_tag_out_sig;
  
end Default;

library ieee;
use ieee.std_logic_1164.all;

-- on reset, trigger an AHIR module, and keep
-- retriggering it..
entity auto_run is
  generic (
    use_delay : boolean := true);
  port (clk   : in  std_logic;
    	reset : in  std_logic;
	start_req: out std_logic;
        start_ack: in std_logic;
        fin_req: out std_logic;
        fin_ack: in std_logic);
end auto_run;

architecture default_arch of auto_run is

begin  

  start_req <= '1';
  fin_req <= '1';

end default_arch;
library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
entity control_delay_element is
  generic (delay_value: integer := 0);
  port (
    req   : in Boolean;
    ack   : out Boolean;
    clk   : in  std_logic;
    reset : in  std_logic);

end control_delay_element;

architecture default_arch of control_delay_element is

  signal delay_count : integer range 0 to delay_value;
  signal state_sig : std_logic;
  
begin  -- default_arch

  ZeroDelay: if delay_value <= 0 generate
    ack <= req;
  end generate ZeroDelay;


  NonZeroDelay: if delay_value > 0 generate

    process(clk,state_sig,delay_count)
      variable next_state_sig : std_logic;
      variable incr_count : Boolean;
      variable ack_var : Boolean;
      variable next_delay_var : integer range 0 to delay_value;
      
    begin

      next_state_sig := state_sig;
      ack_var := false;
      next_delay_var := 0;
      
      if(reset = '1') then
        next_state_sig := '0';
      else
        case state_sig is
          when '0' =>
            if req  then
              next_state_sig := '1';
            end if;
          when others =>
            if(delay_count = delay_value-1) then
              ack_var := true;
              next_state_sig := '0';
            else
              next_delay_var := delay_count + 1;
            end if;
        end case;
      end if;

      ack <= ack_var;
      if(clk'event and clk = '1') then
        state_sig <= next_state_sig;
        delay_count <= next_delay_var;
      end if;
    end process;

  end generate NonZeroDelay;

end default_arch;
library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.Types.all;
use ahir.subprograms.all;
use ahir.BaseComponents.all;

entity join2 is
  port ( pred0, pred1      : in   Boolean;
    	symbol_out : out  boolean;
	clk: in std_logic;
	reset: in std_logic);
end join2;

architecture default_arch of join2 is
  signal preds: BooleanArray(1 downto 0);
begin  -- default_arch

  preds <= pred0 & pred1;
  baseJoin : join
    port map (preds => preds,
              symbol_out => symbol_out,
              clk => clk,
              reset => reset);

end default_arch;
library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.Types.all;
use ahir.subprograms.all;
use ahir.BaseComponents.all;

entity join is
  port ( preds      : in   BooleanArray;
    	symbol_out : out  boolean;
	clk: in std_logic;
	reset: in std_logic);
end join;

architecture default_arch of join is
  signal symbol_out_sig : BooleanArray(0 downto 0);
  signal place_sigs: BooleanArray(preds'range);
  constant H: integer := preds'high;
  constant L: integer := preds'low;

begin  -- default_arch
  
  placegen: for I in H downto L generate
    placeBlock: block
	signal place_pred: BooleanArray(0 downto 0);
    begin
	place_pred(0) <= preds(I);
	pI: place generic map(marking => false, bypass => true)
		port map(place_pred,symbol_out_sig,place_sigs(I),clk,reset);
    end block;
  end generate placegen;
  -- The transition is enabled only when all preds are true.
  
  symbol_out_sig(0) <= AndReduce(place_sigs);
  symbol_out <= symbol_out_sig(0);

end default_arch;
library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.Types.all;
use ahir.subprograms.all;
use ahir.BaseComponents.all;

entity join_with_input is
  port ( preds      : in   BooleanArray;
    	symbol_in  : in   boolean;
    	symbol_out : out  boolean;
	clk: in std_logic;
	reset: in std_logic);
end join_with_input;

architecture default_arch of join_with_input is
  signal symbol_out_sig : BooleanArray(0 downto 0);
  signal place_sigs: BooleanArray(preds'range);
  constant H: integer := preds'high;
  constant L: integer := preds'low;
begin  -- default_arch
  
  placegen: for I in H downto L generate
    placeBlock: block
	signal place_pred: BooleanArray(0 downto 0);
    begin
	place_pred(0) <= preds(I);
	pI: place generic map(marking => false, bypass => true)
		port map(place_pred,symbol_out_sig,place_sigs(I),clk,reset);
    end block;
  end generate placegen;
  -- The transition is enabled only when all preds are true.
  
  symbol_out_sig(0) <= symbol_in and AndReduce(place_sigs);
  symbol_out <= symbol_out_sig(0);
end default_arch;
library ieee;
use ieee.std_logic_1164.all;

-- on reset, trigger an AHIR module, and keep
-- retriggering it..
entity level_to_pulse is
  port (clk   : in  std_logic;
    	reset : in  std_logic;
        lreq: in std_logic;
        lack: out std_logic;
        preq: out boolean;
        pack: in boolean);
end level_to_pulse;

architecture default_arch of level_to_pulse is
  type L2PState is (idle,waiting);
  signal l2p_state : L2PState;
begin

  process(clk,reset,lreq, pack, l2p_state)
    variable nstate : L2PState;
    variable lack_v : std_logic;
    variable preq_v : boolean;
  begin
    lack_v := '0';
    preq_v := false;
    nstate := l2p_state;
    if(l2p_state = idle) then
      if(lreq ='1') then
        preq_v := true;
        if(pack) then
          lack_v := '1';
        else
          nstate := waiting;
        end if;
      end if;
    else
      if(pack) then
        lack_v := '1';
        nstate := idle;
      end if;
    end if;

    lack <= lack_v;
    preq <= preq_v;
    
    if(reset = '1') then
      nstate := idle;
    end if;

    if(clk'event and clk = '1') then
      l2p_state <= nstate;
    end if;
    
  end process;
  
end default_arch;
library ahir;
use ahir.Types.all;
use ahir.subprograms.all;

entity out_transition is
  
  port (preds      : in   BooleanArray;
        symbol_out : out  boolean);

end out_transition;

architecture default_arch of out_transition is
begin  -- default_arch

  -- The transition is enabled only when all preds are true.
  symbol_out <= AndReduce(preds);

end default_arch;
library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.Types.all;
use ahir.subprograms.all;
use ahir.BaseComponents.all;

entity pipeline_interlock is
  port (trigger: in boolean;
        enable : in boolean;
    	symbol_out : out  boolean;
	clk: in std_logic;
	reset: in std_logic);
end pipeline_interlock;

architecture default_arch of pipeline_interlock is
  signal symbol_out_sig : BooleanArray(0 downto 0);
  signal enable_place_pred : BooleanArray(0 downto 0);
  signal enable_place : Boolean;
  signal trigger_place_pred : BooleanArray(0 downto 0);
  signal trigger_place : Boolean;
  

begin  -- default_arch
  

  trigger_place_pred(0) <= trigger;
  pTrig: place generic map(marking => false, bypass => true)
    port map(trigger_place_pred, symbol_out_sig,trigger_place,clk,reset);

  enable_place_pred(0) <= enable;
  pEnable: place generic map(marking => true, bypass => true)
    port map(enable_place_pred, symbol_out_sig,enable_place,clk,reset);
  
  symbol_out_sig(0) <= enable_place and trigger_place;
  symbol_out <= symbol_out_sig(0);

end default_arch;
library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;

entity place is

  generic (
    marking : boolean := false;
    bypass : boolean := false
    );
  port (
    preds : in  BooleanArray;
    succs : in  BooleanArray;
    token : out boolean;
    clk   : in  std_logic;
    reset : in  std_logic);

end place;

architecture default_arch of place is

  signal incoming_token : boolean;      -- true if a pred fires
  signal backward_reset : boolean;      -- true if a succ fires
  signal token_sig      : boolean;  -- asynchronously computed value of the token
  signal token_latch    : boolean;
  
begin  -- default_arch

  -- Atmost one of the preds can send a pulse.
  -- We detect it with an OR over all inputs
  incoming_token <= OrReduce(preds);

  -- Atmost one of the succs can send a pulse.
  -- We detect it with an OR over all inputs
  backward_reset <= OrReduce(succs);

  latch_token : process (clk, reset)

  begin

    if clk'event and clk = '1' then  -- rising clock edge
      if reset = '1' then            -- asynchronous reset (active high)
        token_latch <= marking;
      elsif backward_reset then
        token_latch <= false;
      else
        token_latch <= token_sig;
      end if;
    end if;
  end process latch_token;
  
  token_sig <= true when incoming_token else token_latch;    

  bypassGen: if bypass generate
    token <= token_sig;    
  end generate bypassGen;

  noBypassGen: if not bypass generate
    token <= token_latch;        
  end generate noBypassGen;

end default_arch;
library ahir;
use ahir.Types.all;
use ahir.subprograms.all;

entity transition is
  
  port (
    preds      : in   BooleanArray;
    symbol_in  : in   boolean;
    symbol_out : out  boolean);

end transition;

architecture default_arch of transition is
begin  -- default_arch

  -- The transition is enabled only when all preds are true.
  symbol_out <= symbol_in and AndReduce(preds);

end default_arch;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Subprograms.all;
use ahir.Utilities.all;

entity BinaryEncoder is
  generic (iwidth: integer := 3; owidth: integer := 3);
  port(din: in std_logic_vector(iwidth-1 downto 0);
       dout: out std_logic_vector(owidth-1 downto 0));
end BinaryEncoder;


architecture LowLevel of BinaryEncoder is
  signal ival : integer range 0 to iwidth-1;
  constant awidth : integer := Minimum(Maximum(Ceil_Log2(iwidth),1),owidth);
begin  -- LowLevel

  process(din)
    variable ivar : integer range 0 to iwidth-1;
  begin
    ivar := 0;
    for I in 0 to iwidth-1 loop
      if(din(I) = '1') then
        ivar := I;
        exit;
      end if;
    end loop;
    ival <= ivar;
  end process;

  process(ival)
    variable doutvar : std_logic_vector(owidth-1 downto 0);
  begin
    doutvar := (others => '0');
    doutvar(awidth-1 downto 0) := To_SLV(To_Unsigned(ival,awidth));
    dout <= doutvar;
  end process;
    

end LowLevel;
library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.Utilities.all;
use ahir.SubPrograms.all;

entity BranchBase is
  generic (condition_width: integer := 1);
  port (condition: in std_logic_vector(condition_width-1 downto 0);
        clk,reset: in std_logic;
        req: in Boolean;
        ack0: out Boolean;
        ack1: out Boolean);
end entity;


architecture Behave of BranchBase is
begin

  process(clk)
    variable c_reduce : std_logic;
  begin
    if(clk'event and clk = '1') then
      if(reset = '1') then
        ack0 <= false;
        ack1 <= false;
      elsif req then
        c_reduce := OrReduce(condition);
        if(c_reduce = '1') then
          ack1 <= true;
          ack0 <= false;
        else
          ack0 <= true;
          ack1 <= false;
        end if;
      else
        ack0 <= false;
        ack1 <= false;
      end if;
    end if;
  end process;
end Behave;

library ieee;
use ieee.std_logic_1164.all;

entity BypassRegister is
  generic(data_width: integer; enable_bypass: boolean := false); 
  port (
    clk, reset : in  std_logic;
    enable     : in  std_logic;
    data_in     : in  std_logic_vector(data_width-1 downto 0);
    data_out    : out std_logic_vector(data_width-1 downto 0));
end BypassRegister;

architecture behave of BypassRegister is
  constant datazero : std_logic_vector(data_width-1 downto 0) := (others => '0');
  signal data_reg: std_logic_vector(data_width-1 downto 0);
begin  -- behave

  process (clk, reset)
  begin  -- process
    if clk'event and clk = '1' then     -- rising clock edge
      if reset = '1' then
	data_reg <= datazero;
      elsif enable = '1' then
        data_reg <= data_in;
      end if;
    end if;
  end process;

  Bypass: if enable_bypass generate
    data_out <= data_in when enable = '1' else data_reg;    
  end generate Bypass;

  NoBypass: if not enable_bypass generate
    data_out <= data_reg;
  end generate NoBypass;

end behave;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity CallArbiterNoInargsNoOutargs is
  generic(num_reqs: integer;
	  tag_length: integer);
  port ( -- ready/ready handshake on all ports
    -- ports for the caller
    call_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
    call_acks   : out std_logic_vector(num_reqs-1 downto 0);
    -- call port connected to the called module
    call_mreq   : out std_logic;
    call_mack   : in  std_logic;
    call_mtag   : out std_logic_vector(tag_length-1 downto 0);
    -- similarly for return, initiated by the caller
    return_reqs : in  std_logic_vector(num_reqs-1 downto 0);
    return_acks : out std_logic_vector(num_reqs-1 downto 0);
    -- return from function
    -- function to assert mreq arbiter to return mack
    -- ( NOTE: It has to be this way, the arbiter should
    -- accept the return value if it has room)
    return_mreq : in std_logic;
    return_mack : out std_logic;
    return_mtag : in  std_logic_vector(tag_length-1 downto 0);
    clk: in std_logic;
    reset: in std_logic);
end CallArbiterNoInargsNoOutargs;


architecture Struct of CallArbiterNoInargsNoOutargs is
   signal pe_call_reqs: std_logic_vector(num_reqs-1 downto 0);
   signal return_mack_sig, return_acks_sig: std_logic_vector(num_reqs-1 downto 0);

begin

  -----------------------------------------------------------------------------
  -- priority encode incoming
  -----------------------------------------------------------------------------
   pe_call_reqs <= PriorityEncode(call_reqs);

   ----------------------------------------------------------------------------
   -- combinational process to handle call_reqs  --> call_mreq muxing
   ----------------------------------------------------------------------------
   process(pe_call_reqs,call_mack)
     variable there_is_a_call : std_logic;
   begin
     there_is_a_call := OrReduce(pe_call_reqs);
     call_acks <= (others => '0');
     if(there_is_a_call = '1') then
       for I in num_reqs-1 downto 0 loop
         if(pe_call_reqs(I) = '1') then
           call_acks(I) <= call_mack;
           exit;
         end if;
       end loop;  -- I
     end if;
     call_mreq <= there_is_a_call;
   end process;


   tagGen : BinaryEncoder generic map (iwidth => num_reqs, owidth => tag_length)
     port map (din => pe_call_reqs, dout => call_mtag);
   
   ----------------------------------------------------------------------------
   -- reverse path
   ----------------------------------------------------------------------------

   -- the acks in both directions
   return_acks <= return_acks_sig;
   return_mack <= OrReduce(return_mack_sig);
   
   -- incoming data written into appropriate register.
   RetGen: for I in return_reqs'high downto return_reqs'low generate

     fsm: block
       signal ack_reg, mack_sig, valid_flag : std_logic;
     begin  -- block fsm

       -- valid = '1' implies this index is incoming
       valid_flag <= '1' when return_mreq = '1' and (I = To_Integer(To_Unsigned(return_mtag))) else '0';

       -- mack if valid and mreq and (either ack bit is not set or return_reqs
       -- is asserted)
       mack_sig <= (return_reqs(I) or (not ack_reg)) and return_mreq and valid_flag;

       --------------------------------------------------------------------------
       -- ack ff
       --------------------------------------------------------------------------
       -- set if mack_sig is asserted, else clear if return_reqs is asserted
       -- and register is already set.
       process(clk)
       begin
         if clk'event and clk= '1' then
           if(reset = '1') then
             ack_reg <= '0';
           elsif mack_sig = '1' then
             ack_reg <= '1';
           elsif return_reqs(I) = '1' and ack_reg = '1' then
             ack_reg <= '0';
           end if;
         end if;
       end process;

       -- pass info out of the generate
       return_acks_sig(I) <= ack_reg;
       return_mack_sig(I) <= mack_sig;
       
     end block fsm;

     
   end generate RetGen;
end Struct;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity CallArbiterNoInArgs is
  generic(num_reqs: integer;
	  return_data_width: integer;
	  tag_length: integer);
  port ( -- ready/ready handshake on all ports
    -- ports for the caller
    call_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
    call_acks   : out std_logic_vector(num_reqs-1 downto 0);
    -- call port connected to the called module
    call_mreq   : out std_logic;
    call_mack   : in  std_logic;
    call_mtag   : out std_logic_vector(tag_length-1 downto 0);
    -- similarly for return, initiated by the caller
    return_reqs : in  std_logic_vector(num_reqs-1 downto 0);
    return_acks : out std_logic_vector(num_reqs-1 downto 0);
    return_data : out std_logic_vector((num_reqs*return_data_width)-1 downto 0);
    -- return from function
    -- function to assert mreq arbiter to return mack
    -- ( NOTE: It has to be this way, the arbiter should
    -- accept the return value if it has room)
    return_mreq : in std_logic;
    return_mack : out std_logic;
    return_mdata : in  std_logic_vector(return_data_width-1 downto 0);
    return_mtag : in  std_logic_vector(tag_length-1 downto 0);
    clk: in std_logic;
    reset: in std_logic);
end CallArbiterNoInArgs;


architecture Struct of CallArbiterNoInArgs is
   signal pe_call_reqs: std_logic_vector(num_reqs-1 downto 0);
   signal return_mack_sig, return_acks_sig: std_logic_vector(num_reqs-1 downto 0);

   type TwordArray is array (natural range <>) of std_logic_vector(return_mdata'length-1 downto 0);
   signal return_data_sig : TwordArray(num_reqs-1 downto 0);
begin

  -----------------------------------------------------------------------------
  -- priority encode incoming
  -----------------------------------------------------------------------------
   pe_call_reqs <= PriorityEncode(call_reqs);

   ----------------------------------------------------------------------------
   -- combinational process to handle call_reqs  --> call_mreq muxing
   ----------------------------------------------------------------------------
   process(pe_call_reqs, call_mack)
     variable there_is_a_call : std_logic;
   begin
     there_is_a_call := OrReduce(pe_call_reqs);
     call_acks <= (others => '0');
     if(there_is_a_call = '1') then
       for I in num_reqs-1 downto 0 loop
         if(pe_call_reqs(I) = '1') then
           call_acks(I) <= call_mack;
           exit;
         end if;
       end loop;  -- I
     end if;
     call_mreq <= there_is_a_call;
   end process;

   tagGen : BinaryEncoder generic map (iwidth => num_reqs, owidth => tag_length)
     port map (din => pe_call_reqs, dout => call_mtag);   

   ----------------------------------------------------------------------------
   -- reverse path
   ----------------------------------------------------------------------------

   -- pack registers into return data array
   process(return_data_sig)
     variable lreturn_data : std_logic_vector((num_reqs*return_data_width)-1 downto 0);
   begin
     for J in return_data_sig'high(1) downto return_data_sig'low(1) loop
       Insert(lreturn_data,J,return_data_sig(J));
     end loop;  -- J
     return_data <= lreturn_data;
   end process;

   -- the acks in both directions
   return_acks <= return_acks_sig;
   return_mack <= OrReduce(return_mack_sig);
   
   -- incoming data written into appropriate register.
   RetGen: for I in return_reqs'high downto return_reqs'low generate

     fsm: block
       signal ack_reg, mack_sig, valid_flag : std_logic;
       signal data_reg : std_logic_vector(return_mdata'length-1 downto 0);
     begin  -- block fsm

       -- valid = '1' implies this index is incoming
       valid_flag <= '1' when return_mreq = '1' and (I = To_Integer(To_Unsigned(return_mtag))) else '0';

       -- mack if valid and mreq and (either ack bit is not set or return_reqs
       -- is asserted)
       mack_sig <= (return_reqs(I) or (not ack_reg)) and return_mreq and valid_flag;

       --------------------------------------------------------------------------
       -- ack ff
       --------------------------------------------------------------------------
       -- set if mack_sig is asserted, else clear if return_reqs is asserted
       -- and register is already set.
       process(clk)
       begin
         if clk'event and clk= '1' then
           if(reset = '1') then
             ack_reg <= '0';
           elsif mack_sig = '1' then
             ack_reg <= '1';
           elsif return_reqs(I) = '1' and ack_reg = '1' then
             ack_reg <= '0';
           end if;

           -- register data when you send mack
           if(mack_sig = '1') then
             data_reg <= return_mdata;
           end if;
         end if;
       end process;

       -- pass info out of the generate
       return_acks_sig(I) <= ack_reg;
       return_data_sig(I) <= data_reg;
       return_mack_sig(I) <= mack_sig;
       
     end block fsm;

     
   end generate RetGen;
end Struct;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity CallArbiterNoOutArgs is
  generic(num_reqs: integer;
	  call_data_width: integer;
	  tag_length: integer);
  port ( -- ready/ready handshake on all ports
    -- ports for the caller
    call_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
    call_acks   : out std_logic_vector(num_reqs-1 downto 0);
    call_data   : in  std_logic_vector((num_reqs*call_data_width)-1 downto 0);
    -- call port connected to the called module
    call_mreq   : out std_logic;
    call_mack   : in  std_logic;
    call_mdata  : out std_logic_vector(call_data_width-1 downto 0);
    call_mtag   : out std_logic_vector(tag_length-1 downto 0);
    -- similarly for return, initiated by the caller
    return_reqs : in  std_logic_vector(num_reqs-1 downto 0);
    return_acks : out std_logic_vector(num_reqs-1 downto 0);
    -- return from function
    -- function to assert mreq arbiter to return mack
    -- ( NOTE: It has to be this way, the arbiter should
    -- accept the return value if it has room)
    return_mreq : in std_logic;
    return_mack : out std_logic;
    return_mtag : in  std_logic_vector(tag_length-1 downto 0);
    clk: in std_logic;
    reset: in std_logic);
end CallArbiterNoOutArgs;


architecture Struct of CallArbiterNoOutArgs is
   signal pe_call_reqs: std_logic_vector(num_reqs-1 downto 0);
   signal return_mack_sig, return_acks_sig: std_logic_vector(num_reqs-1 downto 0);

begin

  -----------------------------------------------------------------------------
  -- priority encode incoming
  -----------------------------------------------------------------------------
   pe_call_reqs <= PriorityEncode(call_reqs);

   ----------------------------------------------------------------------------
   -- combinational process to handle call_reqs  --> call_mreq muxing
   ----------------------------------------------------------------------------
   process(pe_call_reqs, call_data, call_mack)
     variable there_is_a_call : std_logic;
     variable out_data : std_logic_vector(call_data_width-1 downto 0);
   begin
     there_is_a_call := OrReduce(pe_call_reqs);
     out_data := (others => '0');
     call_acks <= (others => '0');
     if(there_is_a_call = '1') then
       for I in num_reqs-1 downto 0 loop
         if(pe_call_reqs(I) = '1') then
           Extract(call_data,I,out_data);
           call_acks(I) <= call_mack;
           exit;
         end if;
       end loop;  -- I
     end if;
     call_mreq <= there_is_a_call;
     call_mdata <= out_data;
   end process;

   tagGen : BinaryEncoder generic map (iwidth => num_reqs, owidth => tag_length)
     port map (din => pe_call_reqs, dout => call_mtag);      

   ----------------------------------------------------------------------------
   -- reverse path
   ----------------------------------------------------------------------------

   -- the acks in both directions
   return_acks <= return_acks_sig;
   return_mack <= OrReduce(return_mack_sig);
   
   -- incoming data written into appropriate register.
   RetGen: for I in return_reqs'high downto return_reqs'low generate

     fsm: block
       signal ack_reg, mack_sig, valid_flag : std_logic;
     begin  -- block fsm

       -- valid = '1' implies this index is incoming
       valid_flag <= '1' when return_mreq = '1' and (I = To_Integer(To_Unsigned(return_mtag))) else '0';

       -- mack if valid and mreq and (either ack bit is not set or return_reqs
       -- is asserted)
       mack_sig <= (return_reqs(I) or (not ack_reg)) and return_mreq and valid_flag;

       --------------------------------------------------------------------------
       -- ack ff
       --------------------------------------------------------------------------
       -- set if mack_sig is asserted, else clear if return_reqs is asserted
       -- and register is already set.
       process(clk)
       begin
         if clk'event and clk= '1' then
           if(reset = '1') then
             ack_reg <= '0';
           elsif mack_sig = '1' then
             ack_reg <= '1';
           elsif return_reqs(I) = '1' and ack_reg = '1' then
             ack_reg <= '0';
           end if;
         end if;
       end process;

       -- pass info out of the generate
       return_acks_sig(I) <= ack_reg;
       return_mack_sig(I) <= mack_sig;
       
     end block fsm;

     
   end generate RetGen;
end Struct;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

-- the unitary call arbiter interfaces a set
-- of callers (num_reqs in number) from a single
-- called module.
--
-- the caller is identified by a caller tag.  The unitary
-- arbiter registers the caller tag and returns it when
-- the current call has finished.
--
entity CallArbiterUnitaryNoInargsNoOutargs is
  generic(num_reqs: integer;
	  caller_tag_length: integer;
          callee_tag_length: integer);
  port ( -- ready/ready handshake on all ports
    -- ports for the caller
    call_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
    call_acks   : out std_logic_vector(num_reqs-1 downto 0);
    call_tag    : in  std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
    -- similarly for return, initiated by the caller
    return_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
    return_acks   : out std_logic_vector(num_reqs-1 downto 0);
    return_tag    : out  std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
    -- ports connected to the called module
    call_start   : out std_logic;
    call_fin   : in  std_logic;
    call_in_tag   : out std_logic_vector(callee_tag_length-1 downto 0);
    -- from the called module
    call_out_tag : in  std_logic_vector(callee_tag_length-1 downto 0);
    clk: in std_logic;
    reset: in std_logic);
end CallArbiterUnitaryNoInargsNoOutargs;


architecture Struct of CallArbiterUnitaryNoInargsNoOutargs is
  signal call_acks_sig : std_logic_vector(num_reqs-1 downto 0);
  signal call_mreq, call_mack: std_logic;
  signal call_mtag : std_logic_vector(callee_tag_length-1 downto 0);
  signal return_mreq, return_mack: std_logic;
  signal return_mtag : std_logic_vector(callee_tag_length-1 downto 0);
  signal enable_in_args, enable_out_args: std_logic;
begin

  call_acks <= call_acks_sig;
  
  -- caller tags are registered here.  It is impossible
  -- for caller line I to be re-used until the current
  -- call has finished.  So we can just register the
  -- incoming call-tag to the outgoing return-tag.
  TagGen: for I in num_reqs-1 downto 0 generate
    process(clk)
    begin
      if(clk'event and clk = '1') then
        if(call_reqs(I) = '1' and call_acks_sig(I) = '1') then
          return_tag(((I+1)*caller_tag_length)-1 downto (I*caller_tag_length))
            <=
            call_tag(((I+1)*caller_tag_length)-1 downto (I*caller_tag_length));
        end if;
      end if;
    end process;
  end generate TagGen;

  -- this is the basic call-arbiter which is a bit incomplete,
  -- because it does not provide a handle for the caller to
  -- pass a tag to the callee (this is OK if there is only one
  -- caller, but in general there can be many).
  base: CallArbiterNoInargsNoOutargs
    generic map(num_reqs => num_reqs,
                tag_length => callee_tag_length)
    port map(call_reqs => call_reqs,
             call_acks => call_acks_sig,
             call_mreq => call_mreq,
             call_mack => call_mack,
             call_mtag => call_mtag,
             return_reqs => return_reqs,
             return_acks => return_acks,
             return_mreq => return_mreq,
             return_mack => return_mack,
             return_mtag => return_mtag,
             clk => clk,
             reset => reset);

  -- need the call-mediator to match the split protocol from
  -- the caller side with the unitary protocol of the callee.
  mediator: CallMediator 
    port map(call_req => call_mreq,
             call_ack => call_mack,
             enable_call_data => enable_in_args,
             return_req => return_mack, -- cross-over
             return_ack => return_mreq, -- cross-over
             enable_return_data => enable_out_args,
             start => call_start,
             fin => call_fin,
             clk => clk,
             reset => reset); 
  

  -- to register the call tag
  callTagReg: BypassRegister generic map(data_width => callee_tag_length, enable_bypass => true)
    port map(clk=> clk, reset => reset,
             enable => enable_in_args,
             data_in => call_mtag,
             data_out => call_in_tag);

  -- to register the return tag
  returnTagReg: BypassRegister generic map(data_width => callee_tag_length, enable_bypass => true)
    port map(clk=> clk, reset => reset,
             enable => enable_out_args,
             data_in => call_out_tag,
             data_out => return_mtag);
  

end Struct;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

-- the unitary call arbiter interfaces a set
-- of callers (num_reqs in number) from a single
-- called module.
--
-- the caller is identified by a caller tag.  The unitary
-- arbiter registers the caller tag and returns it when
-- the current call has finished.
--
entity CallArbiterUnitaryNoInargs is
  generic(num_reqs: integer;
	  return_data_width: integer;
	  caller_tag_length: integer;
          callee_tag_length: integer);
  port ( -- ready/ready handshake on all ports
    -- ports for the caller
    call_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
    call_acks   : out std_logic_vector(num_reqs-1 downto 0);
    call_tag    : in  std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
    -- similarly for return, initiated by the caller
    return_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
    return_acks   : out std_logic_vector(num_reqs-1 downto 0);
    return_data   : out std_logic_vector((num_reqs*return_data_width)-1 downto 0);
    return_tag    : out  std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
    -- ports connected to the called module
    call_start   : out std_logic;
    call_fin   : in  std_logic;
    call_in_tag   : out std_logic_vector(callee_tag_length-1 downto 0);
    -- from the called module
    call_out_args : in  std_logic_vector(return_data_width-1 downto 0);
    call_out_tag : in  std_logic_vector(callee_tag_length-1 downto 0);
    clk: in std_logic;
    reset: in std_logic);
end CallArbiterUnitaryNoInargs;


architecture Struct of CallArbiterUnitaryNoInargs is
  signal call_acks_sig : std_logic_vector(num_reqs-1 downto 0);
  signal call_mreq, call_mack: std_logic;
  signal call_mtag : std_logic_vector(callee_tag_length-1 downto 0);
  signal return_mreq, return_mack: std_logic;
  signal return_mdata : std_logic_vector(return_data_width-1 downto 0);
  signal return_mtag : std_logic_vector(callee_tag_length-1 downto 0);
  signal enable_in_args, enable_out_args: std_logic;
begin

  call_acks <= call_acks_sig;
  
  -- caller tags are registered here.  It is impossible
  -- for caller line I to be re-used until the current
  -- call has finished.  So we can just register the
  -- incoming call-tag to the outgoing return-tag.
  TagGen: for I in num_reqs-1 downto 0 generate
    process(clk)
    begin
      if(clk'event and clk = '1') then
        if(call_reqs(I) = '1' and call_acks_sig(I) = '1') then
          return_tag(((I+1)*caller_tag_length)-1 downto (I*caller_tag_length))
            <=
            call_tag(((I+1)*caller_tag_length)-1 downto (I*caller_tag_length));
        end if;
      end if;
    end process;
  end generate TagGen;

  -- this is the basic call-arbiter which is a bit incomplete,
  -- because it does not provide a handle for the caller to
  -- pass a tag to the callee (this is OK if there is only one
  -- caller, but in general there can be many).
  base: CallArbiterNoInargs generic map(num_reqs => num_reqs,
                                        return_data_width => return_data_width,
                                        tag_length => callee_tag_length)
    port map(call_reqs => call_reqs,
             call_acks => call_acks_sig,
             call_mreq => call_mreq,
             call_mack => call_mack,
             call_mtag => call_mtag,
             return_reqs => return_reqs,
             return_acks => return_acks,
             return_data => return_data,
             return_mreq => return_mreq,
             return_mack => return_mack,
             return_mdata => return_mdata,
             return_mtag => return_mtag,
             clk => clk,
             reset => reset);

  -- need the call-mediator to match the split protocol from
  -- the caller side with the unitary protocol of the callee.
  mediator: CallMediator 
    port map(call_req => call_mreq,
             call_ack => call_mack,
             enable_call_data => enable_in_args,
             return_req => return_mack, -- cross-over
             return_ack => return_mreq, -- cross-over
             enable_return_data => enable_out_args,
             start => call_start,
             fin => call_fin,
             clk => clk,
             reset => reset); 
  
  -- to register the call tag
  callTagReg: BypassRegister generic map(data_width => callee_tag_length, enable_bypass => true)
    port map(clk=> clk, reset => reset,
             enable => enable_in_args,
             data_in => call_mtag,
             data_out => call_in_tag);

  -- to register the return data.
  returnDataReg: BypassRegister generic map(data_width => return_data_width, enable_bypass => true)
    port map(clk=> clk, reset => reset,
             enable => enable_out_args,
             data_in => call_out_args,
             data_out => return_mdata);
  -- to register the return tag
  returnTagReg: BypassRegister generic map(data_width => callee_tag_length, enable_bypass => true)
    port map(clk=> clk, reset => reset,
             enable => enable_out_args,
             data_in => call_out_tag,
             data_out => return_mtag);
  

end Struct;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

-- the unitary call arbiter interfaces a set
-- of callers (num_reqs in number) from a single
-- called module.
--
-- the caller is identified by a caller tag.  The unitary
-- arbiter registers the caller tag and returns it when
-- the current call has finished.
--
entity CallArbiterUnitaryNoOutargs is
  generic(num_reqs: integer;
	  call_data_width: integer;
	  caller_tag_length: integer;
          callee_tag_length: integer);
  port ( -- ready/ready handshake on all ports
    -- ports for the caller
    call_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
    call_acks   : out std_logic_vector(num_reqs-1 downto 0);
    call_data   : in  std_logic_vector((num_reqs*call_data_width)-1 downto 0);
    call_tag    : in  std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
    -- similarly for return, initiated by the caller
    return_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
    return_acks   : out std_logic_vector(num_reqs-1 downto 0);
    return_tag    : out  std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
    -- ports connected to the called module
    call_start   : out std_logic;
    call_fin   : in  std_logic;
    call_in_args  : out std_logic_vector(call_data_width-1 downto 0);
    call_in_tag   : out std_logic_vector(callee_tag_length-1 downto 0);
    -- from the called module
    call_out_tag : in  std_logic_vector(callee_tag_length-1 downto 0);
    clk: in std_logic;
    reset: in std_logic);
end CallArbiterUnitaryNoOutargs;


architecture Struct of CallArbiterUnitaryNoOutargs is
  signal call_acks_sig : std_logic_vector(num_reqs-1 downto 0);
  signal call_mreq, call_mack: std_logic;
  signal call_mdata : std_logic_vector(call_data_width-1 downto 0);
  signal call_mtag : std_logic_vector(callee_tag_length-1 downto 0);
  signal return_mreq, return_mack: std_logic;
  signal return_mtag : std_logic_vector(callee_tag_length-1 downto 0);
  signal enable_in_args, enable_out_args: std_logic;
begin

  call_acks <= call_acks_sig;
  
  -- caller tags are registered here.  It is impossible
  -- for caller line I to be re-used until the current
  -- call has finished.  So we can just register the
  -- incoming call-tag to the outgoing return-tag.
  TagGen: for I in num_reqs-1 downto 0 generate
    process(clk)
    begin
      if(clk'event and clk = '1') then
        if(call_reqs(I) = '1' and call_acks_sig(I) = '1') then
          return_tag(((I+1)*caller_tag_length)-1 downto (I*caller_tag_length))
            <=
            call_tag(((I+1)*caller_tag_length)-1 downto (I*caller_tag_length));
        end if;
      end if;
    end process;
  end generate TagGen;

  -- this is the basic call-arbiter which is a bit incomplete,
  -- because it does not provide a handle for the caller to
  -- pass a tag to the callee (this is OK if there is only one
  -- caller, but in general there can be many).
  base: CallArbiterNoOutargs generic map(num_reqs => num_reqs,
                                         call_data_width => call_data_width,
                                         tag_length => callee_tag_length)
    port map(call_reqs => call_reqs,
             call_acks => call_acks_sig,
             call_data => call_data,
             call_mreq => call_mreq,
             call_mack => call_mack,
             call_mdata => call_mdata,
             call_mtag => call_mtag,
             return_reqs => return_reqs,
             return_acks => return_acks,
             return_mreq => return_mreq,
             return_mack => return_mack,
             return_mtag => return_mtag,
             clk => clk,
             reset => reset);

  -- need the call-mediator to match the split protocol from
  -- the caller side with the unitary protocol of the callee.
  mediator: CallMediator 
    port map(call_req => call_mreq,
             call_ack => call_mack,
             enable_call_data => enable_in_args,
             return_req => return_mack, -- cross-over
             return_ack => return_mreq, -- cross-over
             enable_return_data => enable_out_args,
             start => call_start,
             fin => call_fin,
             clk => clk,
             reset => reset); 
  

  -- to register the call data.
  callDataReg: BypassRegister generic map(data_width => call_data_width, enable_bypass => true)
    port map(clk=> clk, reset => reset,
             enable => enable_in_args,
             data_in => call_mdata,
             data_out => call_in_args);
  -- to register the call tag
  callTagReg: BypassRegister generic map(data_width => callee_tag_length, enable_bypass => true)
    port map(clk=> clk, reset => reset,
             enable => enable_in_args,
             data_in => call_mtag,
             data_out => call_in_tag);

  -- to register the return tag
  returnTagReg: BypassRegister generic map(data_width => callee_tag_length, enable_bypass => true)
    port map(clk=> clk, reset => reset,
             enable => enable_out_args,
             data_in => call_out_tag,
             data_out => return_mtag);
  

end Struct;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

-- the unitary call arbiter interfaces a set
-- of callers (num_reqs in number) from a single
-- called module.
--
-- the caller is identified by a caller tag.  The unitary
-- arbiter registers the caller tag and returns it when
-- the current call has finished.
--
entity CallArbiterUnitary is
  generic(num_reqs: integer := 3;
	  call_data_width: integer := 16;
	  return_data_width: integer := 8;
	  caller_tag_length: integer := 3;
          callee_tag_length: integer := 5);
  port ( -- ready/ready handshake on all ports
    -- ports for the caller
    call_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
    call_acks   : out std_logic_vector(num_reqs-1 downto 0);
    call_data   : in  std_logic_vector((num_reqs*call_data_width)-1 downto 0);
    call_tag    : in  std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
    -- similarly for return, initiated by the caller
    return_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
    return_acks   : out std_logic_vector(num_reqs-1 downto 0);
    return_data   : out std_logic_vector((num_reqs*return_data_width)-1 downto 0);
    return_tag    : out  std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
    -- ports connected to the called module
    call_start   : out std_logic;
    call_fin   : in  std_logic;
    call_in_args  : out std_logic_vector(call_data_width-1 downto 0);
    call_in_tag   : out std_logic_vector(callee_tag_length-1 downto 0);
    -- from the called module
    call_out_args : in  std_logic_vector(return_data_width-1 downto 0);
    call_out_tag : in  std_logic_vector(callee_tag_length-1 downto 0);
    clk: in std_logic;
    reset: in std_logic);
end CallArbiterUnitary;


architecture Struct of CallArbiterUnitary is
  signal call_acks_sig : std_logic_vector(num_reqs-1 downto 0);
  signal call_mreq, call_mack: std_logic;
  signal call_mdata : std_logic_vector(call_data_width-1 downto 0);
  signal call_mtag : std_logic_vector(callee_tag_length-1 downto 0);
  signal return_mreq, return_mack: std_logic;
  signal return_mdata : std_logic_vector(return_data_width-1 downto 0);
  signal return_mtag : std_logic_vector(callee_tag_length-1 downto 0);
  signal enable_in_args, enable_out_args: std_logic;
begin

  call_acks <= call_acks_sig;
  
  -- caller tags are registered here.  It is impossible
  -- for caller line I to be re-used until the current
  -- call has finished.  So we can just register the
  -- incoming call-tag to the outgoing return-tag.
  TagGen: for I in num_reqs-1 downto 0 generate
    process(clk)
    begin
      if(clk'event and clk = '1') then
        if(call_reqs(I) = '1' and call_acks_sig(I) = '1') then
          return_tag(((I+1)*caller_tag_length)-1 downto (I*caller_tag_length))
            <=
            call_tag(((I+1)*caller_tag_length)-1 downto (I*caller_tag_length));
        end if;
      end if;
    end process;
  end generate TagGen;

  -- this is the basic call-arbiter which is a bit incomplete,
  -- because it does not provide a handle for the caller to
  -- pass a tag to the callee (this is OK if there is only one
  -- caller, but in general there can be many).
  base: CallArbiter generic map(num_reqs => num_reqs,
                                call_data_width => call_data_width,
                                return_data_width => return_data_width,
                                tag_length => callee_tag_length)
    port map(call_reqs => call_reqs,
             call_acks => call_acks_sig,
             call_data => call_data,
             call_mreq => call_mreq,
             call_mack => call_mack,
             call_mdata => call_mdata,
             call_mtag => call_mtag,
             return_reqs => return_reqs,
             return_acks => return_acks,
             return_data => return_data,
             return_mreq => return_mreq,
             return_mack => return_mack,
             return_mdata => return_mdata,
             return_mtag => return_mtag,
             clk => clk,
             reset => reset);

  -- need the call-mediator to match the split protocol from
  -- the caller side with the unitary protocol of the callee.
  mediator: CallMediator 
    port map(call_req => call_mreq,
             call_ack => call_mack,
             enable_call_data => enable_in_args,
             return_req => return_mack, -- cross-over
             return_ack => return_mreq, -- cross-over
             enable_return_data => enable_out_args,
             start => call_start,
             fin => call_fin,
             clk => clk,
             reset => reset); 
  

  -- to register the call data.
  callDataReg: BypassRegister generic map(data_width => call_data_width, enable_bypass => true)
    port map(clk=> clk, reset => reset,
             enable => enable_in_args,
             data_in => call_mdata,
             data_out => call_in_args);
  -- to register the call tag
  callTagReg: BypassRegister generic map(data_width => callee_tag_length, enable_bypass => true)
    port map(clk=> clk, reset => reset,
             enable => enable_in_args,
             data_in => call_mtag,
             data_out => call_in_tag);

  -- to register the return data.
  returnDataReg: BypassRegister generic map(data_width => return_data_width, enable_bypass => true)
    port map(clk=> clk, reset => reset,
             enable => enable_out_args,
             data_in => call_out_args,
             data_out => return_mdata);
  -- to register the return tag
  returnTagReg: BypassRegister generic map(data_width => callee_tag_length, enable_bypass => true)
    port map(clk=> clk, reset => reset,
             enable => enable_out_args,
             data_in => call_out_tag,
             data_out => return_mtag);
  

end Struct;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity CallArbiter is
  generic(num_reqs: integer;
	  call_data_width: integer;
	  return_data_width: integer;
	  tag_length: integer);
  port ( -- ready/ready handshake on all ports
    -- ports for the caller
    call_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
    call_acks   : out std_logic_vector(num_reqs-1 downto 0);
    call_data   : in  std_logic_vector((num_reqs*call_data_width)-1 downto 0);
    -- call port connected to the called module
    call_mreq   : out std_logic;
    call_mack   : in  std_logic;
    call_mdata  : out std_logic_vector(call_data_width-1 downto 0);
    call_mtag   : out std_logic_vector(tag_length-1 downto 0);
    -- similarly for return, initiated by the caller
    return_reqs : in  std_logic_vector(num_reqs-1 downto 0);
    return_acks : out std_logic_vector(num_reqs-1 downto 0);
    return_data : out std_logic_vector((num_reqs*return_data_width)-1 downto 0);
    -- return from function
    -- function to assert mreq arbiter to return mack
    -- ( NOTE: It has to be this way, the arbiter should
    -- accept the return value if it has room)
    return_mreq : in std_logic;
    return_mack : out std_logic;
    return_mdata : in  std_logic_vector(return_data_width-1 downto 0);
    return_mtag : in  std_logic_vector(tag_length-1 downto 0);
    clk: in std_logic;
    reset: in std_logic);
end CallArbiter;


architecture Struct of CallArbiter is
   signal pe_call_reqs: std_logic_vector(num_reqs-1 downto 0);
   signal return_mack_sig, return_acks_sig: std_logic_vector(num_reqs-1 downto 0);

   type TwordArray is array (natural range <>) of std_logic_vector(return_mdata'length-1 downto 0);
   signal return_data_sig : TwordArray(num_reqs-1 downto 0);
begin

  -----------------------------------------------------------------------------
  -- priority encode incoming
  -----------------------------------------------------------------------------
   pe_call_reqs <= PriorityEncode(call_reqs);

   ----------------------------------------------------------------------------
   -- combinational process to handle call_reqs  --> call_mreq muxing
   ----------------------------------------------------------------------------
   process(pe_call_reqs, call_data, call_mack)
     variable there_is_a_call : std_logic;
     variable out_data : std_logic_vector(call_data_width-1 downto 0);
   begin
     there_is_a_call := OrReduce(pe_call_reqs);
     out_data := (others => '0');
     call_acks <= (others => '0');
     if(there_is_a_call = '1') then
       for I in num_reqs-1 downto 0 loop
         if(pe_call_reqs(I) = '1') then
           Extract(call_data,I,out_data);
           call_acks(I) <= call_mack;
           exit;
         end if;
       end loop;  -- I
     end if;
     call_mreq <= there_is_a_call;
     call_mdata <= out_data;
   end process;

   tagGen : BinaryEncoder generic map (iwidth => num_reqs, owidth => tag_length)
     port map (din => pe_call_reqs, dout => call_mtag);

   ----------------------------------------------------------------------------
   -- reverse path
   ----------------------------------------------------------------------------

   -- pack registers into return data array
   process(return_data_sig)
     variable lreturn_data : std_logic_vector((num_reqs*return_data_width)-1 downto 0);
   begin
     for J in return_data_sig'high(1) downto return_data_sig'low(1) loop
       Insert(lreturn_data,J,return_data_sig(J));
     end loop;  -- J
     return_data <= lreturn_data;
   end process;

   -- the acks in both directions
   return_acks <= return_acks_sig;
   return_mack <= OrReduce(return_mack_sig);
   
   -- incoming data written into appropriate register.
   RetGen: for I in return_reqs'high downto return_reqs'low generate

     fsm: block
       signal ack_reg, mack_sig, valid_flag : std_logic;
       signal data_reg : std_logic_vector(return_mdata'length-1 downto 0);
     begin  -- block fsm

       -- valid = '1' implies this index is incoming
       valid_flag <= '1' when return_mreq = '1' and (I = To_Integer(To_Unsigned(return_mtag))) else '0';

       -- mack if valid and mreq and (either ack bit is not set or return_reqs
       -- is asserted)
       mack_sig <= (return_reqs(I) or (not ack_reg)) and return_mreq and valid_flag;

       --------------------------------------------------------------------------
       -- ack ff
       --------------------------------------------------------------------------
       -- set if mack_sig is asserted, else clear if return_reqs is asserted
       -- and register is already set.
       process(clk)
       begin
         if clk'event and clk= '1' then
           if(reset = '1') then
             ack_reg <= '0';
           elsif mack_sig = '1' then
             ack_reg <= '1';
           elsif return_reqs(I) = '1' and ack_reg = '1' then
             ack_reg <= '0';
           end if;

           -- register data when you send mack
           if(mack_sig = '1') then
             data_reg <= return_mdata;
           end if;
         end if;
       end process;

       -- pass info out of the generate
       return_acks_sig(I) <= ack_reg;
       return_data_sig(I) <= data_reg;
       return_mack_sig(I) <= mack_sig;
       
     end block fsm;

     
   end generate RetGen;
end Struct;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

-- a protocol matching mediator, used to
-- decouple the split-protocol from the caller
-- module from the current unitary start-fin
-- protocol of the called module
entity CallMediator is
  port (
    call_req: in std_logic;             -- the first split req
    call_ack: out std_logic;            -- the first split ack
    enable_call_data: out std_logic;    -- latch the incoming data
    return_req: in std_logic;           -- the second split req
    return_ack: out std_logic;          -- the second split ack
    enable_return_data: out std_logic;  -- latch the return data
    start: out std_logic;               -- start to called module
    fin: in std_logic;                  -- fin from called module
    clk: in std_logic;
    reset: in std_logic);
end CallMediator;


architecture Struct of CallMediator is
	signal call_ack_sig, return_ack_sig: std_logic;
	signal call_reg, return_reg: std_logic;
begin

	process(clk)
	begin
		if(clk'event and clk = '1') then
			if(reset = '1' or fin = '1') then
				call_reg <= '1';
			elsif (call_ack_sig = '1') then
				call_reg <= '0';
			end if;
		end if;
	end process;
	call_ack_sig <= call_req and call_reg;

	call_ack <= call_ack_sig;
	start <= call_ack_sig;
	enable_call_data <= call_ack_sig;

	process(clk)
	begin
		if(clk'event and clk = '1') then
			if(reset = '1' or (return_ack_sig = '1' and return_req = '1')) then
				return_reg <= '0';
			elsif (fin = '1') then
				return_reg <= '1';
			end if;
		end if;
	end process;
	return_ack_sig <= return_reg or fin;
	return_ack <= return_ack_sig;
	enable_return_data <= fin;
end Struct;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.OperatorPackage.all;
use ahir.FloatOperatorPackage.all;

entity GenericCombinationalOperator is
  generic
    (
      operator_id   : string := "ApIntAdd";          -- operator id
      input1_is_int : Boolean := true; -- false means float
      input1_characteristic_width : integer := 0; -- characteristic width if input1 is float
      input1_mantissa_width       : integer := 0; -- mantissa width if input1 is float
      iwidth_1      : integer := 4;    -- width of input1
      input2_is_int : Boolean := true; -- false means float
      input2_characteristic_width : integer := 0; -- characteristic width if input2 is float
      input2_mantissa_width       : integer := 0; -- mantissa width if input2 is float
      iwidth_2      : integer := 0;    -- width of input2
      num_inputs    : integer := 1;    -- can be 1 or 2.
      output_is_int : Boolean := true;  -- false means that the output is a float
      output_characteristic_width : integer := 0;
      output_mantissa_width       : integer := 0;
      owidth        : integer := 4;          -- width of output.
      constant_operand : std_logic_vector := "0001"; -- constant operand.. (it is always the second operand)
      constant_width: integer := 4;
      use_constant  : boolean := true
      );
  port (
    data_in       : in  std_logic_vector(iwidth_1 + iwidth_2 - 1 downto 0);
    result      : out std_logic_vector(owidth-1 downto 0)
    );
end GenericCombinationalOperator;


architecture Vanilla of GenericCombinationalOperator is
  constant iwidth : integer := iwidth_1 + iwidth_2;
begin  -- Behave

  assert((num_inputs = 1) or (num_inputs = 2)) report "either 1 or 2 inputs" severity failure;

  TwoOperand : if num_inputs = 2 generate
    -- int x int -> int
    TwoOpIntIntInt: if input1_is_int and input2_is_int and output_is_int generate
      process(data_in)
        variable   result_var : std_logic_vector(owidth-1 downto 0);
        variable op1: std_logic_vector(iwidth_1-1 downto 0);
        variable op2: std_logic_vector(iwidth_2-1 downto 0);
      begin
        op1 := data_in(iwidth-1 downto iwidth_2);
        op2 := data_in(iwidth_2-1 downto 0);
        TwoInputOperation(operator_id, op1, op2,result_var);
        result <= result_var;
      end process;
    end generate TwoOpIntIntInt;

    -- float x float -> float
    TwoOpFloatFloatFloat: if (not input1_is_int) and (not input2_is_int) and (not output_is_int) generate
      process(data_in)
        variable op1: IStdLogicVector(input1_characteristic_width downto (- input1_mantissa_width));
        variable op2: IStdLogicVector(input2_characteristic_width downto (- input2_mantissa_width));
        variable   result_var: IStdLogicVector(output_characteristic_width downto (-output_mantissa_width));
      begin
        op1 := To_ISLV(data_in(iwidth-1 downto iwidth_2));
        op2 := To_ISLV(data_in(iwidth_2-1 downto 0));
        TwoInputFloatOperation(operator_id, op1,op2,result_var);
        result <= To_SLV(result_var);
      end process;
    end generate TwoOpFloatFloatFloat;

    -- float x float -> int
    TwoOpFloatFloatInt: if (not input1_is_int) and (not input2_is_int) and output_is_int generate
      process(data_in)
        variable op1: IStdLogicVector(input1_characteristic_width downto (- input1_mantissa_width));
        variable op2: IStdLogicVector(input2_characteristic_width downto (- input2_mantissa_width));
        variable   result_var: IStdLogicVector(owidth-1 downto 0);
      begin
        op1 := To_ISLV(data_in(iwidth-1 downto iwidth_2));
        op2 := To_ISLV(data_in(iwidth_2-1 downto 0));
        TwoInputFloatOperation(operator_id, op1,op2,result_var);
        result <= To_SLV(result_var);
      end process;
    end generate TwoOpFloatFloatInt;

    -- float x int -> * and int x float -> * are not permitted.
    assert(input1_is_int = input2_is_int) report "both operands of two input operators should be either ints or floats"
      severity failure;

    -- int x int -> float is not permitted.
    assert((not input1_is_int) or output_is_int) report "if the inputs to a two-input operation are ints, the output cannot be a float!" severity failure;

  end generate TwoOperand;


  SingleOperandNoConstant : if num_inputs = 1 and not use_constant generate

    SingleOperandNoConstantIntInt: if input1_is_int and output_is_int generate
      process(data_in)
        variable   result_var    : std_logic_vector(owidth-1 downto 0);
      begin
        SingleInputOperation(operator_id, data_in, result_var);
        result <= result_var;
      end process;
    end generate SingleOperandNoConstantIntInt;
    
    SingleOperandNoConstantFloatFloat: if (not input1_is_int) and (not output_is_int) generate
      process(data_in)
        variable op1: IStdLogicVector(input1_characteristic_width downto (- input1_mantissa_width));
        variable result_var: IStdLogicVector(output_characteristic_width downto (- output_mantissa_width));
      begin
        op1 := To_ISLV(data_in);
        SingleInputFloatOperation(operator_id, op1, result_var);
        result <= To_SLV(result_var);
      end process;
    end generate SingleOperandNoConstantFloatFloat;

    SingleOperandNoConstantFloatInt: if (not input1_is_int) and output_is_int generate
      process(data_in)
        variable op1: IStdLogicVector(input1_characteristic_width downto (- input1_mantissa_width));
        variable result_var: IStdLogicVector(owidth-1 downto 0);
      begin
        op1 := To_ISLV(data_in);
        SingleInputFloatOperation(operator_id, op1, result_var);
        result <= To_SLV(result_var);
      end process;
    end generate SingleOperandNoConstantFloatInt;

    SingleOperandNoConstantIntFloat: if (input1_is_int) and (not output_is_int) generate
      process(data_in)
        variable result_var: IStdLogicVector(output_characteristic_width downto (- output_mantissa_width));
      begin
        SingleInputFloatOperation(operator_id, To_ISLV(data_in), result_var);
        result <= To_SLV(result_var);
      end process;
    end generate SingleOperandNoConstantIntFloat;
  end generate SingleOperandNoConstant;

  SingleOperandWithConstant : if num_inputs = 1 and use_constant generate

    SingleOperandWithConstantIntInt: if input1_is_int and output_is_int generate
      SigBlock: block
        signal op2_sig : std_logic_vector(constant_width-1 downto 0);
      begin  -- block SigBlock
        -- TODO: changes here.
        op2_sig <= constant_operand;

        process(data_in,op2_sig)
          variable   result_var    : std_logic_vector(owidth-1 downto 0);
        begin
          TwoInputOperation(operator_id,
                            data_in,
                            op2_sig,
                            result_var); 
          result <= result_var;
        end process;
      end block SigBlock;
    end generate SingleOperandWithConstantIntInt;

    SingleOperandWithConstantFloatInt: if (not input1_is_int) and output_is_int generate
      process(data_in)
        variable op1: IStdLogicVector(input1_characteristic_width downto (- input1_mantissa_width));
        constant op2: IStdLogicVector(input2_characteristic_width downto (- input2_mantissa_width)) 
          := To_ISLV(constant_operand);
        variable   result_var: IStdLogicVector(owidth-1 downto 0);
      begin
        op1 := To_ISLV(data_in);	
        TwoInputFloatOperation(operator_id, op1, op2, result_var);
        result <= To_SLV(result_var);
      end process;
    end generate SingleOperandWithConstantFloatInt;

    SingleOperandWithConstantFloatFloat: if (not input1_is_int) and (not output_is_int) generate
      process(data_in)
        variable op1: IStdLogicVector(input1_characteristic_width downto (- input1_mantissa_width));
        constant op2: IStdLogicVector(input2_characteristic_width downto (- input2_mantissa_width)) 
          := To_ISLV(constant_operand);
        variable result_var: IStdLogicVector(output_characteristic_width downto (- output_mantissa_width));
      begin
        op1 := To_ISLV(data_in);
        TwoInputFloatOperation(operator_id, op1, op2, result_var);
        result <= To_SLV(result_var);
      end process;
    end generate SingleOperandWithConstantFloatFloat;
  end generate SingleOperandWithConstant;
  
end Vanilla;



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity InputMuxBaseNoData is
  generic ( twidth: integer;
	   nreqs: integer;
	   no_arbitration: Boolean);
  port (
    -- req/ack follow pulse protocol
    reqL                 : in  BooleanArray(nreqs-1 downto 0);
    ackL                 : out BooleanArray(nreqs-1 downto 0);
    -- output side req/ack level protocol
    reqR                 : out std_logic;
    ackR                 : in  std_logic;
    -- tag specifies the requester index 
    tagR                : out std_logic_vector(twidth-1 downto 0);
    clk, reset          : in std_logic);
end InputMuxBaseNoData;


architecture Behave of InputMuxBaseNoData is

  signal reqP,ackP,ssig : std_logic_vector(nreqs-1 downto 0);
  signal fEN: std_logic_vector(nreqs-1 downto 0);  

  constant tag0 : std_logic_vector(twidth-1 downto 0) := (others => '0');

  -- one-cycle delay between req and ack => in order to break long
  -- combinational (false) paths.
  constant suppress_immediate_ack : BooleanArray(reqL'length-1 downto 0) := (others => true);
begin  -- Behave


  -----------------------------------------------------------------------------
  -- pulse to level translate
  -----------------------------------------------------------------------------
  P2L: for I in nreqs-1 downto 0 generate
      P2LBlk: block
      begin  -- block P2L          
        p2Linst: Pulse_To_Level_Translate_Entity
          port map (rL => reqL(I), rR => reqP(I), aL => ackL(I), aR => ackP(I),
                                 clk => clk, reset => reset);
      end block P2LBlk;

  end generate P2L;
  


  -----------------------------------------------------------------------------
  -- priority encoding or pass through
  -----------------------------------------------------------------------------
  NoArbitration: if no_arbitration generate
    fEN <= reqP;
    reqR <= OrReduce(fEN);
    ackP <= fEN when ackR = '1' else (others => '0');
  end generate NoArbitration;

  Arbitration: if not no_arbitration generate
    rpeInst: Request_Priority_Encode_Entity
      generic map (num_reqs => reqP'length)
      port map( clk => clk,
                reset => reset,
                reqR => reqP,
                ackR => ackP,
                forward_enable => fEN,
                req_s => reqR,
                ack_s => ackR);
    
  end generate Arbitration;

  -----------------------------------------------------------------------------
  -- tag generation
  -----------------------------------------------------------------------------
  taggen : BinaryEncoder generic map (
    iwidth => nreqs,
    owidth => twidth)
    port map (
      din  => fEN,
      dout => tagR);

end Behave;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity InputMuxBase is
  generic ( iwidth: integer := 10;
	   owidth: integer := 10;
	   twidth: integer := 3;
	   nreqs: integer := 1;
	   no_arbitration: Boolean := true;
	   registered_output: Boolean := false);
  port (
    -- req/ack follow pulse protocol
    reqL                 : in  BooleanArray(nreqs-1 downto 0);
    ackL                 : out BooleanArray(nreqs-1 downto 0);
    dataL                : in  std_logic_vector(iwidth-1 downto 0);
    -- output side req/ack level protocol
    reqR                 : out std_logic;
    ackR                 : in  std_logic;
    dataR                : out std_logic_vector(owidth-1 downto 0);
    -- tag specifies the requester index 
    tagR                : out std_logic_vector(twidth-1 downto 0);
    clk, reset          : in std_logic);
end InputMuxBase;


architecture Behave of InputMuxBase is

  signal reqP,ackP,fEN : std_logic_vector(nreqs-1 downto 0);

  type WordArray is array (natural range <>) of std_logic_vector(owidth-1 downto 0);
  signal dataP : WordArray(nreqs-1 downto 0);

  constant tag0 : std_logic_vector(twidth-1 downto 0) := (others => '0');

  -- one-cycle delay between req and ack => in order to break long
  -- combinational (false) paths.
  constant suppress_immediate_ack : BooleanArray(reqL'length-1 downto 0) := (others => true);

  -- intermediate signals.
  signal reqR_sig                : std_logic;
  signal ackR_sig                : std_logic;
  signal dataR_sig               : std_logic_vector(owidth-1 downto 0);
  signal tagR_sig                : std_logic_vector(twidth-1 downto 0);

begin  -- Behave


  assert(iwidth = owidth*nreqs) report "mismatched i/o widths in InputMuxBase" severity error;

  -----------------------------------------------------------------------------
  -- output queue if registered_output is set.
  -----------------------------------------------------------------------------
  OutputRepeater: if registered_output generate

    -- purpose: output queue
    OqBlock: block
      signal oq_data_in : std_logic_vector((twidth + owidth)-1 downto 0);
      signal oq_data_out : std_logic_vector((twidth + owidth)-1 downto 0);
    begin  -- block OqBlock

      oq_data_in <= dataR_sig & tagR_sig;
      dataR <= oq_data_out((twidth+owidth)-1 downto twidth);
      tagR <= oq_data_out(twidth-1 downto 0);
      
      oqueue : QueueBase generic map (
        queue_depth => 2,
        data_width  => twidth + owidth)
        port map (
          clk      => clk,
          reset    => reset,
          data_in  => oq_data_in,
          push_req => reqR_sig,
          push_ack => ackR_sig,
          data_out => oq_data_out,
          pop_ack  => reqR,
          pop_req  => ackR);

    end block OqBlock;
  end generate OutputRepeater;

  NoOutputRepeater: if not registered_output generate
    
    dataR <= dataR_sig;
    reqR <= reqR_sig;
    ackR_sig <= ackR;
    tagR <= tagR_sig;
    
  end generate NoOutputRepeater;
  
  -----------------------------------------------------------------------------
  -- pulse to level translate
  -----------------------------------------------------------------------------
  P2L: for I in nreqs-1 downto 0 generate
    p2Linstance: Pulse_To_Level_Translate_Entity
      port map(rL => reqL(I), rR => reqP(I), aL => ackL(I), aR => ackP(I),
               clk => clk, reset => reset);     

    process(dataL)
      variable regv : std_logic_vector(owidth-1 downto 0);
    begin
      Extract(dataL,I,regv);
      dataP(I) <= regv;
    end process;
    
  end generate P2L;

  -----------------------------------------------------------------------------
  -- priority encoding or pass through
  -----------------------------------------------------------------------------
  NoArbitration: if no_arbitration generate
    fEN <= reqP;
    reqR_sig <= OrReduce(fEN);
    ackP <= fEN when ackR_sig = '1' else (others => '0');
  end generate NoArbitration;

  Arbitration: if not no_arbitration generate
    
    rpe : Request_Priority_Encode_Entity generic map (
      num_reqs => reqP'length)
      port map(
                          clk => clk,
                          reset => reset,
                          reqR => reqP,
                          ackR => ackP,
                          forward_enable => fEN,
                          req_s => reqR_sig,
                          ack_s => ackR_sig);
    
  end generate Arbitration;

  -----------------------------------------------------------------------------
  -- final multiplexor
  -----------------------------------------------------------------------------
  process(fEN,dataP)
  begin
    dataR_sig <= (others => '0');
    for J in 0 to nreqs-1 loop
      if(fEN(J) = '1') then
        dataR_sig <= dataP(J);
        exit;
      end if;
    end loop;
  end process;    

  -----------------------------------------------------------------------------
  -- tag generation
  -----------------------------------------------------------------------------
  taggen : BinaryEncoder generic map (
    iwidth => nreqs,
    owidth => twidth)
    port map (
      din  => fEN,
      dout => tagR_sig);

end Behave;
library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

entity InputPortLevelNoData is
  
  generic (num_reqs: integer; 
	no_arbitration: boolean);
  port (
    -- ready/ready interface with the requesters
    req       : in  std_logic_vector(num_reqs-1 downto 0);
    ack       : out std_logic_vector(num_reqs-1 downto 0);
    -- ready/ready interface with outside world
    oreq       : out std_logic;
    oack       : in  std_logic;
    clk, reset : in  std_logic);
  
end InputPortLevelNoData;

architecture default_arch of InputPortLevelNoData is

  signal req_active, ack_sig  : std_logic_vector(num_reqs-1 downto 0); 
  
begin  -- default_arch

  oreq <= OrReduce(req_active);

  NoArb: if no_arbitration generate
    req_active <= req;
  end generate NoArb;

  Arb: if not no_arbitration generate
    req_active <= PriorityEncode(req);
  end generate Arb;

  gen: for I in num_reqs-1 downto 0 generate

    ack_sig(I) <= req_active(I) and oack; 
    
    ack(I) <= ack_sig(I);
    
  end generate gen;

end default_arch;
library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

entity InputPortLevel is
  
  generic (num_reqs: integer := 5; 
	data_width: integer := 8;  
	no_arbitration: boolean := true);
  port (
    -- ready/ready interface with the requesters
    req       : in  std_logic_vector(num_reqs-1 downto 0);
    ack       : out std_logic_vector(num_reqs-1 downto 0);
    data      : out std_logic_vector((num_reqs*data_width)-1 downto 0);
    -- ready/ready interface with outside world
    oreq       : out std_logic;
    oack       : in  std_logic;
    odata      : in  std_logic_vector(data_width-1 downto 0);
    clk, reset : in  std_logic);
  
end InputPortLevel;

architecture default_arch of InputPortLevel is

  
  type IPWArray is array(integer range <>) of std_logic_vector(data_width-1 downto 0);
  signal data_final, data_reg : IPWArray(num_reqs-1 downto 0);
  signal req_active, ack_sig  : std_logic_vector(num_reqs-1 downto 0); 
  
  
begin  -- default_arch

  oreq <= OrReduce(req_active);

  NoArb: if no_arbitration generate
    req_active <= req;
  end generate NoArb;

  Arb: if not no_arbitration generate
    req_active <= PriorityEncode(req);
  end generate Arb;

  process(data_final)
    variable ldata: std_logic_vector((num_reqs*data_width)-1 downto 0);
  begin
    for J in num_reqs-1 downto 0 loop
      Insert(ldata,J,data_final(J));
    end loop;
    data <= ldata;
  end process;

  gen: for I in num_reqs-1 downto 0 generate

    ack_sig(I) <= req_active(I) and oack; 
    
    ack(I) <= ack_sig(I);
    
    data_final(I) <= odata;
    
  end generate gen;

end default_arch;
library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Components.all;
use ahir.BaseComponents.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

entity InputPortNoData is
  generic (num_reqs: integer;
	   no_arbitration: boolean);
  port (
    -- pulse interface with the data-path
    req        : in  BooleanArray(num_reqs-1 downto 0);
    ack        : out BooleanArray(num_reqs-1 downto 0);
    -- ready/ready interface with outside world
    oreq       : out std_logic;
    oack       : in  std_logic;
    clk, reset : in  std_logic);
end entity;


architecture Base of InputPortNoData is

  signal reqR, ackR : std_logic_vector(num_reqs-1 downto 0);
  signal fEN: std_logic_vector(num_reqs-1 downto 0);

begin

  -----------------------------------------------------------------------------
  -- protocol conversion
  -----------------------------------------------------------------------------
  ProTx : for I in 0 to num_reqs-1 generate
    P2L : block
    begin  -- block P2L
      p2LInst: Pulse_To_Level_Translate_Entity
        port map (rL            => req(I),
                  rR            => reqR(I),
                  aL            => ack(I),
                  aR            => ackR(I),
                  clk           => clk,
                  reset         => reset);
    end block P2L;
  end generate ProTx;

  demux : InputPortLevelNoData generic map (
    num_reqs       => num_reqs,
    no_arbitration => no_arbitration)
    port map (
      req => reqR,
      ack => ackR,
      oreq => oreq,
      oack => oack,
      clk => clk,
      reset => reset);

end Base;
library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Components.all;
use ahir.BaseComponents.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

entity InputPort is
  generic (num_reqs: integer := 5;
	   data_width: integer := 8;
	   no_arbitration: boolean := true);
  port (
    -- pulse interface with the data-path
    req        : in  BooleanArray(num_reqs-1 downto 0);
    ack        : out BooleanArray(num_reqs-1 downto 0);
    data       : out std_logic_vector((num_reqs*data_width)-1 downto 0);
    -- ready/ready interface with outside world
    oreq       : out std_logic;
    oack       : in  std_logic;
    odata      : in  std_logic_vector(data_width-1 downto 0);
    clk, reset : in  std_logic);
end entity;


architecture Base of InputPort is

  signal reqR, ackR : std_logic_vector(num_reqs-1 downto 0);
  signal fEN: std_logic_vector(num_reqs-1 downto 0);

  type   IPWArray is array(integer range <>) of std_logic_vector(data_width-1 downto 0);
  signal data_reg, data_final: IPWArray(num_reqs-1 downto 0);
  signal demux_data : std_logic_vector((num_reqs*data_width)-1 downto 0);
  
begin

  -----------------------------------------------------------------------------
  -- protocol conversion
  -----------------------------------------------------------------------------
  ProTx : for I in 0 to num_reqs-1 generate

    P2L : block
    begin  -- block P2L
      p2LInst: Pulse_To_Level_Translate_Entity
        port map (rL            => req(I),
                  rR            => reqR(I),
                  aL            => ack(I),
                  aR            => ackR(I),
                  clk           => clk,
                  reset         => reset);

    end block P2L;
    
  end generate ProTx;

  demux : InputPortLevel generic map (
    num_reqs       => num_reqs,
    data_width     => data_width,
    no_arbitration => no_arbitration)
    port map (
      req => reqR,
      ack => ackR,
      data => demux_data,
      oreq => oreq,
      odata => odata,
      oack => oack,
      clk => clk,
      reset => reset);

  -----------------------------------------------------------------------------
  -- data handling
  -----------------------------------------------------------------------------
  process(data_final)
    variable ldata: std_logic_vector((num_reqs*data_width)-1 downto 0);
  begin
    for J in num_reqs-1 downto 0 loop
      Insert(ldata,J,data_final(J));
    end loop;
    data <= ldata;
  end process;

  gen : for I in num_reqs-1 downto 0 generate

    process(clk)
      variable target: std_logic_vector(data_width-1 downto 0);
    begin
      if(clk'event and clk = '1') then
        if (ackR(I) = '1') then
          Extract(demux_data,I,target);
          data_reg(I) <= target;
        end if;
      end if;
    end process;

    data_final(I) <= data_reg(I);
    
  end generate gen;

end Base;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity LoadCompleteShared is
    generic
    (
      data_width: integer := 8;
      tag_length:  integer := 1;
      num_reqs : integer := 1;
      no_arbitration: boolean := true
    );
  port (
    -- req/ack follow level protocol
    reqR                     : in BooleanArray(num_reqs-1 downto 0);
    ackR                     : out BooleanArray(num_reqs-1 downto 0);
    dataR                    : out std_logic_vector((data_width*num_reqs)-1 downto 0);
    -- output data consists of concatenated pairs of ops.
    mdata                    : in std_logic_vector(data_width-1 downto 0);
    mreq                     : out  std_logic;
    mack                     : in std_logic;
    mtag                     : in std_logic_vector(tag_length-1 downto 0);
    -- with dataR
    clk, reset              : in std_logic);
end LoadCompleteShared;

architecture Vanilla of LoadCompleteShared is

begin  -- Behave


  odemux: OutputDeMuxBase
    generic map (
      iwidth => data_width,
      owidth =>  data_width*num_reqs,
      twidth =>  tag_length,
      nreqs  => num_reqs,
      no_arbitration => no_arbitration)
    port map (
      reqL   => mack,                   -- cross-over (mack from mem-subsystem)
      ackL   => mreq,                   -- cross-over 
      dataL =>  mdata,
      tagL  =>  mtag,
      reqR  => reqR,
      ackR  => ackR,
      dataR => dataR,
      clk   => clk,
      reset => reset);
  
  
end Vanilla;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity LoadReqShared is
  generic
    (
	addr_width: integer := 8;
      	num_reqs : integer := 1; -- how many requesters?
	tag_length: integer := 1;
	no_arbitration: Boolean := true;
        min_clock_period: Boolean := false
    );
  port (
    -- req/ack follow pulse protocol
    reqL                     : in BooleanArray(num_reqs-1 downto 0);
    ackL                     : out BooleanArray(num_reqs-1 downto 0);
    -- concatenated address corresponding to access
    dataL                    : in std_logic_vector((addr_width*num_reqs)-1 downto 0);
    -- address to memory
    maddr                   : out std_logic_vector(addr_width-1 downto 0);
    mtag                    : out std_logic_vector(tag_length-1 downto 0);
    mreq                    : out std_logic;
    mack                    : in std_logic;
    -- clock, reset (active high)
    clk, reset              : in std_logic);
end LoadReqShared;

architecture Vanilla of LoadReqShared is

  constant iwidth: integer := addr_width*num_reqs;
  constant owidth: integer := addr_width;

  constant debug_flag : boolean := false;
  
begin  -- Behave
  assert(tag_length >= Ceil_Log2(num_reqs)) report "insufficient tag width" severity error;


  -- xilinx xst does not like this assertion...
  DbgAssert: if debug_flag generate
    assert( (not ((reset = '0') and (clk'event and clk = '1') and no_arbitration)) or Is_At_Most_One_Hot(reqL))
      report "in no-arbitration case, at most one request should be hot on clock edge (in SplitOperatorShared)" severity error;    
  end generate DbgAssert;

  
  imux: InputMuxBase
    generic map(iwidth => iwidth,
                owidth => owidth, 
                twidth => tag_length,
                nreqs => num_reqs,
                no_arbitration => no_arbitration,
                registered_output => min_clock_period)
    port map(
      reqL       => reqL,
      ackL       => ackL,
      dataL      => dataL,
      reqR       => mreq,
      ackR       => mack,
      dataR      => maddr,
      tagR       => mtag,
      clk        => clk,
      reset      => reset);
  
end Vanilla;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

entity OutputDeMuxBaseNoData is
  generic(twidth: integer;
	  nreqs: integer;
	  no_arbitration: Boolean);
  port (
    -- req/ack follow level protocol
    reqL                 : in  std_logic;
    ackL                 : out std_logic;
    -- tag identifies index to which demux
    -- should happen
    tagL                 : in std_logic_vector(twidth-1 downto 0);
    -- reqR/ackR follow pulse protocol
    -- and are of length n
    reqR                : in BooleanArray(nreqs-1 downto 0);
    ackR                : out  BooleanArray(nreqs-1 downto 0);
    clk, reset          : in std_logic);
end OutputDeMuxBaseNoData;

architecture Behave of OutputDeMuxBaseNoData is
  
  signal ackL_sig : std_logic_vector(nreqs-1 downto 0);
begin  -- Behave

  -----------------------------------------------------------------------------
  -- parallel generate across all requesters
  -----------------------------------------------------------------------------
  PGen: for I in reqR'range generate
    RegFSM: block
      signal valid: std_logic;
      signal lhs_clear : std_logic;
      signal rhs_state, lhs_state : std_logic;
    begin  -- block Reg
      
      ---------------------------------------------------------------------------
      -- valid true if this I is mentioned in tag
      ---------------------------------------------------------------------------
      valid <= '1' when (reqL = '1') and (I = To_Integer(To_Unsigned(tagL))) else '0';

      ---------------------------------------------------------------------------
      -- lhs-state machine.
      ---------------------------------------------------------------------------
      process(clk,lhs_state, lhs_clear,reset,valid)
        variable nstate : std_logic;
        variable aL_var : std_logic;
      begin
        nstate := lhs_state;
        aL_var := '0';
        
        case lhs_state is
          when '0' =>
            if(valid = '1') then
              nstate := '1';
              aL_var := '1';
            end if;
          when '1' =>
            if(lhs_clear = '1') then
              nstate := '0';
            end if;
          when others => null;
        end case;

        if(reset = '1') then
          nstate := '0';
        end if;        

        ackL_sig(I) <= aL_var;
        
        if(clk'event and clk = '1') then
          lhs_state <= nstate;
        end if;
      end process;

      -------------------------------------------------------------------------
      -- rhs state machine
      -------------------------------------------------------------------------
     process(clk,rhs_state,reset,reqR(I),lhs_state)
       variable nstate : std_logic;
       variable aR_var : boolean;
       variable lhs_clear_var : std_logic;
     begin
        nstate := rhs_state;
        aR_var := false;
        lhs_clear_var := '0';
        
        case rhs_state is
          when '0' =>
            if(reqR(I)) then
              if(lhs_state = '1') then
                aR_var := true;
                lhs_clear_var := '1';
              else
                nstate := '1';
              end if;
            end if;
          when '1' =>
            if(lhs_state = '1') then
              lhs_clear_var := '1';
              aR_var := true;
              nstate := '0';
            end if;
          when others => null;
        end case;

        if(reset = '1') then
          nstate := '0';
        end if;        

        ackR(I) <= aR_var;
        lhs_clear <= lhs_clear_var;
        
        if(clk'event and clk = '1') then
          rhs_state <= nstate;
        end if;
     end process;
    end block RegFSM;
    
  end generate PGen;

  -----------------------------------------------------------------------------
  -- ackL
  -----------------------------------------------------------------------------
  ackL <= OrReduce(ackL_sig);

end Behave;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

-------------------------------------------------------------------------------
-- a single level requester on the left, and nreq requesters on the right.
--
-- reqR -> ackR can be zero delay.
-- reqL -> ackL has at least a unit delay
-------------------------------------------------------------------------------
entity OutputDeMuxBase is
  generic(iwidth: integer := 4;
	  owidth: integer := 12;
	  twidth: integer := 2;
	  nreqs: integer := 3;
	  no_arbitration: Boolean := true);
  port (
    -- req/ack follow level protocol
    reqL                 : in  std_logic;
    ackL                 : out std_logic;
    dataL                : in  std_logic_vector(iwidth-1 downto 0);
    -- tag identifies index to which demux
    -- should happen
    tagL                 : in std_logic_vector(twidth-1 downto 0);
    -- reqR/ackR follow pulse protocol
    -- and are of length n
    reqR                : in BooleanArray(nreqs-1 downto 0);
    ackR                : out  BooleanArray(nreqs-1 downto 0);
    -- dataR is array(n,m) 
    dataR               : out std_logic_vector(owidth-1 downto 0);
    clk, reset          : in std_logic);
end OutputDeMuxBase;

architecture Behave of OutputDeMuxBase is

  type WordArray is array (natural range <>) of std_logic_vector(iwidth-1 downto 0);
  signal dfinal: WordArray(nreqs-1 downto 0);

  signal ackL_sig : std_logic_vector(nreqs-1 downto 0);
begin  -- Behave

  assert(owidth = iwidth*nreqs) report "word-length mismatch in output demux" severity failure;

  -----------------------------------------------------------------------------
  -- dataR
  -----------------------------------------------------------------------------
  process(dfinal)
    variable dataRv : std_logic_vector(dataR'high downto dataR'low);
  begin
    for I in dfinal'range loop
      Insert(dataRv,I,dfinal(I));
    end loop;
    dataR <= dataRv;
  end process;

  -----------------------------------------------------------------------------
  -- parallel generate across all requesters
  -----------------------------------------------------------------------------
  PGen: for I in reqR'range generate
    RegFSM: block
      signal valid: std_logic;
      signal lhs_clear : std_logic;
      signal rhs_state, lhs_state : std_logic;
    begin  -- block Reg
      
      ---------------------------------------------------------------------------
      -- valid true if this I is mentioned in tag
      ---------------------------------------------------------------------------
      valid <= '1' when (reqL = '1') and (I = To_Integer(To_Unsigned(tagL))) else '0';

      ---------------------------------------------------------------------------
      -- lhs-state machine.
      ---------------------------------------------------------------------------
      process(clk,lhs_state, lhs_clear,reset,valid)
        variable nstate : std_logic;
        variable latch_flag : boolean;
        variable aL_var : std_logic;
      begin
        nstate := lhs_state;
        latch_flag := false;
        aL_var := '0';
        
        case lhs_state is
          when '0' =>
            if(valid = '1') then
              nstate := '1';
              latch_flag := true;
              aL_var := '1';
            end if;
          when '1' =>
            if(lhs_clear = '1') then
              nstate := '0';
            end if;
          when others => null;
        end case;

        if(reset = '1') then
          nstate := '0';
        end if;        

        ackL_sig(I) <= aL_var;
        
        if(clk'event and clk = '1') then
          lhs_state <= nstate;
          if(latch_flag) then
            dfinal(I) <= dataL;
          end if;          
        end if;
      end process;

      -------------------------------------------------------------------------
      -- rhs state machine
      -------------------------------------------------------------------------
     process(clk,rhs_state,reset,reqR(I),lhs_state)
       variable nstate : std_logic;
       variable aR_var : boolean;
       variable lhs_clear_var : std_logic;
     begin
        nstate := rhs_state;
        aR_var := false;
        lhs_clear_var := '0';
        
        case rhs_state is
          when '0' =>
            if(reqR(I)) then
              if(lhs_state = '1') then
                aR_var := true;
                lhs_clear_var := '1';
              else
                nstate := '1';
              end if;
            end if;
          when '1' =>
            if(lhs_state = '1') then
              lhs_clear_var := '1';
              aR_var := true;
              nstate := '0';
            end if;
          when others => null;
        end case;

        if(reset = '1') then
          nstate := '0';
        end if;        

        ackR(I) <= aR_var;
        lhs_clear <= lhs_clear_var;
        
        if(clk'event and clk = '1') then
          rhs_state <= nstate;
        end if;
     end process;
    end block RegFSM;
    
  end generate PGen;

  -----------------------------------------------------------------------------
  -- ackL
  -----------------------------------------------------------------------------
  ackL <= OrReduce(ackL_sig);


end Behave;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity OutputPortLevelNoData is
  generic(num_reqs: integer;
	no_arbitration: boolean);
  port (
    req       : in  std_logic_vector(num_reqs-1 downto 0);
    ack       : out std_logic_vector(num_reqs-1 downto 0);
    oreq       : out std_logic;
    oack       : in  std_logic;
    clk, reset : in  std_logic);
end entity;

architecture Base of OutputPortLevelNoData is
  signal req_active, ack_sig  : std_logic_vector(num_reqs-1 downto 0);
begin
  
  oreq <= OrReduce(req_active);

  NoArb: if no_arbitration generate
     req_active <= req;
  end generate NoArb;

  Arb: if not no_arbitration generate
     req_active <= PriorityEncode(req);
  end generate Arb;

  gen: for I in num_reqs-1 downto 0 generate
       ack_sig(I) <= req_active(I) and oack; 
       ack(I) <= ack_sig(I);
  end generate gen;

end Base;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity OutputPortLevel is
  generic(num_reqs: integer;
	data_width: integer;
	no_arbitration: boolean);
  port (
    req       : in  std_logic_vector(num_reqs-1 downto 0);
    ack       : out std_logic_vector(num_reqs-1 downto 0);
    data      : in  std_logic_vector((num_reqs*data_width)-1 downto 0);
    oreq       : out std_logic;
    oack       : in  std_logic;
    odata      : out std_logic_vector(data_width-1 downto 0);
    clk, reset : in  std_logic);
end entity;

architecture Base of OutputPortLevel is
  
  type OPWArray is array(integer range <>) of std_logic_vector(odata'range);
  signal data_array : OPWArray(num_reqs-1 downto 0);
  signal req_active, ack_sig  : std_logic_vector(num_reqs-1 downto 0);
  
begin
  
  oreq <= OrReduce(req_active);

  NoArb: if no_arbitration generate
     req_active <= req;
  end generate NoArb;

  Arb: if not no_arbitration generate
     req_active <= PriorityEncode(req);
  end generate Arb;

  process (data_array)
    variable var_odata : std_logic_vector(data_width-1 downto 0) := (others => '0');
  begin  -- process
    var_odata := (others => '0');
    for I in 0 to num_reqs-1 loop
      var_odata := data_array(I) or var_odata;
    end loop;  -- I
    odata <= var_odata;
  end process;

  gen: for I in num_reqs-1 downto 0 generate

       ack_sig(I) <= req_active(I) and oack; 
       ack(I) <= ack_sig(I);

       process(data,req_active(I))
         variable target: std_logic_vector(data_width-1 downto 0);
       begin
          if(req_active(I) = '1') then
		Extract(data,I,target);
	  else
		target := (others => '0');
	  end if;	
       	  data_array(I) <= target;
       end process;
         
  end generate gen;

end Base;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity OutputPortNoData is
  generic(num_reqs: integer;
	  no_arbitration: boolean);
  port (
    req        : in  BooleanArray(num_reqs-1 downto 0);
    ack        : out BooleanArray(num_reqs-1 downto 0);
    oreq       : out std_logic;
    oack       : in  std_logic;
    clk, reset : in  std_logic);
end entity;

architecture Base of OutputPortNoData is

  signal reqR, ackR : std_logic_vector(num_reqs-1 downto 0);
  signal fEN: std_logic_vector(num_reqs-1 downto 0);

  
begin

  -----------------------------------------------------------------------------
  -- protocol conversion
  -----------------------------------------------------------------------------
  ProTx : for I in 0 to num_reqs-1 generate

    P2L : block
    begin  -- block P2L
      p2LInst: Pulse_To_Level_Translate_Entity
        port map (rL            => req(I),
                  rR            => reqR(I),
                  aL            => ack(I),
                  aR            => ackR(I),
                  clk           => clk,
                  reset         => reset);

    end block P2L;
    
  end generate ProTx;

  mux : OutputPortLevelNoData generic map (
    num_reqs       => num_reqs,
    no_arbitration => no_arbitration)
    port map (
      req   => reqR,
      ack   => ackR,
      oreq  => oreq,
      oack  => oack,
      clk   => clk,
      reset => reset);
    

             
end Base;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity OutputPort is
  generic(num_reqs: integer;
	  data_width: integer;
	  no_arbitration: boolean);
  port (
    req        : in  BooleanArray(num_reqs-1 downto 0);
    ack        : out BooleanArray(num_reqs-1 downto 0);
    data       : in  std_logic_vector((num_reqs*data_width)-1 downto 0);
    oreq       : out std_logic;
    oack       : in  std_logic;
    odata      : out std_logic_vector(data_width-1 downto 0);
    clk, reset : in  std_logic);
end entity;

architecture Base of OutputPort is

  signal reqR, ackR : std_logic_vector(num_reqs-1 downto 0);
  signal fEN: std_logic_vector(num_reqs-1 downto 0);

  type   OPWArray is array(integer range <>) of std_logic_vector(data_width-1 downto 0);
  signal data_array : OPWArray(num_reqs-1 downto 0);

  
begin

  -----------------------------------------------------------------------------
  -- protocol conversion
  -----------------------------------------------------------------------------
  ProTx : for I in 0 to num_reqs-1 generate

    P2L : block
    begin  -- block P2L
      p2LInst: Pulse_To_Level_Translate_Entity
        port map(rL            => req(I),
                 rR            => reqR(I),
                 aL            => ack(I),
                 aR            => ackR(I),
                 clk           => clk,
                 reset         => reset);

    end block P2L;
    
  end generate ProTx;

  mux : OutputPortLevel generic map (
    num_reqs       => num_reqs,
    data_width     => data_width,
    no_arbitration => no_arbitration)
    port map (
      req   => reqR,
      ack   => ackR,
      data  => data,
      oreq  => oreq,
      oack  => oack,
      odata => odata,
      clk   => clk,
      reset => reset);
    

end Base;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity PhiBaseTB is
end entity;


architecture Behave of PhiBaseTB is

	signal a, b, c, d, e, odata : std_logic_vector(4 downto 0);
	signal f : std_logic_vector(24 downto 0);
	signal clk, reset: std_logic := '0';
	signal req: BooleanArray(4 downto 0);
	signal ack: Boolean;

begin  -- Behave

	a <= (0 => '1', others => '0');
	b <= (1 => '1', others => '0');
	c <= (2 => '1', others => '0');
	d <= (3 => '1', others => '0');
	e <= (4 => '1', others => '0');

	f <= e & d & c & b & a;
        

	clk <= not clk after 5 ns;

	process
	begin
		req <= (others => false);
		reset <= '1';
		wait until clk = '1';
		
		reset <= '0';
		for I in 0 to 4 loop
		        req <= (others => false);
			req(I) <= true;
			while true loop
				wait until clk = '1';
                                req(I) <= false;
				if ack then
					exit;
				end if;
			end loop;
			assert (odata(I) = '1') report "result mismatch" severity error;
		end loop;

		wait;
	end process;

        phi : PhiBase
          generic map (
            num_reqs   => 5,
            data_width => 5)
          port map ( req => req,
                     ack => ack,
                     idata => f,
                     odata => odata,
                     clk => clk,
                     reset => reset);
end Behave;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

entity PhiBase is
  generic (
    num_reqs   : integer;
    data_width : integer);
  port (
    req                 : in  BooleanArray(num_reqs-1 downto 0);
    ack                 : out Boolean;
    idata               : in  std_logic_vector((num_reqs*data_width)-1 downto 0);
    odata               : out std_logic_vector(data_width-1 downto 0);
    clk, reset          : in std_logic);
end PhiBase;


architecture Behave of PhiBase is

begin  -- Behave

  assert(idata'length = (odata'length * req'length)) report "data size mismatch" severity failure;

  process(clk)
	variable mux_data : std_logic_vector(odata'length-1 downto 0);
  begin
     if(clk'event and clk = '1') then
	if(reset = '1') then
          ack <= false;
          odata <= (others => '0');
	else
          if(OrReduce(req)) then
            odata <= MuxOneHot(idata,req);
            ack <= true;
          else
            ack <= false;
          end if;
	end if;
     end if;
  end process;

end Behave;
library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity PipeBase is
  
  generic (num_reads: integer;
           num_writes: integer;
           data_width: integer;
           depth: integer := 1);
  port (
    read_req       : in  std_logic_vector(num_reads-1 downto 0);
    read_ack       : out std_logic_vector(num_reads-1 downto 0);
    read_data      : out std_logic_vector((num_reads*data_width)-1 downto 0);
    write_req       : in  std_logic_vector(num_writes-1 downto 0);
    write_ack       : out std_logic_vector(num_writes-1 downto 0);
    write_data      : in std_logic_vector((num_writes*data_width)-1 downto 0);
    clk, reset : in  std_logic);
  
end PipeBase;

architecture default_arch of PipeBase is

  signal pipe_data, pipe_data_repeated : std_logic_vector(data_width-1 downto 0);
  signal pipe_req, pipe_ack, pipe_req_repeated, pipe_ack_repeated: std_logic;
  
  
begin  -- default_arch

  wmux : OutputPortLevel generic map (
    num_reqs       => num_writes,
    data_width     => data_width,
    no_arbitration => false)
    port map (
      req   => write_req,
      ack   => write_ack,
      data  => write_data,
      oreq  => pipe_req,                -- no cross-over, drives req
      oack  => pipe_ack,                -- no cross-over, receives ack
      odata => pipe_data,
      clk   => clk,
      reset => reset);

  queue : QueueBase generic map (
    queue_depth => depth,
    data_width       => data_width)
    port map (
      push_req   => pipe_req,
      push_ack => pipe_ack,
      data_in  => pipe_data,
      pop_req  => pipe_req_repeated,
      pop_ack  => pipe_ack_repeated,
      data_out => pipe_data_repeated,
      clk      => clk,
      reset    => reset);

  rmux : InputPortLevel generic map (
    num_reqs       => num_reads,
    data_width     => data_width,
    no_arbitration => false)
    port map (
      req => read_req,
      ack => read_ack,
      data => read_data,
      oreq => pipe_req_repeated,       
      oack => pipe_ack_repeated,       
      odata => pipe_data_repeated,
      clk => clk,
      reset => reset);
  

end default_arch;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.Components.all;
use ahir.BaseComponents.all;

entity PortTB is
  generic
     ( g_num_req: integer := 2;
       verbose_mode: boolean := false;
       tb_id : string := "anonymous"
     );
end PortTB;

architecture Behave of PortTB is

    constant data_width : integer := 8;
    constant num_req : integer := g_num_req;
    
    signal reqR, ackR, reqL, ackL : BooleanArray(num_req-1 downto 0);
    signal din, dout : std_logic_vector((num_req*data_width)-1 downto 0);

    type   Data2D is array(natural range <>) of std_logic_vector(data_width-1 downto 0);
    signal din_raw, dout_raw: Data2D(num_req-1 downto 0);

    function Build_Data(tmp_addr: in Data2D) return std_logic_vector is
	variable tmp: std_logic_vector((num_req*data_width)-1 downto 0);
    begin
        for I in 0 to num_req-1 loop
            Insert(tmp,I,tmp_addr(I));
        end loop;
	return(tmp);
    end function Build_Data;

    signal clock, reset : std_logic := '0';

    signal done_flag, success_flag: BooleanArray(num_req-1 downto 0);
begin

     clock <= not clock after 5 ns;

     process(done_flag)
     begin
        if(AndReduce(done_flag))then
           if(AndReduce(success_flag)) then
              assert false report "All Tests Have Passed in TB " & tb_id  severity note;
	   else
              assert false report "Some Tests Have Failed in TB " & tb_id severity error;
	   end if;
        end if;
     end process;
    
     process
     begin
	 reset <= '1';
         wait until clock = '1';
         reset <= '0' after 1 ns;
 	 wait;
     end process;

     din <= Build_Data(din_raw);

     GenBlockSend: for R in 0 to num_req-1 generate

       process 
         variable dv: natural;
	 variable counter: natural;
         variable td : std_logic_vector(data_width-1 downto 0);
       begin 
         reqL(R) <= false;
         counter := 1;

         ----------------------------------------------------------------------
         -- first the request
         ----------------------------------------------------------------------
  	 dv := R + 2**(data_width-1);
         
         wait until reset = '0';
         
         while (dv < (2**data_width)-2) loop
           
           din_raw(R) <= (To_SLV(To_Unsigned(dv,data_width)));

           reqL(R) <= true;
	   assert not verbose_mode report "Send request " & Convert_To_String(R) & "," &
		Convert_To_String(counter) & " started in TB " & tb_id severity note;
           while true loop
             wait until clock = '1';
             reqL(R)  <= false;
             if(ackL(R)) then
		assert not verbose_mode report "Send Request " & Convert_To_String(R) & "," &
			Convert_To_String(counter) & " completed in TB " & tb_id severity note;
               exit;
             end if;
           end loop;

	   dv := dv + num_req;
	   counter := counter  + 1;
         end loop;
	wait;
       end process;
     end generate GenBlockSend;

     GenBlockReceive: for R in 0 to num_req-1 generate

       process(dout)
         variable dout_var : std_logic_vector(data_width-1 downto 0);
       begin
         Extract(dout,R,dout_var);
         dout_raw(R) <= dout_var;
       end process;


       process 
         variable dv: natural;
	 variable counter: natural;
	 variable err_flag : boolean;
         variable dout_var : std_logic_vector(data_width-1 downto 0);
       begin 
         reqR(R) <= false;	
         counter := 1;
 	 err_flag := false;

  	 dv := R + 2**(data_width-1);

         wait until reset = '0';

         while (dv < (2**data_width)-2) loop
           
           -- operation complete?
           reqR(R) <= true;
	   assert not verbose_mode report "Receive request " & Convert_To_String(R) & "," &
		Convert_To_String(counter) & " started in TB " & tb_id severity note;
           while true loop
             wait until clock = '1';
             reqR(R) <= false;
             if(ackR(R)) then
		assert not verbose_mode report "Receive Request " & Convert_To_String(R) & "," &
			Convert_To_String(counter) & " completed in TB " & tb_id  severity note;

                Extract(dout,R,dout_var);
                if(To_SLV(To_Unsigned(dv,data_width)) /= dout_var) then
                  err_flag := true;
                  assert false report "Mismatch observed at " & Convert_To_String(R) & "," &
			Convert_To_String(counter) & " in TB " & tb_id  severity note;                  
		end if;
               exit;
             end if;
             
           end loop;

	   dv := dv + num_req;
	   counter := counter  + 1;
         end loop;

	assert err_flag report "Send/Receive Tests Finished Successfully (" & Convert_To_String(R) & ") in TB "
			& tb_id
			severity note;
	assert (not err_flag) report "Send/Receive Tests Failed (" & Convert_To_String(R) & ") in TB "
			& tb_id
			severity error;

        done_flag(R) <= true;
        success_flag(R) <= not err_flag;
	wait;
       end process;
     end generate GenBlockReceive;

     --------------------------------------------------------------------------
     -- component instantiations: output port linked to input port
     --------------------------------------------------------------------------
     InstanceBlock: block
	signal ip_to_op_ack, op_to_ip_req: std_logic;
	signal op_to_ip_data: std_logic_vector(data_width-1 downto 0);
     begin
     	op: OutputPort generic map(num_reqs => num_req, data_width => data_width , no_arbitration => false)
		port map(req => reqL,
		 	ack => ackL,
		 	data => din,
		 	oreq => op_to_ip_req,
		 	oack => ip_to_op_ack,
                 	odata => op_to_ip_data,
		 	clk => clock,
		 	reset => reset);
        
     	ip: InputPort generic map (num_reqs => num_req, data_width => data_width , no_arbitration => false)
 		port map (req => reqR,
                  	ack => ackR,
                  	data => dout,
		  	oreq => ip_to_op_ack,
                  	oack => op_to_ip_req,
		  	odata => op_to_ip_data,
		  	clk => clock,
		  	reset => reset);
      end block;
end Behave;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.Components.all;


entity PortTBWrap is
end PortTBWrap;

architecture Wrap of PortTBWrap is
	component PortTB is
  		generic
     				( g_num_req: integer := 2;
       				verbose_mode: boolean := false;
       				tb_id : string := "anonymous"
     				);
	end component PortTB;
begin
   tb0: PortTB generic map(g_num_req => 1, verbose_mode => false, tb_id => "num_req = 1");
   tb1: PortTB generic map(g_num_req => 2, verbose_mode => false, tb_id => "num_req = 2");
   tb2: PortTB generic map(g_num_req => 5, verbose_mode => false, tb_id => "num_req = 5");
end Wrap;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

--
-- in pull_mode, rL/aL accepts data which is sent by rR/aR.
-- rL -> rR is 0 delay, but aR -> aL MUST have a delay.
--
entity Pulse_To_Level_Translate_Entity is
  port( rL : in boolean;
        rR : out std_logic;
        aL : out boolean;
        aR : in std_logic;
        clk : in std_logic;
        reset : in std_logic);
end entity;

architecture Behave of Pulse_To_Level_Translate_Entity is
  type PullModeState is (Idle,Ack,Waiting);
  signal pull_mode_state : PullModeState;
begin  -- Behave

  process(clk)
    variable nstate : PullModeState;
  begin
    nstate := pull_mode_state;

    if(reset = '1') then
      nstate := Idle;
    else
      
      case pull_mode_state is
        when Idle =>
          if(rL) then
            if(aR = '1') then
              nstate := Ack;
            else
              nstate := Waiting;
            end if;
          end if;
        when Ack =>
          nstate := Idle;
        when Waiting =>
          if(aR = '1') then
            nstate := Ack;
          end if;
        when others => null;
      end case;

    end if;

    if(clk'event and clk = '1') then
      pull_mode_state <= nstate;
    end if;
  end process;


  rR <= '1' when ((pull_mode_state = Idle) and rL) or (pull_mode_state = Waiting) else '0';
  aL <= true when (pull_mode_state = Ack) else false;
      
end Behave;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity QueueBase is
    generic(queue_depth: integer := 2; data_width: integer := 32);
    port(clk: in std_logic;
         reset: in std_logic;
         data_in: in std_logic_vector(data_width-1 downto 0);
         push_req: in std_logic;
         push_ack: out std_logic;
         data_out: out std_logic_vector(data_width-1 downto 0);
         pop_ack : out std_logic;
         pop_req: in std_logic);
end entity QueueBase;

architecture behave of QueueBase is

  type QueueArray is array(natural range <>) of std_logic_vector(data_width-1 downto 0);

  signal queue_array : QueueArray(queue_depth-1 downto 0);
  signal top_pointer, bottom_pointer : integer range 0 to queue_depth-1;
  signal queue_size : integer range 0 to queue_depth;

  function Incr(x: integer; M: integer) return integer is
  begin
    if(x < M) then
      return(x + 1);
    else
      return(0);
    end if;
  end Incr;

begin  -- SimModel

  -- acks come out registers =>  always asserted
  -- if conditions permit
  push_ack <= '1' when (queue_size < queue_depth) else '0';
  pop_ack  <= '1' when (queue_size > 0) else '0';

  -- bottom pointer gives the data
  data_out <= queue_array(bottom_pointer);
  
  -- single process
  process(clk)
    variable qsize : integer range 0 to queue_depth;
    variable push,pop : boolean;
    variable next_top_ptr,next_bottom_ptr : integer range 0 to queue_depth-1;
  begin
    qsize := queue_size;
    push  := false;
    pop   := false;
    next_top_ptr := top_pointer;
    next_bottom_ptr := bottom_pointer;
    
    if(reset = '1') then
      qsize := 0;
      next_top_ptr := 0;
      next_bottom_ptr := 0;
    else
      if((qsize < queue_depth) and push_req = '1') then
        push := true;
      end if;

      if((qsize > 0) and pop_req = '1') then
        pop := true;
      end if;


      if(push) then
        next_top_ptr := Incr(next_top_ptr,queue_depth-1);
      end if;

      if(pop) then
        next_bottom_ptr := Incr(next_bottom_ptr,queue_depth-1);
      end if;


      if(pop and (not push)) then
        qsize := qsize - 1;
      elsif(push and (not pop)) then
        qsize := qsize + 1;
      end if;
      
    end if;

    if(clk'event and clk = '1') then
      
      if(push) then
        queue_array(top_pointer) <= data_in;
      end if;
      
      queue_size <= qsize;
      top_pointer <= next_top_ptr;
      bottom_pointer <= next_bottom_ptr;
    end if;
    
  end process;

end behave;
library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.Types.all;
use ahir.Utilities.all;
use ahir.Subprograms.all;

-- a simple register! if flow-through is set, then
-- it is just a combinational circuit.
entity RegisterBase is
  generic(in_data_width: integer; out_data_width: integer; flow_through: boolean := false);
  port(din: in std_logic_vector(in_data_width-1 downto 0);
       dout: out std_logic_vector(out_data_width-1 downto 0);
       req: in boolean;
       ack: out boolean;
       clk,reset: in std_logic);
end RegisterBase;


architecture arch of RegisterBase is
  constant min_data_width : integer := Minimum(in_data_width,out_data_width);
begin

  NoFlowThrough: if not flow_through generate
    process(din,req,reset,clk)
    begin
      if(clk'event and clk = '1') then
        if(reset = '1') then
          ack <= false;
          dout <= (others => '0');
        elsif req then
          ack <= true;
          dout(min_data_width-1 downto 0) <= din(min_data_width-1 downto 0);
        else
          ack <= false;
        end if;
      end if;
    end process;
  end generate NoFlowThrough;

  FlowThrough: if flow_through generate
    ack <= req;
    process(din)
      variable dout_var : std_logic_vector(out_data_width-1 downto 0);
    begin
      dout_var := (others => '0');
      dout_var(min_data_width-1 downto 0) := din(min_data_width-1 downto 0);
      dout <= dout_var;
    end process;
  end generate FlowThrough;
  
end arch;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

entity Request_Priority_Encode_Entity is
  generic (
    num_reqs : integer := 1;
    pull_mode : boolean := false);
  port (
    clk,reset : in std_logic;
    reqR : in std_logic_vector(num_reqs-1 downto 0);
    forward_enable: out std_logic_vector(num_reqs-1 downto 0);
    ackR: out std_logic_vector(num_reqs-1 downto 0);
    req_s : out std_logic;
    ack_s : in std_logic);
end entity;

architecture Behave of Request_Priority_Encode_Entity is

  signal req_fsm_state : std_logic;
  signal reqR_priority_encoded : std_logic_vector(num_reqs-1 downto 0);
  signal there_is_a_request  : std_logic;
  signal pull_state : std_logic;
  
begin  -- Behave

  reqR_priority_encoded <= PriorityEncode(reqR);
  there_is_a_request <= OrReduce(reqR);
  
  forward_enable <= reqR_priority_encoded;
  req_s <= there_is_a_request;
  
  process(ack_s,reqR_priority_encoded)
  begin
    for I in reqR'range loop
      ackR(I) <= reqR_priority_encoded(I) and ack_s;
    end loop;  -- I
  end process;

  
end Behave;
library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;

entity SelectBase is
  generic(data_width: integer);
  port(x,y: in std_logic_vector(data_width-1 downto 0);
       sel: in std_logic_vector(0 downto 0);
       req: in boolean;
       z: out std_logic_vector(data_width-1 downto 0);
       ack: out boolean;
       clk,reset: in std_logic);
end SelectBase;


architecture arch of SelectBase is 
begin

  process(x,y,sel,req,reset,clk)
  begin
    
    if(clk'event and clk = '1') then
      if(reset = '1') then
        ack <= false;
        z <= (others => '0');
      elsif(sel(sel'right) = '1' and req = true) then
        ack <= req;
        z <= x;
      elsif(sel(sel'right) = '0' and req = true) then
        ack <= req;
        z <= y; 
      else 
        ack <= false;
      end if;
    end if;
  end process;

end arch;

library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.Types.all;
use ahir.Utilities.all;
use ahir.Subprograms.all;

-- a simple slicing element.
entity Slicebase is
  generic(in_data_width : integer; high_index: integer; low_index : integer; zero_delay : boolean);
  port(din: in std_logic_vector(in_data_width-1 downto 0);
       dout: out std_logic_vector(high_index-low_index downto 0);
       req: in boolean;
       ack: out boolean;
       clk,reset: in std_logic);
end Slicebase;


architecture arch of Slicebase is

begin

  assert ((high_index < in_data_width) and (low_index >= 0) and (high_index >= low_index))
    report "inconsistent slice parameters" severity failure;
  
  ZeroDelay: if zero_delay generate
    ack <= req;
    dout <= din(high_index downto low_index);
  end generate ZeroDelay;

  NonZeroDelay: if not zero_delay generate
    process(clk)
      variable ack_var  : boolean;
    begin
      if(clk'event and clk = '1') then
        if(reset = '1') then
          ack <= false;
        else
          ack <= req;
        end if;
      end if;
    end process;

    process(clk)
    begin
      if(clk'event and clk = '1') then
        if(req) then
          dout <= din(high_index downto low_index);
        end if;
      end if;
    end process;
  end generate NonZeroDelay;
  
end arch;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity SplitCallArbiterNoInArgsNoOutArgs is
  generic(num_reqs: integer;
	  caller_tag_length: integer;
          callee_tag_length: integer);
  port ( -- ready/ready handshake on all ports
    -- ports for the caller
    call_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
    call_acks   : out std_logic_vector(num_reqs-1 downto 0);
    call_tag    : in  std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
    -- call port connected to the called module
    call_mreq   : out std_logic;
    call_mack   : in  std_logic;
    call_mtag   : out std_logic_vector(callee_tag_length-1 downto 0);
    -- similarly for return, initiated by the caller
    return_reqs : in  std_logic_vector(num_reqs-1 downto 0);
    return_acks : out std_logic_vector(num_reqs-1 downto 0);
    return_tag  : out std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
    -- return from function
    return_mreq : out std_logic;
    return_mack : in std_logic;
    return_mtag : in  std_logic_vector(callee_tag_length-1 downto 0);
    clk: in std_logic;
    reset: in std_logic);
end SplitCallArbiterNoInArgsNoOutArgs;


architecture Struct of SplitCallArbiterNoInArgsNoOutArgs is
   signal pe_call_reqs: std_logic_vector(num_reqs-1 downto 0);
   signal return_acks_sig: std_logic_vector(num_reqs-1 downto 0);

   type TagwordArray is array (natural range <>) of std_logic_vector(caller_tag_length-1 downto 0);
   signal return_tag_sig : TagwordArray(num_reqs-1 downto 0);
begin

  -----------------------------------------------------------------------------
  -- priority encode incoming
  -----------------------------------------------------------------------------
   pe_call_reqs <= PriorityEncode(call_reqs);

   ----------------------------------------------------------------------------
   -- combinational process to handle call_reqs  --> call_mreq muxing
   ----------------------------------------------------------------------------
   process(pe_call_reqs, call_mack)
     variable there_is_a_call : std_logic;
   begin
     there_is_a_call := OrReduce(pe_call_reqs);
     call_acks <= (others => '0');
     if(there_is_a_call = '1') then
       for I in num_reqs-1 downto 0 loop
         if(pe_call_reqs(I) = '1') then
           call_acks(I) <= call_mack;
           exit;
         end if;
       end loop;  -- I
     end if;
     call_mreq <= there_is_a_call;
   end process;

   tagGen : BinaryEncoder generic map (iwidth => num_reqs,
                                       owidth => callee_tag_length)
     port map (din => pe_call_reqs, dout => call_mtag);

   -- on a successful call, register the tag from the caller
   -- side..
   tagRegGen: for T in 0 to num_reqs-1 generate
     process(clk)
     begin
       if(clk'event and clk = '1') then
         if(pe_call_reqs(T) = '1') then
           return_tag_sig(T)
             <= call_tag(((T+1)*caller_tag_length)-1 downto T*caller_tag_length);
         end if;
       end if;
     end process;     
   end generate tagRegGen;


   ----------------------------------------------------------------------------
   -- reverse path
   ----------------------------------------------------------------------------
   process(return_tag_sig)
     variable lreturn_tag : std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
   begin
     for J in return_tag_sig'high(1) downto return_tag_sig'low(1) loop
       Insert(lreturn_tag,J,return_tag_sig(J));
     end loop;  -- J
     return_tag <= lreturn_tag;
   end process;

   -- always ready to accept return data..
   return_mreq <= '1';

   -- the acks in both directions
   return_acks <= return_acks_sig;
   
   -- incoming data written into appropriate register.
   RetGen: for I in return_reqs'high downto return_reqs'low generate

     fsm: block
       signal ack_reg,  valid_flag : std_logic;
     begin  -- block fsm

       -- valid = '1' implies this index is incoming
       valid_flag <= '1' when return_mack = '1' and (I = To_Integer(To_Unsigned(return_mtag))) else '0';

       --------------------------------------------------------------------------
       -- ack ff
       --------------------------------------------------------------------------
       -- set if valid_flag is asserted, else clear if return_reqs is asserted
       -- and register is already set.
       process(clk)
       begin
         if clk'event and clk= '1' then
           if(reset = '1') then
             ack_reg <= '0';
           elsif valid_flag = '1' then
             ack_reg <= '1';
           elsif return_reqs(I) = '1' and ack_reg = '1' then
             ack_reg <= '0';
           end if;

         end if;
       end process;

       -- pass info out of the generate
       return_acks_sig(I) <= ack_reg;
       
     end block fsm;

     
   end generate RetGen;
end Struct;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity SplitCallArbiterNoInargs is
  generic(num_reqs: integer;
	  return_data_width: integer;
	  caller_tag_length: integer;
          callee_tag_length: integer);
  port ( -- ready/ready handshake on all ports
    -- ports for the caller
    call_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
    call_acks   : out std_logic_vector(num_reqs-1 downto 0);
    call_tag    : in  std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
    -- call port connected to the called module
    call_mreq   : out std_logic;
    call_mack   : in  std_logic;
    call_mtag   : out std_logic_vector(callee_tag_length-1 downto 0);
    -- similarly for return, initiated by the caller
    return_reqs : in  std_logic_vector(num_reqs-1 downto 0);
    return_acks : out std_logic_vector(num_reqs-1 downto 0);
    return_data : out std_logic_vector((num_reqs*return_data_width)-1 downto 0);
    return_tag  : out std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
    -- return from function
    return_mreq : out std_logic;
    return_mack : in std_logic;
    return_mdata : in  std_logic_vector(return_data_width-1 downto 0);
    return_mtag : in  std_logic_vector(callee_tag_length-1 downto 0);
    clk: in std_logic;
    reset: in std_logic);
end SplitCallArbiterNoInargs;


architecture Struct of SplitCallArbiterNoInargs is
   signal pe_call_reqs: std_logic_vector(num_reqs-1 downto 0);
   signal return_acks_sig: std_logic_vector(num_reqs-1 downto 0);

   type TwordArray is array (natural range <>) of std_logic_vector(return_mdata'length-1 downto 0);
   signal return_data_sig : TwordArray(num_reqs-1 downto 0);

   type TagwordArray is array (natural range <>) of std_logic_vector(caller_tag_length-1 downto 0);
   signal return_tag_sig : TagwordArray(num_reqs-1 downto 0);
begin

  -----------------------------------------------------------------------------
  -- priority encode incoming
  -----------------------------------------------------------------------------
   pe_call_reqs <= PriorityEncode(call_reqs);

   ----------------------------------------------------------------------------
   -- combinational process to handle call_reqs  --> call_mreq muxing
   ----------------------------------------------------------------------------
   process(pe_call_reqs, call_mack)
     variable there_is_a_call : std_logic;
   begin
     there_is_a_call := OrReduce(pe_call_reqs);
     call_acks <= (others => '0');
     if(there_is_a_call = '1') then
       for I in num_reqs-1 downto 0 loop
         if(pe_call_reqs(I) = '1') then
           call_acks(I) <= call_mack;
           exit;
         end if;
       end loop;  -- I
     end if;
     call_mreq <= there_is_a_call;
   end process;

   tagGen : BinaryEncoder generic map (iwidth => num_reqs,
                                       owidth => callee_tag_length)
     port map (din => pe_call_reqs, dout => call_mtag);

   -- on a successful call, register the tag from the caller
   -- side..
   tagRegGen: for T in 0 to num_reqs-1 generate
     process(clk)
     begin
       if(clk'event and clk = '1') then
         if(pe_call_reqs(T) = '1') then
           return_tag_sig(T)
             <= call_tag(((T+1)*caller_tag_length)-1 downto T*caller_tag_length);
         end if;
       end if;
     end process;     
   end generate tagRegGen;


   ----------------------------------------------------------------------------
   -- reverse path
   ----------------------------------------------------------------------------
   -- pack registers into return data array
   process(return_data_sig)
     variable lreturn_data : std_logic_vector((num_reqs*return_data_width)-1 downto 0);
   begin
     for J in return_data_sig'high(1) downto return_data_sig'low(1) loop
       Insert(lreturn_data,J,return_data_sig(J));
     end loop;  -- J
     return_data <= lreturn_data;
   end process;

   process(return_tag_sig)
     variable lreturn_tag : std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
   begin
     for J in return_tag_sig'high(1) downto return_tag_sig'low(1) loop
       Insert(lreturn_tag,J,return_tag_sig(J));
     end loop;  -- J
     return_tag <= lreturn_tag;
   end process;

   -- always ready to accept return data.
   return_mreq <= '1';

   -- the acks in both directions
   return_acks <= return_acks_sig;
   
   -- incoming data written into appropriate register.
   RetGen: for I in return_reqs'high downto return_reqs'low generate

     fsm: block
       signal ack_reg, valid_flag : std_logic;
       signal data_reg : std_logic_vector(return_mdata'length-1 downto 0);
     begin  -- block fsm

       -- valid = '1' implies this index is incoming
       valid_flag <= '1' when return_mack = '1' and (I = To_Integer(To_Unsigned(return_mtag))) else '0';

       --------------------------------------------------------------------------
       -- ack ff
       --------------------------------------------------------------------------
       -- set if valid_flag is asserted, else clear if return_reqs is asserted
       -- and register is already set.
       process(clk)
       begin
         if clk'event and clk= '1' then
           if(reset = '1') then
             ack_reg <= '0';
           elsif valid_flag = '1' then
             ack_reg <= '1';
           elsif return_reqs(I) = '1' and ack_reg = '1' then
             ack_reg <= '0';
           end if;

           -- register data when you send mack
           if(valid_flag = '1') then
             data_reg <= return_mdata;
           end if;
         end if;
       end process;

       -- pass info out of the generate
       return_acks_sig(I) <= ack_reg;
       return_data_sig(I) <= data_reg;
       
     end block fsm;

     
   end generate RetGen;
end Struct;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity SplitCallArbiterNoOutArgs is
  generic(num_reqs: integer;
	  call_data_width: integer;
	  caller_tag_length: integer;
          callee_tag_length: integer);
  port ( -- ready/ready handshake on all ports
    -- ports for the caller
    call_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
    call_acks   : out std_logic_vector(num_reqs-1 downto 0);
    call_data   : in  std_logic_vector((num_reqs*call_data_width)-1 downto 0);
    call_tag    : in  std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
    -- call port connected to the called module
    call_mreq   : out std_logic;
    call_mack   : in  std_logic;
    call_mdata  : out std_logic_vector(call_data_width-1 downto 0);
    call_mtag   : out std_logic_vector(callee_tag_length-1 downto 0);
    -- similarly for return, initiated by the caller
    return_reqs : in  std_logic_vector(num_reqs-1 downto 0);
    return_acks : out std_logic_vector(num_reqs-1 downto 0);
    return_tag  : out std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
    -- return from function
    return_mreq : out std_logic;
    return_mack : in std_logic;
    return_mtag : in  std_logic_vector(callee_tag_length-1 downto 0);
    clk: in std_logic;
    reset: in std_logic);
end SplitCallArbiterNoOutArgs;


architecture Struct of SplitCallArbiterNoOutArgs is
   signal pe_call_reqs: std_logic_vector(num_reqs-1 downto 0);
   signal return_acks_sig: std_logic_vector(num_reqs-1 downto 0);


   type TagwordArray is array (natural range <>) of std_logic_vector(caller_tag_length-1 downto 0);
   signal return_tag_sig : TagwordArray(num_reqs-1 downto 0);
begin

  -----------------------------------------------------------------------------
  -- priority encode incoming
  -----------------------------------------------------------------------------
   pe_call_reqs <= PriorityEncode(call_reqs);

   ----------------------------------------------------------------------------
   -- combinational process to handle call_reqs  --> call_mreq muxing
   ----------------------------------------------------------------------------
   process(pe_call_reqs, call_data, call_mack)
     variable there_is_a_call : std_logic;
     variable out_data : std_logic_vector(call_data_width-1 downto 0);
   begin
     there_is_a_call := OrReduce(pe_call_reqs);
     out_data := (others => '0');
     call_acks <= (others => '0');
     if(there_is_a_call = '1') then
       for I in num_reqs-1 downto 0 loop
         if(pe_call_reqs(I) = '1') then
           Extract(call_data,I,out_data);
           call_acks(I) <= call_mack;
           exit;
         end if;
       end loop;  -- I
     end if;
     call_mreq <= there_is_a_call;
     call_mdata <= out_data;
   end process;

   tagGen : BinaryEncoder generic map (iwidth => num_reqs,
                                       owidth => callee_tag_length)
     port map (din => pe_call_reqs, dout => call_mtag);

   -- on a successful call, register the tag from the caller
   -- side..
   tagRegGen: for T in 0 to num_reqs-1 generate
     process(clk)
     begin
       if(clk'event and clk = '1') then
         if(pe_call_reqs(T) = '1') then
           return_tag_sig(T)
             <= call_tag(((T+1)*caller_tag_length)-1 downto T*caller_tag_length);
         end if;
       end if;
     end process;     
   end generate tagRegGen;


   ----------------------------------------------------------------------------
   -- reverse path
   ----------------------------------------------------------------------------
   process(return_tag_sig)
     variable lreturn_tag : std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
   begin
     for J in return_tag_sig'high(1) downto return_tag_sig'low(1) loop
       Insert(lreturn_tag,J,return_tag_sig(J));
     end loop;  -- J
     return_tag <= lreturn_tag;
   end process;

   -- always ready to accept return data..
   -- (assumption... that call and return requests from the 
   --  the left will alternate).
   return_mreq <='1';

   -- the acks in both directions
   return_acks <= return_acks_sig;
   
   -- incoming data written into appropriate register.
   RetGen: for I in return_reqs'high downto return_reqs'low generate

     fsm: block
       signal ack_reg, valid_flag : std_logic;
     begin  -- block fsm

       -- valid = '1' implies this index is incoming
       valid_flag <= '1' when return_mack = '1' and (I = To_Integer(To_Unsigned(return_mtag))) else '0';
       --------------------------------------------------------------------------
       -- ack ff
       --------------------------------------------------------------------------
       -- set if valid_flag is asserted, else clear if return_reqs is asserted
       -- and register is already set.
       process(clk)
       begin
         if clk'event and clk= '1' then
           if(reset = '1') then
             ack_reg <= '0';
           elsif valid_flag = '1' then
             ack_reg <= '1';
           elsif return_reqs(I) = '1' and ack_reg = '1' then
             ack_reg <= '0';
           end if;
         end if;
       end process;

       -- pass info out of the generate
       return_acks_sig(I) <= ack_reg;
       
     end block fsm;

     
   end generate RetGen;
end Struct;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity SplitCallArbiter is
  generic(num_reqs: integer;
	  call_data_width: integer;
	  return_data_width: integer;
	  caller_tag_length: integer;
          callee_tag_length: integer);
  port ( -- ready/ready handshake on all ports
    -- ports for the caller
    call_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
    call_acks   : out std_logic_vector(num_reqs-1 downto 0);
    call_data   : in  std_logic_vector((num_reqs*call_data_width)-1 downto 0);
    call_tag    : in  std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
    -- call port connected to the called module
    call_mreq   : out std_logic;
    call_mack   : in  std_logic;
    call_mdata  : out std_logic_vector(call_data_width-1 downto 0);
    call_mtag   : out std_logic_vector(callee_tag_length-1 downto 0);
    -- similarly for return, initiated by the caller
    return_reqs : in  std_logic_vector(num_reqs-1 downto 0);
    return_acks : out std_logic_vector(num_reqs-1 downto 0);
    return_data : out std_logic_vector((num_reqs*return_data_width)-1 downto 0);
    return_tag  : out std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
    -- return from function
    return_mreq : out std_logic;
    return_mack : in std_logic;
    return_mdata : in  std_logic_vector(return_data_width-1 downto 0);
    return_mtag : in  std_logic_vector(callee_tag_length-1 downto 0);
    clk: in std_logic;
    reset: in std_logic);
end SplitCallArbiter;


architecture Struct of SplitCallArbiter is
   signal pe_call_reqs: std_logic_vector(num_reqs-1 downto 0);
   signal return_acks_sig: std_logic_vector(num_reqs-1 downto 0);

   type TwordArray is array (natural range <>) of std_logic_vector(return_mdata'length-1 downto 0);
   signal return_data_sig : TwordArray(num_reqs-1 downto 0);

   type TagwordArray is array (natural range <>) of std_logic_vector(caller_tag_length-1 downto 0);
   signal return_tag_sig : TagwordArray(num_reqs-1 downto 0);
begin

  -----------------------------------------------------------------------------
  -- priority encode incoming
  -----------------------------------------------------------------------------
   pe_call_reqs <= PriorityEncode(call_reqs);

   ----------------------------------------------------------------------------
   -- combinational process to handle call_reqs  --> call_mreq muxing
   ----------------------------------------------------------------------------
   process(pe_call_reqs, call_data, call_mack)
     variable there_is_a_call : std_logic;
     variable out_data : std_logic_vector(call_data_width-1 downto 0);
   begin
     there_is_a_call := OrReduce(pe_call_reqs);
     out_data := (others => '0');
     call_acks <= (others => '0');
     if(there_is_a_call = '1') then
       for I in num_reqs-1 downto 0 loop
         if(pe_call_reqs(I) = '1') then
           Extract(call_data,I,out_data);
           call_acks(I) <= call_mack;
           exit;
         end if;
       end loop;  -- I
     end if;
     call_mreq <= there_is_a_call;
     call_mdata <= out_data;
   end process;

   tagGen : BinaryEncoder generic map (iwidth => num_reqs,
                                       owidth => callee_tag_length)
     port map (din => pe_call_reqs, dout => call_mtag);

   -- on a successful call, register the tag from the caller
   -- side..
   tagRegGen: for T in 0 to num_reqs-1 generate
     process(clk)
     begin
       if(clk'event and clk = '1') then
         if(pe_call_reqs(T) = '1') then
           return_tag_sig(T)
             <= call_tag(((T+1)*caller_tag_length)-1 downto T*caller_tag_length);
         end if;
       end if;
     end process;     
   end generate tagRegGen;


   ----------------------------------------------------------------------------
   -- reverse path
   ----------------------------------------------------------------------------
   -- pack registers into return data array
   process(return_data_sig)
     variable lreturn_data : std_logic_vector((num_reqs*return_data_width)-1 downto 0);
   begin
     for J in return_data_sig'high(1) downto return_data_sig'low(1) loop
       Insert(lreturn_data,J,return_data_sig(J));
     end loop;  -- J
     return_data <= lreturn_data;
   end process;

   process(return_tag_sig)
     variable lreturn_data : std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
   begin
     for J in return_tag_sig'high(1) downto return_tag_sig'low(1) loop
       Insert(lreturn_data,J,return_tag_sig(J));
     end loop;  -- J
     return_tag <= lreturn_data;
   end process;

   -- always ready to accept return data!
   return_mreq <= '1';

   -- return to caller.
   return_acks <= return_acks_sig;
   
   -- incoming data written into appropriate register.
   RetGen: for I in return_reqs'high downto return_reqs'low generate

     fsm: block
       signal ack_reg, valid_flag : std_logic;
       signal data_reg : std_logic_vector(return_mdata'length-1 downto 0);
     begin  -- block fsm

       -- valid = '1' implies this index is incoming
       valid_flag <= '1' when return_mack = '1' and (I = To_Integer(To_Unsigned(return_mtag))) else '0';
       --------------------------------------------------------------------------
       -- ack ff
       --------------------------------------------------------------------------
       -- set if mack_sig is asserted, else clear if return_reqs is asserted
       -- and register is already set.
       process(clk)
       begin
         if clk'event and clk= '1' then
           if(reset = '1') then
             ack_reg <= '0';
           elsif valid_flag = '1' then
             ack_reg <= '1';
           elsif return_reqs(I) = '1' and ack_reg = '1' then
             ack_reg <= '0';
           end if;

           -- register data when you send mack
           if(valid_flag = '1') then
             data_reg <= return_mdata;
           end if;
         end if;
       end process;

       -- pass info out of the generate
       return_acks_sig(I) <= ack_reg;
       return_data_sig(I) <= data_reg;
     end block fsm;
     
   end generate RetGen;

end Struct;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.OperatorPackage.all;
use ahir.FloatOperatorPackage.all;
use ahir.BaseComponents.all;

entity SplitOperatorBase is
  generic
    (
      operator_id   : string := "ApIntAdd";          -- operator id
      input1_is_int : Boolean := true; -- false means float
      input1_characteristic_width : integer := 0; -- characteristic width if input1 is float
      input1_mantissa_width       : integer := 0; -- mantissa width if input1 is float
      iwidth_1      : integer := 4;    -- width of input1
      input2_is_int : Boolean := true; -- false means float
      input2_characteristic_width : integer := 0; -- characteristic width if input2 is float
      input2_mantissa_width       : integer := 0; -- mantissa width if input2 is float
      iwidth_2      : integer := 0;    -- width of input2
      num_inputs    : integer := 1;    -- can be 1 or 2.
      output_is_int : Boolean := true;  -- false means that the output is a float
      output_characteristic_width : integer := 0;
      output_mantissa_width       : integer := 0;
      owidth        : integer := 4;          -- width of output.
      constant_operand : std_logic_vector := "0001"; -- constant operand.. (it is always the second operand)
      constant_width: integer := 4;
      twidth        : integer := 1;          -- tag width
      use_constant  : boolean := true;
      zero_delay    : boolean := false
      );
  port (
    -- req/ack follow level protocol
    reqR: out std_logic;
    ackR: in std_logic;
    reqL: in std_logic;
    ackL : out  std_logic;
    -- tagL is passed out to tagR
    tagL       : in  std_logic_vector(twidth-1 downto 0);
    -- input array consists of m sets of 1 or 2 possibly concatenated
    -- operands.
    dataL      : in  std_logic_vector(iwidth_1 + iwidth_2 - 1 downto 0);
    dataR      : out std_logic_vector(owidth-1 downto 0);
    -- tagR is received from tagL, concurrent
    -- with dataR
    tagR       : out std_logic_vector(twidth-1 downto 0);
    clk, reset : in  std_logic);
end SplitOperatorBase;


architecture Vanilla of SplitOperatorBase is
  signal   result    : std_logic_vector(owidth-1 downto 0);
  signal   state_sig : std_logic;
  constant tag0      : std_logic_vector(tagR'length-1 downto 0) := (others => '0');
  constant iwidth : integer := iwidth_1  + iwidth_2;

begin  -- Behave

  assert((num_inputs = 1) or (num_inputs = 2)) report "either 1 or 2 inputs" severity failure;

  reqR <= reqL;
  ackL <= ackR;
  tagR <= tagL;
  
  comb_block: GenericCombinationalOperator
    generic map (
      operator_id                 => operator_id,
      input1_is_int               => input1_is_int,
      input1_characteristic_width => input1_characteristic_width,
      input1_mantissa_width       => input1_mantissa_width,
      iwidth_1                    => iwidth_1,
      input2_is_int               => input2_is_int,
      input2_characteristic_width => input2_characteristic_width,
      input2_mantissa_width       => input2_mantissa_width,
      iwidth_2                    => iwidth_2,
      num_inputs                  => num_inputs,
      output_is_int               => output_is_int,
      output_characteristic_width => output_characteristic_width,
      output_mantissa_width       => output_mantissa_width,
      owidth                      => owidth,
      constant_operand            => constant_operand,
      constant_width		  => constant_width,
      use_constant                => use_constant)
    port map (
      data_in => dataL,
      result  => dataR);


end Vanilla;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.OperatorPackage.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity SplitOperatorSharedTB is
  generic
     ( g_num_req: integer := 2;
       operator_id: string := "ApIntAdd";
       zero_delay : boolean := false;
       verbose_mode: boolean := false;
       input_data_width: integer := 8;
       output_data_width: integer := 8;
       num_ips : integer := 2;
       tb_id : string := "anonymous"
     );
end SplitOperatorSharedTB;

architecture Behave of SplitOperatorSharedTB is

    constant num_req : integer := g_num_req;
    
    signal reqR, ackR, reqL, ackL : BooleanArray(num_req-1 downto 0);
    signal din_2 : StdLogicArray2D((2*num_req)-1 downto 0, input_data_width-1 downto 0);
    signal din_2_slv : std_logic_vector((input_data_width*2*num_req)-1 downto 0);
    
    signal din_1, din_2_c : StdLogicArray2D(num_req-1 downto 0, input_data_width-1 downto 0);
    signal din_1_slv, din_2_c_slv : std_logic_vector((input_data_width*2*num_req)-1 downto 0);
    signal dout_2, dout_1, dout_1_C: StdLogicArray2D(num_req-1 downto 0, output_data_width-1 downto 0);
    signal dout_2_slv, dout_1_slv, dout_1_C_slv  : std_logic_vector((num_req*output_data_width)-1 downto 0);

    signal op_idata : std_logic_vector((num_req*input_data_width*num_ips)-1 downto 0);
    signal op_odata : std_logic_vector((num_req*output_data_width)-1 downto 0);

    constant const_operand: std_logic_vector(input_data_width-1 downto 0) := (others => '1');

    type   Data2D is array(natural range <>) of std_logic_vector(input_data_width-1 downto 0);
    signal d2_1, d2_2, d1, d2_C: Data2D(num_req-1 downto 0);

    function Build_Data(tmp_addr: in Data2D) return StdLogicArray2D is
	variable tmp: StdLogicArray2D(num_req-1 downto 0, input_data_width-1 downto 0);
    begin
        for I in 0 to num_req-1 loop
            Insert(tmp,I,tmp_addr(I));
        end loop;
	return(tmp);
    end function Build_Data;

    signal clock, reset : std_logic := '0';

    signal done_flag, success_flag: BooleanArray(num_req-1 downto 0);
begin

     clock <= not clock after 5 ns;

     process(done_flag)
     begin
        if(AndReduce(done_flag))then
           if(AndReduce(success_flag)) then
              assert false report "All Tests Have Passed in TB " & tb_id  severity note;
	   else
              assert false report "Some Tests Have Failed in TB " & tb_id severity error;
	   end if;
        end if;
     end process;
    
     process
     begin
	 reset <= '1';
         wait until clock = '1';
         reset <= '0' after 1 ns;
 	 wait;
     end process;

     din_2 <= Stack(Build_Data(d2_1), Build_Data(d2_2));

     GenBlock_2: for R in 0 to num_req-1 generate

       process 
         variable dv: natural;
	 variable counter: natural;
	 variable err_flag : boolean;
         variable td : std_logic_vector(output_data_width-1 downto 0);
         variable td_islv : IStdLogicVector(output_data_width-1 downto 0);
       begin 
         reqR(R) <= false;	
         reqL(R) <= false;

         counter := 1;

 	 err_flag := false;

         ----------------------------------------------------------------------
         -- first the request
         ----------------------------------------------------------------------
  	 dv := R + 2**(input_data_width-1);
         
         wait until reset = '0';
         
         while (dv < (2**input_data_width)-2) loop
           
           d2_1(R) <= (To_SLV(To_Unsigned(dv,input_data_width)));
           d2_2(R) <= (To_SLV(To_Unsigned(dv+1,input_data_width)));

           reqL(R) <= true;
	   assert not verbose_mode report "Operator Request " & Convert_To_String(R) & "," &
		Convert_To_String(counter) & " started in TB " & tb_id severity note;
           while true loop
             wait until clock = '1';
             reqL(R)  <= false;
             if(ackL(R)) then
		assert not verbose_mode report "Operator Request " & Convert_To_String(R) & "," &
			Convert_To_String(counter) & " completed in TB " & tb_id severity note;
               exit;
             end if;
           end loop;

           -- operation complete?
           reqR(R) <= true;
           while true loop
             wait until clock = '1';
             reqR(R) <= false;
             if(ackR(R)) then
		assert not verbose_mode report "Operation Complete " & Convert_To_String(R) & "," &
			Convert_To_String(counter) & " completed in TB " & tb_id  severity note;
	
                TwoInputOperation(operator_id,
                                     To_SLV(To_Unsigned(dv,input_data_width)),
                                     To_SLV(To_Unsigned(dv+1,input_data_width)),td);


                if(td /= (Extract(dout_2,R))) then
                  err_flag := true;
                  assert false report "Mismatch observed at " & Convert_To_String(R) & "," &
			Convert_To_String(counter) & " in TB " & tb_id  severity note;                  
		end if;
               exit;
             end if;
             
           end loop;

	   dv := dv + num_req;
	   counter := counter  + 1;
         end loop;

	assert err_flag report "Two Operator Tests Finished Successfully (" & Convert_To_String(R) & ") in TB "
			& tb_id
			severity note;
	assert (not err_flag) report "Two Operator Tests Failed (" & Convert_To_String(R) & ") in TB "
			& tb_id
			severity error;

        done_flag(R) <= true;
        success_flag(R) <= not err_flag;

	wait;
       end process;
     end generate GenBlock_2;

     --------------------------------------------------------------------------
     -- component instantiations
     --------------------------------------------------------------------------
     -- insert stuff which converts 2D array to SLV and back..
     din_2_slv <= To_SLV_Shuffle(din_2);
     dout_2 <= To_StdLogicArray2D(dout_2_slv, output_data_width);
     
     op2: SplitOperatorShared
       -- generic map needs to be redone..
       generic map (
         operator_id  => operator_id,
        input1_is_int => true,
        input1_characteristic_width => 0,
        input1_mantissa_width    => 0,
        iwidth_1      => input_data_width,
        input2_is_int => true,
        input2_characteristic_width => 0,
        input2_mantissa_width      => 0,
        iwidth_2      => input_data_width,
        num_inputs     => 2,
        output_is_int => true,
        output_characteristic_width => output_data_width,
        output_mantissa_width    => 0,
         owidth     => output_data_width,
	constant_operand => const_operand,
        constant_width => const_operand'length,
        use_constant  => false,
        zero_delay   => false, 
        num_reqs => num_req,
        no_arbitration => false
        )
       port map (
         reqL => reqL,
	 ackL => ackL,
	 reqR => reqR,
 	 ackR => ackR,
	 dataL => din_2_slv,
	 dataR => dout_2_slv, 
	 clk => clock,
	 reset => reset);
end Behave;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity SplitOperatorSharedTBWrap is
end SplitOperatorSharedTBWrap;

architecture Behave of SplitOperatorSharedTBWrap is
begin
   tb0: SplitOperatorSharedTB generic map(g_num_req => 1,
                                          operator_id => "ApIntAdd",
                                          zero_delay => true,
                                          verbose_mode => false,
                                          input_data_width => 8,
                                          output_data_width => 8,
                                          num_ips => 2,
                                          tb_id => "ApIntAdd num_req=1 ");  
   tb1: SplitOperatorSharedTB generic map(g_num_req => 2,
                                          operator_id => "ApIntAdd",
                                          zero_delay => false,
                                          verbose_mode => false,
                                          input_data_width => 8,
                                          output_data_width => 8,
                                          num_ips => 2,
                                          tb_id => "ApIntAdd num_req=2 ");
   tb2: SplitOperatorSharedTB generic map(g_num_req => 5,
                                          operator_id => "ApIntAdd",
                                          zero_delay => true,
                                          verbose_mode => false,
                                          input_data_width => 8,
                                          output_data_width => 8,
                                          num_ips => 2,
                                          tb_id => "ApIntAdd num_req=5 ");
end Behave;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity SplitOperatorShared is
    generic
    (
      operator_id   : string := "ApIntAdd";          -- operator id
      input1_is_int : Boolean := true; -- false means float
      input1_characteristic_width : integer := 0; -- characteristic width if input1 is float
      input1_mantissa_width       : integer := 0; -- mantissa width if input1 is float
      iwidth_1      : integer := 4;    -- width of input1
      input2_is_int : Boolean := true; -- false means float
      input2_characteristic_width : integer := 0; -- characteristic width if input2 is float
      input2_mantissa_width       : integer := 0; -- mantissa width if input2 is float
      iwidth_2      : integer := 0;    -- width of input2
      num_inputs    : integer := 1;    -- can be 1 or 2.
      output_is_int : Boolean := true;  -- false means that the output is a float
      output_characteristic_width : integer := 0;
      output_mantissa_width       : integer := 0;
      owidth        : integer := 4;          -- width of output.
      constant_operand : std_logic_vector := "0001"; -- constant operand.. (it is always the second operand)
      constant_width: integer := 4;
      use_constant  : boolean := true;
      zero_delay    : boolean := false;
      no_arbitration: boolean := true;
      min_clock_period: boolean := false;
      num_reqs : integer := 3 -- how many requesters?
    );
  port (
    -- req/ack follow level protocol
    reqL                     : in BooleanArray(num_reqs-1 downto 0);
    ackR                     : out BooleanArray(num_reqs-1 downto 0);
    ackL                     : out BooleanArray(num_reqs-1 downto 0);
    reqR                     : in  BooleanArray(num_reqs-1 downto 0);
    -- input data consists of concatenated pairs of ips
    dataL                    : in std_logic_vector(((iwidth_1 + iwidth_2)*num_reqs)-1 downto 0);
    -- output data consists of concatenated pairs of ops.
    dataR                    : out std_logic_vector((owidth*num_reqs)-1 downto 0);
    -- with dataR
    clk, reset              : in std_logic);
end SplitOperatorShared;

architecture Vanilla of SplitOperatorShared is

  constant num_operands : integer := num_inputs;
  constant iwidth : integer := iwidth_1 + iwidth_2;
  
  constant ignore_tag  : boolean := no_arbitration or (reqL'length = 1);

  -- NOTE: the following combination is not allowed
  --       zero_delay = true and ignore_tag = false and reqL'length =1
  --       because it leads to a zero-delay cycle inside the shared operator 
  --
  -- THUS: if an operator is shared by mutually non-exclusive requesters,
  --       (non-compatible operators), then it CANNOT be zero_delay.
  --       This is explicitly blocked out by using the following constant
  constant use_zero_delay : boolean := zero_delay and ((reqL'length = 1) or ignore_tag);
  signal idata : std_logic_vector(iwidth-1 downto 0);
  signal odata: std_logic_vector(owidth-1 downto 0);

  constant tag_length: integer := Maximum(1,Ceil_Log2(reqL'length));
  signal itag,otag : std_logic_vector(tag_length-1 downto 0);
  signal ireq,iack, oreq, oack: std_logic;

  constant debug_flag : boolean := false;
  
begin  -- Behave
  assert ackL'length = reqL'length report "mismatched req/ack vectors" severity error;
  
  assert (not zero_delay) or use_zero_delay
    report "Zero delay flag ignored for shared operators which are not exclusive " severity warning;

  DebugGen: if debug_flag generate 
    assert( (not ((reset = '0') and (clk'event and clk = '1') and no_arbitration)) or Is_At_Most_One_Hot(reqL))
    report "in no-arbitration case, at most one request should be hot on clock edge (in SplitOperatorShared)" severity error;
  end generate DebugGen;
  
  imux: InputMuxBase
    generic map(iwidth => iwidth*num_reqs,
                owidth => iwidth, 
                twidth => tag_length,
                nreqs => num_reqs,
                no_arbitration => no_arbitration,
                registered_output => min_clock_period)
    port map(
      reqL       => reqL,
      ackL       => ackL,
      reqR       => ireq,
      ackR       => iack,
      dataL      => dataL,
      dataR      => idata,
      tagR       => itag,
      clk        => clk,
      reset      => reset);

  op: SplitOperatorBase
    generic map (
      operator_id   => operator_id,
      input1_is_int => input1_is_int,
      input1_characteristic_width => input1_characteristic_width,
      input1_mantissa_width => input1_mantissa_width,
      iwidth_1  => iwidth_1,
      input2_is_int => input2_is_int,
      input2_characteristic_width => input2_characteristic_width,
      input2_mantissa_width  => input2_mantissa_width,
      iwidth_2  => iwidth_2,
      num_inputs  => num_inputs,
      output_is_int => output_is_int,
      output_characteristic_width => output_characteristic_width,
      output_mantissa_width  => output_mantissa_width,
      owidth    => owidth,
      constant_operand => constant_operand,
      constant_width => constant_width,
      twidth     => tag_length,
      use_constant => use_constant,
      zero_delay  => zero_delay
      )
    port map (
      reqL => ireq,
      ackL => iack,
      reqR => oreq,
      ackR => oack,
      dataL => idata,
      dataR => odata,
      tagR => otag,
      tagL => itag,
      clk => clk,
      reset => reset);


  odemux: OutputDeMuxBase
    generic map (
  	iwidth => owidth,
  	owidth =>  owidth*num_reqs,
	twidth =>  tag_length,
	nreqs  => num_reqs,
	no_arbitration => no_arbitration)
    port map (
      reqL   => oreq,
      ackL   => oack,
      dataL => odata,
      tagL  => otag,
      reqR  => reqR,
      ackR  => ackR,
      dataR => dataR,
      clk   => clk,
      reset => reset);
  
end Vanilla;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity StoreCompleteShared is
  generic (num_reqs: integer := 3;
	   tag_length: integer :=  3);
  port (
    -- in requester array, pulse protocol
    -- more than one requester can be active
    -- at any time
    reqR : in BooleanArray(num_reqs-1 downto 0);
    -- out ack array, pulse protocol
    -- more than one ack can be sent back
    -- at any time.
    --
    -- Note: req -> ack delay can be 0
    ackR : out BooleanArray(num_reqs-1 downto 0);
    -- mreq goes out to memory as 
    -- a response to mack.
    mreq : out std_logic;
    mack : in  std_logic;
    -- mtag to distinguish the 
    -- requesters.
    mtag : in std_logic_vector(tag_length-1 downto 0);
    -- rising edge of clock is used
    clk : in std_logic;
    -- synchronous reset, active high
    reset : in std_logic);
end StoreCompleteShared;

architecture Behave of StoreCompleteShared is
begin  -- Behave


  odemux: OutputDemuxBaseNoData
    generic map (
      twidth =>  tag_length,
      nreqs  => num_reqs,
      no_arbitration => true)
    port map (
      reqL   => mack,                   -- cross-over (mack from mem-subsystem)
      ackL   => mreq,                   -- cross-over 
      tagL  =>  mtag,
      reqR  => reqR,
      ackR  => ackR,
      clk   => clk,
      reset => reset);

end Behave;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity StoreReqShared is
    generic
    (
	addr_width: integer;
	data_width : integer;
      	num_reqs : integer; -- how many requesters?
	tag_length: integer;
	no_arbitration: Boolean;
        min_clock_period: Boolean := false        
    );
  port (
    -- req/ack follow pulse protocol
    reqL                     : in BooleanArray(num_reqs-1 downto 0);
    ackL                     : out BooleanArray(num_reqs-1 downto 0);
    -- address corresponding to access
    addr                    : in std_logic_vector((addr_width*num_reqs)-1 downto 0);
    data                    : in std_logic_vector((data_width*num_reqs)-1 downto 0);
    -- address to memory
    maddr                   : out std_logic_vector(addr_width-1 downto 0);
    mdata                   : out std_logic_vector(data_width-1 downto 0);
    mtag                    : out std_logic_vector(tag_length-1 downto 0);
    mreq                    : out std_logic;
    mack                    : in std_logic;
    -- clock, reset (active high)
    clk, reset              : in std_logic);
end StoreReqShared;

architecture Vanilla of StoreReqShared is

  constant iwidth: integer := addr_width*num_reqs;
  constant owidth: integer := addr_width;

  signal idata: std_logic_vector(((addr_width+data_width)*num_reqs)-1 downto 0);
  signal odata: std_logic_vector((addr_width+data_width)-1 downto 0);

  constant debug_flag : boolean := false;
  
begin  -- Behave

  process(addr,data)
  begin
     for I in num_reqs-1 downto 0 loop
	idata(((I+1)*(addr_width+data_width))-1 downto (I*(addr_width+data_width))) <= 
		addr(((I+1)*addr_width)-1 downto I*addr_width) & 
		data(((I+1)*data_width)-1 downto I*data_width);
     end loop;
  end process;

  maddr <= odata(addr_width+data_width-1 downto data_width);
  mdata <= odata(data_width-1 downto 0);

  assert(tag_length >= Ceil_Log2(num_reqs)) report "insufficient tag width" severity error;

  debugCase: if debug_flag generate
    assert( (not ((reset = '0') and (clk'event and clk = '1') and no_arbitration)) or Is_At_Most_One_Hot(reqL))
      report "in no-arbitration case, at most one request should be hot on clock edge (in SplitOperatorShared)" severity error;
  end generate debugCase;
  
  imux: InputMuxBase
  	generic map(iwidth => (addr_width+data_width)*num_reqs ,
	   owidth => addr_width+data_width, 
	   twidth => tag_length,
	   nreqs => num_reqs,
           registered_output => min_clock_period,
	   no_arbitration => no_arbitration)
    port map(
      reqL       => reqL,
      ackL       => ackL,
      reqR       => mreq,
      ackR       => mack,
      dataL      => idata,
      dataR      => odata,
      tagR       => mtag,
      clk        => clk,
      reset      => reset);
  
end Vanilla;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.OperatorPackage.all;
use ahir.BaseComponents.all;
use ahir.FloatOperatorPackage.all;

entity UnsharedOperatorBase is
  generic
    (
      operator_id   : string;          -- operator id
      input1_is_int : Boolean := true; -- false means float
      input1_characteristic_width : integer := 0; -- characteristic width if input1 is float
      input1_mantissa_width       : integer := 0; -- mantissa width if input1 is float
      iwidth_1      : integer;    -- width of input1
      input2_is_int : Boolean := true; -- false means float
      input2_characteristic_width : integer := 0; -- characteristic width if input2 is float
      input2_mantissa_width       : integer := 0; -- mantissa width if input2 is float
      iwidth_2      : integer;    -- width of input2
      num_inputs    : integer := 2;    -- can be 1 or 2.
      output_is_int : Boolean := true;  -- false means that the output is a float
      output_characteristic_width : integer := 0;
      output_mantissa_width       : integer := 0;
      owidth        : integer;          -- width of output.
      constant_operand : std_logic_vector; -- constant operand.. (it is always the second operand)
      constant_width : integer;
      use_constant  : boolean := false;
      zero_delay    : boolean := false;
      flow_through  : boolean := false
      );
  port (
    -- req -> ack follow pulse protocol
    reqL:  in Boolean;
    ackL : out Boolean;
    reqR : in Boolean;
    ackR:  out Boolean;
    -- operands.
    dataL      : in  std_logic_vector(iwidth_1 + iwidth_2 - 1 downto 0);
    dataR      : out std_logic_vector(owidth-1 downto 0);
    clk, reset : in  std_logic);
end UnsharedOperatorBase;


architecture Vanilla of UnsharedOperatorBase is
  signal   result: std_logic_vector(owidth-1 downto 0);
  signal   state_sig : std_logic;
  constant iwidth : integer := iwidth_1  + iwidth_2;
  signal   enable_data_reg : std_logic;
  
begin  -- Behave


  assert((num_inputs = 1) or (num_inputs = 2)) report "either 1 or 2 inputs" severity failure;

  ackR <= reqR;                         -- all action on reqL->ackL

  comb_block: GenericCombinationalOperator
    generic map (
      operator_id                 => operator_id,
      input1_is_int               => input1_is_int,
      input1_characteristic_width => input1_characteristic_width,
      input1_mantissa_width       => input1_mantissa_width,
      iwidth_1                    => iwidth_1,
      input2_is_int               => input2_is_int,
      input2_characteristic_width => input2_characteristic_width,
      input2_mantissa_width       => input2_mantissa_width,
      iwidth_2                    => iwidth_2,
      num_inputs                  => num_inputs,
      output_is_int               => output_is_int,
      output_characteristic_width => output_characteristic_width,
      output_mantissa_width       => output_mantissa_width,
      owidth                      => owidth,
      constant_operand            => constant_operand,
      constant_width              => constant_width,
      use_constant                => use_constant)
    port map (
      data_in => dataL,
      result  => result);

  FlowThrough: if flow_through generate
    ackL <= reqL;
    dataR <= result;
  end generate FlowThrough;

  ZeroDelay: if ((not flow_through) and zero_delay) generate

    ackL <= reqL;
    enable_data_reg <= '1' when reqL  else '0';

    dreg : BypassRegister generic map (
      data_width    => owidth,
      enable_bypass => true)
      port map (
        clk      => clk,
        reset    => reset,
        enable   => enable_data_reg,
        data_in  => result,
        data_out => dataR);
    
  end generate ZeroDelay;

  NonZeroDelay: if ((not flow_through) and (not zero_delay)) generate

    process(clk)
    begin
      if(clk'event and clk = '1') then
        if(reset = '1') then
          ackL <= false;
        else
          ackL <= reqL;
        end if;
      end if;
    end process;

    enable_data_reg <= '1' when reqL  else '0';

    dreg : BypassRegister generic map (
      data_width    => owidth,
      enable_bypass => false)
      port map (
        clk      => clk,
        reset    => reset,
        enable   => enable_data_reg,
        data_in  => result,
        data_out => dataR);
  
  end generate NonZeroDelay;
  
end Vanilla;

