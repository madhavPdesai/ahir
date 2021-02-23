------------------------------------------------------------------------------------------------
--
-- Copyright (C) 2010-: Madhav P. Desai, Ch. V. Kalyani
-- All Rights Reserved.
--  
-- Permission is hereby granted, free of charge, to any person obtaining a
-- copy of this software and associated documentation files (the
-- "Software"), to deal with the Software without restriction, including
-- without limitation the rights to use, copy, modify, merge, publish,
-- distribute, sublicense, and/or sell copies of the Software, and to
-- permit persons to whom the Software is furnished to do so, subject to
-- the following conditions:
-- 
--  * Redistributions of source code must retain the above copyright
--    notice, this list of conditions and the following disclaimers.
--  * Redistributions in binary form must reproduce the above
--    copyright notice, this list of conditions and the following
--    disclaimers in the documentation and/or other materials provided
--    with the distribution.
--  * Neither the names of the AHIR Team, the Indian Institute of
--    Technology Bombay, nor the names of its contributors may be used
--    to endorse or promote products derived from this Software
--    without specific prior written permission.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
-- OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
-- IN NO EVENT SHALL THE CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR
-- ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
-- TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
-- SOFTWARE OR THE USE OR OTHER DEALINGS WITH THE SOFTWARE.
--------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;	
use ahir.Types.all;	
use ahir.Subprograms.all;	
use ahir.mem_function_pack.all;
use ahir.memory_subsystem_package.all;
--use ahir.Utilities.all;

library aHiR_ieee_proposed;
use aHiR_ieee_proposed.math_utility_pkg.all;
use aHiR_ieee_proposed.float_pkg.all;

package MemcutDescriptionPackage is
   constant spmem_cut_row_heights : IntegerArray(1 to 16) := (16384, 4096, 4096, 512, 512, 512, 128, 128, 64, 64, 64, 64, 64, 32, 16, 8);
    constant spmem_cut_address_widths : IntegerArray(1 to 16) := (14, 12, 12, 9, 9, 9, 7, 7, 6, 6, 6, 6, 6, 5, 4, 3);
    constant spmem_cut_data_widths : IntegerArray(1 to 16) := (8, 64, 8, 64, 16, 4, 64, 32, 128, 64, 16, 8, 2, 32, 32, 64);
   constant dpmem_cut_row_heights : IntegerArray(1 to 8) := (256, 256, 256, 64, 64, 64, 64, 32);
    constant dpmem_cut_address_widths : IntegerArray(1 to 8) := (8, 8, 8, 6, 6, 6, 6, 5);
    constant dpmem_cut_data_widths : IntegerArray(1 to 8) := (32, 16, 4, 16, 8, 4, 2, 128);
   constant register_file_1w_1r_cut_row_heights : IntegerArray(1 to 6) := (64, 64, 64, 64, 16, 16);
    constant register_file_1w_1r_cut_address_widths : IntegerArray(1 to 6) := (6, 6, 6, 6, 4, 4);
    constant register_file_1w_1r_cut_data_widths : IntegerArray(1 to 6) := (16, 8, 4, 2, 32, 16);
end package;
