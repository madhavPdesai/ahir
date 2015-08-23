library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Components.all;
use ahir.BaseComponents.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

--
-- optimized for single-reader case.
--    sample_req->sample_ack is 0-delay.
--    update_req->update_ack has unit delay.
--    update_req->oreq has 0 delay.
--    oack -> update_ack has unit delay.
--
-- Assumptions
--    successive update-reqs will be separated
--    by update-acks.
--    
-- oack comes from a pipe with "Moore" outputs.
-- oreq paths into pipe are broken by FFs.
--
entity InputPortSingleReader is
  generic (name : string;
	   data_width: integer);
  port (
    -- pulse interface with the data-path
    sample_req        : in  boolean;
    sample_ack        : out boolean;
    update_req        : in  boolean;
    update_ack        : out boolean;
    data              : out std_logic_vector((data_width-1) downto 0);
    -- ready/ready interface with outside world
    oreq       : out std_logic;
    oack       : in  std_logic;
    odata      : in  std_logic_vector((data_width-1) downto 0);
    clk, reset : in  std_logic);
end entity;


architecture Base of InputPortSingleReader is

  signal data_register: std_logic_vector((data_width-1) downto 0);
  type FsmState is (Idle, WaitingForOack);

  signal fsm_state : FsmState;

begin

  -- sample req is always responded to..
  sample_ack <= sample_req;

  -- state machine.
  process(clk, reset, update_ack,  oack, odata)
	variable next_fsm_state: FsmState;
	variable oreqv : std_logic;
	variable update_ack_v: boolean;
  begin
	next_fsm_state := fsm_state;
	oreqv := '0';
	update_ack_v := false;
	
	case fsm_state is 
		when Idle =>
			if(update_req) then
				oreqv := '1';
			 	if  (oack = '1')) then
					update_ack_v := true;
				else 
					next_fsm_state := WaitingForOack;
				end if;
			end if;
		when WaitingForOack =>
			oreqv := '1';
			if(oack = '1') then
				update_ack_v := true;
				next_fsm_state := Idle;
			end if;
	end case;

	oreq <= oreqv;
	
	if(clk'event and clk = '1') then
		if(reset = '1') then
			fsm_state <= Idle;
			update_ack <= false;
		else
			fsm_state <= next_fsm_state;
			update_ack <= update_ack_v;
		end if;

		if(update_ack_v) then
			data_register <= odata;
		end if;
	end if;
  end process;

  data <= data_register;

end Base;
