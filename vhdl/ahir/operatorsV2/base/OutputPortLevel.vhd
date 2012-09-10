library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity OutputPortLevel is
  generic(num_reqs: integer;
	data_width: integer;
	no_arbitration: boolean);
  port (
    req       : in  std_logic_vector(num_reqs-1 downto 0);
    ack       : out std_logic_vector(num_reqs-1 downto 0);
    data      : in  std_logic_vector((num_reqs*data_width)-1 downto 0);
    oreq       : out std_logic;
    oack       : in  std_logic;
    odata      : out std_logic_vector(data_width-1 downto 0);
    clk, reset : in  std_logic);
end entity;

architecture Base of OutputPortLevel is
  
  type OPWArray is array(integer range <>) of std_logic_vector(odata'range);
  signal data_array : OPWArray(num_reqs-1 downto 0);
  signal req_active, ack_sig , fair_reqs, fair_acks : std_logic_vector(num_reqs-1 downto 0);
  
begin

  fairify: NobodyLeftBehind generic map(num_reqs => num_reqs)
		port map(clk => clk, reset => reset,
				reqIn => req,
				ackOut => ack,
				reqOut => fair_reqs,
				ackIn => fair_acks);
  
  oreq <= OrReduce(req_active);

  NoArb: if no_arbitration generate
     req_active <= fair_reqs;
  end generate NoArb;

  Arb: if not no_arbitration generate
     req_active <= PriorityEncode(fair_reqs);
  end generate Arb;

  process (data_array)
    variable var_odata : std_logic_vector(data_width-1 downto 0) := (others => '0');
  begin  -- process
    var_odata := (others => '0');
    for I in 0 to num_reqs-1 loop
      var_odata := data_array(I) or var_odata;
    end loop;  -- I
    odata <= var_odata;
  end process;

  gen: for I in num_reqs-1 downto 0 generate

       ack_sig(I) <= req_active(I) and oack; 
       fair_acks(I) <= ack_sig(I);

       process(data,req_active(I))
         variable target: std_logic_vector(data_width-1 downto 0);
       begin
          if(req_active(I) = '1') then
		Extract(data,I,target);
	  else
		target := (others => '0');
	  end if;	
       	  data_array(I) <= target;
       end process;
         
  end generate gen;

end Base;
