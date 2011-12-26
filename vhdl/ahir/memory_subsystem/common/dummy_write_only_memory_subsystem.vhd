library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.mem_function_pack.all;
use ahir.merge_functions.all;
use ahir.mem_component_pack.all;

-- a dummy write-only memory (perfectly useless,
-- but plug-in for corner cases).
entity dummy_write_only_memory_subsystem is
  generic( num_stores            : natural := 10;
          addr_width            : natural := 9;
          data_width            : natural := 5;
          tag_width             : natural := 7);
  port(
    ------------------------------------------------------------------------------
    -- store request ports
    ------------------------------------------------------------------------------
    sr_addr_in : in std_logic_vector((num_stores*addr_width)-1 downto 0);
    sr_data_in : in std_logic_vector((num_stores*data_width)-1 downto 0);

    -- req/ack pair:
    -- when both are asserted, time-stamp is set on store request.
    sr_req_in  : in  std_logic_vector(num_stores-1 downto 0);
    sr_ack_out : out std_logic_vector(num_stores-1 downto 0);

    -- tag for request, will be returned on completion.
    sr_tag_in : in std_logic_vector((num_stores*tag_width)-1 downto 0);

    ---------------------------------------------------------------------------
    -- store complete ports
    ---------------------------------------------------------------------------
    -- req/ack pair:
    -- when both are asserted, user assumes that store is done.
    sc_req_in  : in  std_logic_vector(num_stores-1 downto 0);
    sc_ack_out : out std_logic_vector(num_stores-1 downto 0);

    -- tag of completed request.
    sc_tag_out : out std_logic_vector((num_stores*tag_width)-1 downto 0);

    ------------------------------------------------------------------------------
    -- clock, reset
    ------------------------------------------------------------------------------
    clock : in std_logic;  -- only rising edge is used to trigger activity.
    reset : in std_logic               -- active high.
    );
end entity dummy_write_only_memory_subsystem;


-- architecture: synchronous R/W.
--               on destination conflict, writer with lowest index wins.
architecture Default of dummy_write_only_memory_subsystem is
begin

     -- you are always done..
     sc_ack_out <= (others => '1');

     -- ack after one tick..
     process(clock)
     begin
	if(clock'event and clock = '1') then
		if(reset = '1') then
			sr_ack_out <= (others => '0');
		else
			for I in 0 to num_stores-1 loop
				if(sr_req_in(I) = '1') then
					sc_tag_out(((I+1)*tag_width)-1 downto I*tag_width) 
						<= 
						sr_tag_in(((I+1)*tag_width)-1 downto I*tag_width);
					sr_ack_out(I) <= '1';
				else
					sr_ack_out(I) <= '0';
				end if;
			end loop;
		end if;
	end if;
     end process;

end Default;

