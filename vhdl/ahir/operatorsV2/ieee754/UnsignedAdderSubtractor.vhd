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
-- a basic unsigned adder..  if addition is specified, just
-- adds using a simple carry lookahead scheme.  if subtraction
-- is specified, takes the twos complement of the second operand
-- and adds the two numbers.  No overflow/negative checks
-- are performed.
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Utilities.all;

entity AddSubCell  is
	generic ( operand_width: integer);
	port (A,B: in unsigned(operand_width-1 downto 0);
		Sum: out unsigned(operand_width-1 downto 0);
		BP,BG: out std_logic;
		stall: in std_logic;
		clk, reset: in std_logic);
end entity AddSubCell;

architecture Behave of AddSubCell is
begin
	process(clk, reset, A, B, stall)
		variable sumv: unsigned(operand_width-1 downto 0);
		variable prop, gen: std_logic;
	begin
		prop := '1';
		gen  := '0';

		sumv := A+B;

		for I in 0 to operand_width-1 loop
			prop := (prop and (A(I) or B(I)));
			gen  := (A(I) and B(I)) or (gen and (A(I) or B(I)));
		end loop;


		if(clk'event and clk = '1') then
		   if(stall = '0') then
			Sum <= sumv;
			BP <= prop;
			BG <= gen;
		   end if;
		end if;
	end process;
end Behave;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Utilities.all;
entity UnsignedAdderSubtractor is
  
  generic (
    name: string;
    tag_width          : integer;
    operand_width      : integer;
    chunk_width        : integer
	);

  port (
    L            : in  unsigned(operand_width-1 downto 0);
    R            : in  unsigned(operand_width-1 downto 0);
    RESULT       : out unsigned(operand_width-1 downto 0);
    subtract_op  : in std_logic;
    clk, reset   : in  std_logic;
    in_rdy       : in  std_logic;
    out_rdy      : out std_logic;
    stall        : in std_logic;
    tag_in       : in std_logic_vector(tag_width-1 downto 0);
    tag_out      : out std_logic_vector(tag_width-1 downto 0));
end entity;


architecture Pipelined of UnsignedAdderSubtractor is
 
  constant num_chunks: integer := Ceil(operand_width, chunk_width);
  constant padded_operand_width: integer := num_chunks  * chunk_width;
  signal Lpadded, Rpadded, Resultpadded : unsigned(padded_operand_width-1 downto 0);

  constant pipe_depth : integer := 3;
  signal stage_active : std_logic_vector(0 to pipe_depth);


  type CWORD is array (natural range <>) of unsigned(chunk_width-1 downto 0);
  type TWORD is array (natural range <>) of std_logic_vector(tag_width-1 downto 0);  
  signal stage_tags: TWORD(0 to pipe_depth);


  signal addsubcell_Sum, addsubcell_Sum_Delayed, 
			addsubcell_A, addsubcell_B, final_sums: CWord(0 to num_chunks-1);
  signal addsubcell_BP, addsubcell_BG : std_logic_vector(0 to num_chunks-1);
  signal addsubcell_Cin: std_logic_vector(0 to num_chunks);
  constant zero_Cin: std_logic_vector(0 to num_chunks) := (others => '0');


  signal block_carries: std_logic_vector(0 to num_chunks);
  signal subtract_op_1, subtract_op_2: std_logic;


  component AddSubCell  is
	generic ( operand_width: integer);
	port (A,B: in unsigned(operand_width-1 downto 0);
		Sum: out unsigned(operand_width-1 downto 0);
		BP,BG: out std_logic;
		stall: in std_logic;
		clk, reset: in std_logic);
  end component AddSubCell;
  
begin  -- Pipelined

  -- note: if subtract_op = '1', then complement R (see below) and add 1.
  process(subtract_op)
     variable TMP: std_logic_vector(0 to num_chunks);
  begin
     TMP := (others =>  '0');
     if (subtract_op = '1') then
       TMP(0) := '1';
     end if;
     addsubcell_Cin <= TMP;
  end process;

  stage_active(0) <= in_rdy;
  out_rdy <= stage_active(pipe_depth);
  stage_tags(0) <= tag_in;
  tag_out <= stage_tags(3);

  RESULT <= Resultpadded(operand_width-1 downto 0);


  -- pad. also if subtract_op = '1' then complement R and add 1 (addsubcell_Cin).
  process(L,R,subtract_op)
	variable ltmp, rtmp: unsigned(padded_operand_width-1 downto 0);
  begin
	ltmp := (others => '0'); ltmp(operand_width-1 downto 0) := L;
	rtmp := (others => '0'); rtmp(operand_width-1 downto 0) := R;
	Lpadded <= ltmp;

	if(subtract_op = '0') then
		Rpadded <= rtmp;
	else
		Rpadded <= not rtmp;
	end if;
  end process;

  Stage1:  for I in  0 to num_chunks-1 generate

	addsubCell_A(I) <= Lpadded(((I+1)*chunk_width)-1 downto (I*chunk_width));
	addsubCell_B(I) <= Rpadded(((I+1)*chunk_width)-1 downto (I*chunk_width));

	asCell: AddSubCell generic map(operand_width => chunk_width)
		port  map( A => addsubcell_A(I),
			   B => addsubcell_B(I),	
			   Sum => addsubcell_Sum(I),
			   BP => addsubcell_BP(I),
			   BG => addsubcell_BG(I),
			   stall => stall,
			   clk => clk,
			   reset => reset);
  end generate Stage1;

  process(clk)
  begin
	if(clk'event and clk = '1') then
		if(stall = '0') then
			stage_tags(1) <= stage_tags(0);
			subtract_op_1 <= subtract_op;
		end if;
		if(reset = '1') then
			stage_active(1) <= '0';
		elsif stall = '0' then
			stage_active(1) <= stage_active(0);
		end if;
	end if;
  end process;

  -- stage two: calculate the block carries.
  MoreThanOneChunk: if (num_chunks > 1) generate
     process(clk, reset, stall, stage_active, addsubcell_Cin, addsubcell_BP, addsubcell_BG)	
	variable cin: std_logic_vector(0 to num_chunks);
     begin
	cin := addsubcell_Cin;
	for I in 1 to num_chunks loop
		cin(I) := (cin(I-1) and addsubcell_BP(I-1))  or addsubcell_BG(I-1);
	end loop;

	if(clk'event and clk = '1') then
		if(reset = '1') then
			stage_active(2) <= '0';
		elsif(stall = '0') then
			block_carries <= cin;
			stage_tags(2) <= stage_tags(1);
			addsubcell_Sum_Delayed <= addsubcell_Sum;
			subtract_op_2 <= subtract_op_1;
			stage_active(2) <= stage_active(1);
		end if;
	end if;
    end process;




  -- stage three: final sums
    process(clk)
	variable correction, tmp: unsigned(chunk_width-1 downto 0);
	variable is_negative: boolean;
    begin
	if(clk'event and clk = '1') then
		if(reset = '1') then
			stage_active(3) <= '0';
		elsif(stall = '0') then
			final_sums(0) <= addsubcell_Sum_Delayed(0);
			for I in 0 to num_chunks-1 loop
				correction := (others => '0');
				if(block_carries(I) = '1') then
					correction(0) := '1';
				end if;
				final_sums(I) <= addsubcell_Sum_Delayed(I) + correction;
			end loop;

			stage_tags(3) <= stage_tags(2);
			stage_active(3) <= stage_active(2);
		end if;
	end if;
    end process;

  end generate MoreThanOneChunk;

  OnlyOneChunk: if (num_chunks = 1) generate
     stage_tags(2) <= stage_tags(1);
     stage_active(2) <= stage_active(1);
     addsubcell_Sum_Delayed <= addsubcell_Sum;

     stage_tags(3) <= stage_tags(2);
     stage_active(3) <= stage_active(2);
     final_sums(0) <= addsubcell_Sum_Delayed(0) when (subtract_op = '0') else (addsubcell_Sum_Delayed(0) + 1);

  end generate OnlyOneChunk;

  -- collect final-sums into RESULT
  process(final_sums)
  begin
	for I in 0 to num_chunks-1 loop
		ResultPadded(((I+1)*chunk_width)-1 downto (I*chunk_width)) <= final_sums(I);
	end loop;
  end process;

end Pipelined;
