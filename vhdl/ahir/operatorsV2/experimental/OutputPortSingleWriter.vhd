library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

--
--
-- assumption: data is maintained valid between sample-req and sample-ack.
--
entity OutputPortSingleWriter is
  generic(name : string;
	  data_width: integer);
  port (
    sample_req        : in  BooleanArray(0 downto 0);
    sample_ack        : out BooleanArray(0 downto 0);
    update_req        : in  BooleanArray(0 downto 0); -- sacrificial
    update_ack        : out BooleanArray(0 downto 0); -- sacrificial
    data       : in  std_logic_vector((data_width-1) downto 0);
    oreq       : out std_logic;
    oack       : in  std_logic;
    odata      : out std_logic_vector((data_width-1) downto 0);
    clk, reset : in  std_logic);
end entity;

architecture Base of OutputPortSingleWriter is
  type   FsmState is (Idle, Waiting);
  signal fsm_state : FsmState;
begin

  update_ack <= update_req; -- sacrificial, pretend to have split protocol.

  process(clk, reset, oack, sample_req)
	variable next_fsm_state : FsmState;
	variable oreqv : std_logic;
	variable sample_ackv : boolean;

  begin
	next_fsm_state := fsm_state;
	oreqv := '0';
	sample_ackv := false;

	case fsm_state is
		when Idle =>
			if(sample_req(0)) then
				oreqv := '1';
				if(oack = '1') then
					sample_ackv := true;
				else
					next_fsm_state := Waiting;
				end if;
			end if;
		when Waiting =>
			oreqv := '1';
			if(oack = '1') then
				sample_ackv := true;
			end if;
	end case;

	oreq <= oreqv;
	sample_ack(0) <= sample_ackv;

	if(clk'event and clk = '1') then
		if(reset = '1') then
			fsm_state <= Idle;
		else
			fsm_state <= next_fsm_state;
		end if;
	end if;
  end process; 

  odata <= data;
end Base;
