------------------------------------------------------------------------------------------------
--
-- Copyright (C) 2010-: Madhav P. Desai
-- All Rights Reserved.
--  
-- Permission is hereby granted, free of charge, to any person obtaining a
-- copy of this software and associated documentation files (the
-- "Software"), to deal with the Software without restriction, including
-- without limitation the rights to use, copy, modify, merge, publish,
-- distribute, sublicense, and/or sell copies of the Software, and to
-- permit persons to whom the Software is furnished to do so, subject to
-- the following conditions:
-- 
--  * Redistributions of source code must retain the above copyright
--    notice, this list of conditions and the following disclaimers.
--  * Redistributions in binary form must reproduce the above
--    copyright notice, this list of conditions and the following
--    disclaimers in the documentation and/or other materials provided
--    with the distribution.
--  * Neither the names of the AHIR Team, the Indian Institute of
--    Technology Bombay, nor the names of its contributors may be used
--    to endorse or promote products derived from this Software
--    without specific prior written permission.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
-- OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
-- IN NO EVENT SHALL THE CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR
-- ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
-- TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
-- SOFTWARE OR THE USE OR OTHER DEALINGS WITH THE SOFTWARE.
------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity SplitCallArbiterNoOutArgs is
  generic(name: string;
	  num_reqs: integer;
	  call_data_width: integer;
	  caller_tag_length: integer;
          callee_tag_length: integer);
  port ( -- ready/ready handshake on all ports
    -- ports for the caller
    call_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
    call_acks   : out std_logic_vector(num_reqs-1 downto 0);
    call_data   : in  std_logic_vector((num_reqs*call_data_width)-1 downto 0);
    call_tag    : in  std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
    -- call port connected to the called module
    call_mreq   : out std_logic;
    call_mack   : in  std_logic;
    call_mdata  : out std_logic_vector(call_data_width-1 downto 0);
    call_mtag   : out std_logic_vector(callee_tag_length+caller_tag_length-1 downto 0);
    -- similarly for return, initiated by the caller
    return_reqs : in  std_logic_vector(num_reqs-1 downto 0);
    return_acks : out std_logic_vector(num_reqs-1 downto 0);
    return_tag  : out std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
    -- return from function
    return_mreq : out std_logic;
    return_mack : in std_logic;
    return_mtag : in  std_logic_vector(callee_tag_length+caller_tag_length-1 downto 0);
    clk: in std_logic;
    reset: in std_logic);
end SplitCallArbiterNoOutArgs;


architecture Struct of SplitCallArbiterNoOutArgs is
   signal pe_call_reqs: std_logic_vector(num_reqs-1 downto 0);
   signal return_acks_sig: std_logic_vector(num_reqs-1 downto 0);


   type TagwordArray is array (natural range <>) of std_logic_vector(caller_tag_length-1 downto 0);
   signal return_tag_sig : TagwordArray(num_reqs-1 downto 0);

   type CallStateType is (idle, busy);
   signal call_state: CallStateType;


   signal latch_call_data : std_logic;
   signal call_mdata_prereg  : std_logic_vector(call_data_width-1 downto 0);
   signal callee_mtag_prereg, callee_mtag_reg  : std_logic_vector(callee_tag_length-1 downto 0);
   signal caller_mtag_reg : std_logic_vector(caller_tag_length-1 downto 0);
   
   signal fair_call_reqs, fair_call_acks: std_logic_vector(num_reqs-1 downto 0);
   signal return_mreq_sig : std_logic_vector(num_reqs-1 downto 0); 
begin

  -----------------------------------------------------------------------------
  -- "fairify" the call-reqs.
  -----------------------------------------------------------------------------
  fairify: NobodyLeftBehind generic map (name=> name & "-fairify", num_reqs => num_reqs)
		port map (clk => clk, reset => reset, reqIn => call_reqs, ackOut => call_acks,
					reqOut => fair_call_reqs, ackIn => fair_call_acks);

  -----------------------------------------------------------------------------
  -- priority encode incoming
  -----------------------------------------------------------------------------
   pe_call_reqs <= PriorityEncode(fair_call_reqs);

   ----------------------------------------------------------------------------
   -- process to handle call_reqs  --> call_mreq muxing
   ----------------------------------------------------------------------------
   process(clk, pe_call_reqs, call_mack, call_state)
        variable nstate: CallStateType;
        variable there_is_a_call : std_logic;
   begin
	nstate := call_state;
        there_is_a_call := OrReduce(pe_call_reqs);
	latch_call_data <= '0';
	call_mreq <= '0';

	if(call_state = idle) then
		if(there_is_a_call = '1') then
			latch_call_data <=  '1';
			nstate := busy;
		end if;
	elsif (call_state = busy) then
		call_mreq <= '1';
		if(call_mack = '1') then
			nstate := idle;
		end if;
	end if;
	
	if(clk'event and clk = '1') then
		if(reset = '1') then
			call_state <= idle;
		else
			call_state <= nstate;
		end if;
	end if;
   end process;



   -- combinational process.. generate call_acks, and also
   -- mux to input of call data register.
   process(pe_call_reqs,latch_call_data, call_data)
	variable out_data : std_logic_vector(call_data_width-1 downto 0);
   begin
	fair_call_acks <= (others => '0');
        out_data := (others => '0');
       	for I in num_reqs-1 downto 0 loop
       		if(pe_call_reqs(I) = '1') then
			out_data := call_data(((I+1)*call_data_width)-1 downto I*call_data_width);
       			--Extract(call_data,I,out_data);
			if(latch_call_data = '1') then
				fair_call_acks(I) <= '1';
			end if;
       		end if;
	end loop;
	call_mdata_prereg <= out_data;
   end process;

   -- call data register.
   process(clk)
   begin
     if(clk'event and clk = '1') then
     	if(latch_call_data = '1') then
		call_mdata <= call_mdata_prereg;
		callee_mtag_reg <= callee_mtag_prereg;
        end if;  -- I
     end if;
   end process;
 
   -- tag generation.
   tagGen : BinaryEncoder generic map (name=> name & "-tagGen", iwidth => num_reqs,
                                       owidth => callee_tag_length)
     port map (din => pe_call_reqs, dout => callee_mtag_prereg);

   -- on a successful call, register the tag from the caller
   -- side..
   process(clk)
   begin
       if(clk'event and clk = '1') then
	for T in 0 to num_reqs-1 loop
         if(pe_call_reqs(T) = '1' and latch_call_data = '1') then
           caller_mtag_reg <= call_tag(((T+1)*caller_tag_length)-1 downto T*caller_tag_length);
         end if;
        end loop;
       end if;
   end process;     

   -- call tag.
   call_mtag <= callee_mtag_reg & caller_mtag_reg;

   ----------------------------------------------------------------------------
   -- reverse path
   ----------------------------------------------------------------------------
   process(return_tag_sig)
     variable lreturn_tag : std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
   begin
     for J in return_tag_sig'high(1) downto return_tag_sig'low(1) loop
       lreturn_tag(((J+1)*caller_tag_length)-1 downto J*caller_tag_length)
		:= return_tag_sig(J);
       -- Insert(lreturn_tag,J,return_tag_sig(J));
     end loop;  -- J
     return_tag <= lreturn_tag;
   end process;

   -- always ready to accept return data..
   -- (assumption... that call and return requests from the 
   --  the left will alternate).
   return_mreq <= OrReduce(return_mreq_sig);

   -- the acks in both directions
   return_acks <= return_acks_sig;
   
   -- incoming data written into appropriate register.
   RetGen: for I in return_reqs'high downto return_reqs'low generate

     fsm: block
       signal ack_reg, valid_flag : std_logic;
       signal tag_reg  : std_logic_vector(caller_tag_length-1 downto 0);
       signal return_state : CallStateType;
     begin  -- block fsm

       -- valid = '1' implies this index is incoming
       valid_flag <= '1' when return_mack = '1' and (I = To_Integer(To_Unsigned(return_mtag(callee_tag_length+caller_tag_length-1 downto caller_tag_length)))) else '0';

       --------------------------------------------------------------------------
       -- ack FSM
       --------------------------------------------------------------------------
       process(clk,return_state,return_reqs(I),valid_flag,reset)
	variable nstate: CallStateType;
	variable latch_var: std_logic;
       begin

	 nstate := return_state;
	 latch_var := '0';
	 return_acks_sig(I) <= '0';

	 if(return_state = Idle) then
		if(valid_flag = '1') then
			latch_var := '1';
			nstate := Busy;
		end if;		
	 else 
	 	return_acks_sig(I) <= '1';
		if((valid_flag = '1') and (return_reqs(I) = '1')) then
			latch_var := '1';
		elsif (return_reqs(I) = '1') then
			nstate := Idle;
		end if;
	 end if;

	 return_mreq_sig(I) <= latch_var;

         if clk'event and clk= '1' then
           if(reset = '1') then
             return_state <= Idle;
	   else 
	     return_state <= nstate;
	     if (latch_var = '1') then
             	tag_reg  <= return_mtag(caller_tag_length-1 downto 0);
	     end if;
           end if;
         end if;
       end process;

       -- pass info out of the generate
       return_tag_sig(I) <= tag_reg;
     end block fsm;

   end generate RetGen;

end Struct;
