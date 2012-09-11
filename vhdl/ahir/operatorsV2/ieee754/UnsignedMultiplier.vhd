-------------------------------------------------------------------------------
-- a basic unsigned multiplier.
--
-- for the moment, this just does a multiply and adds delay stages at
-- the end; presumably, the synthesis tool will retime things
-- appropriately..
--
-- TODO: pipeline this explicitly!
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UnsignedMultiplier is
  
  generic (
    tag_width     : integer;
    operand_width : integer);

  port (
    L, R       : in  unsigned(operand_width-1 downto 0);
    RESULT     : out unsigned((2*operand_width)-1 downto 0);
    clk, reset : in  std_logic;
    in_rdy     : in  std_logic;
    out_rdy    : out std_logic;
    stall      : in std_logic;
    tag_in     : in std_logic_vector(tag_width-1 downto 0);
    tag_out    : out std_logic_vector(tag_width-1 downto 0));
end entity;


architecture Pipelined of UnsignedMultiplier is

  constant pipe_depth : integer := operand_width/16;

  type RWORD is array (natural range <>) of unsigned((2*operand_width)-1 downto 0);
  type TWORD is array (natural range <>) of std_logic_vector(tag_width-1 downto 0);  


  signal intermediate_results : RWORD(0 to pipe_depth);
  signal intermediate_tags : TWORD(0 to pipe_depth);  
  signal stage_active : std_logic_vector(0 to pipe_depth);
  
begin  -- Pipelined

  -- for now, just multiply..
  intermediate_results(0) <= L*R;


  -- I/O
  intermediate_tags(0) <= tag_in;
  stage_active(0) <= in_rdy;
  out_rdy <= stage_active(pipe_depth);
  tag_out <= intermediate_tags(pipe_depth);
  RESULT <= intermediate_results(pipe_depth);
  
  -- for now, just add stages after the multiply
  -- the synthesis tool should retime.  Later
  -- we'll get around to doing the array multiplier
  -- right.
  Pipeline: for STAGE in 1 to pipe_depth generate

    process(clk)
    begin
      if(clk'event and clk = '1') then
        if(reset = '1') then
          stage_active(STAGE) <= '0';
        elsif(stall = '0') then
          stage_active(STAGE) <= stage_active(STAGE-1);
        end if;

        if(stall = '0') then
          intermediate_results(STAGE) <= intermediate_results(STAGE-1);
          intermediate_tags(STAGE) <= intermediate_tags(STAGE-1);
        end if;
        
      end if;
    end process;
    
  end generate Pipeline;
end Pipelined;
