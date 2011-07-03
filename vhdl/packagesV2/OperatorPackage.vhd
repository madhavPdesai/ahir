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
