------------------------------------------------------------------------------------------------
--
-- Copyright (C) 2010-: Madhav P. Desai
-- All Rights Reserved.
--  
-- Permission is hereby granted, free of charge, to any person obtaining a
-- copy of this software and associated documentation files (the
-- "Software"), to deal with the Software without restriction, including
-- without limitation the rights to use, copy, modify, merge, publish,
-- distribute, sublicense, and/or sell copies of the Software, and to
-- permit persons to whom the Software is furnished to do so, subject to
-- the following conditions:
-- 
--  * Redistributions of source code must retain the above copyright
--    notice, this list of conditions and the following disclaimers.
--  * Redistributions in binary form must reproduce the above
--    copyright notice, this list of conditions and the following
--    disclaimers in the documentation and/or other materials provided
--    with the distribution.
--  * Neither the names of the AHIR Team, the Indian Institute of
--    Technology Bombay, nor the names of its contributors may be used
--    to endorse or promote products derived from this Software
--    without specific prior written permission.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
-- OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
-- IN NO EVENT SHALL THE CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR
-- ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
-- TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
-- SOFTWARE OR THE USE OR OTHER DEALINGS WITH THE SOFTWARE.
------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.GlobalConstants.all;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

entity place_with_bypass is

  generic (
    capacity: integer := 1;
    marking : integer := 0;
    name   : string
    );
  port (
    preds : in  BooleanArray;
    succs : in  BooleanArray;
    token : out boolean;
    clk   : in  std_logic;
    reset : in  std_logic);

end place_with_bypass;

architecture default_arch of place_with_bypass is

  signal incoming_token : boolean;      -- true if a pred fires
  signal backward_reset : boolean;      -- true if a succ fires
  signal token_latch    : integer range 0 to capacity;
  signal non_zero       : boolean;

  constant debug_flag : boolean := global_debug_flag;
  
begin  -- default_arch

  assert capacity > 0 report "in place " & name & ": place must have capacity > 1." severity error;
  assert marking <= capacity report "in place " & name & ": initial marking must be less than place capacity." severity error;

  -- At most one of the preds can send a pulse.
  -- We detect it with an OR over all inputs
  incoming_token <= OrReduce(preds);

  -- At most one of the succs can send a pulse.
  -- We detect it with an OR over all inputs
  backward_reset <= OrReduce(succs);


  latch_token : process (clk, reset,incoming_token, backward_reset, token_latch, non_zero)
	variable incr, decr: boolean;
  begin

    incr := incoming_token and (not backward_reset);
    decr := backward_reset and (not incoming_token);
    

    if clk'event and clk = '1' then  -- rising clock edge

      if reset = '1' then            -- synchronous reset (active high)
        token_latch <= marking;
	non_zero <= (marking > 0);
      elsif decr then

        if(debug_flag) then
        	if(token_latch = 0) then
          		assert false report "in place-with-bypass: " & name &  ": number of tokens cannot become negative!" severity error;
        	end if;
           	assert false report "in place " & name & ": token count decremented from " & Convert_To_String(token_latch) 
		 	severity note;
	end if;

	non_zero <= not (token_latch = 1);
       	token_latch <= token_latch - 1;

      elsif incr then

	if(debug_flag) then
       		if(token_latch = capacity) then
         		assert false report "in place-with-bypass: " & name & " number of tokens "
			 	& Convert_To_String(token_latch+1) & " cannot exceed capacity " 
			 	& Convert_To_String(capacity) severity error;
       		end if;
           	assert false report "in place " & name & " token count incremented from " & Convert_To_String(token_latch) 
		  	severity note;
	end if;

	non_zero <= true;
        token_latch <= token_latch + 1;

      end if;
    end if;
  end process latch_token;

  token <= incoming_token or non_zero;

end default_arch;
