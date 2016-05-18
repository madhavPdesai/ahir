library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


library ahir;
use ahir.BaseComponents.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

entity genericCamBase is
	generic (index_width: integer; tag_width: integer; data_width: integer);
	port (clk, reset: in std_logic;
		tag_in: in std_logic_vector(tag_width-1 downto 0);
		  data_in: in std_logic_vector(data_width-1 downto 0);
		    data_out: out std_logic_vector(data_width-1 downto 0);
		       index_in: in std_logic_vector(index_width-1 downto 0);
			   clear_flag, insert_flag, lookup_flag : in std_logic;
			      hit_flag: out std_logic;
				  enable_in : in std_logic);
end entity;

architecture Behave of genericCamBase is
	signal valid_entry: std_logic_vector(0 to (2**index_width)-1);
	signal hit_vector: std_logic_vector(0 to (2**index_width)-1);

	type TagArray is array (natural range <>) of std_logic_vector(tag_width-1 downto 0);
	type DataArray is array (natural range <>) of std_logic_vector(tag_width-1 downto 0);

	signal tag_array: TagArray(0 to max_number_of_entries-1);
	signal data_array: DataArray(0 to max_number_of_entries-1);

	signal there_was_a_hit: std_logic;
begin
	process(clk, cam_state, hit_vector,  enable_in)
		variable hit_flag_var : std_logic;	
		variable index_out_var: std_logic_vector(index_width-1 downto 0);
		variable data_out_var : std_logic_vector(data_width-1 downto 0);
		variable number_of_valid_entries_var : integer range 0 to ((2**index_width)-1);
		variable hit_index_var: integer range 0 to ((2**index_width)-1);
	begin
		hit_flag_var := '0';
		index_out_var := (others => '0');
		data_out_var := (others => '0');
		number_of_valid_entries_var := number_of_valid_entries_int;
		hit_index := 0;
		
		if(clk'event and clk = '1') then

		
		    if(enable_in = '1') then
			if((reset_flag = '1') or (clear_flag = '1')) then
				valid_entry <= (others => '0');
				hit_flag <= '0';
			elsif (insert_flag = '1') then
				hit_index := to_integer(to_integer(to_unsigned(index_in));
				tag_array(hit_index) <= tag_in;
				data_array(hit_index) <= data_in;
				valid_entry(I) <= '1';
				hit_flag <= '1';
			elsif (lookup_flag = '1') then
				hit_flag <= '0';
				-- this is ugly logic.
				for I in 0 to (2**index_width)-1 loop
				    if((tag_in = tag_array(I)) and (valid_entry(I) = '1')) then
					data_out <= data_array(I);
					hit_flag <= '1';
					exit;
				    end if;
				end loop;
			end if;
		    end if;
		end if;
	end process;
end Behave;
