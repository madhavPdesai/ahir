library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity OutputPort is
  generic(num_reqs: integer;
	  data_width: integer;
	  no_arbitration: boolean);
  port (
    req        : in  BooleanArray(num_reqs-1 downto 0);
    ack        : out BooleanArray(num_reqs-1 downto 0);
    data       : in  std_logic_vector((num_reqs*data_width)-1 downto 0);
    oreq       : out std_logic;
    oack       : in  std_logic;
    odata      : out std_logic_vector(data_width-1 downto 0);
    clk, reset : in  std_logic);
end entity;

architecture Base of OutputPort is

  signal reqR, ackR, eN : std_logic_vector(num_reqs-1 downto 0);
  signal fEN: std_logic_vector(num_reqs-1 downto 0);

  type   OPWArray is array(integer range <>) of std_logic_vector(data_width-1 downto 0);
  signal data_array : OPWArray(num_reqs-1 downto 0);

  
begin

  -----------------------------------------------------------------------------
  -- protocol conversion
  -----------------------------------------------------------------------------
  ProTx : for I in 0 to num_reqs-1 generate

    P2L : block
      signal state : P2LState;
    begin  -- block P2L
      p2LInst: Pulse_To_Level_Translate_Entity
        generic map(suppr_imm_ack => true)
        port map(rL            => req(I),
                 rR            => reqR(I),
                 aL            => ack(I),
                 aR            => ackR(I),
                 en            => eN(I),
                 clk           => clk,
                 reset         => reset);

    end block P2L;
    
  end generate ProTx;

  -----------------------------------------------------------------------------
  -- request handling
  -----------------------------------------------------------------------------
  priorityEncode: Request_Priority_Encode_Entity
    generic map (
      num_reqs => reqR'length)
    port map(clk           => clk,
             reset         => reset,
             reqR          => reqR,
             ackR          => ackR,
             forward_enable => fEN,
             req_s         => oreq,
             ack_s         => oack);

  -----------------------------------------------------------------------------
  -- data handling
  -----------------------------------------------------------------------------
  process (data_array)
    variable var_odata : std_logic_vector(data_width-1 downto 0) := (others => '0');
  begin  -- process
    var_odata := (others => '0');
    for I in 0 to num_reqs - 1 loop
      var_odata := data_array(I) or var_odata;
    end loop;  -- I
    odata <= var_odata;
  end process;

  gen : for I in num_reqs-1 downto 0 generate

    process(data,fEN(I))
       variable target: std_logic_vector(data_width-1 downto 0);
    begin
       	if(fEN(I) = '1') then
		Extract(data,I,target);
       	else 
		target := (others => '0');
	end if;
	data_array(I) <= target;	
    end process;
    
  end generate gen;

end Base;
