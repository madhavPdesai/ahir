------------------------------------------------------------------------------/
-- Copyright (c) 1995/2005 Xilinx, Inc.
-- All Right Reserved.
------------------------------------------------------------------------------/
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor : Xilinx
-- \   \   \/     Version : 11.1
--  \   \         Description : Xilinx Timing Simulation Library Component
--  /   /                  Configuration Simulation Model
-- /___/   /\     Filename : x_sim_config_v5.vhd
-- \   \  /  \    Timestamp : 
--  \___\/\___\
--
-- Revision:
--    07/23/07 - Initial version.
--    07/15/08 - Change readback data from byte to same as write width.(CR477214)
--    01/12/10 - Reverse bits for readback (CR544212)
--    05/19/10 - Not reset startup_set_pulse when rw_en=0 (CR559852)
-- End Revision


----- CELL X_SIM_CONFIG_V5  -----
library IEEE;
use IEEE.std_logic_1164.all;

library IEEE;
use IEEE.VITAL_Timing.all;

library STD;
use STD.TEXTIO.all;

library simprim;
use simprim.VPACKAGE.all;
use simprim.VCOMPONENTS.all;

entity X_SIM_CONFIG_V5 is
  generic (
-- begining timing generic
    TimingChecksOn : boolean := true;
    InstancePath : string := "*";
    Xon : boolean := true;
    MsgOn : boolean := false;
    LOC : string  := "UNPLACED";

-- end_timing generic

    DEVICE_ID : bit_vector := X"00000000"

    );

  port (
                   BUSY : out std_ulogic := '0';
                   CSOB : out std_ulogic := '1';
                   DONE : inout std_ulogic := '0';
                   CCLK : in  std_ulogic := '0';
                   CSB : in  std_ulogic := '0';
                   D : inout std_logic_vector(31 downto 0);
                   DCMLOCK : in  std_ulogic := '0';
                   INITB : inout std_ulogic := 'H';
                   M : in  std_logic_vector(2 downto 0) := "000";
                   PROGB : in  std_ulogic := '0';
                   RDWRB : in  std_ulogic := '0'
                   );

  attribute VITAL_LEVEL0 of X_SIM_CONFIG_V5 : entity is true;

end X_SIM_CONFIG_V5;


architecture X_SIM_CONFIG_V5_V of X_SIM_CONFIG_V5 is

function  crc_next (
   crc_currf : in std_logic_vector(31 downto 0);
   crc_inputf : in std_logic_vector(36 downto 0)
 ) return  std_logic_vector
   is
      variable x : std_logic_vector(31 downto 0);
      variable m : std_logic_vector(36 downto 0);
      variable bcc_next : std_logic_vector(31 downto 0);
  begin
 m := crc_inputf;
 x := crc_inputf(31 downto 0)  xor  crc_currf(31 downto 0);

 bcc_next(31) := m(32) xor m(36) xor x(31) xor x(30) xor x(29) xor x(28) xor x(27) xor x(24) xor x(20) xor x(19) xor x(18) xor x(15) xor x(13) xor x(11) xor x(10) xor x(9) xor x(8) xor x(6) xor x(5) xor x(1) xor x(0);

 bcc_next(30) := m(35) xor x(31) xor x(30) xor x(29) xor x(28) xor x(27) xor x(26) xor x(23) xor x(19) xor x(18) xor x(17) xor x(14) xor x(12) xor x(10) xor x(9) xor x(8) xor x(7) xor x(5) xor x(4) xor x(0);

 bcc_next(29) := m(34) xor x(30) xor x(29) xor x(28) xor x(27) xor x(26) xor x(25) xor x(22) xor x(18) xor x(17) xor x(16) xor x(13) xor x(11) xor x(9) xor x(8) xor x(7) xor x(6) xor x(4) xor x(3);

 bcc_next(28) := m(33) xor x(29) xor x(28) xor x(27) xor x(26) xor x(25) xor x(24) xor x(21) xor x(17) xor x(16) xor x(15) xor x(12) xor x(10) xor x(8) xor x(7) xor x(6) xor x(5) xor x(3) xor x(2);

 bcc_next(27) := m(32) xor x(28) xor x(27) xor x(26) xor x(25) xor x(24) xor x(23) xor x(20) xor x(16) xor x(15) xor x(14) xor x(11) xor x(9) xor x(7) xor x(6) xor x(5) xor x(4) xor x(2) xor x(1);

 bcc_next(26) := x(31) xor x(27) xor x(26) xor x(25) xor x(24) xor x(23) xor x(22) xor x(19) xor x(15) xor x(14) xor x(13) xor x(10) xor x(8) xor x(6) xor x(5) xor x(4) xor x(3) xor x(1) xor x(0);

 bcc_next(25) := m(32) xor m(36) xor x(31) xor x(29) xor x(28) xor x(27) xor x(26) xor x(25) xor x(23) xor x(22) xor x(21) xor x(20) xor x(19) xor x(15) xor x(14) xor x(12) xor x(11) xor x(10) xor x(8) xor x(7) xor x(6) xor x(4) xor x(3) xor x(2) xor x(1);

 bcc_next(24) := m(35) xor x(31) xor x(30) xor x(28) xor x(27) xor x(26) xor x(25) xor x(24) xor x(22) xor x(21) xor x(20) xor x(19) xor x(18) xor x(14) xor x(13) xor x(11) xor x(10) xor x(9) xor x(7) xor x(6) xor x(5) xor x(3) xor x(2) xor x(1) xor x(0);

 bcc_next(23) := m(32) xor m(34) xor m(36) xor x(31) xor x(28) xor x(26) xor x(25) xor x(23) xor x(21) xor x(17) xor x(15) xor x(12) xor x(11) xor x(4) xor x(2);

 bcc_next(22) := m(32) xor m(33) xor m(35) xor m(36) xor x(29) xor x(28) xor x(25) xor x(22) xor x(19) xor x(18) xor x(16) xor x(15) xor x(14) xor x(13) xor x(9) xor x(8) xor x(6) xor x(5) xor x(3) xor x(0);

 bcc_next(21) := m(34) xor m(35) xor m(36) xor x(30) xor x(29) xor x(21) xor x(20) xor x(19) xor x(17) xor x(14) xor x(12) xor x(11) xor x(10) xor x(9) xor x(7) xor x(6) xor x(4) xor x(2) xor x(1) xor x(0);

 bcc_next(20) := m(32) xor m(33) xor m(34) xor m(35) xor m(36) xor x(31) xor x(30) xor x(27) xor x(24) xor x(16) xor x(15) xor x(3);

 bcc_next(19) := m(32) xor m(33) xor m(34) xor m(35) xor x(31) xor x(30) xor x(29) xor x(26) xor x(23) xor x(15) xor x(14) xor x(2);

 bcc_next(18) := m(33) xor m(34) xor m(36) xor x(27) xor x(25) xor x(24) xor x(22) xor x(20) xor x(19) xor x(18) xor x(15) xor x(14) xor x(11) xor x(10) xor x(9) xor x(8) xor x(6) xor x(5) xor x(0);

 bcc_next(17) := m(33) xor m(35) xor m(36) xor x(31) xor x(30) xor x(29) xor x(28) xor x(27) xor x(26) xor x(23) xor x(21) xor x(20) xor x(17) xor x(15) xor x(14) xor x(11) xor x(7) xor x(6) xor x(4) xor x(1) xor x(0);

 bcc_next(16) := m(32) xor m(34) xor m(35) xor x(30) xor x(29) xor x(28) xor x(27) xor x(26) xor x(25) xor x(22) xor x(20) xor x(19) xor x(16) xor x(14) xor x(13) xor x(10) xor x(6) xor x(5) xor x(3) xor x(0);

 bcc_next(15) := m(33) xor m(34) xor x(31) xor x(29) xor x(28) xor x(27) xor x(26) xor x(25) xor x(24) xor x(21) xor x(19) xor x(18) xor x(15) xor x(13) xor x(12) xor x(9) xor x(5) xor x(4) xor x(2);

 bcc_next(14) := m(32) xor m(33) xor x(30) xor x(28) xor x(27) xor x(26) xor x(25) xor x(24) xor x(23) xor x(20) xor x(18) xor x(17) xor x(14) xor x(12) xor x(11) xor x(8) xor x(4) xor x(3) xor x(1);

 bcc_next(13) := m(36) xor x(30) xor x(28) xor x(26) xor x(25) xor x(23) xor x(22) xor x(20) xor x(18) xor x(17) xor x(16) xor x(15) xor x(9) xor x(8) xor x(7) xor x(6) xor x(5) xor x(3) xor x(2) xor x(1);

 bcc_next(12) := m(32) xor m(35) xor m(36) xor x(31) xor x(30) xor x(28) xor x(25) xor x(22) xor x(21) xor x(20) xor x(18) xor x(17) xor x(16) xor x(14) xor x(13) xor x(11) xor x(10) xor x(9) xor x(7) xor x(4) xor x(2);

 bcc_next(11) := m(32) xor m(34) xor m(35) xor m(36) xor x(28) xor x(21) xor x(18) xor x(17) xor x(16) xor x(12) xor x(11) xor x(5) xor x(3) xor x(0);

 bcc_next(10) := m(33) xor m(34) xor m(35) xor x(31) xor x(27) xor x(20) xor x(17) xor x(16) xor x(15) xor x(11) xor x(10) xor x(4) xor x(2);

 bcc_next(9) := m(33) xor m(34) xor m(36) xor x(31) xor x(29) xor x(28) xor x(27) xor x(26) xor x(24) xor x(20) xor x(18) xor x(16) xor x(14) xor x(13) xor x(11) xor x(8) xor x(6) xor x(5) xor x(3) xor x(0);

 bcc_next(8) := m(33) xor m(35) xor m(36) xor x(31) xor x(29) xor x(26) xor x(25) xor x(24) xor x(23) xor x(20) xor x(18) xor x(17) xor x(12) xor x(11) xor x(9) xor x(8) xor x(7) xor x(6) xor x(4) xor x(2) xor x(1) xor x(0);

 bcc_next(7) := m(32) xor m(34) xor m(35) xor x(30) xor x(28) xor x(25) xor x(24) xor x(23) xor x(22) xor x(19) xor x(17) xor x(16) xor x(11) xor x(10) xor x(8) xor x(7) xor x(6) xor x(5) xor x(3) xor x(1) xor x(0);

 bcc_next(6) := m(32) xor m(33) xor m(34) xor m(36) xor x(30) xor x(28) xor x(23) xor x(22) xor x(21) xor x(20) xor x(19) xor x(16) xor x(13) xor x(11) xor x(8) xor x(7) xor x(4) xor x(2) xor x(1);

 bcc_next(5) := m(33) xor m(35) xor m(36) xor x(30) xor x(28) xor x(24) xor x(22) xor x(21) xor x(13) xor x(12) xor x(11) xor x(9) xor x(8) xor x(7) xor x(5) xor x(3);

 bcc_next(4) := m(34) xor m(35) xor m(36) xor x(31) xor x(30) xor x(28) xor x(24) xor x(23) xor x(21) xor x(19) xor x(18) xor x(15) xor x(13) xor x(12) xor x(9) xor x(7) xor x(5) xor x(4) xor x(2) xor x(1) xor x(0);

 bcc_next(3) := m(32) xor m(33) xor m(34) xor m(35) xor m(36) xor x(31) xor x(28) xor x(24) xor x(23) xor x(22) xor x(19) xor x(17) xor x(15) xor x(14) xor x(13) xor x(12) xor x(10) xor x(9) xor x(5) xor x(4) xor x(3);

 bcc_next(2) := m(32) xor m(33) xor m(34) xor m(35) xor x(31) xor x(30) xor x(27) xor x(23) xor x(22) xor x(21) xor x(18) xor x(16) xor x(14) xor x(13) xor x(12) xor x(11) xor x(9) xor x(8) xor x(4) xor x(3) xor x(2);

 bcc_next(1) := m(32) xor m(33) xor m(34) xor x(31) xor x(30) xor x(29) xor x(26) xor x(22) xor x(21) xor x(20) xor x(17) xor x(15) xor x(13) xor x(12) xor x(11) xor x(10) xor x(8) xor x(7) xor x(3) xor x(2) xor x(1);

 bcc_next(0) := m(32) xor m(33) xor x(31) xor x(30) xor x(29) xor x(28) xor x(25) xor x(21) xor x(20) xor x(19) xor x(16) xor x(14) xor x(12) xor x(11) xor x(10) xor x(9) xor x(7) xor x(6) xor x(2) xor x(1) xor x(0);

 return bcc_next;

end crc_next;

function bit_revers8 ( din8 : in std_logic_vector(7 downto 0))
                   return  std_logic_vector is
  variable bit_rev8 : std_logic_vector(7 downto 0);
  begin
      bit_rev8(0) := din8(7);
      bit_rev8(1) := din8(6);
      bit_rev8(2) := din8(5);
      bit_rev8(3) := din8(4);
      bit_rev8(4) := din8(3);
      bit_rev8(5) := din8(2);
      bit_rev8(6) := din8(1);
      bit_rev8(7) := din8(0);

     return bit_rev8;
  end bit_revers8;

  constant cfg_Tprog : time := 300000 ps;   -- min PROG must be low, 300 ns
  constant cfg_Tpl : time :=   100000 ps;  -- max program latency us.
  constant STARTUP_PH0 : std_logic_vector(2 downto 0) := "000";
  constant STARTUP_PH1 : std_logic_vector(2 downto 0) := "001";
  constant STARTUP_PH2 : std_logic_vector(2 downto 0) := "010";
  constant STARTUP_PH3 : std_logic_vector(2 downto 0) := "011";
  constant STARTUP_PH4 : std_logic_vector(2 downto 0) := "100";
  constant STARTUP_PH5 : std_logic_vector(2 downto 0) := "101";
  constant STARTUP_PH6 : std_logic_vector(2 downto 0) := "110";
  constant STARTUP_PH7 : std_logic_vector(2 downto 0) := "111";
  signal GSR : std_ulogic := '1';
  signal GTS : std_ulogic := '1';
  signal GWE : std_ulogic := '0';
  signal cclk_in : std_ulogic;
  signal init_b_in : std_ulogic;
  signal prog_b_in : std_ulogic;
  signal rdwr_b_in : std_ulogic;
  signal init_b_out  : std_ulogic :=  '1';
  signal done_o  : std_ulogic :=  '0';
  signal por_b : std_ulogic := '0';
  signal m_in  : std_logic_vector (2 downto 0) ; 
  signal d_in  : std_logic_vector (31 downto 0) ; 
  signal d_out  : std_logic_vector (31 downto 0) ; 
  signal busy_out : std_ulogic;
  signal cso_b_out : std_ulogic;
  signal csi_b_in : std_ulogic;
  signal d_out_en : std_ulogic;
  signal dcm_locked : std_ulogic;
  signal init_b_t : std_ulogic;
  signal prog_b_t : std_ulogic;
  signal bus_en : std_ulogic;
  signal desync_flag : std_ulogic;
  signal crc_rst : std_ulogic;

  signal  prog_pulse_low_edge  : time :=  0 ps;
  signal  prog_pulse_low  : time :=  0 ps;
  signal  mode_sample_flag  : std_ulogic :=  '0';
  signal  buswid_flag_init  : std_ulogic :=  '0';
  signal  buswid_flag  : std_ulogic :=  '0';
  signal buswidth : std_logic_vector (1 downto 0) :=  "00"; 
  signal pack_in_reg : std_logic_vector (31 downto 0) :=  X"00000000";
  signal reg_addr  : std_logic_vector (4 downto 0) ; 
  signal  new_data_in_flag   : std_ulogic :=  '0';
  signal  wr_flag   : std_ulogic :=  '0';
  signal  rd_flag   : std_ulogic :=  '0';
  signal  cmd_wr_flag   : std_ulogic :=  '0';
  signal  cmd_reg_new_flag  : std_ulogic :=  '0';
  signal  cmd_rd_flag   : std_ulogic :=  '0';
  signal  bus_sync_flag  : std_ulogic :=  '0';
  signal  conti_data_flag  : std_ulogic :=  '0';
  signal  wr_cnt   : integer :=  0;
  signal  conti_data_cnt  : integer :=  0;
  signal  rd_data_cnt  : integer :=  0;
  signal  abort_cnt  : integer :=  0;
  signal st_state : std_logic_vector (2 downto 0) :=  STARTUP_PH0; 
  signal  startup_begin_flag  : std_ulogic :=  '0';
  signal  startup_end_flag  : std_ulogic :=  '0';
  signal  crc_ck  : std_ulogic :=  '0';
  signal crc_err_flag  : std_ulogic :=  '0';
  signal crc_err_flag_tot : std_ulogic;
  signal crc_err_flag_reg  : std_ulogic :=  '0';
  signal  crc_en : std_ulogic;
  signal crc_curr : std_logic_vector (31 downto 0) :=  X"00000000";
  signal  gwe_out  : std_ulogic :=  '0';
  signal  gts_out  : std_ulogic :=  '1';
  signal outbus : std_logic_vector (31 downto 0) :=  X"00000000";
  signal outbus1 : std_logic_vector (31 downto 0) :=  X"00000000";
  signal  busy_o  : std_ulogic :=  '0';
  signal tmp_val1  : std_logic_vector (31 downto 0) ; 
  signal ctl0_reg : std_logic_vector (31 downto 0) :=  "X0XXXXXXXXXXXXXXXXXXX001X0000XX1"; 
  signal cor0_reg : std_logic_vector (31 downto 0) :=  "00000X0000000000X011111111101100"; 
  signal cor1_reg : std_logic_vector (31 downto 0) :=  X"00000000";
  signal wbstar_reg : std_logic_vector (31 downto 0) :=  X"00000000";
  signal timer_reg : std_logic_vector (31 downto 0) :=  X"00000000";
  signal bootsts_reg : std_logic_vector (31 downto 0) :=  X"00000000";
  signal crc_reg  : std_logic_vector (31 downto 0) ; 
  signal far_reg  : std_logic_vector (31 downto 0) ; 
  signal fdri_reg  : std_logic_vector (31 downto 0) ; 
  signal mask_reg  : std_logic_vector (31 downto 0) ; 
  signal lout_reg  : std_logic_vector (31 downto 0) ; 
  signal mfwr_reg  : std_logic_vector (31 downto 0) ; 
  signal cbc_reg  : std_logic_vector (31 downto 0) ; 
  signal idcode_reg  : std_logic_vector (31 downto 0) ; 
  signal csob_reg  : std_logic_vector (31 downto 0) ; 
  signal ctl1_reg  : std_logic_vector (31 downto 0) ; 
  signal axss_reg  : std_logic_vector (31 downto 0) ; 
  signal cmd_reg  : std_logic_vector (4 downto 0) ; 
  signal mode_pin_in : std_logic_vector (2 downto 0) :=  "000"; 
  signal mode_reg  : std_logic_vector (2 downto 0) ; 
  signal  crc_reset  : std_ulogic :=  '0';
  signal  gsr_set  : std_ulogic :=  '0';
  signal  gts_usr_b  : std_ulogic :=  '1';
  signal  done_pin_drv  : std_ulogic :=  '0';
  
  signal  shutdown_set  : std_ulogic :=  '0';
  signal  desynch_set  : std_ulogic :=  '0';
  signal done_cycle_reg  : std_logic_vector (2 downto 0) ; 
  signal gts_cycle_reg  : std_logic_vector (2 downto 0) ; 
  signal gwe_cycle_reg  : std_logic_vector (2 downto 0) ; 
  signal  init_pin : std_ulogic;
  signal  init_rst  : std_ulogic :=  '0';
  signal  init_complete : std_ulogic; 
  signal nx_st_state : std_logic_vector (2 downto 0) :=  "000"; 
  signal  ghigh_b  : std_ulogic :=  '0';
  signal  gts_cfg_b  : std_ulogic :=  '0';
  signal  eos_startup  : std_ulogic :=  '0';
  signal startup_set  : std_ulogic :=  '0';
  signal startup_set_pulse : std_logic_vector (1 downto 0) :=  "00"; 
  signal abort_out_en  : std_ulogic :=  '0';
  signal tmp_dword  : std_logic_vector (31 downto 0) ; 
  signal id_error_flag  : std_ulogic :=  '0';
  signal iprog_b  : std_ulogic :=  '1';
  signal i_init_b_cmd  : std_ulogic :=  '1';
  signal i_init_b  : std_ulogic :=  '0';
  signal abort_flag_wr  : std_ulogic :=  '0';
  signal abort_flag_rd  : std_ulogic :=  '0';
  signal abort_status : std_logic_vector (7 downto 0) :=  "00000000"; 
  signal persist_en  : std_ulogic :=  '0';
  signal rst_sync  : std_ulogic :=  '0';
  signal abort_dis  : std_ulogic :=  '0';
  signal lock_cycle_reg : std_logic_vector (2 downto 0) :=  "000"; 
  signal rbcrc_no_pin  : std_ulogic :=  '0';
  signal abort_flag_rst  : std_ulogic :=  '0';
  signal gsr_st_out  : std_ulogic :=  '1'; 
  signal gsr_cmd_out  : std_ulogic :=  '0';
  signal gsr_cmd_out_pulse  : std_ulogic :=  '0';
  signal d_o_en  : std_ulogic :=  '0';
  signal stat_reg  : std_logic_vector (31 downto 0) ; 
  signal rst_intl : std_ulogic;
  signal rw_en : std_ulogic;
  signal gsr_out : std_ulogic;
  signal cfgerr_b_flag : std_ulogic;
  signal abort_flag : std_ulogic;
  signal downcont_cnt  : integer :=  0;
--  signal rst_en  : std_ulogic :=  '1';
  signal rst_en  : std_ulogic :=  '0';
  signal prog_b_a  : std_ulogic :=  '1';
  signal csbo_flag  : std_ulogic :=  '0';
  signal crc_bypass  : std_ulogic :=  '0';
  signal csi_sync  : std_ulogic :=  '0';
  signal rd_sw_en  : std_ulogic :=  '0';
  signal csbo_cnt  : integer :=  0;
  signal rd_reg_addr : std_logic_vector (4 downto 0) :=  "00000"; 
  signal init_b_p : std_ulogic :=  '0';
  signal done_in : std_ulogic :=  '0';
  
begin
   INITB <=  (not crc_err_flag_tot) when mode_sample_flag = '1' else init_b_out when init_b_out ='0' else 'H';

    DONE <= done_o;
    done_in <= DONE;

   BUSY <= busy_out;
   CSOB <= cso_b_out;
   cclk_in <= CCLK;
   csi_b_in <= CSB;

   d_in <= D;
   D <=  d_out when d_out_en = '1' else "HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH";
   dcm_locked <= DCMLOCK;

   init_b_in <= INITB;
   m_in <= M;
   prog_b_in <= PROGB;
   rdwr_b_in <= RDWRB;

        INIPROC : process
        begin
          if (DEVICE_ID = X"00000000") then
             assert FALSE report "Attribute Syntax Error : The attribute DEVICE_ID on  X_SIM_CONFIG_V5 is not set." severity error;
          end if;
          wait;
        end process;

    GSR <= gsr_out;
    GTS <= gts_out;
    GWE <= gwe_out;
    busy_out <= busy_o;
    cfgerr_b_flag <= rw_en  and   not crc_err_flag_tot;
    crc_err_flag_tot <= id_error_flag  or  crc_err_flag_reg;
    d_out(7 downto 0) <=  abort_status when (abort_out_en = '1') else outbus1(7 downto 0);
    d_out(31 downto 8) <=  X"000000" when (abort_out_en = '1') else outbus1(31 downto 8);
    d_out_en <= d_o_en;
    cso_b_out <= '0' when (csbo_flag= '1') else '1';
    crc_en <=  '1';


   outbus1_p : process(outbus)
   begin
      outbus1(7 downto 0) <= bit_revers8(outbus(7 downto 0));
      outbus1(15 downto 8) <= bit_revers8(outbus(15 downto 8));
      outbus1(23 downto 16) <= bit_revers8(outbus(23 downto 16));
      outbus1(31 downto 24) <= bit_revers8(outbus(31 downto 24));
   end process;

   process (csi_b_in, abort_flag) begin
        if (csi_b_in = '1')  then
           busy_o <= '1';
        else
          if (abort_flag = '1') then
            busy_o <= '1';
          else
            busy_o <= '0';
          end if;
        end if;
   end process;

   process (abort_out_en, csi_b_in, rdwr_b_in, rd_flag ) begin
    if (abort_out_en = '1') then
       d_o_en <= '1';
    else
       d_o_en <= rdwr_b_in  and  (not csi_b_in)  and  rd_flag;
    end if;
    end process;


   init_b_t <= init_b_in  and  i_init_b_cmd;

  process (rst_en, init_rst, prog_b_in, iprog_b)
  begin
   if (init_rst = '1') then
       init_b_out <= '0';
   else
     if ((rst_en = '1' and prog_b_in  =  '0') or iprog_b = '0' ) then
         init_b_out <= '0';
     elsif ((rst_en = '1' and prog_b_in  =  '1') or iprog_b = '1') then
         init_b_out <= '1' after cfg_Tpl;
     end if;
   end if;
--   wait on rst_en, init_rst, prog_b_in, iprog_b;
   end process;

  process  begin
     if  (rising_edge(id_error_flag)) then
      init_rst <= '1';
      init_rst <= '0' after cfg_Tprog;
     end if;
   wait on id_error_flag;
  end process;
  
    process  
    variable rst_en_v : std_ulogic;
    begin
      if (prog_b_in'event and prog_b_in = '0') then
         rst_en_v := '0';
         rst_en <= '0';
         wait for cfg_Tprog;
         wait for 1 ps;
         rst_en_v := '1';
         rst_en <= '1';
      end if;
    if (rst_en_v = '1') then
       if (prog_pulse_low  =  cfg_Tprog) then
           prog_b_a <= '0';
           prog_b_a <= '1' after 500 ps;
       else
          prog_b_a <= prog_b_in;
       end if;
    else 
          prog_b_a <= '1';
    end if;
     wait on prog_b_in, prog_pulse_low;
  end process;

   process begin
    por_b <= '0';
    por_b <= '1' after 400 ns;
    wait;
  end process; 

   prog_b_t <= prog_b_a   and  iprog_b  and  por_b;

   rst_intl <= '0' when (prog_b_t  =  '0' ) else '1';

  process (init_b_t, prog_b_t)
    variable Message : line;
  begin
   if (falling_edge (prog_b_t)) then
      mode_sample_flag <= '0';
   elsif (init_b_t'event and init_b_t = '1') then
      if (mode_sample_flag = '0') then
        if(prog_b_t = '1') then
           mode_pin_in <= m_in;
           mode_sample_flag <= '1' after 1 ps;
           if (m_in /= "110") then
              Write ( Message, string'(" Error: input M is "));
              Write ( Message, string'(SLV_TO_STR(m_in)));
              Write ( Message, string'(" . Only Slave SelectMAP mode M=110 supported on X_SIM_CONFIG_V5."));
              assert false report Message.all severity error;
              DEALLOCATE (Message);
           end if;
        elsif (NOW > 0 ps) then
            assert false report "Error: PROGB is not high when INITB goes high on X_SIM_CONFIG_V5." severity error;
       end if;
    end if;
   end if;
  end process;

  process (m_in) begin
    if (mode_sample_flag = '1' and persist_en = '1') then
       assert false report "Error : Mode pine M[2:0] changed after rising edge of INITB on X_SIM_CONFIG_V5." severity error;
    end if;
  end process;

  prog_pulse_P : process (prog_b_in)
     variable prog_pulse_low_v : time;
--     variable prog_pulse_low : time;
     variable Message : line;
  begin
    if (falling_edge (prog_b_in)) then
       prog_pulse_low_edge <= NOW;
    else
      if (NOW > 0 ps ) then
         prog_pulse_low_v := NOW - prog_pulse_low_edge;
         prog_pulse_low <= NOW - prog_pulse_low_edge;
         if (prog_pulse_low_v < cfg_Tprog ) then
             Write ( Message, string'(" Error: Low time of PROGB is less than required minimum Tprogram time "));
             Write ( Message, prog_pulse_low_v);
             Write ( Message, string'(" ."));
             assert false report Message.all severity error;
             DEALLOCATE(Message);
         end if;
      end if;
    end if;
  end process;

     bus_en <= '1' when (mode_sample_flag  =  '1'  and   csi_b_in  = '0') else '0';

    process (cclk_in,  rst_intl)
       variable tmp_byte : std_logic_vector (7 downto 0);
    begin
      if (rst_intl  = '0') then
         buswid_flag_init <= '0';
         buswid_flag <= '0';
         buswidth <= "00";
      elsif (rising_edge(cclk_in)) then
        if (buswid_flag  =  '0') then
           if (bus_en = '1'  and  rdwr_b_in  =  '0')  then
                 tmp_byte := bit_revers8(d_in(7 downto 0));
                 if (buswid_flag_init  =  '0') then
                     if (tmp_byte  =  X"BB") then
                         buswid_flag_init <= '1';
                     end if;
                  else 
                     if (tmp_byte  =  X"11") then
                         buswid_flag <= '1'; 
                         buswidth <= "01";
                     elsif (tmp_byte  =  X"22") then
                         buswid_flag <= '1'; 
                         buswidth <= "10";
                     elsif (tmp_byte  =  X"44") then
                         buswid_flag <= '1'; 
                         buswidth <= "11";
                     else 
                         buswid_flag <= '0'; 
                         buswidth <= "00";
                         buswid_flag_init <= '0';
             assert false report 
                         "Error : BUS Width Auto Dection did not find 0x11 or 0x22 or 0x44 on D(7:0) followed 0xBB on X_SIM_CONFIG_V5."
              severity error;
                     end if;
                 end if;
            end if;
         end if;
     end if;
     end process;
 
     rw_en <=  '1' when (bus_en  =  '1'  and  buswid_flag  =  '1') else '0';
     desync_flag <=  (not rst_intl)  or  desynch_set  or  crc_err_flag  or  id_error_flag;

   process (cclk_in) begin
   if (rising_edge(cclk_in)) then
       csi_sync <= csi_b_in;
     end if;
   end process;

   process (cclk_in, rdwr_b_in) begin
      if (rdwr_b_in = '0') then
           rd_sw_en <= '0';
      elsif (rising_edge(cclk_in)) then
           if (csi_sync = '1' and rdwr_b_in = '1') then
              rd_sw_en <= '1';
           end if;
      end if;
   end process;


    bus_sync_p : process (cclk_in, desync_flag)
      variable tmp_byte  : std_logic_vector (7 downto 0);
      variable tmp_word  : std_logic_vector (15 downto 0);
      variable tmp_dword  : std_logic_vector (31 downto 0);
    begin
      if (desync_flag = '1') then
          pack_in_reg <= X"00000000";
          new_data_in_flag <= '0';
          bus_sync_flag <= '0';
          wr_cnt <= 0;
          wr_flag <= '0';
          rd_flag <= '0';
      elsif (rising_edge(cclk_in)) then
       if (rw_en  =  '1' ) then
         if (rdwr_b_in  =  '0') then
           wr_flag <= '1';
           rd_flag <= '0';
           if (buswidth  =  "01") then
               tmp_byte := bit_revers8(d_in(7 downto 0));
               if (bus_sync_flag  =  '0') then
                  if (pack_in_reg(23 downto 16) = X"AA" and pack_in_reg(15 downto 8) = X"99"
                       and  pack_in_reg(7 downto 0)  =  X"55"  and  tmp_byte = X"66") then
                          bus_sync_flag <= '1';
                          new_data_in_flag <= '0';
                          wr_cnt <= 0;
                   else 
                      pack_in_reg(31 downto 24) <= pack_in_reg(23 downto 16);
                      pack_in_reg(23 downto 16) <= pack_in_reg(15 downto 8);
                      pack_in_reg(15 downto 8) <= pack_in_reg(7 downto 0);
                      pack_in_reg(7 downto 0) <= tmp_byte;
                   end if;
               else 
                 if (wr_cnt  =  0) then
                    pack_in_reg(31 downto 24) <= tmp_byte;
                     new_data_in_flag <= '0';
                     wr_cnt <=  1;
                 elsif (wr_cnt  =  1) then
                     pack_in_reg(23 downto 16) <= tmp_byte;
                     new_data_in_flag <= '0';
                     wr_cnt <= 2;
                 elsif (wr_cnt  =  2) then
                     pack_in_reg(15 downto 8) <= tmp_byte;
                     new_data_in_flag <= '0';
                     wr_cnt <= 3;
                 elsif (wr_cnt  =  3) then
                     pack_in_reg(7 downto 0) <= tmp_byte;
                     new_data_in_flag <= '1';
                     wr_cnt <= 0;
                 end if;
             end if;
           elsif (buswidth  =  "10") then
             tmp_word := bit_revers8(d_in(15 downto 8)) & bit_revers8(d_in(7 downto 0));
             if (bus_sync_flag  =  '0') then
                if (pack_in_reg(15 downto 0)  =  X"AA99"  and  tmp_word  = X"5566") then
                     wr_cnt <= 0;
                     bus_sync_flag <= '1';
                     new_data_in_flag <= '0';
                else 
                   pack_in_reg(31 downto 16) <= pack_in_reg(15 downto 0);
                   pack_in_reg(15 downto 0) <= tmp_word;
                   new_data_in_flag <= '0';
                   wr_cnt <= 0;
                end if;
             else 
               if (wr_cnt  =  0) then
                   pack_in_reg(31 downto 16) <= tmp_word;
                   new_data_in_flag <= '0';
                   wr_cnt <= 1;
               elsif (wr_cnt  =  1) then
                   pack_in_reg(15 downto 0) <= tmp_word;
                   new_data_in_flag <= '1';
                   wr_cnt <= 0;
               end if;
             end if;
           elsif (buswidth  =  "11" ) then
             tmp_dword := bit_revers8(d_in(31 downto 24)) & bit_revers8(d_in(23 downto 16)) &
                          bit_revers8(d_in(15 downto 8)) &  bit_revers8(d_in(7 downto 0));
             pack_in_reg(31 downto 0) <= tmp_dword;
             if (bus_sync_flag  =  '0') then
                if (tmp_dword  =  X"AA995566") then
                     bus_sync_flag <= '1';
                     new_data_in_flag <= '0';
                end if;
             else
                pack_in_reg(31 downto 0) <= tmp_dword;
                new_data_in_flag <= '1';
             end if;
           end if;  -- end buswidth check
       else 
            wr_flag <= '0';
            new_data_in_flag <= '0';
            if (rd_sw_en  = '1') then
               rd_flag <= '1';
            end if;
       end if; -- end rdwr check
     else 
            wr_flag <= '0';
            rd_flag <= '0';
            new_data_in_flag <= '0';
     end if;
   end if;
   end process;
           
   pack_decode_p :  process (cclk_in, rst_intl)
      variable tmp_v : std_logic_vector(5 downto 0);
      variable tmp_v27 : std_logic_vector(26 downto 0);
      variable tmp_v11 : std_logic_vector(10 downto 0);
      variable tmp_v1 : std_logic_vector(27 downto 0);
      variable tmp_v2 : std_logic_vector(31 downto 0);
      variable tmp_v3 : std_logic_vector(27 downto 0);
      variable message_line : line;
--      variable csbo_cnt : integer := 0;
      variable crc_new : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
      variable crc_input : std_logic_vector(36 downto 0) := "0000000000000000000000000000000000000";
   begin
      if (rst_intl  = '0') then
         conti_data_flag <= '0';
         conti_data_cnt <= 0;
         cmd_wr_flag <= '0';
         cmd_rd_flag <= '0';
         id_error_flag <= '0';
         crc_curr <= X"00000000";
         crc_ck <= '0';
         csbo_cnt <= 0;
         csbo_flag <= '0';
         downcont_cnt <= 0;
         rd_data_cnt <= 0;
      elsif (falling_edge(cclk_in)) then
        if (crc_reset  =  '1' ) then
            crc_reg <= X"00000000";
            crc_ck <= '0';
            crc_curr <= X"00000000";
        end if;
        if (crc_ck  =  '1') then
             crc_curr <= X"00000000";
        end if;
        if (desynch_set = '1'  or  crc_err_flag = '1') then
           conti_data_flag <= '0';
           conti_data_cnt <= 0;
           cmd_wr_flag <= '0';
           cmd_rd_flag <= '0';
           cmd_reg_new_flag <= '0';
           crc_ck <= '0';
           csbo_cnt <= 0;
           csbo_flag <= '0';
           downcont_cnt <= 0;
           rd_data_cnt <= 0;
        end if;

        if (new_data_in_flag = '1'  and  wr_flag = '1') then
           if (conti_data_flag  =  '1' ) then
               case (reg_addr) is
               when "00000" =>  crc_reg <= pack_in_reg;
                                crc_ck <= '1';
               when "00001" => far_reg <= pack_in_reg;
               when "00010" => fdri_reg <= pack_in_reg;
               when "00100" => cmd_reg <= pack_in_reg(4 downto 0);
               when "00101" => ctl0_reg <= (pack_in_reg and mask_reg) or (ctl0_reg and not mask_reg);
               when "00110" => mask_reg <= pack_in_reg;
               when "01000" => lout_reg <= pack_in_reg;
               when "01001" => cor0_reg <= pack_in_reg;
               when "01010" => mfwr_reg <= pack_in_reg;
--               when "01101" => cbc_reg <= pack_in_reg;
               when "01100" => idcode_reg <= pack_in_reg;
                          tmp_v1 := pack_in_reg(27 downto 0);
                          tmp_v2 := TO_STDLOGICVECTOR(DEVICE_ID);
                          tmp_v3 := tmp_v2(27 downto 0);
--                          if (pack_in_reg(27 downto 0)  /=  DEVICE_ID(27 downto 0)) then
                          if (tmp_v1  /=  tmp_v3) then
                             id_error_flag <= '1';
                                write(message_line, string'("Error : written value to IDCODE register is "));
                                write(message_line, string'(SLV_TO_STR(tmp_v1)));
                                write(message_line, string'(" which does not match DEVICE ID "));
                                write(message_line, string'(SLV_TO_STR(tmp_v2)));
                                write(message_line, string'("."));
                                assert false report message_line.all  severity error;
                                DEALLOCATE(message_line);
                          else
                             id_error_flag <= '0';
                          end if;
               when "01101" => axss_reg <= pack_in_reg;
               when "01110" => cor1_reg <= pack_in_reg;
               when "01111" => csob_reg <= pack_in_reg;
               when "10000" => wbstar_reg <= pack_in_reg;
               when "10001" => timer_reg <= pack_in_reg;
               when "11000" => ctl1_reg <= (pack_in_reg and mask_reg) or (ctl1_reg and not mask_reg);
               when others => NULL;
               end case;
   
             if (reg_addr  /=  "00000") then
                crc_ck <= '0';
             end if;

             if (reg_addr  =  "00100") then
                  cmd_reg_new_flag <= '1';
             else
                 cmd_reg_new_flag <= '0';
             end if;

             if (crc_en  =  '1')  then
               if (reg_addr  = "00100"  and  pack_in_reg(4 downto 0)  =  "00111") then
                   crc_curr(31 downto 0) <= X"00000000";
               else 
                  if ( reg_addr /= "00011" and reg_addr /= "00111" and reg_addr /= "10110" and 
                    reg_addr /= "01000" and reg_addr /= "00000") then
                     crc_input(36 downto 0) := reg_addr(4 downto 0) & pack_in_reg(31 downto 0); 
                     crc_new(31 downto 0) := crc_next(crc_curr, crc_input);
                     crc_curr(31 downto 0) <= crc_new;
                   end if;
               end if;
             end if;

             if (conti_data_cnt = 1) then
                  conti_data_cnt <= 0;
             else 
                conti_data_cnt <= conti_data_cnt - 1;
             end if;
        elsif (conti_data_flag  =  '0' ) then
            if ( downcont_cnt >= 1) then
                   if (crc_en  =  '1') then
                     crc_input(36 downto 0) :=  "00010" & pack_in_reg; 
                     crc_new(31 downto 0) := crc_next(crc_curr, crc_input);
                     crc_curr(31 downto 0) <= crc_new;
                   end if;
             end if;
       
             if (pack_in_reg(31 downto 29)  =  "010"  and  downcont_cnt  =  0  ) then
                cmd_rd_flag <= '0';
                cmd_wr_flag <= '0';
                conti_data_flag <= '0';
                conti_data_cnt <= 0;
                tmp_v27 := pack_in_reg(26 downto 0);
                downcont_cnt <= SLV_TO_INT(SLV=>tmp_v27);
             elsif (pack_in_reg(31 downto 29)  =  "001") then
                if (pack_in_reg(28 downto 27)  =  "01"  and  downcont_cnt  =  0) then
                    if (pack_in_reg(10 downto 0)  /=  "00000000000") then
                       cmd_rd_flag <= '1';
                       cmd_wr_flag <= '0';
                       rd_data_cnt <= 4;
                       conti_data_cnt <= 0;
                       conti_data_flag <= '0';
                       rd_reg_addr <= pack_in_reg(17 downto 13);
                    end if;
                elsif (pack_in_reg(28 downto 27)  =  "10"  and  downcont_cnt  =  0) then
                   if (pack_in_reg(17 downto 13)  =  "01111")   then
                           csob_reg <= pack_in_reg;
                           csbo_cnt <= SLV_TO_INT(SLV=>pack_in_reg(10 downto 0));
                           csbo_flag <= '1';
                           conti_data_flag <= '0';
                           reg_addr <= pack_in_reg(17 downto 13);
                           cmd_wr_flag <= '1';
                           conti_data_cnt <= 0;
                    elsif (pack_in_reg(10 downto 0)  /=  "00000000000") then
                       cmd_rd_flag <= '0';
                       cmd_wr_flag <= '1';
                       conti_data_flag <= '1';
                       tmp_v11 := pack_in_reg(10 downto 0);
                       conti_data_cnt <= SLV_TO_INT(SLV=>tmp_v11);
                       reg_addr <= pack_in_reg(17 downto 13);
                    end if;
                else 
                    cmd_wr_flag <= '0';
                    conti_data_flag <= '0';
                    conti_data_cnt <= 0;
                end if;
             end if;
             cmd_reg_new_flag <= '0';
             crc_ck <= '0';
          end  if;  -- if (conti_data_flag  =  '0' ) 
          if (csbo_cnt  /=  0 ) then
             if (csbo_flag  =  '1') then
              csbo_cnt <= csbo_cnt - 1;
             end if;
          else
              csbo_flag <= '0';
          end if;

          if (conti_data_cnt  =  1 )  then
                conti_data_flag <= '0';
          end if;

      end if;

      if (rw_en  = '1') then
         if (rd_data_cnt  =  1 and  rd_flag  =  '1')  then
            rd_data_cnt <= 0;
         elsif (rd_data_cnt  =  0  and  rd_flag  =  '1') then
               cmd_rd_flag <= '0';
         elsif (cmd_rd_flag  = '1'   and  rd_flag  =  '1') then
             rd_data_cnt <= rd_data_cnt - 1;
         end if;

          if (downcont_cnt >= 1 and conti_data_flag = '0' and new_data_in_flag = '1' and wr_flag = '1') then
              downcont_cnt <= downcont_cnt - 1;
          end if;
      end if;

     if (crc_ck = '1') then
         crc_ck <= '0';
     end if;
    end if;
    end  process;

   rd_back_p : process ( cclk_in, rst_intl) begin
    if (rst_intl  = '0') then
         outbus <= X"00000000";
    elsif (rising_edge(cclk_in)) then
        if (cmd_rd_flag  =  '1'  and  rdwr_b_in  =  '1'  and  csi_b_in  =  '0') then
               case (rd_reg_addr) is
               when "00000" => if (buswidth = "01") then 
                              outbus(31 downto 8) <= X"000000";
                          if (rd_data_cnt = 1)  then
                             outbus(7 downto 0) <= crc_reg(7 downto 0);
                          elsif (rd_data_cnt = 2)  then
                             outbus(7 downto 0) <= crc_reg(15 downto 8);
                          elsif (rd_data_cnt = 3)  then
                             outbus(7 downto 0) <= crc_reg(23 downto 16);
                          elsif (rd_data_cnt = 4)  then
                             outbus(7 downto 0) <= crc_reg(31 downto 24);
                          end if;
                             elsif (buswidth = "10") then
                              outbus(31 downto 16) <= X"0000";
                          if (rd_data_cnt = 1)  then
                             outbus(15 downto 0) <= crc_reg(15 downto 0);
                          elsif (rd_data_cnt = 2)  then
                             outbus(15 downto 0) <= crc_reg(31 downto 16);
                          elsif (rd_data_cnt = 3)  then
                             outbus(15 downto 0) <= X"00FF";
                          elsif (rd_data_cnt = 4)  then
                             outbus(15 downto 0) <= X"00FF";
                          end if;
                            elsif (buswidth = "11") then
                          if (rd_data_cnt = 1)  then
                             outbus <= crc_reg;
                          elsif (rd_data_cnt = 2)  then
                             outbus <= X"000000FF";
                          elsif (rd_data_cnt = 3)  then
                             outbus <= X"000000FF";
                          elsif (rd_data_cnt = 4)  then
                             outbus <= X"000000FF";
                          end if;
                            end if;
               when "00111" => if (buswidth = "01") then
                             outbus(31 downto 8) <= X"000000";
                          if (rd_data_cnt = 1)  then
                             outbus(7 downto 0) <= stat_reg(7 downto 0);
                          elsif (rd_data_cnt = 2) then
                             outbus(7 downto 0) <= stat_reg(15 downto 8);
                          elsif (rd_data_cnt = 3) then
                             outbus(7 downto 0) <= stat_reg(23 downto 16);
                          elsif (rd_data_cnt = 4) then
                             outbus(7 downto 0) <= stat_reg(31 downto 24);
                          end if;
                             elsif (buswidth = "10") then
                              outbus(31 downto 16) <= X"0000";
                          if (rd_data_cnt = 1)  then
                             outbus(15 downto 0) <= stat_reg(15 downto 0);
                          elsif (rd_data_cnt = 2) then
                             outbus(15 downto 0) <= stat_reg(31 downto 16);
                          elsif (rd_data_cnt = 3) then
                             outbus(15 downto 0) <= X"00FF";
                          elsif (rd_data_cnt = 4) then
                             outbus(15 downto 0) <=  X"00FF";
                          end if;
                             elsif (buswidth = "11") then
                          if (rd_data_cnt = 1)  then
                             outbus <= stat_reg;
                          elsif (rd_data_cnt = 2)  then
                             outbus <= X"000000FF";
                          elsif (rd_data_cnt = 3)  then
                             outbus <= X"000000FF";
                          elsif (rd_data_cnt = 4)  then
                             outbus <= X"000000FF";
                          end if;
                              end if;
               when "01100" => if (buswidth = "01") then
                              outbus(31 downto 8) <= X"000000";
                          if (rd_data_cnt = 1) then
                             outbus(7 downto 0) <= idcode_reg(7 downto 0);
                          elsif (rd_data_cnt = 2) then
                             outbus(7 downto 0) <= idcode_reg(15 downto 8);
                          elsif (rd_data_cnt = 3) then
                             outbus(7 downto 0) <= idcode_reg(23 downto 16);
                          elsif (rd_data_cnt = 4) then
                             outbus(7 downto 0) <= idcode_reg(31 downto 24);
                          end if;
                             elsif (buswidth = "10") then
                              outbus(31 downto 16) <= X"0000";
                          if (rd_data_cnt = 1) then
                             outbus(15 downto 0) <= idcode_reg(15 downto 0);
                          elsif (rd_data_cnt = 2) then
                             outbus(15 downto 0) <= idcode_reg(31 downto 16);
                          elsif (rd_data_cnt = 3) then
                             outbus(15 downto 0) <= X"00FF";
                          elsif (rd_data_cnt = 4) then
                             outbus(15 downto 0) <= X"00FF";
                          end if;
                             elsif (buswidth = "11") then
                          if (rd_data_cnt = 1) then
                             outbus <= idcode_reg;
                          elsif (rd_data_cnt = 2) then
                             outbus <= X"000000FF";
                          elsif (rd_data_cnt = 3) then
                             outbus <= X"000000FF";
                          elsif (rd_data_cnt = 4) then
                             outbus <= X"000000FF";
                          end if;
                             end if;
               when others => NULL;
               end case;
       else
             outbus <= X"00000000";
       end if;
    end if;
   end process;

     crc_rst <= crc_reset  or   not rst_intl;

    process ( cclk_in,  crc_rst ) begin
     if (crc_rst = '1') then
         crc_err_flag <= '0';
     elsif (rising_edge(cclk_in)) then
        if (crc_ck = '1') then
          if (crc_bypass = '1') then
             if (crc_reg(15 downto 0)  /=  X"DEFC")  then
                 crc_err_flag <= '1';
             else
                 crc_err_flag <= '0';
             end if;
          else 
            if (crc_curr(31 downto 0)  /=  crc_reg(31 downto 0))  then
                crc_err_flag <= '1';
            else
                 crc_err_flag <= '0';
            end if;
          end if;
       else
           crc_err_flag <= '0';
       end if;
    end if;
    end process;

    process ( crc_err_flag,  rst_intl,  bus_sync_flag) begin
     if (rst_intl  =  '0') then
         crc_err_flag_reg <= '0';
     elsif (rising_edge(crc_err_flag)) then
         crc_err_flag_reg <= '1';
     elsif (rising_edge(bus_sync_flag)) then
         crc_err_flag_reg <= '0';
     end if;
    end process;


    process (cclk_in, rst_intl) begin
    if (rst_intl  = '0') then
         startup_set <= '0';
         crc_reset  <= '0';
         gsr_cmd_out <= '0';
         shutdown_set <= '0';
         desynch_set <= '0';
         ghigh_b <= '0';
    elsif (rising_edge(cclk_in)) then
    if (cmd_reg_new_flag  = '1') then
      if (cmd_reg  =  "00011")  then
          ghigh_b <= '1';
      elsif (cmd_reg  =  "01000") then
           ghigh_b <= '0';
      end if;

      if (cmd_reg  =  "00101") then
           startup_set <= '1';
      end if;

      if (cmd_reg  =  "00111")  then
           crc_reset <= '1';
      end if;

      if (cmd_reg  =  "01010")  then
           gsr_cmd_out <= '1';
      end if;

      if (cmd_reg  =  "01011") then
           shutdown_set <= '1';
      end if;

      if (cmd_reg  =  "01101")  then
           desynch_set <= '1';
      end if;

      if (cmd_reg  =  "01111") then
          iprog_b <= '0';
          i_init_b_cmd <= '0';
          iprog_b <= '1' after cfg_Tprog;
          i_init_b_cmd <= '1' after (cfg_Tprog + cfg_Tpl);
      end if;
    else 
             startup_set <= '0';
              crc_reset <= '0';
              gsr_cmd_out <= '0';
              shutdown_set <= '0';
              desynch_set <= '0';
    end if;
    end if;
   end process;

   startup_set_pulse_p : process  begin
    if (rw_en  =  '1') then
--       startup_set_pulse <= "00";
    if (rising_edge(startup_set)) then
      if (startup_set_pulse  =  "00") then
         startup_set_pulse <= "01";
      end if;
    elsif (rising_edge(desynch_set)) then
      if (startup_set_pulse  =  "01") then
          startup_set_pulse <= "11";
          wait until (rising_edge(cclk_in ));
          startup_set_pulse <= "00";
      end if;
     end if;
    end if;
      wait on startup_set, desynch_set, rw_en;
    end process;


   gsr_cmd_out_pulse_p :  process  begin
    if (rw_en  =  '1') then
--       gsr_cmd_out_pulse <= '0';
    if (rising_edge(gsr_cmd_out)) then
       gsr_cmd_out_pulse <= '1';
       wait until (rising_edge(cclk_in ));
       wait until (rising_edge(cclk_in ));
       gsr_cmd_out_pulse <=  '0';
    end if;
    end if;
      wait on gsr_cmd_out, rw_en;
   end process;


    process (ctl0_reg) begin
      if (ctl0_reg(9)  =  '1') then
         abort_dis <= '1';
      else
         abort_dis <= '0';
      end if;
      if (ctl0_reg(3)  =  '1') then
         persist_en <= '1';
      else
         persist_en <= '0';
      end if;
      if (ctl0_reg(0)  =  '1') then
         gts_usr_b <= '1';
      else
         gts_usr_b <= '0';
      end if;
    end process;

    process (cor0_reg) 
    begin
      done_cycle_reg <= cor0_reg(14 downto 12);
      lock_cycle_reg <= cor0_reg(8 downto 6);
      gts_cycle_reg <= cor0_reg(5 downto 3);
      gwe_cycle_reg <= cor0_reg(2 downto 0);

     if (cor0_reg(24)  =  '1') then
         done_pin_drv <= '1';
      else
         done_pin_drv <= '0';
      end if;
      if (cor0_reg(28)  =  '1') then
         crc_bypass <= '1';
      else
         crc_bypass <= '0';
      end if;
    end process;

    process (cor1_reg) begin
       rbcrc_no_pin <= cor1_reg(8);
    end process;

     stat_reg(26 downto 25) <= buswidth;
     stat_reg(20 downto 18) <= st_state;
     stat_reg(16) <= '0';
     stat_reg(15) <= id_error_flag;
     stat_reg(14) <= DONE;
     stat_reg(13) <= '1' when (done_o /=  '0') else '0';
     stat_reg(12) <= INITB;
     stat_reg(11) <= mode_sample_flag;
     stat_reg(10 downto 8) <= mode_pin_in;
     stat_reg(7) <= ghigh_b;
     stat_reg(6) <= gwe_out;
     stat_reg(5) <= gts_cfg_b;
     stat_reg(4) <= eos_startup;
     stat_reg(3) <= 'X';
     stat_reg(2) <= dcm_locked;
     stat_reg(1) <= 'X';
     stat_reg(0) <= crc_err_flag_reg; 


    st_state_p : process ( cclk_in, rst_intl) begin
      if (rst_intl  =  '0') then
        st_state <= STARTUP_PH0;
        startup_begin_flag <= '0';
        startup_end_flag <= '0';
      elsif (rising_edge(cclk_in)) then
           if (nx_st_state  =  STARTUP_PH1) then
              startup_begin_flag <= '1';
              startup_end_flag <= '0';
           elsif (st_state  =  STARTUP_PH7) then
              startup_end_flag <= '1';
              startup_begin_flag <= '0';
           end if;
           if  ((lock_cycle_reg = "111") or (dcm_locked  =  '1') or (st_state /= lock_cycle_reg)) then
                st_state <= nx_st_state;
           else
              st_state <= st_state;
           end if;
      end if;
     end process;

    nx_st_state_p : process (st_state, startup_set_pulse, done_in ) begin
    if ((( st_state  =  done_cycle_reg) and (done_in /= '0')) or ( st_state /= done_cycle_reg)) then
      case (st_state) is
      when STARTUP_PH0  =>      if (startup_set_pulse  =  "11" ) then
                                     nx_st_state <= STARTUP_PH1;
                                else
                                     nx_st_state <= STARTUP_PH0;
                                end if;
      when STARTUP_PH1  =>      nx_st_state <= STARTUP_PH2;

      when STARTUP_PH2  =>      nx_st_state <= STARTUP_PH3;

      when STARTUP_PH3  =>      nx_st_state <= STARTUP_PH4;

      when STARTUP_PH4  =>      nx_st_state <= STARTUP_PH5;

      when STARTUP_PH5  =>      nx_st_state <= STARTUP_PH6;

      when STARTUP_PH6  =>      nx_st_state <= STARTUP_PH7;

      when STARTUP_PH7  =>      nx_st_state <= STARTUP_PH0;
      when others => NULL;
      end case;
   end if;
   end process;

    start_out_p : process ( cclk_in, rst_intl ) begin
      if (rst_intl  =  '0') then
          gwe_out <= '0';
          gts_out <= '1';
          eos_startup <= '0';
          gsr_st_out <= '1';
          done_o <= '0';
      elsif (rising_edge(cclk_in)) then

         if (nx_st_state  =  done_cycle_reg) then
            if (done_in  /=  '0' or done_pin_drv = '1') then
               done_o <= '1';
            else
               done_o <= 'H';
            end if;
         else
             if (done_in  /=  '0') then
                     done_o <= '1';
             end if;
         end if;
         
         if (st_state  =  gwe_cycle_reg  and  DONE  /=  '0')   then
             gwe_out <= '1';
         end if;   
         if (st_state  =  gts_cycle_reg  and  DONE  /=  '0')   then
             gts_out <= '0';
         end if;   
         if (st_state  =  STARTUP_PH6  and  DONE  /=  '0') then
             gsr_st_out <= '0';
         end if;
         if (st_state  =  STARTUP_PH7  and  DONE  /=  '0')  then
            eos_startup <= '1';
         end if; 
      end if;
    end process;
      
      gsr_out <= gsr_st_out  or  gsr_cmd_out;

    process (rdwr_b_in ,  rst_intl, abort_flag_rst , csi_b_in)
    begin
      if (rst_intl = '0'  or  abort_flag_rst = '1'  or  csi_b_in  =  '1') then
          abort_flag_wr <= '0';
      elsif (rising_edge(rdwr_b_in)) then
        if (abort_dis  =  '0'  and  csi_b_in  =  '0') then
             if (NOW  /=  0 ps) then
               abort_flag_wr <= '1';
               assert false report " Warning : RDWRB changes when CS_B low, which causes Configuration abort on X_SIM_CONFIG_V5."
               severity warning;
             end if;
        else
           abort_flag_wr <= '0';
        end if;
     end if;
    end process;
     

    process ( rdwr_b_in,  rst_intl,  abort_flag_rst,  csi_b_in) begin
      if (rst_intl = '0'  or   csi_b_in  =  '1'  or  abort_flag_rst = '1') then
          abort_flag_rd <= '0';
      elsif (falling_edge(rdwr_b_in)) then
       if (abort_dis  =  '0'  and  csi_b_in  =  '0') then
         if (NOW  /=  0 ps) then
          abort_flag_rd <= '1';
          assert false report " Warning :  RDWRB changes when CS_B low, which causes Configuration abort on X_SIM_CONFIG_V5."
          severity warning;
         end if;
       else
         abort_flag_rd <= '0';
       end if;
     end if;
    end process;

     abort_flag <= abort_flag_wr  or  abort_flag_rd;

    process ( cclk_in,  rst_intl) begin
      if (rst_intl  =  '0') then
         abort_cnt <= 0;
         abort_out_en <= '0';
      elsif (rising_edge(cclk_in)) then
         if ( abort_flag  = '1' ) then
             if (abort_cnt < 4) then
                 abort_cnt <= abort_cnt + 1;
                 abort_out_en <= '1';
             else
                abort_flag_rst <= '1';
             end if;
         else
                abort_cnt <=  0;
                abort_out_en <= '0';
                abort_flag_rst <= '0';
         end if;

         if (abort_cnt =  0) then
            abort_status <= (cfgerr_b_flag & bus_sync_flag &  "011111");
            abort_status <= (cfgerr_b_flag & bus_sync_flag &  "011111");
         elsif (abort_cnt =  1) then
            abort_status <= (cfgerr_b_flag & "1001111");
         elsif (abort_cnt =  2) then
            abort_status <= (cfgerr_b_flag & "0001111");
         elsif (abort_cnt =  3) then
            abort_status <= (cfgerr_b_flag & "0011111");
         end if;
      end if;
    end process;
         
end X_SIM_CONFIG_V5_V;
