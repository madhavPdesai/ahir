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
-------------------------------------------------------------------------------
-- a basic unsigned shifter.
--
-- for the moment, this just does a shift and adds delay stages at
-- the end; presumably, the synthesis tool will retime things
-- appropriately..
--
-- TODO: pipeline this explicitly!
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.GlobalConstants.all;
use ahir.Utilities.all;
use ahir.SubPrograms.all;

entity UnsignedShifter_n_n_n is
  generic (
    name: string;
    tag_width          : integer;
    operand_width      : integer;
    shift_amount_width : integer);

  port (
    slv_L       : in  std_logic_vector(operand_width-1 downto 0);
    slv_R       : in  std_logic_vector(shift_amount_width-1 downto 0);
    slv_RESULT  : out std_logic_vector(operand_width-1 downto 0);
    clk, reset  : in  std_logic;
    in_rdy      : in  std_logic;
    out_rdy     : out std_logic;
    shift_right_flag : in std_logic;
    signed_flag : in std_logic;
    stall       : in std_logic;
    tag_in      : in std_logic_vector(tag_width-1 downto 0);
    tag_out     : out std_logic_vector(tag_width-1 downto 0));

end entity;


architecture Pipelined of UnsignedShifter_n_n_n is

  -- depth of multiplexor..
  constant phases_per_stage: integer := 8;

  constant num_sig_bits: integer := Maximum(1,Minimum(shift_amount_width, Ceil_Log2(operand_width)));
  constant pipe_depth : integer := Ceil(num_sig_bits,phases_per_stage);

  type RWORD is array (natural range <>) of std_logic_vector(operand_width-1 downto 0);
  type TWORD is array (natural range <>) of std_logic_vector(tag_width-1 downto 0);  

  type SWORD is array (natural range <>) of unsigned(num_sig_bits-1 downto 0);  

  signal intermediate_results : RWORD(0 to pipe_depth);
  signal intermediate_tags : TWORD(0 to pipe_depth);  
  signal intermediate_shift_amount : SWORD(0 to pipe_depth);  
  signal stage_active : std_logic_vector(0 to pipe_depth);

  
  constant debug_flag: boolean := global_debug_flag;

  function shift_right_signed ( X: std_logic_vector; Y: integer )
		return std_logic_vector is
	variable ret_val: std_logic_vector(1 to X'length);
  begin
	ret_val := To_SLV( shift_right(To_Signed(X),Y));
	return(ret_val);
  end shift_right_signed;

  function shift_right_unsigned ( X: std_logic_vector; Y: integer )
		return std_logic_vector is
	variable ret_val: std_logic_vector(1 to X'length);
  begin
	ret_val := To_SLV(shift_right(To_Unsigned(X),Y));
	return(ret_val);
  end shift_right_unsigned;

  constant ZZZ: std_logic_vector(operand_width-1 downto 0) := (others => '0');

begin  -- Pipelined


   
  TrivOp: if operand_width = 1 generate
	intermediate_results(0) <= (others => '0') when (slv_R /= ZZZ) else slv_L;
  end generate TrivOp;
  

  NonTrivOp: if operand_width > 1 generate

        genStages: for STAGE in 1 to pipe_depth generate
  		process(clk, reset, signed_flag, intermediate_results, intermediate_shift_amount, shift_right_flag)
			variable shifted_L: std_logic_vector(operand_width-1 downto 0);
			variable shift_amount: unsigned(num_sig_bits-1 downto 0);
  		begin
			shifted_L := intermediate_results(STAGE-1);
			shift_amount := intermediate_shift_amount(STAGE-1);

			for I in ((STAGE-1)*phases_per_stage) to 
					Minimum(num_sig_bits-1,(STAGE*phases_per_stage)-1) loop  
				if(shift_amount(I) = '1') then
					if(shift_right_flag = '1') then
						if(signed_flag = '1') then
							shifted_L := shift_right_signed(shifted_L, 2**I);
						else 
							shifted_L := shift_right_unsigned(shifted_L, 2**I);
						end if;
					else
						shifted_L :=  To_SLV(shift_left(To_Unsigned(shifted_L),2**I));
					end if;
				end if;
			end loop;

			if(clk'event and clk='1') then

                                if(reset = '1') then
					stage_active(STAGE) <=  '0';
				elsif stall = '0' then
					stage_active(STAGE) <= stage_active(STAGE-1);
  					intermediate_results(STAGE) <= shifted_L;
  					intermediate_tags(STAGE) <= intermediate_tags(STAGE-1);
					intermediate_shift_amount(STAGE) <= 
							intermediate_shift_amount(STAGE-1);
				end if;
			end if;
  		end process;
	end generate genStages;

  end generate NonTrivOp;


  -- I/O
  intermediate_results(0) <=  slv_L;
  intermediate_tags(0) <= tag_in;
  intermediate_shift_amount(0) <= To_Unsigned(slv_R(num_sig_bits-1 downto 0));
  stage_active(0) <= in_rdy;
  out_rdy <= stage_active(pipe_depth);
  tag_out <= intermediate_tags(pipe_depth);
  slv_RESULT <= intermediate_results(pipe_depth);
  
end Pipelined;
