library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
entity control_delay_element is
  generic (delay_value: integer := 0);
  port (
    req   : in Boolean;
    ack   : out Boolean;
    clk   : in  std_logic;
    reset : in  std_logic);

end control_delay_element;

architecture default_arch of control_delay_element is

  signal delay_count : integer range 0 to delay_value;
  signal state_sig : std_logic;
  
begin  -- default_arch

  ZeroDelay: if delay_value <= 0 generate
    ack <= req;
  end generate ZeroDelay;


  NonZeroDelay: if delay_value > 0 generate

    process(clk,state_sig,delay_count)
      variable next_state_sig : std_logic;
      variable incr_count : Boolean;
      variable ack_var : Boolean;
      variable next_delay_var : integer range 0 to delay_value;
      
    begin

      next_state_sig := state_sig;
      ack_var := false;
      next_delay_var := 0;
      
        case state_sig is
          when '0' =>
            if req  then
              next_state_sig := '1';
            end if;
          when others =>
            if(delay_count = delay_value-1) then
              ack_var := true;
              next_state_sig := '0';
            else
              next_delay_var := delay_count + 1;
            end if;
        end case;

      ack <= ack_var;
      if(clk'event and clk = '1') then
	if(reset = '1') then
		state_sig <=  '0';
		delay_count <= 0;
	else 
        	state_sig <= next_state_sig;
        	delay_count <= next_delay_var;
	end if;
      end if;
    end process;

  end generate NonZeroDelay;

end default_arch;
