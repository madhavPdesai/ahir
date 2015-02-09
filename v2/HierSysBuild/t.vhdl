package HierSysComponentPackage is --
  component Left is -- 
    port( -- 
      clk, reset: in std_logic; 
      A_pipe_read_data : in std_logic_vector(15 downto 0);
      A_pipe_read_req  : out std_logic_vector(0  downto 0);
      A_pipe_read_ack  : in std_logic_vector(0  downto 0);
      TMP_pipe_write_data : out std_logic_vector(15 downto 0);
      TMP_pipe_write_req  : out std_logic_vector(0  downto 0);
      TMP_pipe_write_ack  : in std_logic_vector(0  downto 0);
      -- 
    );
    --
  end component;
  component Right is -- 
    port( -- 
      clk, reset: in std_logic; 
      TMP_pipe_read_data : in std_logic_vector(15 downto 0);
      TMP_pipe_read_req  : out std_logic_vector(0  downto 0);
      TMP_pipe_read_ack  : in std_logic_vector(0  downto 0);
      B_pipe_write_data : out std_logic_vector(15 downto 0);
      B_pipe_write_req  : out std_logic_vector(0  downto 0);
      B_pipe_write_ack  : in std_logic_vector(0  downto 0);
      -- 
    );
    --
  end component;
  component Top is -- 
    port( -- 
      clk, reset: in std_logic; 
      a_pipe_read_data : in std_logic_vector(15 downto 0);
      a_pipe_read_req  : out std_logic_vector(0  downto 0);
      a_pipe_read_ack  : in std_logic_vector(0  downto 0);
      b_pipe_write_data : out std_logic_vector(15 downto 0);
      b_pipe_write_req  : out std_logic_vector(0  downto 0);
      b_pipe_write_ack  : in std_logic_vector(0  downto 0);
      -- 
    );
    --
  end component;
  --
end package;
library work;
use work.HierSysComponentPackage.all;
library ieee;
use ieee.std_logic_1164.all;
entity Top is -- 
  port( -- 
    clk, reset: in std_logic; 
    a_pipe_read_data : in std_logic_vector(15 downto 0);
    a_pipe_read_req  : out std_logic_vector(0  downto 0);
    a_pipe_read_ack  : in std_logic_vector(0  downto 0);
    b_pipe_write_data : out std_logic_vector(15 downto 0);
    b_pipe_write_req  : out std_logic_vector(0  downto 0);
    b_pipe_write_ack  : in std_logic_vector(0  downto 0);
    -- 
  );
  --
end entity Top;
architecture struct of Top is 
signal tmp_pipe_data : std_logic_vector(15 downto 0);
signal tmp_pipe_read_ack_write_req  : std_logic_vector(0  downto 0);
signal tmp_pipe_read_req_write_ack  : std_logic_vector(0  downto 0);
begin 
i0: Left
port map ( --
  A_pipe_read_data => a_pipe_read_data,
  A_pipe_read_req => a_pipe_read_req,
  A_pipe_read_ack => a_pipe_read_ack,
  TMP_pipe_write_data => tmp_pipe_data,
  TMP_pipe_write_req => tmp_pipe_read_ack_write_req,
  TMP_pipe_write_ack => tmp_pipe_read_req_write_ack,
  clk => clk, reset => reset 
  ); -- 
i1: Right
port map ( --
  B_pipe_write_data => b_pipe_write_data,
  B_pipe_write_req => b_pipe_write_req,
  B_pipe_write_ack => b_pipe_write_ack,
  TMP_pipe_read_data => tmp_pipe_data,
  TMP_pipe_read_req => tmp_pipe_read_req_write_ack,
  TMP_pipe_read_ack => tmp_pipe_read_ack_write_req,
  clk => clk, reset => reset 
  ); -- 
end struct;
