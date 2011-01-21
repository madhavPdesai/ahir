library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.LoadStorePack.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity StoreCompleteShared is
  generic (num_reqs: integer;
	   tag_length: integer);
  port (
    -- in requester array, pulse protocol
    -- more than one requester can be active
    -- at any time
    reqR : in BooleanArray(num_reqs-1 downto 0);
    -- out ack array, pulse protocol
    -- more than one ack can be sent back
    -- at any time.
    --
    -- Note: req -> ack delay can be 0
    ackR : out BooleanArray(num_reqs-1 downto 0);
    -- mreq goes out to memory as 
    -- a response to mack.
    mreq : out std_logic;
    mack : in  std_logic;
    -- mtag to distinguish the 
    -- requesters.
    mtag : in std_logic_vector(tag_length-1 downto 0);
    -- rising edge of clock is used
    clk : in std_logic;
    -- synchronous reset, active high
    reset : in std_logic);
end StoreCompleteShared;

architecture Behave of StoreCompleteShared is
  signal full_flag, wait_flag : std_logic_vector(num_reqs-1 downto 0);
  signal ackR_sig: BooleanArray(num_reqs-1 downto 0);
  signal mreq_sig : std_logic_vector(num_reqs-1 downto 0);
  
begin  -- Behave

  assert ackR'length = reqR'length report "mismatched req/ack vectors" severity error;


  
  AckBits: for I in 0 to num_reqs-1 generate
   
	-- reqR/ackR state machine.
	-- when full_flag is reset, assert reqR if tag matches.
	-- if ackR is received, set full_flag.
	-- clear full flag only when ackR is observed.
	process(clk, reset, full_flag(I), ackR_sig(I), mack, mtag)
		variable next_flag : std_logic;
		variable rR: std_logic;
 		variable valid: boolean;
	begin
		next_flag := full_flag(I); rR := '0';
		valid := (mtag = To_SLV(To_Unsigned(I, tag_length)));

		if(reset = '1') then
			next_flag := '0';
		else if(full_flag(I) = '0') then
			if(v) then
				rR := '1';
				if mack = '1' then
					next_flag := '1';
				end if;
			end if;
		else
			if ackR_sig(I) then
				next_flag := '0';
			end if;
		end if;

		mreq_sig(I) <= rR;
		if(clk'event and clk = '1') then
			full_flag(I) <= next_flag;
		end if;
	end process;


	-- reqR/ackR state machine.  If reqR pulse is received
	-- when full_flag is set, assert ackR pulse.
	-- otherwise, go to wait state until full_flag is set
	-- to assert ackR.
	process(clk, reset, wait_flag(I), reqR(I), full_flag(I))
		variable next_flag : std_logic;
		variable aL: boolean;
	begin
		next_flag := wait_flag(I); aL := false;
		if(reset = '1') then
			next_flag := '0';
		else 
			if(wait_flag(I) = '0') then
				if(reqR(I) and (full_flag(I) = '1')) then
					aL := true;
				end if;
				if(reqR(I) and (full_flag(I) = '0')) then
					next_flag := '1';
				end if;
			else
				if(full_flag(I) = '1') then
					aL := true;
					next_flag := '0';
				end if;
			end if;
		end if;

		ackR_sig(I) <= aL;
		if(clk'event and clk = '1') then
			wait_flag(I) <= next_flag;
		end if;
	end process;

  end generate AckBits;

  mreq <= OrReduce(mreq_sig);
  ackR <= ackR_sig;

end Behave;
