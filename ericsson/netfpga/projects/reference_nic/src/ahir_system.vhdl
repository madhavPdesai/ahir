library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.memory_subsystem_package.all;
use ahir.types.all;
use ahir.subprograms.all;
use ahir.components.all;
use ahir.basecomponents.all;
use ahir.operatorpackage.all;
use ahir.utilities.all;
entity ahir_system is  -- system 
  port (-- 
    clk : in std_logic;
    reset : in std_logic;
    in_ctrl_pipe_write_data: in std_logic_vector(7 downto 0);
    in_ctrl_pipe_write_req : in std_logic_vector(0 downto 0);
    in_ctrl_pipe_write_ack : out std_logic_vector(0 downto 0);
    in_data_pipe_write_data: in std_logic_vector(63 downto 0);
    in_data_pipe_write_req : in std_logic_vector(0 downto 0);
    in_data_pipe_write_ack : out std_logic_vector(0 downto 0);
    out_ctrl_pipe_read_data: out std_logic_vector(7 downto 0);
    out_ctrl_pipe_read_req : in std_logic_vector(0 downto 0);
    out_ctrl_pipe_read_ack : out std_logic_vector(0 downto 0);
    out_data_pipe_read_data: out std_logic_vector(63 downto 0);
    out_data_pipe_read_req : in std_logic_vector(0 downto 0);
    out_data_pipe_read_ack : out std_logic_vector(0 downto 0)); -- 
  -- 
end entity; 
architecture Default of ahir_system is -- system-architecture 
begin -- 
  in_ctrl_Pipe: PipeBase -- 
    generic map( -- 
      num_reads => 1,
      num_writes => 1,
      data_width => 8,
      depth => 1 --
    )
    port map( -- 
      read_req => out_ctrl_pipe_read_req,
      read_ack => out_ctrl_pipe_read_ack,
      read_data => out_ctrl_pipe_read_data,
      write_req => in_ctrl_pipe_write_req,
      write_ack => in_ctrl_pipe_write_ack,
      write_data => in_ctrl_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  in_data_Pipe: PipeBase -- 
    generic map( -- 
      num_reads => 1,
      num_writes => 1,
      data_width => 64,
      depth => 1 --
    )
    port map( -- 
      read_req => out_data_pipe_read_req,
      read_ack => out_data_pipe_read_ack,
      read_data => out_data_pipe_read_data,
      write_req => in_data_pipe_write_req,
      write_ack => in_data_pipe_write_ack,
      write_data => in_data_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
end Default;
