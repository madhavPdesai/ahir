library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.types.all;
use ahir.subprograms.all;

entity testbench is

end testbench;

architecture default_arch of testbench is

  component system
    port (
      clk             : in  std_logic;
      env_accept_data : in  std_logic_vector(0 downto 0);
      env_accept_in   : in  std_logic;
      env_accept_out  : out std_logic;
      env_lc_ack      : out std_logic;
      env_lc_data     : out std_logic_vector(7 downto 0);
      env_lc_tag      : out std_logic_vector(7 downto 0);
      env_lc_req      : in  std_logic;
      env_lr_ack      : out std_logic;
      env_lr_addr     : in  std_logic_vector(7 downto 0);
      env_lr_tag      : in  std_logic_vector(7 downto 0);
      env_lr_req      : in  std_logic;
      env_return_data : out std_logic_vector(0 downto 0);
      env_return_in   : in  std_logic;
      env_return_out  : out std_logic;
      env_sr_ack      : out std_logic;
      env_sr_addr     : in  std_logic_vector(7 downto 0);
      env_sr_data     : in  std_logic_vector(7 downto 0);
      env_sr_tag      : in  std_logic_vector(7 downto 0);
      env_sr_req      : in  std_logic;
      reset           : in  std_logic);
  end component;

  signal clk             : std_logic                    := '0';
  signal env_accept_data : std_logic_vector(0 downto 0) := (others => '0');
  signal env_accept_in   : std_logic                    := '0';
  signal env_accept_out  : std_logic;
  signal env_lc_ack      : std_logic;
  signal env_lc_data     : std_logic_vector(7 downto 0);
  signal env_lc_tag      : std_logic_vector(7 downto 0);
  signal env_lc_req      : std_logic                    := '0';
  signal env_lr_ack      : std_logic;
  signal env_lr_addr     : std_logic_vector(7 downto 0) := (others => '0');
  signal env_lr_tag      : std_logic_vector(7 downto 0) := (others => '0');
  signal env_lr_req      : std_logic                    := '0';
  signal env_return_data : std_logic_vector(0 downto 0);
  signal env_return_in   : std_logic                    := '0';
  signal env_return_out  : std_logic;
  signal env_sr_ack      : std_logic;
  signal env_sr_addr     : std_logic_vector(7 downto 0) := (others => '0');
  signal env_sr_data     : std_logic_vector(7 downto 0) := (others => '0');
  signal env_sr_tag      : std_logic_vector(7 downto 0) := (others => '0');
  signal env_sr_req      : std_logic                    := '0';
  signal reset           : std_logic                    := '1';

begin  -- default_arch

  clk <= not clk after 10 ns;

  process
  begin  -- process
    wait on clk until clk = '1';
    reset <= '0';
    wait;
  end process;

  process

    subtype AWord is std_logic_vector(7 downto 0);
    type    AddrArray is array (integer range <>) of AWord;

    subtype DWord is std_logic_vector (7 downto 0);
    type    DataArray is array (integer range <>) of DWord;

    constant num_init : integer := 16;

    variable init_addr : AddrArray(0 to num_init - 1) :=
      (std_logic_vector(to_unsigned(1, 8)),
       std_logic_vector(to_unsigned(2, 8)),
       std_logic_vector(to_unsigned(3, 8)),
       std_logic_vector(to_unsigned(4, 8)),
       std_logic_vector(to_unsigned(5, 8)),
       std_logic_vector(to_unsigned(6, 8)),
       std_logic_vector(to_unsigned(7, 8)),
       std_logic_vector(to_unsigned(8, 8)),
       std_logic_vector(to_unsigned(13, 8)),
       std_logic_vector(to_unsigned(14, 8)),
       std_logic_vector(to_unsigned(15, 8)),
       std_logic_vector(to_unsigned(16, 8)),
       std_logic_vector(to_unsigned(17, 8)),
       std_logic_vector(to_unsigned(18, 8)),
       std_logic_vector(to_unsigned(19, 8)),
       std_logic_vector(to_unsigned(20, 8)));

    variable init_data : DataArray(0 to num_init - 1) :=
      (('1','1','1','0','0','0','0','1'),
       ('0','1','1','1','1','0','1','0'),
       ('0','0','0','1','1','1','0','0'),
       ('0','1','0','0','0','0','0','1'),  -- 1 to 4
       ('0','1','1','1','0','0','1','0'),
       ('1','1','1','1','1','0','0','1'),
       ('0','1','1','1','1','1','1','1'),
       ('0','0','1','1','1','1','1','1'),  -- 5 to 8
       std_logic_vector(to_signed(-1, 8)),
       std_logic_vector(to_signed(-1, 8)),
       std_logic_vector(to_signed(-1, 8)),
       std_logic_vector(to_signed(-1, 8)),  -- 13 to 16
       std_logic_vector(to_unsigned(56, 8)),
       std_logic_vector(to_unsigned(0, 8)),  -- 17 to 18
       std_logic_vector(to_signed(-23, 8)),
       std_logic_vector(to_signed(-1, 8))); -- 19 to 20

    constant num_fin  : integer                     := 16;
    variable fin_addr : AddrArray(0 to num_fin - 1) :=
      (std_logic_vector(to_unsigned(13, 8)),
       std_logic_vector(to_unsigned(14, 8)),
       std_logic_vector(to_unsigned(15, 8)),
       std_logic_vector(to_unsigned(16, 8)),
       std_logic_vector(to_unsigned(17, 8)),
       std_logic_vector(to_unsigned(18, 8)),
       std_logic_vector(to_unsigned(19, 8)),
       std_logic_vector(to_unsigned(20, 8)),
       std_logic_vector(to_unsigned(21, 8)),
       std_logic_vector(to_unsigned(22, 8)),
       std_logic_vector(to_unsigned(23, 8)),
       std_logic_vector(to_unsigned(24, 8)),
       std_logic_vector(to_unsigned(25, 8)),
       std_logic_vector(to_unsigned(26, 8)),
       std_logic_vector(to_unsigned(27, 8)),
       std_logic_vector(to_unsigned(28, 8)));

  begin  -- process

    wait until reset = '0';
    wait until clk = '1';

    env_sr_req <= '1';
    for i in 0 to init_addr'length(1) - 1 loop
      env_sr_addr <= init_addr(i);
      env_sr_data <= init_data(i);
      if env_sr_ack /= '1' then
        wait until env_sr_ack = '1';
      end if;
      wait until clk = '1';
    end loop;  -- i
    env_sr_req <= '0';

    env_accept_in <= '1';
    wait until env_accept_out = '1';
    wait until clk = '1';
    env_accept_in <= '0';

    env_return_in <= '1';
    wait until env_return_out = '1';
    wait until clk = '1';
    env_return_in <= '0';

    env_lr_req <= '1';
    for i in 0 to num_fin - 1 loop
      env_lr_addr <= fin_addr(i);
      wait until env_lr_ack = '1';
      wait until clk = '1';
    end loop;  -- i
    env_lr_req <= '0';

    env_lc_req <= '1';
    for i in 0 to num_fin - 1 loop
      wait until env_lc_ack = '1';
      wait until clk = '1';
    end loop;  -- i
    env_lc_req <= '0';

    assert false report "simulation done" severity note;
    wait;
  end process;

  system_inst : system
    port map (
      clk             => clk,
      env_accept_data => env_accept_data,
      env_accept_in   => env_accept_in,
      env_accept_out  => env_accept_out,
      env_lc_ack      => env_lc_ack,
      env_lc_data     => env_lc_data,
      env_lc_tag      => env_lc_tag,
      env_lc_req      => env_lc_req,
      env_lr_ack      => env_lr_ack,
      env_lr_addr     => env_lr_addr,
      env_lr_tag      => env_lr_tag,
      env_lr_req      => env_lr_req,
      env_return_data => env_return_data,
      env_return_in   => env_return_in,
      env_return_out  => env_return_out,
      env_sr_ack      => env_sr_ack,
      env_sr_addr     => env_sr_addr,
      env_sr_tag      => env_sr_tag,
      env_sr_data     => env_sr_data,
      env_sr_req      => env_sr_req,
      reset           => reset);

end default_arch;
