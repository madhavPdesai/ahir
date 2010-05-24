
library ieee;
use ieee.std_logic_1164.all;

package memory_subsystem_package is

  component memory_subsystem
    generic (
      num_loads       : natural;
      num_stores      : natural;
      addr_width      : natural;
      data_width      : natural;
      tag_width       : natural;
      number_of_banks : natural;
      mux_degree      : natural;
      demux_degree    : natural;
      base_bank_addr_width: natural;
      base_bank_data_width: natural);
    port (
      lr_addr_in  : in  std_logic_vector((num_loads*addr_width)-1 downto 0);
      lr_req_in   : in  std_logic_vector(num_loads-1 downto 0);
      lr_ack_out  : out std_logic_vector(num_loads-1 downto 0);
      lr_tag_in   : in  std_logic_vector((num_loads*tag_width)-1 downto 0);
      lc_data_out : out std_logic_vector((num_loads*data_width)-1 downto 0);
      lc_req_in   : in  std_logic_vector(num_loads-1 downto 0);
      lc_ack_out  : out std_logic_vector(num_loads-1 downto 0);
      lc_tag_out  : out std_logic_vector((num_loads*tag_width)-1 downto 0);
      sr_addr_in  : in  std_logic_vector((num_stores*addr_width)-1 downto 0);
      sr_data_in  : in  std_logic_vector((num_stores*data_width)-1 downto 0);
      sr_req_in   : in  std_logic_vector(num_stores-1 downto 0);
      sr_ack_out  : out std_logic_vector(num_stores-1 downto 0);
      sr_tag_in   : in  std_logic_vector((num_stores*tag_width)-1 downto 0);
      sc_req_in   : in  std_logic_vector(num_stores-1 downto 0);
      sc_ack_out  : out std_logic_vector(num_stores-1 downto 0);
      sc_tag_out  : out std_logic_vector((num_stores*tag_width)-1 downto 0);
      clock       : in  std_logic;
      reset       : in  std_logic);
  end component;
  
end memory_subsystem_package;
