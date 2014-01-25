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


     gen: for I in 0 to num_stores-1 generate
	sr_ack_out(I) <= sr_req_in(I);

	fsm: block
		signal busy : std_logic;
	begin
		sc_ack_out(I) <= busy;

		process(clock)
		begin
			if(clock'event and clock = '1') then
				if(reset = '1') then 
				elsif (sr_req_in(I) = '1') then
					busy <= '1';
					sc_tag_out <= sr_tag_in;
				elsif (sc_req_in(I) = '1') then
					busy <= '0';
				end if;
			end if;
		end process;
	end block;
     end generate gen;

end Default;

