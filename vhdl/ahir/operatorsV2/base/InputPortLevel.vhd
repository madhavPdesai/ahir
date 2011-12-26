library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

entity InputPortLevel is
  
  generic (num_reqs: integer := 5; 
	data_width: integer := 8;  
	no_arbitration: boolean := true);
  port (
    -- ready/ready interface with the requesters
    req       : in  std_logic_vector(num_reqs-1 downto 0);
    ack       : out std_logic_vector(num_reqs-1 downto 0);
    data      : out std_logic_vector((num_reqs*data_width)-1 downto 0);
    -- ready/ready interface with outside world
    oreq       : out std_logic;
    oack       : in  std_logic;
    odata      : in  std_logic_vector(data_width-1 downto 0);
    clk, reset : in  std_logic);
  
end InputPortLevel;

architecture default_arch of InputPortLevel is

  
  type IPWArray is array(integer range <>) of std_logic_vector(data_width-1 downto 0);
  signal data_final, data_reg : IPWArray(num_reqs-1 downto 0);
  signal req_active, ack_sig  : std_logic_vector(num_reqs-1 downto 0); 
  
  
begin  -- default_arch

  oreq <= OrReduce(req_active);

  NoArb: if no_arbitration generate
    req_active <= req;
  end generate NoArb;

  Arb: if not no_arbitration generate
    req_active <= PriorityEncode(req);
  end generate Arb;

  process(data_final)
    variable ldata: std_logic_vector((num_reqs*data_width)-1 downto 0);
  begin
    for J in num_reqs-1 downto 0 loop
      Insert(ldata,J,data_final(J));
    end loop;
    data <= ldata;
  end process;

  gen: for I in num_reqs-1 downto 0 generate

    ack_sig(I) <= req_active(I) and oack; 
    
    ack(I) <= ack_sig(I);
    
    data_final(I) <= odata;
    
  end generate gen;

end default_arch;
