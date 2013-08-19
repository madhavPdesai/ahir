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
  port ( write_req: in boolean;
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

  signal pop_req, pop_ack, push_req, push_ack: std_logic_vector(0 downto 0);
  signal pipe_data_out, pipe_data_in:  std_logic_vector(data_width-1 downto 0);

  signal output_register : std_logic_vector(data_width-1 downto 0);

  type LoadFsmState is (l_idle, l_busy);
  signal l_fsm_state : LoadFsmState;

  type UnloadFsmState is (idle, waiting);
  signal fsm_state : UnloadFsmState;
  
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

		jReq: join2 generic map (bypass => true)
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
	pipe_data_in <= write_data;

	process(output_register)
	begin
  		read_data <= (others => '0');
  		read_data(data_width-1 downto 0)  <= output_register;
	end process;
  end generate inSmaller;

  outSmaller: if out_data_width < in_data_width generate
	pipe_data_in <= write_data(data_width-1 downto 0);
  	read_data  <= output_register;
  end generate outSmaller;

  -- write FSM to pipe.
  process(clk,reset, l_fsm_state, push_ack(0), write_req)
	variable nstate : LoadFsmState;
  begin
	nstate := l_fsm_state;
	push_req(0) <= '0';
        write_ack <= false;
	if(l_fsm_state = l_idle) then
		if(write_req) then
			push_req(0) <= '1';
			if(push_ack(0) = '1') then
				write_ack <= true;
			else
				nstate := l_busy;
			end if;
		end if;
	else
		push_req(0) <= '1';
		if(push_ack(0) = '1') then
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

  -- the input pipe.
  bufPipe : PipeBase generic map (
    name =>  name & " fifo ",
    num_reads  => 1,
    num_writes => 1,
    data_width => data_width,
    lifo_mode  => false,
    depth      => buffer_size)
    port map (
      read_req   => pop_req,
      read_ack   => pop_ack,
      read_data  => pipe_data_out,
      write_req  => push_req,
      write_ack  => push_ack,
      write_data => pipe_data_in,
      clk        => clk,
      reset      => reset);


  -- FSM for unloading data..
  process(clk,fsm_state,read_req,pop_ack,reset)
     variable nstate: UnloadFsmState;
     variable ackv: boolean;
     variable preq : std_logic;
  begin
     nstate :=  fsm_state;
     preq := '0';
     ackv := false;
  
     case fsm_state is
         when idle => 
               if(read_req and (pop_ack(0) = '1')) then
		    preq := '1';   
		    ackv := true;
               elsif (read_req) then
                    nstate := waiting;
               end if;
	 when waiting =>
		preq := '1';
	        if(pop_ack(0) = '1') then
		    nstate := idle;
		    ackv := true;
		end if;
     end case;
 
     pop_req(0) <= preq;

     if(clk'event and clk = '1') then
	if(reset = '1') then
		fsm_state <= idle;
     		read_ack <= false;
	else
		fsm_state <= nstate;
     		read_ack <= ackv;
	end if;

	if(ackv) then
           output_register <= pipe_data_out;
        end if;
     end if;
  end process;
  end generate bufGtOne;


end default_arch;
