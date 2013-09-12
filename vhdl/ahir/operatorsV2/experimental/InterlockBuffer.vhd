library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity InterlockBuffer is
  generic (name: string; buffer_size: integer := 2; 
		in_data_width : integer := 32;
		out_data_width : integer := 32);
  port (write_req: in boolean;
        write_ack: out boolean;
        write_data: in std_logic_vector(in_data_width-1 downto 0);
        read_req: in boolean;
        read_ack: out boolean;
        read_data: out std_logic_vector(out_data_width-1 downto 0);
        clk : in std_logic;
        reset: in std_logic);
end InterlockBuffer;

architecture default_arch of InterlockBuffer is

  constant data_width: integer := Minimum(in_data_width,out_data_width);

  signal buf_write_req, buf_write_ack: std_logic;
  signal buf_write_data, buf_read_data:  std_logic_vector(data_width-1 downto 0);

  type LoadFsmState is (l_idle, l_busy);
  signal l_fsm_state : LoadFsmState;
  
begin  -- default_arch

  -- interlock buffer must have buffer-size > 0
  assert buffer_size > 0 report " interlock buffer size must be > 0 " severity failure;

  bufEqOne: if buffer_size = 1 generate
	regBlock: block
  		signal req, ack: boolean;
	begin
		reg: RegisterBase 
			generic map (in_data_width => in_data_width,
					out_data_width => out_data_width)
			port map(din => write_data, dout => read_data, req => req,
					ack => ack, clk => clk, reset => reset);

		jReq: join2 generic map (bypass => true, name => name & ":join2")
				port map (pred0 => write_req,
						pred1 => read_req,
						symbol_out => req,
						clk => clk, reset => reset);

		write_ack <= ack;
		read_ack  <= ack;
	end block;
  end generate bufEqOne;

  bufGtOne: if buffer_size > 1 generate 
    inSmaller: if in_data_width <= out_data_width generate
	buf_write_data <= write_data;

	process(buf_read_data)
	begin
  		read_data <= (others => '0');
  		read_data(data_width-1 downto 0)  <= buf_read_data;
	end process;
     end generate inSmaller;

     outSmaller: if out_data_width < in_data_width generate
	buf_write_data <= write_data(data_width-1 downto 0);
  	read_data  <= buf_read_data;
     end generate outSmaller;
  end generate bufGtOne;

  -- write FSM to pipe.
  process(clk,reset, l_fsm_state, buf_write_ack, write_req)
	variable nstate : LoadFsmState;
  begin
	nstate := l_fsm_state;
	buf_write_req <= '0';
        write_ack <= false;
	if(l_fsm_state = l_idle) then
		if(write_req) then
			buf_write_req <= '1';
			if(buf_write_ack = '1') then
				write_ack <= true;
			else
				nstate := l_busy;
			end if;
		end if;
	else
		buf_write_req <= '1';
		if(buf_write_ack = '1') then
			nstate := l_idle;
			write_ack <= true;
		end if;
	end if;

	if(clk'event and clk = '1') then
		if(reset = '1') then
			l_fsm_state <= l_idle;
		else
			l_fsm_state <= nstate;
		end if;
	end if;
  end process;

  -- the unload buffer.
  buf : UnloadBuffer generic map (
    name =>  name & " buffer ",
    data_width => data_width,
    buffer_size => buffer_size)
    port map (
      write_req   => buf_write_req,
      write_ack   => buf_write_ack,
      write_data  => buf_write_data,
      unload_req  => read_req,
      unload_ack  => read_ack,
      read_data   => buf_read_data,
      clk         => clk,
      reset       => reset);


end default_arch;
