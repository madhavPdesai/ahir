library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;

entity place is

  generic (
    capacity: integer := 1;
    marking : integer := 0
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
  signal token_latch    : integer range 0 to capacity;
  
begin  -- default_arch

  assert capacity > 0 report "place must have capacity > 1" severity error;
  assert marking <= capacity report "initial marking must be less than place capacity" severity error;

  -- At most one of the preds can send a pulse.
  -- We detect it with an OR over all inputs
  incoming_token <= OrReduce(preds);

  -- At most one of the succs can send a pulse.
  -- We detect it with an OR over all inputs
  backward_reset <= OrReduce(succs);

  latch_token : process (clk, reset)

  begin

    if clk'event and clk = '1' then  -- rising clock edge
      if reset = '1' then            -- asynchronous reset (active high)
        token_latch <= marking;
      elsif (backward_reset and (not incoming_token)) then
        assert token_latch > 0 report "number of tokens cannot become negative!" severity error;
        token_latch <= token_latch - 1;
      elsif (incoming_token and (not backward_reset)) then
        assert token_latch < capacity report "number of tokens cannot exceed capacity" severity error;
        token_latch <= token_latch + 1;
      end if;
    end if;
  end process latch_token;

  token <= true when (token_latch > 0) else false;

end default_arch;
