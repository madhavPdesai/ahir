library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity PipeMux is
  generic (name : string; data_width: integer);
  port (
    write_req_0   : in std_logic;
    write_ack_0   : out std_logic;
    write_data_0   : in std_logic_vector(data_width-1 downto 0);
    write_req_1   : in std_logic;
    write_ack_1   : out std_logic;
    write_data_1   : in std_logic_vector(data_width-1 downto 0);
    read_req      : in  std_logic;
    read_ack       : out std_logic;
    read_data     : out std_logic_vector(data_width-1 downto 0);
    clk, reset : in  std_logic);
end PipeMux;

architecture default_arch of PipeMux is

   signal priority_flag: std_logic;
  
begin  -- default_arch
   assert false report "NOT IMPLEMENTED" severity ERROR;
end default_arch;
