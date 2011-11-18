library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.mem_function_pack.all;
use ahir.mem_component_pack.all;

entity memory_bank is
   generic (
     g_addr_width: natural;
     g_data_width: natural;
     g_write_tag_width : natural;
     g_read_tag_width : natural;
     g_time_stamp_width: natural;
     g_base_bank_addr_width: natural;
     g_base_bank_data_width: natural
	);
   port (
     clk : in std_logic;
     reset: in std_logic;
     write_data     : in  std_logic_vector(g_data_width-1 downto 0);
     write_addr     : in std_logic_vector(g_addr_width-1 downto 0);
     write_tag      : in std_logic_vector(g_write_tag_width-1 downto 0);
     write_tag_out  : out std_logic_vector(g_write_tag_width-1 downto 0);
     write_enable   : in std_logic;
     write_ack   : out std_logic;
     write_result_accept : in std_logic;
     write_result_ready : out std_logic;
     read_data     : out std_logic_vector(g_data_width-1 downto 0);
     read_addr     : in std_logic_vector(g_addr_width-1 downto 0);
     read_tag      : in std_logic_vector(g_read_tag_width-1 downto 0);
     read_tag_out  : out std_logic_vector(g_read_tag_width-1 downto 0);
     read_enable   : in std_logic;
     read_ack      : out std_logic;
     read_result_accept: in std_logic;
     read_result_ready: out std_logic
     );
end entity memory_bank;


architecture SimModel of memory_bank is

  signal write_done, read_done, write_has_priority: std_logic;
  signal write_address_sig, read_address_sig : natural range 0 to (2**g_addr_width)-1;
  signal state_sig: std_logic;
  signal enable_base,enable_sig, write_enable_base, read_enable_base: std_logic;

  signal addr_base : std_logic_vector(g_addr_width-1 downto 0);
  signal block_write_ack, block_read_ack: std_logic;
  
  
begin  -- behave

  Tstampgen: if g_time_stamp_width > 0 generate 
  
  tstamp_block: Block
  	signal read_time_stamp, write_time_stamp: std_logic_vector(g_time_stamp_width-1 downto 0);
  begin 
  	read_time_stamp <= read_tag(g_time_stamp_width-1 downto 0);
  	write_time_stamp <= write_tag(g_time_stamp_width-1 downto 0);

  	process(read_time_stamp,write_time_stamp, read_enable, write_enable)
  	begin
      	if(write_enable = '1' and read_enable = '1') then
		if(IsGreaterThan(read_time_stamp,write_time_stamp)) then
        		write_has_priority <=   '1';
		else
			write_has_priority <= '0';
		end if;
      	elsif(write_enable = '1') then
		write_has_priority <= '1';
      	elsif(read_enable = '1') then
		write_has_priority <= '0';
      	else
		write_has_priority <= '1';
      	end if;
  	end process;
   end block;
   end generate Tstampgen;

   NoTstampGen: if g_time_stamp_width <= 0 generate
        write_has_priority <= not read_enable;
   end generate NoTstampGen;


  -- basically, the enable/ack pair and the ready/accept pair
  -- have to be coordinated: in one complete cycle, the
  -- following sequence must be followed
  --  enable -> ready -> accept -> ack.
  process(reset,write_enable,write_has_priority,read_enable,clk, write_tag, read_tag)
  begin
    if clk'event and clk = '1' then

      -- one cycle delay through memory bank
      write_tag_out <= write_tag;
      read_tag_out  <= read_tag;
      
      if(reset = '1') then
        write_done <= '0';
        read_done <= '0';
      else
        if(write_enable = '1' and (write_has_priority = '1' or read_enable = '0')) then
          write_done <= '1';
        else
          write_done <= '0';
        end if; 
        if(read_enable = '1' and (write_has_priority = '0' or write_enable = '0')) then
          read_done <= '1';
        else
          read_done <= '0';
        end if;
      end if;
    end if;
  end process;

  -- ack when done 
  block_write_ack <= '1' when (write_done = '1' and write_result_accept = '0') else '0';
  write_ack <= '1' when (write_enable = '1' and (read_enable = '0' or write_has_priority = '1') and  block_write_ack = '0') else '0';
  write_result_ready <= write_done;
  
  -- ack to read only when result is also enabled
  block_read_ack <= '1' when (read_done = '1' and read_result_accept = '0') else '0';
  read_ack <= '1' when (read_enable = '1' and (write_enable = '0' or write_has_priority = '0') and  block_read_ack = '0') else '0';
  read_result_ready <= read_done;  


  process(write_enable, write_has_priority, block_write_ack)
  begin  -- process
      if(write_enable = '1' and write_has_priority = '1' and block_write_ack = '0') then
	write_enable_base <= '1';
      else
	write_enable_base <= '0';
      end if;
  end process;

  
  process(read_enable,  write_has_priority, block_read_ack)
  begin
    if(read_enable = '1' and write_has_priority = '0' and block_read_ack = '0') then
	read_enable_base <= '1';
    else
	read_enable_base <= '0';
    end if;
  end process;

  addr_base <= write_addr when write_enable_base = '1' else read_addr when read_enable_base = '1' else (others => '0');
  enable_sig <= write_enable_base or read_enable_base;
  
  memBase: memory_bank_base generic map(g_addr_width => g_addr_width,
                                        g_data_width => g_data_width,
					g_base_bank_addr_width => g_base_bank_addr_width,
					g_base_bank_data_width => g_base_bank_data_width)
    port map(data_in => write_data,
             addr_in => addr_base,
             data_out => read_data,
             enable => enable_sig,
             write_bar => read_enable_base,
             clk => clk,
             reset => reset);
  
end SimModel;

