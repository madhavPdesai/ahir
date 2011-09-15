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
