library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Components.all;
use ahir.BaseComponents.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

entity InputPort is
  generic (colouring: NaturalArray);
  port (
    -- pulse interface with the data-path
    req       : in  BooleanArray;
    ack       : out BooleanArray;
    data      : out StdLogicArray2D;
    -- ready/ready interface with outside world
    oreq       : out std_logic;
    oack       : in  std_logic;
    odata      : in  std_logic_vector;
    clk, reset : in  std_logic);
end entity;


architecture Base of InputPort is
  signal treq, tack : BooleanArray(req'length-1 downto 0);
  alias lreq : BooleanArray(req'length-1 downto 0) is req;
  alias lack : BooleanArray(req'length-1 downto 0) is ack;  
  signal ftagL: std_logic_vector(0 downto 0);
  
  type IPWArray is array(integer range <>) of std_logic_vector(odata'range);
  signal data_final, data_reg : IPWArray(data'length(1)-1 downto 0);
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

  process(data_final)
     variable ldata: StdLogicArray2D(data'length(1)-1 downto 0, data'length(2)-1 downto 0);
  begin
     for J in data'length(1)-1 downto 0 loop
        Insert(ldata,J,data_final(J));
     end loop;
     data <= ldata;
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
 
       lack(I) <= true when ack_sig(I) = '1' else false;

       process(clk)
       begin
          if(clk'event and clk = '1') then
		if(ack_sig(I) = '1') then
			data_reg(I) <= odata;
		end if;
	  end if;
       end process;

       data_final(I) <= odata when ack_sig(I) = '1' else data_reg(I);
  end generate gen;

end Base;
