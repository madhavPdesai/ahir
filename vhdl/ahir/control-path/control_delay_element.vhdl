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
  
begin  -- default_arch

  ZeroDelay: if delay_value <= 0 generate
    ack <= req;
  end generate ZeroDelay;


  NonZeroDelay: if delay_value > 0 generate

   ShiftReg: block
	signal sr_state: BooleanArray(0 to delay_value);
   begin
 	process(clk)
	begin
		if(clk'event and clk = '1') then
			if(reset = '1') then
				sr_state <= (others => false);
			else
				sr_state(0) <= req;
				for I in 1 to delay_value loop
					sr_state(I) <= sr_state(I-1);
				end loop;
			end if;
		end if;
	end process;

	ack <= sr_state(delay_value);
   end block;

  end generate NonZeroDelay;

end default_arch;
