library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

-- like PhiBase, but multiple writers can
-- be simultaneously active.  Use simple priority
-- to decide the winner.
entity ScalarRegister is

  generic (
    num_reqs   : integer;
    data_width : integer);
  port (
    req                 : in  BooleanArray(num_reqs-1 downto 0);
    ack                 : out Boolean;
    idata               : in  std_logic_vector((num_reqs*data_width)-1 downto 0);
    odata               : out std_logic_vector(data_width-1 downto 0);
    clk, reset          : in std_logic);

end ScalarRegister;


architecture Behave of ScalarRegister is
  signal req_PE: BooleanArray(num_reqs-1 downto 0);
begin  -- Behave

  req_PE <= PriorityEncode(req);
  pInst: PhiBase generic map(num_reqs => num_reqs, data_width => data_width)
		port map(req => req_PE, ack => ack, idata => idata, odata => odata,
				clk => clk, reset => reset);
end Behave;
