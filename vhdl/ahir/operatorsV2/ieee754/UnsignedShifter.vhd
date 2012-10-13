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
use ahir.Utilities.all;


entity UnsignedShifter is
  
  generic (
    shift_right_flag   : boolean;
    tag_width          : integer;
    operand_width      : integer;
    shift_amount_width : integer);

  port (
    L       : in  unsigned(operand_width-1 downto 0);
    R       : in  unsigned(shift_amount_width-1 downto 0);
    RESULT     : out unsigned(operand_width-1 downto 0);
    clk, reset : in  std_logic;
    in_rdy     : in  std_logic;
    out_rdy    : out std_logic;
    stall      : in std_logic;
    tag_in     : in std_logic_vector(tag_width-1 downto 0);
    tag_out    : out std_logic_vector(tag_width-1 downto 0));
end entity;


architecture Pipelined of UnsignedShifter is

  constant phases_per_stage: integer := 4;
  constant num_sig_bits: integer := Maximum(1,Minimum(shift_amount_width, Ceil_Log2(operand_width)));
  constant pipe_depth : integer := Ceil(num_sig_bits,phases_per_stage);

  type RWORD is array (natural range <>) of unsigned(operand_width-1 downto 0);
  type TWORD is array (natural range <>) of std_logic_vector(tag_width-1 downto 0);  
  type SWORD is array (natural range <>) of unsigned(num_sig_bits-1 downto 0);  


  signal intermediate_results : RWORD(0 to pipe_depth);
  signal intermediate_tags : TWORD(0 to pipe_depth);  
  signal intermediate_shift_amount : SWORD(0 to pipe_depth);  
  signal stage_active : std_logic_vector(0 to pipe_depth);

  
  constant debug_flag: boolean := true;
begin  -- Pipelined

  Debug: if debug_flag  generate
	
	DebugBlock: block
		signal pipe_depth_sig, num_sig_bits_sig, tmp_sig, tmp_sig_2: integer;
	begin
		pipe_depth_sig <= pipe_depth;
		num_sig_bits_sig <= num_sig_bits;
		tmp_sig <= Ceil(num_sig_bits,phases_per_stage);
		tmp_sig_2 <= (num_sig_bits/phases_per_stage);
	end block;

  end generate debug;

   
  TrivOp: if operand_width = 1 generate
	intermediate_results(0) <= (others => '0') when R(0) = '1' else L;
  end generate TrivOp;
  

  NonTrivOp: if operand_width > 1 generate



        genStages: for STAGE in 1 to pipe_depth generate
  		process(clk)
			variable shifted_L: unsigned(operand_width-1 downto 0);
			variable shift_amount: unsigned(num_sig_bits-1 downto 0);
  		begin
			shifted_L := intermediate_results(STAGE-1);
			shift_amount := intermediate_shift_amount(STAGE-1);

			for I in ((STAGE-1)*phases_per_stage) to 
					Minimum(num_sig_bits-1,(STAGE*phases_per_stage)-1) loop  
				if(shift_amount(I) = '1') then
					if(shift_right_flag) then
						shifted_L :=  shift_right(shifted_L, 2**I);
					else
						shifted_L :=  shift_left(shifted_L, 2**I);
					end if;
				end if;
			end loop;

			if(clk'event and clk='1') then

                                if(reset = '1') then
					stage_active(STAGE) <=  '0';
				elsif stall = '0' then
					stage_active(STAGE) <= stage_active(STAGE-1);
				end if;

				if(stall = '0') then
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
  intermediate_results(0) <=  L;
  intermediate_tags(0) <= tag_in;
  intermediate_shift_amount(0) <= R(num_sig_bits-1 downto 0);
  stage_active(0) <= in_rdy;
  out_rdy <= stage_active(pipe_depth);
  tag_out <= intermediate_tags(pipe_depth);
  RESULT <= intermediate_results(pipe_depth);
  
end Pipelined;
