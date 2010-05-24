 library ieee;        
 use ieee.std_logic_1164.all;        
 library ahir;        
 use ahir.Types.all;        
 use ahir.Components.all;        
 use ahir.BaseComponents.all;        
 
 configuration ApIntToApFloatSigned of ApIntToApFloat_S_1 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntToApFloatSigned",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntToApFloatSigned;

 configuration ApIntToApFloatUnsigned of ApIntToApFloat_S_1 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApIntToApFloatUnsigned",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApIntToApFloatUnsigned;

 configuration ApFloatToApIntSigned of ApFloatToApInt_S_1 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatToApIntSigned",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatToApIntSigned;

 configuration ApFloatToApIntUnsigned of ApFloatToApInt_S_1 is        
   for Base        
     for op : OperatorShared        
       use entity ahir.OperatorShared(Vanilla)        
         generic map (        
           colouring => colouring,        
           const_operand => const_operand,        
           operator_id => "ApFloatToApIntUnsigned",        
           use_constant => use_constant,        
           suppress_immediate_ack => suppress_immediate_ack,        
           zero_delay  => false);        
     end for;        
   end for;        
 end ApFloatToApIntUnsigned;
