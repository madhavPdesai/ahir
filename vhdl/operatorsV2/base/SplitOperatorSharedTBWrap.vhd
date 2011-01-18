library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity SplitOperatorSharedTBWrap is
end SplitOperatorSharedTBWrap;

architecture Behave of SplitOperatorSharedTBWrap is
begin
   tb0: SplitOperatorSharedTB generic map(g_num_req => 1,
                                          operator_id => "ApIntAdd",
                                          zero_delay => true,
                                          verbose_mode => false,
                                          input_data_width => 8,
                                          output_data_width => 8,
                                          num_ips => 2,
                                          tb_id => "ApIntAdd num_req=1 ");  
   tb1: SplitOperatorSharedTB generic map(g_num_req => 2,
                                          operator_id => "ApIntAdd",
                                          zero_delay => false,
                                          verbose_mode => false,
                                          input_data_width => 8,
                                          output_data_width => 8,
                                          num_ips => 2,
                                          tb_id => "ApIntAdd num_req=2 ");
   tb2: SplitOperatorSharedTB generic map(g_num_req => 5,
                                          operator_id => "ApIntAdd",
                                          zero_delay => true,
                                          verbose_mode => false,
                                          input_data_width => 8,
                                          output_data_width => 8,
                                          num_ips => 2,
                                          tb_id => "ApIntAdd num_req=5 ");
end Behave;
