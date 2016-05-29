-- TODO: add bypass path to the receive buffer.
--       this will reduce buffering requirements
--       by a factor of two (for full pipelining).
--
library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity ReceiveBuffer  is
  generic (name: string; buffer_size: integer ; data_width : integer ; full_rate: boolean);
  port ( write_req: in boolean;
         write_ack: out boolean;
         write_data: in std_logic_vector(data_width-1 downto 0);
         read_req: in std_logic;
         read_ack: out std_logic;
         read_data: out std_logic_vector(data_width-1 downto 0);
         clk : in std_logic;
         reset: in std_logic);
end ReceiveBuffer;

architecture default_arch of ReceiveBuffer is

  signal push_req, push_ack, pop_req, pop_ack: std_logic_vector(0 downto 0);
  signal pipe_data_in:  std_logic_vector(data_width-1 downto 0);



  type RxBufFsmState is (idle, busy);
  signal fsm_state : RxBufFsmState;



begin  -- default_arch

  -- the output pipe.
  bufPipe : PipeBase generic map (
    name =>  name & "-bufPipe",
    num_reads  => 1,
    num_writes => 1,
    data_width => data_width,
    lifo_mode  => false,
    depth      => buffer_size,
    full_rate  => full_rate)
    port map (
      read_req   => pop_req,
      read_ack   => pop_ack,
      read_data  => read_data,
      write_req  => push_req,
      write_ack  => push_ack,
      write_data => write_data,
      clk        => clk,
      reset      => reset);
  read_ack <= pop_ack(0);
  pop_req(0) <= read_req;


  -- FSM
  process(clk,reset, write_req, push_ack)
	variable nstate : RxBufFsmState;
	variable pushreqv: std_logic;
	variable decr: boolean;
	variable wackv : boolean;
  begin
	wackv := false;
	pushreqv := '0'; 

	nstate := fsm_state;
	case fsm_state is
		when idle => 
			if(write_req) then
				pushreqv := '1';
				if(push_ack(0) = '1') then 
					wackv := true;
				else
					nstate := busy;	
				end if;
			end if;
		when busy => 
			pushreqv := '1';
			if (push_ack(0) = '1') then
				nstate := idle;
				wackv := true;
			end if;
	end case;

	push_req(0) <= pushreqv;
	write_ack <= wackv;

	if(clk'event and clk = '1') then
		if(reset = '1') then
			fsm_state <= idle;
		else
			fsm_state <= nstate;
		end if;
	end if;
		
  end process;
end default_arch;
