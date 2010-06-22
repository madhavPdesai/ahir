library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity OutputPort is
  generic(colouring: NaturalArray);
  port (
    req       : in  BooleanArray;
    ack       : out BooleanArray;
    data      : in  StdLogicArray2D;
    oreq       : out std_logic;
    oack       : in  std_logic;
    odata      : out std_logic_vector;
    clk, reset : in  std_logic);
end entity;

architecture Base of OutputPort is
  signal treq, tack : BooleanArray(req'length-1 downto 0);
  alias lreq : BooleanArray(req'length-1 downto 0) is req;
  alias lack : BooleanArray(req'length-1 downto 0) is ack;  
  
  type OPWArray is array(integer range <>) of std_logic_vector(odata'range);
  signal data_array : OPWArray(data'length(1)-1 downto 0);
  signal req_pending,req_active, req_reg, ack_sig  : std_logic_vector(data'length(1)-1 downto 0); 
  
  constant no_arbitration: boolean := All_Entries_Same(colouring);
  
begin
  
  oreq <= OrReduce(req_pending);

  NoArb: if no_arbitration generate
     req_active <= req_pending;
  end generate NoArb;

  Arb: if not no_arbitration generate
     req_active <= PriorityEncode(req_pending);
  end generate Arb;

  process (data_array)
    variable var_odata : std_logic_vector(odata'range) := (others => '0');
  begin  -- process
    var_odata := (others => '0');
    for I in 0 to data'length(1) - 1 loop
      var_odata := data_array(I) or var_odata;
    end loop;  -- I
    odata <= var_odata;
  end process;

  gen: for I in data'length(1)-1 downto 0 generate

      process(clk)
      begin
         if(clk'event and clk = '1') then
                if(reset = '1' or ack_sig(I) = '1') then
			req_reg(I) <= '0';
		elsif lreq(I) then
			req_reg(I) <= '1';
		end if;
	 end if;
       end process;

       req_pending(I) <= '1' when (lreq(I) and (not oack = '1')) or (req_reg(I) = '1') else '0';
       ack_sig(I) <= req_active(I) and oack; 
 
       lack(I) <= ack_sig(I) = '1';

       data_array(I) <= Extract(data, I) when req_active(I) = '1' else (others => '0');
         
  end generate gen;

end Base;
