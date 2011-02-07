library ieee;	
use ieee.std_logic_1164.all;	
use ieee.numeric_std.all;	
	
library ahir;	
use ahir.Types.all;	
use ahir.Subprograms.all;	
use ahir.Utilities.all;
	
package OperatorPackage is

  procedure ApIntNot_proc(l: in apint; result : out IStdLogicVector);
  procedure ApIntToApIntSigned_proc(l: in apint; result : out IStdLogicVector);
  procedure ApIntToApIntUnsigned_proc(l: in apint; result : out IStdLogicVector);
  procedure ApIntAdd_proc(l: in apint; r : in apint; result : out IStdLogicVector);
  procedure ApIntSub_proc(l: in apint; r : in apint; result : out IStdLogicVector);
  procedure ApIntAnd_proc(l: in apint; r : in apint; result : out IStdLogicVector);
  procedure ApIntOr_proc(l: in apint; r : in apint; result : out IStdLogicVector);
  procedure ApIntXor_proc(l: in apint; r : in apint; result : out IStdLogicVector);
  procedure ApIntMul_proc(l: in apint; r : in apint; result : out IStdLogicVector);
  procedure ApIntSHL_proc(l: in apint; r : in apint; result : out IStdLogicVector);
  procedure ApIntLSHR_proc(l: in apint; r : in apint; result : out IStdLogicVector);
  procedure ApIntASHR_proc(l: in apint; r : in apint; result : out IStdLogicVector);
  procedure ApIntEq_proc(l: in apint; r : in apint; result : out IStdLogicVector);
  procedure ApIntNe_proc(l: in apint; r : in apint; result : out IStdLogicVector);
  procedure ApIntUgt_proc(l: in apint; r : in apint; result : out IStdLogicVector);
  procedure ApIntUge_proc(l: in apint; r : in apint; result : out IStdLogicVector);
  procedure ApIntUlt_proc(l: in apint; r : in apint; result : out IStdLogicVector);
  procedure ApIntUle_proc(l: in apint; r : in apint; result : out IStdLogicVector);
  procedure ApIntSgt_proc(l: in apint; r : in apint; result : out IStdLogicVector);
  procedure ApIntSge_proc(l: in apint; r : in apint; result : out IStdLogicVector);
  procedure ApIntSlt_proc(l: in apint; r : in apint; result : out IStdLogicVector);
  procedure ApIntSle_proc(l: in apint; r : in apint; result : out IStdLogicVector);
  -- TODO
  -- procedures ApFloatToApIntSigned_Proc, ApFloatToApIntUnsigned_Proc,
  --            ApIntSignedToApFloat_Proc, ApIntUnsignedToApFloat_Proc

  procedure TwoInputOperation(constant id    : in string; x, y : in IStdLogicVector; result : out IStdLogicVector);
  procedure SingleInputOperation(constant id : in string; x : in IStdLogicVector; result : out IStdLogicVector);

end package OperatorPackage;

package body OperatorPackage is

  -----------------------------------------------------------------------------
  procedure ApIntNot_proc (l : in apint; result : out IStdLogicVector) is					
  begin
    assert (l'length = result'length)						     
      report "Length Mismatch inApIntNot_proc" severity error;
    result := To_ISLV(to_apint( not to_signed(l)));
  end ApIntNot_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntToApIntSigned_proc (l : in apint; result : out IStdLogicVector) is					
  begin
     result := To_ISLV(to_apint(RESIZE(to_signed(l), result'length)));
  end ApIntToApIntSigned_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntToApIntUnsigned_proc (l : in apint; result : out IStdLogicVector) is					
  begin
     result := To_ISLV(to_apint(RESIZE(to_unsigned(l), result'length)));
  end ApIntToApIntUnsigned_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntAdd_proc (l : in apint; r : in apint; result : out IStdLogicVector) is					
  begin
    assert (l'length = r'length) and (l'length = result'length)						     
      report "Length Mismatch inApIntAdd_proc" severity error;
    result := To_ISLV(to_apint(to_signed(l)  + to_signed(r)));
  end ApIntAdd_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntSub_proc (l : in apint; r : in apint; result : out IStdLogicVector) is					
  begin
    assert (l'length = r'length) and (l'length = result'length)						     
      report "Length Mismatch inApIntSub_proc" severity error;
    result := To_ISLV(to_apint(to_signed(l)  - to_signed(r)));
  end ApIntSub_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntAnd_proc (l : in apint; r : in apint; result : out IStdLogicVector) is					
  begin
    assert (l'length = r'length) and (l'length = result'length)						     
      report "Length Mismatch inApIntAnd_proc" severity error;
    result := To_ISLV(to_apint(to_signed(l)  and to_signed(r)));
  end ApIntAnd_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntOr_proc (l : in apint; r : in apint; result : out IStdLogicVector) is					
  begin
    assert (l'length = r'length) and (l'length = result'length)						     
      report "Length Mismatch inApIntOr_proc" severity error;
    result := To_ISLV(to_apint(to_signed(l)  or to_signed(r)));
  end ApIntOr_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntXor_proc (l : in apint; r : in apint; result : out IStdLogicVector) is					
  begin
    assert (l'length = r'length) and (l'length = result'length)						     
      report "Length Mismatch inApIntXor_proc" severity error;
    result := To_ISLV(to_apint(to_signed(l)  xor to_signed(r)));
  end ApIntXor_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntMul_proc (l : in apint; r : in apint; result : out IStdLogicVector) is					
  begin
    assert (l'length = r'length) and (l'length = result'length)						     
      report "Length Mismatch inApIntMul_proc" severity error;
     result := To_ISLV(to_apint(resize((to_unsigned(l)  * to_unsigned(r)),result'length)));
  end ApIntMul_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntSHL_proc (l : in apint; r : in apint; result : out IStdLogicVector) is					
  begin
     result := To_ISLV(to_apint(to_unsigned(l)  sll to_integer(to_unsigned(r))));
  end ApIntSHL_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntLSHR_proc (l : in apint; r : in apint; result : out IStdLogicVector) is					
  begin
     result := To_ISLV(to_apint(to_unsigned(l)  srl to_integer(to_unsigned(r))));
  end ApIntLSHR_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntASHR_proc (l : in apint; r : in apint; result : out IStdLogicVector) is					
  begin
     result := To_ISLV(to_apint(shift_right(to_signed(l), to_integer(to_unsigned(r))))); 
  end ApIntASHR_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntEq_proc (l : in apint; r : in apint; result : out IStdLogicVector) is					
  begin
    result := To_ISLV(to_apint(to_signed(l)  = to_signed(r)));
  end ApIntEq_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntNe_proc (l : in apint; r : in apint; result : out IStdLogicVector) is					
  begin
    result := To_ISLV(to_apint(to_signed(l)  /= to_signed(r)));
  end ApIntNe_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntUgt_proc (l : in apint; r : in apint; result : out IStdLogicVector) is					
  begin
    result := To_ISLV(to_apint(to_unsigned(l)  > to_unsigned(r)));
  end ApIntUgt_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntUge_proc (l : in apint; r : in apint; result : out IStdLogicVector) is					
  begin
    result := To_ISLV(to_apint(to_unsigned(l)  >= to_unsigned(r))); 
  end ApIntUge_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntUlt_proc (l : in apint; r : in apint; result : out IStdLogicVector) is					
  begin
    result := To_ISLV(to_apint(to_unsigned(l)  < to_unsigned(r)));
  end ApIntUlt_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntUle_proc (l : in apint; r : in apint; result : out IStdLogicVector) is					
  begin
    result := To_ISLV(to_apint(to_unsigned(l)  <= to_unsigned(r))); 
  end ApIntUle_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntSgt_proc (l : in apint; r : in apint; result : out IStdLogicVector) is					
  begin
    result := To_ISLV(to_apint(to_signed(l)  > to_signed(r)));
  end ApIntSgt_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntSge_proc (l : in apint; r : in apint; result : out IStdLogicVector) is					
  begin
    result := To_ISLV(to_apint(to_signed(l)  >= to_signed(r)));
  end ApIntSge_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntSlt_proc (l : in apint; r : in apint; result : out IStdLogicVector) is					
  begin
    result := To_ISLV(to_apint(to_signed(l)  < to_signed(r)));
  end ApIntSlt_proc; 				
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure ApIntSle_proc (l : in apint; r : in apint; result : out IStdLogicVector) is					
  begin
    result := To_ISLV(to_apint(to_signed(l)  <= to_signed(r)));
  end ApIntSle_proc;
  ---------------------------------------------------------------------
  -----------------------------------------------------------------------------
  procedure TwoInputOperation(constant id : in string; x, y : in IStdLogicVector; result : out IStdLogicVector) is	
    variable result_var : IStdLogicVector(result'high downto result'low);	
    variable temp_int: integer;
  begin
    if id = "ApIntBitsel" then
      result_var := x & y;
    elsif id = "ApIntBitsel" then
      temp_int := To_Integer(To_Unsigned(To_SLV(y)));
      result_var(result_var'low) := x(temp_int);
    elsif id = "ApIntAdd" then					
      ApIntAdd_proc(To_apint(x), To_apint(y), result_var);
    elsif id = "ApIntSub" then					
      ApIntSub_proc(To_apint(x), To_apint(y), result_var);
    elsif id = "ApIntAnd" then					
      ApIntAnd_proc(To_apint(x), To_apint(y), result_var);
    elsif id = "ApIntOr" then					
      ApIntOr_proc(To_apint(x), To_apint(y), result_var);
    elsif id = "ApIntXor" then					
      ApIntXor_proc(To_apint(x), To_apint(y), result_var);
    elsif id = "ApIntMul" then					
      ApIntMul_proc(To_apint(x), To_apint(y), result_var);
    elsif id = "ApIntSHL" then					
      ApIntSHL_proc(To_apint(x), To_apint(y), result_var);
    elsif id = "ApIntLSHR" then					
      ApIntLSHR_proc(To_apint(x), To_apint(y), result_var);
    elsif id = "ApIntASHR" then					
      ApIntASHR_proc(To_apint(x), To_apint(y), result_var);
    elsif id = "ApIntEq" then					
      ApIntEq_proc(To_apint(x), To_apint(y), result_var);
    elsif id = "ApIntNe" then					
      ApIntNe_proc(To_apint(x), To_apint(y), result_var);
    elsif id = "ApIntUgt" then					
      ApIntUgt_proc(To_apint(x), To_apint(y), result_var);
    elsif id = "ApIntUge" then					
      ApIntUge_proc(To_apint(x), To_apint(y), result_var);
    elsif id = "ApIntUlt" then					
      ApIntUlt_proc(To_apint(x), To_apint(y), result_var);
    elsif id = "ApIntUle" then					
      ApIntUle_proc(To_apint(x), To_apint(y), result_var);
    elsif id = "ApIntSgt" then					
      ApIntSgt_proc(To_apint(x), To_apint(y), result_var);
    elsif id = "ApIntSge" then					
      ApIntSge_proc(To_apint(x), To_apint(y), result_var);
    elsif id = "ApIntSlt" then					
      ApIntSlt_proc(To_apint(x), To_apint(y), result_var);
    elsif id = "ApIntSle" then					
      ApIntSle_proc(To_apint(x), To_apint(y), result_var);
    else	
      assert false report "Unsupported operator-id " & id severity failure;	
    end if;	
    result := result_var;	
  end TwoInputOperation;			
  -----------------------------------------------------------------------------
	
  -----------------------------------------------------------------------------	
  procedure SingleInputOperation(constant id : in string; x : in IStdLogicVector; result : out IStdLogicVector) is	
    variable result_var : IStdLogicVector(result'high downto result'low);	
  begin
    if id = "ApIntNot" then					
      ApIntNot_proc(To_apint(x), result_var);
    elsif id = "ApIntAssign" then
      result_var := x;
    elsif id = "ApIntToApIntSigned" then					
      ApIntToApIntSigned_proc(To_apint(x), result_var);
    elsif id = "ApIntToApIntUnsigned" then					
      ApIntToApIntUnsigned_proc(To_apint(x), result_var);
    else	
      assert false report "Unsupported operator-id " & id severity failure;	
    end if;	
    result := result_var;	
  end SingleInputOperation;	
	
end package body OperatorPackage;	
