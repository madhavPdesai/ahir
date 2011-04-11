library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;

entity place is

  generic (
    marking : boolean := false);
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
    if reset = '1' then                 -- asynchronous reset (active high)
      token_latch <= marking;
    elsif clk'event and clk = '1' then  -- rising clock edge
      if backward_reset then
        token_latch <= false;
      else
        token_latch <= token_sig;
      end if;
    end if;
  end process latch_token;

  token_sig <= true when incoming_token else
               token_latch;

  token <= token_sig;

end default_arch;
