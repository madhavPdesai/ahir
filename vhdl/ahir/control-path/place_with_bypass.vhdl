library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

entity place_with_bypass is

  generic (
    capacity: integer := 1;
    marking : integer := 0;
    name   : string := "anonPlaceWithBypass"
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

  constant debug_flag : boolean := false;
  
begin  -- default_arch

  assert capacity > 0 report "in place " & name & ": place must have capacity > 1." severity error;
  assert marking <= capacity report "in place " & name & ": initial marking must be less than place capacity." severity error;

  -- At most one of the preds can send a pulse.
  -- We detect it with an OR over all inputs
  incoming_token <= OrReduce(preds);

  -- At most one of the succs can send a pulse.
  -- We detect it with an OR over all inputs
  backward_reset <= OrReduce(succs);


  non_zero <= (token_latch > 0);

  latch_token : process (clk, reset,incoming_token, backward_reset, token_latch, non_zero)
	variable incr, decr: boolean;
  begin
    

 

    incr := incoming_token and (not backward_reset);
    decr := backward_reset and (not incoming_token);
    

    if clk'event and clk = '1' then  -- rising clock edge
      if reset = '1' then            -- asynchronous reset (active high)
        token_latch <= marking;
      elsif decr then
	-- if(debug_flag) then
         -- assert false report "in place " & name & ": token count decremented from " & Convert_To_String(token_latch) 
		 -- severity note;
	-- end if;
        token_latch <= token_latch - 1;
      elsif incr then
	-- if(debug_flag) then
         -- assert false report "in place " & name & " token count incremented from " & Convert_To_String(token_latch) 
		 -- severity note;
	-- end if;
        token_latch <= token_latch + 1;
      end if;

       if((token_latch = capacity) and incoming_token and (not backward_reset)) then
         assert false report "in place-with-bypass: " & name & " number of tokens "
			 & Convert_To_String(token_latch+1) & " cannot exceed capacity " 
			 & Convert_To_String(capacity) severity error;
       end if;
       if((not non_zero) and backward_reset and (not incoming_token)) then
         assert false report "in place-with-bypass: " & name &  ": number of tokens cannot become negative!" severity error;
       end if;

    end if;
  end process latch_token;

  token <= incoming_token or non_zero;

end default_arch;
