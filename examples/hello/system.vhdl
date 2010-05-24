
library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.types.all;
use ahir.memory_subsystem_package.all;

entity system is
  port(
    clk : in std_logic;
    env_accept_data : in std_logic_vector(0 downto 0);
    env_accept_in : in std_logic;
    env_accept_out : out std_logic;
    env_lc_ack : out std_logic;
    env_lc_data : out std_logic_vector(7 downto 0);
    env_lc_req : in std_logic;
    env_lc_tag : out std_logic_vector(7 downto 0);
    env_lr_ack : out std_logic;
    env_lr_addr : in std_logic_vector(7 downto 0);
    env_lr_req : in std_logic;
    env_lr_tag : in std_logic_vector(7 downto 0);
    env_return_data : out std_logic_vector(0 downto 0);
    env_return_in : in std_logic;
    env_return_out : out std_logic;
    env_sr_ack : out std_logic;
    env_sr_addr : in std_logic_vector(7 downto 0);
    env_sr_data : in std_logic_vector(7 downto 0);
    env_sr_req : in std_logic;
    env_sr_tag : in std_logic_vector(7 downto 0);
    reset : in std_logic);
end system;


architecture default_arch of system is

  signal lc_ack : std_logic_vector(8 downto 0);
  signal lc_data : std_logic_vector(71 downto 0);
  signal lc_req : std_logic_vector(8 downto 0);
  signal lc_tag : std_logic_vector(71 downto 0);
  signal lr_ack : std_logic_vector(8 downto 0);
  signal lr_addr : std_logic_vector(71 downto 0);
  signal lr_req : std_logic_vector(8 downto 0);
  signal lr_tag : std_logic_vector(71 downto 0);
  signal sc_req : std_logic_vector(4 downto 0);
  signal sr_ack : std_logic_vector(4 downto 0);
  signal sr_addr : std_logic_vector(39 downto 0);
  signal sr_data : std_logic_vector(39 downto 0);
  signal sr_req : std_logic_vector(4 downto 0);
  signal sr_tag : std_logic_vector(39 downto 0);
  signal start_cp_LambdaIn : BooleanArray(23 downto 1);
  signal start_cp_LambdaOut : BooleanArray(23 downto 1);
  signal start_dp_SigmaIn : BooleanArray(23 downto 1);
  signal start_dp_SigmaOut : BooleanArray(23 downto 1);

  component start_cp is
    port(
      LambdaIn : in BooleanArray(23 downto 1);
      LambdaOut : out BooleanArray(23 downto 1);
      clk : in std_logic;
      reset : in std_logic);
  end component;

  component start_dp is
    port(
      SigmaIn : in BooleanArray(23 downto 1);
      SigmaOut : out BooleanArray(23 downto 1);
      accept_data : in std_logic_vector(0 downto 0);
      accept_in : in std_logic;
      accept_out : out std_logic;
      clk : in std_logic;
      lc_ack : in std_logic_vector(7 downto 0);
      lc_data : in std_logic_vector(63 downto 0);
      lc_req : out std_logic_vector(7 downto 0);
      lc_tag : in std_logic_vector(63 downto 0);
      lr_ack : in std_logic_vector(7 downto 0);
      lr_addr : out std_logic_vector(63 downto 0);
      lr_req : out std_logic_vector(7 downto 0);
      lr_tag : out std_logic_vector(63 downto 0);
      reset : in std_logic;
      return_data : out std_logic_vector(0 downto 0);
      return_in : in std_logic;
      return_out : out std_logic;
      sr_ack : in std_logic_vector(3 downto 0);
      sr_addr : out std_logic_vector(31 downto 0);
      sr_data : out std_logic_vector(31 downto 0);
      sr_req : out std_logic_vector(3 downto 0);
      sr_tag : out std_logic_vector(31 downto 0));
  end component;

  component start_ln is
    port(
      clk : in std_logic;
      reset : in std_logic;
      start_cp_LambdaIn : out BooleanArray(23 downto 1);
      start_cp_LambdaOut : in BooleanArray(23 downto 1);
      start_dp_SigmaIn : out BooleanArray(23 downto 1);
      start_dp_SigmaOut : in BooleanArray(23 downto 1));
  end component;


begin

  sc_req <= (others => '1');
  lr_req(0) <= env_lr_req;
  env_lr_ack <= lr_ack(0);
  lr_addr(7 downto 0) <= env_lr_addr;
  lr_tag(7 downto 0) <= env_lr_tag;
  
  lc_req(0) <= env_lc_req;
  env_lc_ack <= lc_ack(0);
  env_lc_data <= lc_data(7 downto 0);
  env_lc_tag <= lc_tag(7 downto 0);
  
  sr_req(0) <= env_sr_req;
  env_sr_ack <= sr_ack(0);
  sr_addr(7 downto 0) <= env_sr_addr;
  sr_data(7 downto 0) <= env_sr_data;
  sr_tag(7 downto 0) <= env_sr_tag;
  
  start_cp_inst : start_cp -- 
  -- configuration: 
    port map(
      LambdaIn => start_cp_LambdaIn,
      LambdaOut => start_cp_LambdaOut,
      clk => clk,
      reset => reset);

  start_dp_inst : start_dp -- 
  -- configuration: start_dp_config
    port map(
      SigmaIn => start_dp_SigmaIn,
      SigmaOut => start_dp_SigmaOut,
      accept_data => env_accept_data,
      accept_in => env_accept_in,
      accept_out => env_accept_out,
      clk => clk,
      lc_ack => lc_ack(8 downto 1),
      lc_data => lc_data(71 downto 8),
      lc_req => lc_req(8 downto 1),
      lc_tag => lc_tag(71 downto 8),
      lr_ack => lr_ack(8 downto 1),
      lr_addr => lr_addr(71 downto 8),
      lr_req => lr_req(8 downto 1),
      lr_tag => lr_tag(71 downto 8),
      reset => reset,
      return_data => env_return_data,
      return_in => env_return_in,
      return_out => env_return_out,
      sr_ack => sr_ack(4 downto 1),
      sr_addr => sr_addr(39 downto 8),
      sr_data => sr_data(39 downto 8),
      sr_req => sr_req(4 downto 1),
      sr_tag => sr_tag(39 downto 8));

  start_ln_inst : start_ln -- 
  -- configuration: 
    port map(
      clk => clk,
      reset => reset,
      start_cp_LambdaIn => start_cp_LambdaIn,
      start_cp_LambdaOut => start_cp_LambdaOut,
      start_dp_SigmaIn => start_dp_SigmaIn,
      start_dp_SigmaOut => start_dp_SigmaOut);

  memory_subsystem_inst : memory_subsystem -- system memory
  -- configuration: 
    generic map(
      addr_width => 8,
      base_bank_addr_width => 8,
      base_bank_data_width => 8,
      data_width => 8,
      demux_degree => 2,
      mux_degree => 2,
      num_loads => 9,
      num_stores => 5,
      number_of_banks => 1,
      tag_width => 8)
    port map(
      clock => clk,
      lc_ack_out => lc_ack,
      lc_data_out => lc_data,
      lc_req_in => lc_req,
      lc_tag_out => lc_tag,
      lr_ack_out => lr_ack,
      lr_addr_in => lr_addr,
      lr_req_in => lr_req,
      lr_tag_in => lr_tag,
      reset => reset,
      sc_req_in => sc_req,
      sr_ack_out => sr_ack,
      sr_addr_in => sr_addr,
      sr_data_in => sr_data,
      sr_req_in => sr_req,
      sr_tag_in => sr_tag);


end default_arch;