-------------------------------------------------------------------------------
-- a basic unsigned adder.
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
		subtract_op: in std_logic;
		BP,BG: out std_logic;
		stall: in std_logic;
		clk, reset: in std_logic);
end entity AddSubCell;

architecture Behave of AddSubCell is
begin
	process(clk)
		variable sumv: unsigned(operand_width-1 downto 0);
		variable prop, gen: std_logic;
	begin
		prop := '1';
		gen  := '0';

		if(subtract_op = '0') then
			sumv := A+B;
		else
			sumv := A-B;
		end if;

		for I in 0 to operand_width-1 loop
		 	
		   if(subtract_op = '0') then 
			prop := (prop and (A(I) or B(I)));
			gen  := (A(I) and B(I)) or (gen and (A(I) or B(I)));
		   else
			prop := (prop and (A(I) xnor B(I)));
			gen  := ((not A(I)) and B(I)) or (gen and (A(I) xnor B(I)));
		   end if;
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
  signal addsubcell_BP, addsubcell_BG, addsubcell_Cout, addsubcell_Cin: std_logic_vector(0 to num_chunks-1);

  signal block_carries: std_logic_vector(1 to num_chunks);
  signal subtract_op_1, subtract_op_2: std_logic;


  component AddSubCell  is
	generic ( operand_width: integer);
	port (A,B: in unsigned(operand_width-1 downto 0);
		Sum: out unsigned(operand_width-1 downto 0);
		subtract_op: in std_logic;
		BP,BG: out std_logic;
		stall: in std_logic;
		clk, reset: in std_logic);
  end component AddSubCell;
  
begin  -- Pipelined

  addsubcell_Cin <= (others => '0');
  stage_active(0) <= in_rdy;
  out_rdy <= stage_active(pipe_depth);
  stage_tags(0) <= tag_in;
  tag_out <= stage_tags(3);

  RESULT <= Resultpadded(operand_width-1 downto 0);

  process(L,R)
	variable ltmp, rtmp: unsigned(padded_operand_width-1 downto 0);
  begin
	ltmp := (others => '0'); ltmp(operand_width-1 downto 0) := L;
	rtmp := (others => '0'); rtmp(operand_width-1 downto 0) := R;
	Lpadded <= ltmp;
	Rpadded <= rtmp;
  end process;

  Stage1:  for I in  0 to num_chunks-1 generate

	addsubCell_A(I) <= Lpadded(((I+1)*chunk_width)-1 downto (I*chunk_width));
	addsubCell_B(I) <= Rpadded(((I+1)*chunk_width)-1 downto (I*chunk_width));

	asCell: AddSubCell generic map(operand_width => chunk_width)
		port  map( A => addsubcell_A(I),
			   B => addsubcell_B(I),	
			   Sum => addsubcell_Sum(I),
			   subtract_op => subtract_op,
			   BP => addsubcell_BP(I),
			   BG => addsubcell_BG(I),
			   stall => stall,
			   clk => clk,
			   reset => reset);

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
			
  end generate Stage1;

  -- stage two: calculate the block carries.
  process(clk)	
	variable cin: std_logic_vector(0 to num_chunks);
  begin
	cin := (others => '0');
	for I in 1 to num_chunks loop
		cin(I) := (cin(I-1) and addsubcell_BP(I-1))  or addsubcell_BG(I-1);
	end loop;

	if(clk'event and clk = '1') then
		if(stall = '0') then
			block_carries <= cin(1 to num_chunks);
			stage_tags(2) <= stage_tags(1);
			addsubcell_Sum_Delayed <= addsubcell_Sum;
			subtract_op_2 <= subtract_op_1;
		end if;	
		if(reset = '1') then
			stage_active(2) <= '0';
		elsif stall = '0' then
			stage_active(2) <= stage_active(1);
		end if;
	end if;
  end process;


  -- stage three: final sums
  process(clk)
	variable correction, tmp: unsigned(chunk_width-1 downto 0);
	variable is_negative: boolean;
  begin
	correction := (others => '0');
	if(clk'event and clk = '1') then
		if(stall = '0') then
			final_sums(0) <= addsubcell_Sum_Delayed(0);
			for I in 1 to num_chunks-1 loop
				if(block_carries(I) = '1') then
					if(subtract_op_2 = '1') then
						correction := (others => '1');
					else
						correction := (0 => '1', others => '0');
					end if;
				else	
					correction := (others => '0');
				end if;
				tmp := addsubcell_Sum_Delayed(I) + correction;


				-- if correction is negative, then check that the
				-- result is not negative! 
				if(subtract_op_2 = '1') then
					is_negative :=  (addsubcell_Sum_Delayed(I) < tmp);
					if(is_negative) then
						tmp  := (others => '0');
					end if;
				end if;
				final_sums(I) <= tmp;
			end loop;
			stage_tags(3) <= stage_tags(2);
			if(reset = '1') then
				stage_active(3) <= '0';
			elsif stall = '0' then
				stage_active(3) <= stage_active(2);
			end if;
		end if;
	end if;
  end process;


  -- collect final-sums into RESULT
  process(final_sums)
  begin
	for I in 0 to num_chunks-1 loop
		ResultPadded(((I+1)*chunk_width)-1 downto (I*chunk_width)) <= final_sums(I);
	end loop;
  end process;



end Pipelined;
