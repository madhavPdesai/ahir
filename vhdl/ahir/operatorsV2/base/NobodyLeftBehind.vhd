library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;


-- make sure that there is no starvation..
--
-- latch the incoming requests (reqIn) and present them
-- to the downstream user (reqOut).  As ackIn is received,
-- clear reqOut.  The latching of reqIn to reqOut is done
-- only if reqOut is cleared.  There is a bypass path
-- from reqIn to reqOut if reqIn_register is 0..  This
-- prevents a useless latency.
entity NobodyLeftBehind is
  generic ( num_reqs : integer := 1);
  port (
    clk,reset : in std_logic;
    reqIn : in std_logic_vector(num_reqs-1 downto 0);
    ackOut: out std_logic_vector(num_reqs-1 downto 0);
    reqOut : out std_logic_vector(num_reqs-1 downto 0);
    ackIn : in std_logic_vector(num_reqs-1 downto 0));
end entity;


architecture Fair of NobodyLeftBehind is
  signal reqIn_register: std_logic_vector(num_reqs-1 downto 0);
  signal reqIn_reg_is_non_zero: std_logic;
begin  -- Behave


   -- if there is only one requester, there is really no point.
   Trivial: if num_reqs = 1 generate
     reqOut <= reqIn;
     ackOut <= ackIn;
   end generate Trivial;

   Nontrivial: if num_reqs > 1 generate

     reqIn_reg_is_non_zero <= OrReduce(reqIn_register);
     reqOut <= reqIn_register when reqIn_reg_is_non_zero = '1' else reqIn;
     
     process(clk)
	  variable next_reqIn_register : std_logic_vector(num_reqs-1 downto 0);
     begin
	  next_reqIn_register := reqIn_register;
  
          if(reqIn_reg_is_non_zero = '0') then
              -- if reqIn_register is 0, then reqIn will be 
	      -- immediately forwarded to reqOut..  An ackIn
              -- may immediately appear.. in which case reqIn_register
              -- will stay 0.
	      next_reqIn_register := reqIn and (not ackIn); -- reqIn and (reqIn xor ackIn);
          else
              -- reqOut must come from reqIn_register.. the next
              -- state will be determined by reqIn_register and ackIn
	      next_reqIn_register := reqIn_register and (not ackIn); -- reqIn_register and (reqIn_register xor ackIn);
          end if;
  
          if(clk'event and clk = '1') then
		  if(reset = '1') then
			  reqIn_register <= (others => '0');
		  else
			  reqIn_register <= next_reqIn_register;
		  end if;
	  end if;
	  
     end process;

     ackOut <= ackIn;
   
   end generate NonTrivial;

end Fair;
