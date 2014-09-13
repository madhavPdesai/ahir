library ieee;
use ieee.std_logic_1164.all;

package Types is

  type ApInt is array(integer range <>) of std_logic;
  type ApIntArray is array(integer range <>, integer range <>) of std_logic;
 
  type ApFloat is array(integer range <>) of std_logic;
  type ApFloatArray is array(integer range <>, integer range <>) of std_logic;
  
  type BooleanArray is array(integer range <>) of boolean;
  type IntegerArray is array(integer range <>) of integer;
  type NaturalArray is array(integer range <>) of natural;

  type StdLogicArray2D is array (integer range <>,integer range <>) of std_logic;
  type IStdLogicVector is array (integer range <>) of std_logic; -- note: integer range

  constant slv_zero: std_logic_vector(0 downto 0) := "0";
  constant sl_zero: std_logic := '0';
  constant slv_one: std_logic_vector(0 downto 0) := "1";
  constant sl_one: std_logic := '1';

  constant loop_pipeline_buffering: integer := 4;
end package Types;

