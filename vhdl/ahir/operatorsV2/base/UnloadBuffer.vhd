library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity UnloadBuffer is
  generic (name: string; buffer_size: integer := 2; data_width : integer := 32);
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
  
begin  -- default_arch

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
      write_data => write_data,
      clk        => clk,
      reset      => reset);
  push_req(0) <= write_req;
  write_ack <= push_ack(0);


  -- FSM
  process(clk,unload_req, pop_ack)
     variable nstate: UnloadFsmState;
     variable ackv: boolean;
     variable preq : std_logic;
  begin
     nstate :=  fsm_state;
     preq := '0';
     ackv := false;
  
     case fsm_state is
         when idle => 
               if(unload_req and (pop_ack(0) = '1')) then
		    preq := '1';   
		    ackv := true;
               elsif (unload_req) then
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
     load_reg <= ackv;

     if(clk'event and clk = '1') then
	if(reset = '1') then
		fsm_state <= idle;
	else
		fsm_state <= nstate;
	end if;

	if(ackv) then
           output_register <= pipe_data_out;
        end if;

	unload_ack <= ackv;
     end if;
  end process;

  -- no bypass!
  read_data <= output_register;

end default_arch;
