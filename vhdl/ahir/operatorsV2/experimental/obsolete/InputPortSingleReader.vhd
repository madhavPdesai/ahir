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
    sample_req        : in  BooleanArray(0 downto 0); -- sacrificial.
    sample_ack        : out BooleanArray(0 downto 0); -- sacrificial.
    update_req        : in  BooleanArray(0 downto 0);
    update_ack        : out BooleanArray(0 downto 0);
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

  sample_ack(0) <= sample_req(0); -- sacrificial, pretend to have split protocol.

  -- state machine.
  process(clk, reset, update_req,  oack, odata)
	variable next_fsm_state: FsmState;
	variable oreqv : std_logic;
	variable update_ack_v: boolean;
  begin
	next_fsm_state := fsm_state;
	oreqv := '0';
	update_ack_v := false;
	
	case fsm_state is 
		when Idle =>
			if(update_req(0)) then
				oreqv := '1';
			 	if  (oack = '1') then
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
			update_ack(0) <= false;
		else
			fsm_state <= next_fsm_state;
			update_ack(0) <= update_ack_v;
		end if;

		if(update_ack_v) then
			data_register <= odata;
		end if;
	end if;
  end process;

  data <= data_register;

end Base;
