library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity UnloadBuffer is
  generic (name: string; buffer_size: integer := 2; data_width : integer := 32; 
			bypass_flag : boolean := false; 
			nonblocking_read_flag : boolean := false;
			full_rate: boolean);
  port ( write_req: in std_logic;
        write_ack: out std_logic;
        write_data: in std_logic_vector(data_width-1 downto 0);
        unload_req: in boolean;
        unload_ack: out boolean;
        read_data: out std_logic_vector(data_width-1 downto 0);
        clk : in std_logic;
        reset: in std_logic);
end UnloadBuffer;

architecture default_arch of UnloadBuffer is

  signal pop_req, pop_ack, push_req, push_ack: std_logic_vector(0 downto 0);
  signal pipe_data_out:  std_logic_vector(data_width-1 downto 0);

  signal output_register : std_logic_vector(data_width-1 downto 0);

  signal unload_req_reg, unload_req_token, unload_req_clear  : boolean;
  signal unload_ack_sig : boolean;

  type UnloadFsmState is (idle, waiting);
  signal fsm_state : UnloadFsmState;

  signal load_reg: boolean;

  signal unload_ack_no_byp, unload_ack_byp : boolean;
  
begin  -- default_arch

  assert (buffer_size > 0) report "Unload buffer size must be > 0" & ": buffer = " & name  severity error;
  
  -- the input pipe.
  blocking_read: if (not nonblocking_read_flag) generate
    bufPipe : PipeBase generic map (
        name =>  name & " fifo ",
        num_reads  => 1,
        num_writes => 1,
        data_width => data_width,
        lifo_mode  => false,
        depth      => buffer_size,
	full_rate  => full_rate)
      port map (
        read_req   => pop_req,
        read_ack   => pop_ack,
        read_data  => pipe_data_out,
        write_req  => push_req,
        write_ack  => push_ack,
        write_data => write_data,
        clk        => clk,
        reset      => reset);
    push_req(0) <= write_req;
    write_ack <= push_ack(0);
  end generate blocking_read;

  nonblocking_read: if (nonblocking_read_flag) generate
    bufPipe : NonBlockingReadPipeBase generic map (
        name =>  name & " non-blocking-read-fifo ",
        num_reads  => 1,
        num_writes => 1,
        data_width => data_width,
        lifo_mode  => false,
        depth      => buffer_size,
        full_rate  => full_rate)
      port map (
        read_req   => pop_req,
        read_ack   => pop_ack,
        read_data  => pipe_data_out,
        write_req  => push_req,
        write_ack  => push_ack,
        write_data => write_data,
        clk        => clk,
        reset      => reset);
    push_req(0) <= write_req;
    write_ack <= push_ack(0);
  end generate nonblocking_read;


  -- FSM
  process(clk,unload_req, pop_ack)
     variable nstate: UnloadFsmState;
     variable loadv : boolean;
     variable bypassv : boolean;
     variable preq : std_logic;
  begin
     nstate :=  fsm_state;
     preq := '0';
     loadv := false;
     bypassv := false;
  
     case fsm_state is
         when idle => 
               if(unload_req) then
                 preq := '1';   
                 if (pop_ack(0) = '1') then
		    -- load output register.
		    loadv := true;
                 else
		    -- desire to unload, but nothing present.
                    nstate := waiting;
                 end if;
               end if;
	 when waiting =>
		preq := '1';
	        if(pop_ack(0) = '1') then
		    -- ack the unload-req.
		    loadv := true;
		    bypassv := bypass_flag;
		    -- if a new unload req arrives
		    -- stay in idle.
		    if(not unload_req) then	
		    	nstate := idle;
		    end if;
		end if;
     end case;
 
     pop_req(0) <= preq;
     load_reg <= loadv;
     unload_ack_byp <= bypassv;

     if(clk'event and clk = '1') then
	if(reset = '1') then
		fsm_state <= idle;
		unload_ack_no_byp <= false;
	else
		fsm_state <= nstate;
		unload_ack_no_byp <= (loadv and (not bypassv));
	end if;

	if(loadv) then
           output_register <= pipe_data_out;
        end if;
     end if;
  end process;

  -- without bypass
  bypassGen: if bypass_flag generate
  	read_data <= pipe_data_out when unload_ack_byp else output_register;
	unload_ack <= unload_ack_byp or unload_ack_no_byp;
  end generate bypassGen;

  -- with bypass.
  nobypassGen: if not bypass_flag generate
	read_data <= output_register;
	unload_ack <= unload_ack_no_byp;
  end generate nobypassGen;

end default_arch;
