 library ieee;        
 use ieee.std_logic_1164.all;        
 library ahir;        
 use ahir.Types.all;        
 use ahir.Components.all;        
 use ahir.BaseComponents.all;        
 
 configuration ApFloatResize of ApFloat_S_1 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatResize",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatResize;

 configuration ApFloatAdd of ApFloat_S_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatAdd",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatAdd;

 configuration ApFloatSub of ApFloat_S_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatSub",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatSub;

 configuration ApFloatMul of ApFloat_S_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatMul",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatMul;

 configuration ApFloatOeq of ApFloat_Cmp_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatOeq",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatOeq;

 configuration ApFloatOne of ApFloat_Cmp_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatOne",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatOne;

 configuration ApFloatOgt of ApFloat_Cmp_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatOgt",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatOgt;

 configuration ApFloatOge of ApFloat_Cmp_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatOge",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatOge;

 configuration ApFloatOlt of ApFloat_Cmp_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatOlt",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatOlt;

 configuration ApFloatOle of ApFloat_Cmp_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatOle",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatOle;

 configuration ApFloatUeq of ApFloat_Cmp_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatUeq",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatUeq;

 configuration ApFloatUne of ApFloat_Cmp_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatUne",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatUne;

 configuration ApFloatUgt of ApFloat_Cmp_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatUgt",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatUgt;

 configuration ApFloatUge of ApFloat_Cmp_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatUge",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatUge;

 configuration ApFloatUlt of ApFloat_Cmp_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatUlt",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatUlt;

 configuration ApFloatUle of ApFloat_Cmp_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatUle",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatUle;

 configuration ApFloatOrd of ApFloat_Cmp_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatOrd",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatOrd;

 configuration ApFloatUno of ApFloat_Cmp_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatUno",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatUno;

 configuration ApFloatAddC of ApFloat_S_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatAdd",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatAddC;

 configuration ApFloatSubC of ApFloat_S_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatSub",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatSubC;

 configuration ApFloatMulC of ApFloat_S_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatMul",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatMulC;

 configuration ApFloatOeqC of ApFloat_Cmp_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatOeq",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatOeqC;

 configuration ApFloatOneC of ApFloat_Cmp_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatOne",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatOneC;

 configuration ApFloatOgtC of ApFloat_Cmp_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatOgt",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatOgtC;

 configuration ApFloatOgeC of ApFloat_Cmp_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatOge",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatOgeC;

 configuration ApFloatOltC of ApFloat_Cmp_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatOlt",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatOltC;

 configuration ApFloatOleC of ApFloat_Cmp_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatOle",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatOleC;

 configuration ApFloatUeqC of ApFloat_Cmp_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatUeq",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatUeqC;

 configuration ApFloatUneC of ApFloat_Cmp_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatUne",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatUneC;

 configuration ApFloatUgtC of ApFloat_Cmp_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatUgt",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatUgtC;

 configuration ApFloatUgeC of ApFloat_Cmp_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatUge",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatUgeC;

 configuration ApFloatUltC of ApFloat_Cmp_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatUlt",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatUltC;

 configuration ApFloatUleC of ApFloat_Cmp_2_C is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatUle",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatUleC;

 configuration ApFloatOrdC of ApFloat_Cmp_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatOrd",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatOrdC;

 configuration ApFloatUnoC of ApFloat_Cmp_2 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatUno",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatUnoC;
