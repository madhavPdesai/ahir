 library ieee;        
 use ieee.std_logic_1164.all;        
 library ahir;        
 use ahir.Types.all;        
 use ahir.Components.all;        
 use ahir.BaseComponents.all;        
 
 configuration ApIntNot of ApInt_S_1 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntNot",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntNot; 


 configuration ApIntToApIntSigned of ApInt_S_1 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntToApIntSigned",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntToApIntSigned; 


 configuration ApIntToApIntUnsigned of ApInt_S_1 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntToApIntUnsigned",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntToApIntUnsigned; 


 configuration ApIntAdd of ApInt_S_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntAdd",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntAdd; 


 configuration ApIntSub of ApInt_S_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntSub",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntSub; 


 configuration ApIntAnd of ApInt_S_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntAnd",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntAnd; 


 configuration ApIntOr of ApInt_S_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntOr",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntOr; 


 configuration ApIntXor of ApInt_S_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntXor",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntXor; 


 configuration ApIntMul of ApInt_S_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntMul",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntMul; 


 configuration ApIntSHL of ApInt_S_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntSHL",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntSHL; 


 configuration ApIntLSHR of ApInt_S_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntLSHR",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntLSHR; 


 configuration ApIntASHR of ApInt_S_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntASHR",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntASHR; 


 configuration ApIntEq of ApInt_S_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntEq",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntEq; 


 configuration ApIntNe of ApInt_S_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntNe",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntNe; 


 configuration ApIntUgt of ApInt_S_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntUgt",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntUgt; 


 configuration ApIntUge of ApInt_S_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntUge",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntUge; 


 configuration ApIntUlt of ApInt_S_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntUlt",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntUlt; 


 configuration ApIntUle of ApInt_S_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntUle",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntUle; 


 configuration ApIntSgt of ApInt_S_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntSgt",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntSgt; 


 configuration ApIntSge of ApInt_S_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntSge",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntSge; 


 configuration ApIntSlt of ApInt_S_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntSlt",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntSlt; 


 configuration ApIntSle of ApInt_S_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntSle",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntSle; 


 configuration ApIntAddC of ApInt_S_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntAdd",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntAddC; 


 configuration ApIntSubC of ApInt_S_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntSub",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntSubC; 


 configuration ApIntAndC of ApInt_S_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntAnd",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntAndC; 


 configuration ApIntOrC of ApInt_S_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntOr",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntOrC; 


 configuration ApIntXorC of ApInt_S_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntXor",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntXorC; 


 configuration ApIntMulC of ApInt_S_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntMul",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntMulC; 


 configuration ApIntSHLC of ApInt_S_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntSHL",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntSHLC; 


 configuration ApIntLSHRC of ApInt_S_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntLSHR",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntLSHRC; 


 configuration ApIntASHRC of ApInt_S_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntASHR",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntASHRC; 


 configuration ApIntEqC of ApInt_S_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntEq",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntEqC; 


 configuration ApIntNeC of ApInt_S_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntNe",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntNeC; 


 configuration ApIntUgtC of ApInt_S_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntUgt",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntUgtC; 


 configuration ApIntUgeC of ApInt_S_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntUge",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntUgeC; 


 configuration ApIntUltC of ApInt_S_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntUlt",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntUltC; 


 configuration ApIntUleC of ApInt_S_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntUle",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntUleC; 


 configuration ApIntSgtC of ApInt_S_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntSgt",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntSgtC; 


 configuration ApIntSgeC of ApInt_S_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntSge",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntSgeC; 


 configuration ApIntSltC of ApInt_S_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntSlt",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntSltC; 


 configuration ApIntSleC of ApInt_S_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntSle",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntSleC; 

