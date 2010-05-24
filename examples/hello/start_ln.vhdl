
library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.types.all;

entity start_ln is
  port(
    clk : in std_logic;
    reset : in std_logic;
    start_cp_LambdaIn : out BooleanArray(23 downto 1);
    start_cp_LambdaOut : in BooleanArray(23 downto 1);
    start_dp_SigmaIn : out BooleanArray(23 downto 1);
    start_dp_SigmaOut : in BooleanArray(23 downto 1));
end start_ln;

architecture default_arch of start_ln is
begin
  start_cp_LambdaIn(1) <= start_dp_SigmaOut(1);
  start_cp_LambdaIn(2) <= start_dp_SigmaOut(2);
  start_cp_LambdaIn(3) <= start_dp_SigmaOut(3);
  start_cp_LambdaIn(4) <= start_dp_SigmaOut(4);
  start_cp_LambdaIn(5) <= start_dp_SigmaOut(5);
  start_cp_LambdaIn(6) <= start_dp_SigmaOut(6);
  start_cp_LambdaIn(7) <= start_dp_SigmaOut(7);
  start_cp_LambdaIn(8) <= start_dp_SigmaOut(8);
  start_cp_LambdaIn(9) <= start_dp_SigmaOut(9);
  start_cp_LambdaIn(10) <= start_dp_SigmaOut(10);
  start_cp_LambdaIn(11) <= start_dp_SigmaOut(11);
  start_cp_LambdaIn(12) <= start_dp_SigmaOut(12);
  start_cp_LambdaIn(13) <= start_dp_SigmaOut(13);
  start_cp_LambdaIn(14) <= start_dp_SigmaOut(14);
  start_cp_LambdaIn(15) <= start_dp_SigmaOut(15);
  start_cp_LambdaIn(16) <= start_dp_SigmaOut(16);
  start_cp_LambdaIn(17) <= start_dp_SigmaOut(17);
  start_cp_LambdaIn(18) <= start_dp_SigmaOut(18);
  start_cp_LambdaIn(19) <= start_dp_SigmaOut(19);
  start_cp_LambdaIn(20) <= start_dp_SigmaOut(20);
  start_cp_LambdaIn(21) <= start_dp_SigmaOut(21);
  start_cp_LambdaIn(22) <= start_dp_SigmaOut(22);
  start_cp_LambdaIn(23) <= start_dp_SigmaOut(23);

  start_dp_SigmaIn(1) <= start_cp_LambdaOut(1);
  start_dp_SigmaIn(2) <= start_cp_LambdaOut(2);
  start_dp_SigmaIn(3) <= start_cp_LambdaOut(3);
  start_dp_SigmaIn(4) <= start_cp_LambdaOut(4);
  start_dp_SigmaIn(5) <= start_cp_LambdaOut(5);
  start_dp_SigmaIn(6) <= start_cp_LambdaOut(6);
  start_dp_SigmaIn(7) <= start_cp_LambdaOut(7);
  start_dp_SigmaIn(8) <= start_cp_LambdaOut(8);
  start_dp_SigmaIn(9) <= start_cp_LambdaOut(9);
  start_dp_SigmaIn(10) <= start_cp_LambdaOut(10);
  start_dp_SigmaIn(11) <= start_cp_LambdaOut(11);
  start_dp_SigmaIn(12) <= start_cp_LambdaOut(12);
  start_dp_SigmaIn(13) <= start_cp_LambdaOut(13);
  start_dp_SigmaIn(14) <= start_cp_LambdaOut(14);
  start_dp_SigmaIn(15) <= start_cp_LambdaOut(15);
  start_dp_SigmaIn(16) <= start_cp_LambdaOut(16);
  start_dp_SigmaIn(17) <= start_cp_LambdaOut(17);
  start_dp_SigmaIn(18) <= start_cp_LambdaOut(18);
  start_dp_SigmaIn(19) <= start_cp_LambdaOut(19);
  start_dp_SigmaIn(20) <= start_cp_LambdaOut(20);
  start_dp_SigmaIn(21) <= start_cp_LambdaOut(21);
  start_dp_SigmaIn(22) <= start_cp_LambdaOut(22);
  start_dp_SigmaIn(23) <= start_cp_LambdaOut(23);
end default_arch;