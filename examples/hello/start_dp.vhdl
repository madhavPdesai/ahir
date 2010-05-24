
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.types.all;
use ahir.components.all;
use ahir.subprograms.all;
use ahir.LoadStorePack.all;

entity start_dp is
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
end start_dp;

architecture default_arch of start_dp is

  -- wrapper wires
  signal wrapper_0_ack : BooleanArray(2 downto 0);
  signal wrapper_0_data : StdLogicArray2D(2 downto 0, 31 downto 0);
  signal wrapper_0_req : BooleanArray(2 downto 0);
  signal dpe_12_data : StdLogicArray2D(0 downto 0, 15 downto 0);
  signal dpe_15_data : StdLogicArray2D(0 downto 0, 31 downto 0);
  signal dpe_4_data : StdLogicArray2D(0 downto 0, 31 downto 0);

  signal wrapper_1_ack : BooleanArray(1 downto 0);
  signal wrapper_1_data : StdLogicArray2D(1 downto 0, 31 downto 0);
  signal wrapper_1_req : BooleanArray(1 downto 0);
  signal dpe_18_data : StdLogicArray2D(0 downto 0, 31 downto 0);
  signal dpe_9_data : StdLogicArray2D(0 downto 0, 15 downto 0);

  signal wrapper_2_ack : BooleanArray(1 downto 0);
  signal wrapper_2_addr : APIntArray(1 downto 0, 7 downto 0);
  signal wrapper_2_data : StdLogicArray2D(1 downto 0, 31 downto 0);
  signal wrapper_2_req : BooleanArray(1 downto 0);
  signal wrapper_3_ack : BooleanArray(2 downto 0);
  signal wrapper_3_addr : APIntArray(2 downto 0, 7 downto 0);
  signal wrapper_3_req : BooleanArray(2 downto 0);
  signal wrapper_4_ack : BooleanArray(1 downto 0);
  signal wrapper_4_addr : APIntArray(1 downto 0, 7 downto 0);
  signal wrapper_4_req : BooleanArray(1 downto 0);

  -- element wires
  signal wire_6 : APIntArray(0 downto 0, 7 downto 0);
  signal wire_8 : APIntArray(0 downto 0, 7 downto 0);
  signal wire_10 : APIntArray(0 downto 0, 7 downto 0);
  signal wire_12 : APIntArray(0 downto 0, 7 downto 0);
  signal dpe_2_data : StdLogicArray2D(0 downto 0, 0 downto 0);
  signal wire_13 : APFloatArray(0 downto 0, 8 downto -23);
  signal wire_14 : APIntArray(0 downto 0, 7 downto 0);
  signal dpe_23_z : APInt(15 downto 0);
  signal wire_16 : APIntArray(0 downto 0, 15 downto 0);
  signal wire_17 : APIntArray(0 downto 0, 15 downto 0);
  signal wire_18 : APIntArray(0 downto 0, 7 downto 0);
  signal wire_2 : APIntArray(0 downto 0, 7 downto 0);
  signal wire_3 : APIntArray(0 downto 0, 0 downto 0);
  signal wire_4 : APIntArray(0 downto 0, 31 downto 0);

  -- other wires
  signal dpe_1_condition : APInt(0 downto 0);
  signal dpe_21_data : StdLogicArray2D(0 downto 0, 31 downto 0);
  signal dpe_23_x : APInt(15 downto 0);
  signal dpe_23_y : APInt(15 downto 0);
  signal dpe_26_data : StdLogicArray2D(0 downto 0, 15 downto 0);
  signal dpe_28_data : StdLogicArray2D(0 downto 0, 0 downto 0);
  signal dpe_28_data_0 : std_logic_vector(0 downto 0);
  signal dpe_2_data_0 : std_logic_vector(0 downto 0);
  signal wire_1 : APIntArray(0 downto 0, 31 downto 0);
  signal wire_11 : APFloatArray(0 downto 0, 8 downto -23);
  signal wire_15 : APIntArray(0 downto 0, 15 downto 0);
  signal wire_5 : APIntArray(0 downto 0, 15 downto 0);
  signal wire_7 : APIntArray(0 downto 0, 15 downto 0);
  signal wire_9 : APFloatArray(0 downto 0, 8 downto -23);

begin

  --  wrapper: wrapper_0
  --    dpe: dpe_12
  wire_7 <= To_APIntArray(dpe_12_data);
  --    dpe: dpe_15
  wire_9 <= To_APFloatArray(dpe_15_data);
  --    dpe: dpe_4
  wire_1 <= To_APIntArray(dpe_4_data);

  SigmaOut(11) <= wrapper_0_ack(2);
  SigmaOut(13) <= wrapper_0_ack(1);
  SigmaOut(5) <= wrapper_0_ack(0);

  dpe_12_data <= to_StdLogicArray2D(extract(wrapper_0_data, 2)(15 downto 0));
  dpe_15_data <= to_StdLogicArray2D(extract(wrapper_0_data, 1)(31 downto 0));
  dpe_4_data <= to_StdLogicArray2D(extract(wrapper_0_data, 0)(31 downto 0));

  wrapper_0_req(2) <= SigmaIn(10);
  wrapper_0_req(1) <= SigmaIn(12);
  wrapper_0_req(0) <= SigmaIn(4);

  wrapper_0 : ApLoadComplete -- LoadComplete
  -- configuration: 
  -- counterpart: wrapper_3
    generic map(
      width => (2, 4, 4))
    port map(
      ack => wrapper_0_ack,
      clk => clk,
      data => wrapper_0_data,
      mack => lc_ack(3 downto 0),
      mdata => lc_data(31 downto 0),
      mreq => lc_req(3 downto 0),
      mtag => lc_tag(31 downto 0),
      req => wrapper_0_req,
      reset => reset);

  --  wrapper: wrapper_1
  --    dpe: dpe_18
  wire_11 <= To_APFloatArray(dpe_18_data);
  --    dpe: dpe_9
  wire_5 <= To_APIntArray(dpe_9_data);

  SigmaOut(15) <= wrapper_1_ack(1);
  SigmaOut(9) <= wrapper_1_ack(0);

  dpe_18_data <= to_StdLogicArray2D(extract(wrapper_1_data, 1)(31 downto 0));
  dpe_9_data <= to_StdLogicArray2D(extract(wrapper_1_data, 0)(15 downto 0));

  wrapper_1_req(1) <= SigmaIn(14);
  wrapper_1_req(0) <= SigmaIn(8);

  wrapper_1 : ApLoadComplete -- LoadComplete
  -- configuration: 
  -- counterpart: wrapper_4
    generic map(
      width => (4, 2))
    port map(
      ack => wrapper_1_ack,
      clk => clk,
      data => wrapper_1_data,
      mack => lc_ack(7 downto 4),
      mdata => lc_data(63 downto 32),
      mreq => lc_req(7 downto 4),
      mtag => lc_tag(63 downto 32),
      req => wrapper_1_req,
      reset => reset);

  --  wrapper: wrapper_2
  --    dpe: dpe_21
  dpe_21_data <= To_StdLogicArray2D(wire_13);
  --    dpe: dpe_26
  dpe_26_data <= To_StdLogicArray2D(wire_17);

  SigmaOut(18) <= wrapper_2_ack(1);
  SigmaOut(22) <= wrapper_2_ack(0);

  unflatten(wrapper_2_addr, 
    zero_pad(extract(wire_14, 0), 7, 0) &
    zero_pad(extract(wire_18, 0), 7, 0));

  unflatten(wrapper_2_data, 
    zero_pad(extract(dpe_21_data, 0), 31, 0) &
    zero_pad(extract(dpe_26_data, 0), 31, 0));

  wrapper_2_req(1) <= SigmaIn(17);
  wrapper_2_req(0) <= SigmaIn(22);

  wrapper_2 : ApStoreReq -- Store
  -- configuration: 
    generic map(
      width => (4, 2))
    port map(
      ack => wrapper_2_ack,
      addr => wrapper_2_addr,
      clk => clk,
      data => wrapper_2_data,
      mack => sr_ack(3 downto 0),
      maddr => sr_addr(31 downto 0),
      mdata => sr_data(31 downto 0),
      mreq => sr_req(3 downto 0),
      mtag => sr_tag(31 downto 0),
      req => wrapper_2_req,
      reset => reset);

  --  wrapper: wrapper_3
  --    dpe: dpe_11
  --    dpe: dpe_14
  --    dpe: dpe_3

  SigmaOut(10) <= wrapper_3_ack(2);
  SigmaOut(12) <= wrapper_3_ack(1);
  SigmaOut(4) <= wrapper_3_ack(0);

  unflatten(wrapper_3_addr, 
    zero_pad(extract(wire_8, 0), 7, 0) &
    zero_pad(extract(wire_10, 0), 7, 0) &
    zero_pad(extract(wire_2, 0), 7, 0));

  wrapper_3_req(2) <= SigmaIn(9);
  wrapper_3_req(1) <= SigmaIn(11);
  wrapper_3_req(0) <= SigmaIn(3);

  wrapper_3 : ApLoadReq -- LoadComplete
  -- configuration: 
  -- counterpart: wrapper_0
    generic map(
      width => (2, 4, 4))
    port map(
      ack => wrapper_3_ack,
      addr => wrapper_3_addr,
      clk => clk,
      mack => lr_ack(3 downto 0),
      maddr => lr_addr(31 downto 0),
      mreq => lr_req(3 downto 0),
      mtag => lr_tag(31 downto 0),
      req => wrapper_3_req,
      reset => reset);

  --  wrapper: wrapper_4
  --    dpe: dpe_17
  --    dpe: dpe_8

  SigmaOut(14) <= wrapper_4_ack(1);
  SigmaOut(8) <= wrapper_4_ack(0);

  unflatten(wrapper_4_addr, 
    zero_pad(extract(wire_12, 0), 7, 0) &
    zero_pad(extract(wire_6, 0), 7, 0));

  wrapper_4_req(1) <= SigmaIn(13);
  wrapper_4_req(0) <= SigmaIn(7);

  wrapper_4 : ApLoadReq -- LoadComplete
  -- configuration: 
  -- counterpart: wrapper_1
    generic map(
      width => (4, 2))
    port map(
      ack => wrapper_4_ack,
      addr => wrapper_4_addr,
      clk => clk,
      mack => lr_ack(7 downto 4),
      maddr => lr_addr(63 downto 32),
      mreq => lr_req(7 downto 4),
      mtag => lr_tag(63 downto 32),
      req => wrapper_4_req,
      reset => reset);

  -- address dpe_10
  wire_6 <= to_apintarray(to_apint(to_unsigned(19, 8)));
  -- address dpe_13
  wire_8 <= to_apintarray(to_apint(to_unsigned(17, 8)));
  -- address dpe_16
  wire_10 <= to_apintarray(to_apint(to_unsigned(5, 8)));
  -- address dpe_19
  wire_12 <= to_apintarray(to_apint(to_unsigned(1, 8)));
  -- address dpe_22
  wire_14 <= to_apintarray(to_apint(to_unsigned(9, 8)));
  -- constant dpe_24
  wire_16 <= to_APIntArray(to_apint(to_unsigned(5, 16)));
  -- address dpe_27
  wire_18 <= to_apintarray(to_apint(to_unsigned(21, 8)));
  -- address dpe_5
  wire_2 <= to_apintarray(to_apint(to_unsigned(13, 8)));
  -- constant dpe_7
  wire_4 <= to_APIntArray(to_apint(to_unsigned(0, 32)));

  dpe_1_condition <= extract(wire_3, 0);
  dpe_1 : ApIntBranch -- entry: exit
  -- configuration: 
    port map(
      ack0 => SigmaOut(1),
      ack1 => SigmaOut(2),
      clk => clk,
      condition => dpe_1_condition,
      req => SigmaIn(1),
      reset => reset);

  dpe_2_data_0 <= extract(dpe_2_data, 0);
  dpe_2 : InputPort -- incoming call
  -- configuration: 
    generic map(
      colouring => (0 => 0))
    port map(
      ack => SigmaOut(3 downto 3),
      clk => clk,
      data => dpe_2_data,
      oack => accept_in,
      odata => accept_data,
      oreq => accept_out,
      req => SigmaIn(2 downto 2),
      reset => reset);

  dpe_20 : APFloat_S_2 -- FAdd_61
  -- configuration: APFloatAdd
    generic map(
      colouring => (0 => 0))
    port map(
      ackC => SigmaOut(17 downto 17),
      ackR => SigmaOut(16 downto 16),
      clk => clk,
      reqC => SigmaIn(16 downto 16),
      reqR => SigmaIn(15 downto 15),
      reset => reset,
      x => wire_9,
      y => wire_11,
      z => wire_13);

  dpe_23_x <= extract(wire_16, 0);
  dpe_23_y <= extract(wire_7, 0);
  wire_15 <= to_APIntArray(dpe_23_z);
  dpe_23 : APIntPhi -- .pn: mux 1
  -- configuration: 
    port map(
      ack => SigmaOut(19),
      clk => clk,
      reqx => SigmaIn(18),
      reqy => SigmaIn(19),
      reset => reset,
      x => dpe_23_x,
      y => dpe_23_y,
      z => dpe_23_z);

  dpe_25 : APInt_S_2 -- t.0
  -- configuration: APIntAdd
    generic map(
      colouring => (0 => 0))
    port map(
      ackC => SigmaOut(21 downto 21),
      ackR => SigmaOut(20 downto 20),
      clk => clk,
      reqC => SigmaIn(21 downto 21),
      reqR => SigmaIn(20 downto 20),
      reset => reset,
      x => wire_15,
      y => wire_5,
      z => wire_17);

  dpe_28_data <= to_stdlogicarray2d(dpe_28_data_0);
  dpe_28 : OutputPort -- Return_77
  -- configuration: 
    generic map(
      colouring => (0 => 0))
    port map(
      ack => SigmaOut(23 downto 23),
      clk => clk,
      data => dpe_28_data,
      oack => return_in,
      odata => return_data,
      oreq => return_out,
      req => SigmaIn(23 downto 23),
      reset => reset);

  dpe_6 : APInt_S_2 -- ICMP_SGT_27
  -- configuration: APIntSGT
    generic map(
      colouring => (0 => 0))
    port map(
      ackC => SigmaOut(7 downto 7),
      ackR => SigmaOut(6 downto 6),
      clk => clk,
      reqC => SigmaIn(6 downto 6),
      reqR => SigmaIn(5 downto 5),
      reset => reset,
      x => wire_1,
      y => wire_4,
      z => wire_3);

end default_arch;