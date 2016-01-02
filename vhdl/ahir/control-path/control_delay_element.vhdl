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
  
begin  -- default_arch

  ZeroDelay: if (delay_value <= 0) generate
    ack <= req;
  end generate ZeroDelay;

  UnitDelay: if (delay_value = 1) generate

	process(clk)
        begin
		if(clk'event and clk = '1') then 
			if(reset = '1') then
				ack <= false;
			else	
				ack <= req;
			end if;
		end if;
	end process;

  end generate UnitDelay;


  DelayGTOne: if (delay_value > 1) generate

   ShiftReg: block
	signal sr_state: BooleanArray(0 to delay_value-1);
   begin
 	process(clk)
	begin
		if(clk'event and clk = '1') then
			if(reset = '1') then
				sr_state <= (others => false);
			else
				sr_state(0) <= req;
				for I in 1 to delay_value-1 loop
					sr_state(I) <= sr_state(I-1);
				end loop;
			end if;
		end if;
	end process;
	ack <= sr_state(delay_value-1);
   end block;
  end generate DelayGTOne;

end default_arch;
