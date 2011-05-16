library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

entity Request_Priority_Encode_Entity is
  generic (
    num_reqs : integer := 1);
  port (
    clk,reset : in std_logic;
    reqR : in std_logic_vector(num_reqs-1 downto 0);
    ackR: out std_logic_vector(num_reqs-1 downto 0);
    reqF_in : in std_logic_vector(num_reqs-1 downto 0);
    reqF_out : out std_logic_vector(num_reqs-1 downto 0);
    req_s : out std_logic;
    ack_s : in std_logic);
end entity;

architecture Behave of Request_Priority_Encode_Entity is

  signal req_fsm_state : std_logic;
  signal reqFreg : std_logic_vector(num_reqs-1 downto 0);
  
begin  -- Behave
  
  process(clk,reset,reqR,reqF_in,ack_s,reqFreg,req_fsm_state)
    variable next_state : std_logic;
    variable reqFregvar, ack_var, reqFvar, reqFrawvar : std_logic_vector(reqR'length-1 downto 0);
    variable req_s_var : std_logic;
    variable there_is_a_request : std_logic;
    
  begin
    next_state := req_fsm_state;
    
    reqFrawvar := PriorityEncode(reqR);
    there_is_a_request := OrReduce(reqR);

    reqFregvar := reqFreg;
    req_s_var := '0';

    reqFvar := (others => '0');
    ack_var := (others => '0');
    
    if(reset = '1') then
      next_state := '0';
      reqFregvar := (others => '0');
    else
      case req_fsm_state is
        when '0' =>
          if(there_is_a_request = '1') then
            reqFregvar := reqFrawvar;
            reqFvar := reqFrawvar;
            req_s_var := '1';

	    if(ack_s = '1') then
		ack_var := reqF_in;	
	    else
            	next_state := '1';
	    end if;  
	  else
	    reqFregvar := (others => '0');
	    reqFvar := (others => '0');
          end if;
        when '1' =>
          reqFvar := reqFreg;                           
          req_s_var := '1';
          if(ack_s = '1') then
            ack_var := reqF_in;
            reqFregvar := (others => '0');
            next_state := '0';
          end if;
        when others =>
          null;
      end case;
    end if;

    ackR <= ack_var;
    req_s <= req_s_var;
    reqF_out  <= reqFvar;
    
    if(clk'event and clk = '1') then
      req_fsm_state <= next_state;
      reqFreg <= reqFregvar;
    end if;
  end process;

end Behave;
