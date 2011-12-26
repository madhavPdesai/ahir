library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.mem_function_pack.all;
use ahir.merge_functions.all;
use ahir.mem_component_pack.all;


-- a dummy ROM  which is never initialized.
-- any load to it returns 0.
entity dummy_read_only_memory_subsystem is
  generic(num_loads             : natural := 5;
          addr_width            : natural := 9;
          data_width            : natural := 5;
          tag_width             : natural := 7);
  port(
    ------------------------------------------------------------------------------
    -- load request ports
    ------------------------------------------------------------------------------
    lr_addr_in : in std_logic_vector((num_loads*addr_width)-1 downto 0);

    -- req/ack pair:
    -- when both are asserted, time-stamp is set on load request.
    lr_req_in  : in  std_logic_vector(num_loads-1 downto 0);
    lr_ack_out : out std_logic_vector(num_loads-1 downto 0);

    -- tag for request, will be returned on completion.
    lr_tag_in : in std_logic_vector((num_loads*tag_width)-1 downto 0);

    ---------------------------------------------------------------------------
    -- load complete ports
    ---------------------------------------------------------------------------
    lc_data_out : out std_logic_vector((num_loads*data_width)-1 downto 0);

    -- req/ack pair:
    -- when both are asserted, user should latch data_out.
    lc_req_in  : in  std_logic_vector(num_loads-1 downto 0);
    lc_ack_out : out std_logic_vector(num_loads-1 downto 0);

    -- tag of completed request.
    lc_tag_out : out std_logic_vector((num_loads*tag_width)-1 downto 0);

    ------------------------------------------------------------------------------
    -- clock, reset
    ------------------------------------------------------------------------------
    clock : in std_logic;  -- only rising edge is used to trigger activity.
    reset : in std_logic               -- active high.
    );
end entity dummy_read_only_memory_subsystem;


architecture Default of dummy_read_only_memory_subsystem is
begin

     lc_data_out <= (others => '0');
     lc_ack_out <= (others => '1');

     -- ack after one tick..
     process(clock)
     begin
	if(clock'event and clock = '1') then
		if(reset = '1') then
			lr_ack_out <= (others => '0');
		else
			for I in 0 to num_loads-1 loop
				if(lr_req_in(I) = '1') then
					lc_tag_out(((I+1)*tag_width)-1 downto I*tag_width) 
						<= 
						lr_tag_in(((I+1)*tag_width)-1 downto I*tag_width);
					lr_ack_out(I) <= '1';
				else
					lr_ack_out(I) <= '0';
				end if;
			end loop;
		end if;
	end if;
     end process;

end Default;

