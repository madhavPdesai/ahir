
library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.types.all;
use ahir.components.all;

entity start_cp is
  port(
    LambdaIn : in BooleanArray(23 downto 1);
    LambdaOut : out BooleanArray(23 downto 1);
    clk : in std_logic;
    reset : in std_logic);
end start_cp;

architecture default_arch of start_cp is
  signal place_0_preds : BooleanArray(0 downto 0);
  signal place_0_succs : BooleanArray(0 downto 0);
  signal place_0_token : boolean;
  signal place_5_preds : BooleanArray(0 downto 0);
  signal place_5_succs : BooleanArray(1 downto 0);
  signal place_5_token : boolean;
  signal place_11_preds : BooleanArray(0 downto 0);
  signal place_11_succs : BooleanArray(0 downto 0);
  signal place_11_token : boolean;
  signal place_14_preds : BooleanArray(0 downto 0);
  signal place_14_succs : BooleanArray(0 downto 0);
  signal place_14_token : boolean;
  signal place_17_preds : BooleanArray(0 downto 0);
  signal place_17_succs : BooleanArray(0 downto 0);
  signal place_17_token : boolean;
  signal place_24_preds : BooleanArray(0 downto 0);
  signal place_24_succs : BooleanArray(0 downto 0);
  signal place_24_token : boolean;
  signal place_25_preds : BooleanArray(0 downto 0);
  signal place_25_succs : BooleanArray(0 downto 0);
  signal place_25_token : boolean;
  signal place_26_preds : BooleanArray(0 downto 0);
  signal place_26_succs : BooleanArray(0 downto 0);
  signal place_26_token : boolean;
  signal place_27_preds : BooleanArray(0 downto 0);
  signal place_27_succs : BooleanArray(0 downto 0);
  signal place_27_token : boolean;
  signal place_30_preds : BooleanArray(0 downto 0);
  signal place_30_succs : BooleanArray(0 downto 0);
  signal place_30_token : boolean;
  signal place_33_preds : BooleanArray(0 downto 0);
  signal place_33_succs : BooleanArray(0 downto 0);
  signal place_33_token : boolean;
  signal place_36_preds : BooleanArray(0 downto 0);
  signal place_36_succs : BooleanArray(0 downto 0);
  signal place_36_token : boolean;
  signal place_39_preds : BooleanArray(0 downto 0);
  signal place_39_succs : BooleanArray(0 downto 0);
  signal place_39_token : boolean;
  signal place_42_preds : BooleanArray(0 downto 0);
  signal place_42_succs : BooleanArray(0 downto 0);
  signal place_42_token : boolean;
  signal place_45_preds : BooleanArray(0 downto 0);
  signal place_45_succs : BooleanArray(0 downto 0);
  signal place_45_token : boolean;
  signal place_48_preds : BooleanArray(0 downto 0);
  signal place_48_succs : BooleanArray(0 downto 0);
  signal place_48_token : boolean;
  signal place_55_preds : BooleanArray(0 downto 0);
  signal place_55_succs : BooleanArray(0 downto 0);
  signal place_55_token : boolean;
  signal place_56_preds : BooleanArray(0 downto 0);
  signal place_56_succs : BooleanArray(0 downto 0);
  signal place_56_token : boolean;
  signal place_57_preds : BooleanArray(0 downto 0);
  signal place_57_succs : BooleanArray(0 downto 0);
  signal place_57_token : boolean;
  signal place_59_preds : BooleanArray(0 downto 0);
  signal place_59_succs : BooleanArray(0 downto 0);
  signal place_59_token : boolean;
  signal place_62_preds : BooleanArray(1 downto 0);
  signal place_62_succs : BooleanArray(0 downto 0);
  signal place_62_token : boolean;
  signal place_70_preds : BooleanArray(0 downto 0);
  signal place_70_succs : BooleanArray(0 downto 0);
  signal place_70_token : boolean;
  signal place_71_preds : BooleanArray(0 downto 0);
  signal place_71_succs : BooleanArray(0 downto 0);
  signal place_71_token : boolean;
  signal place_72_preds : BooleanArray(0 downto 0);
  signal place_72_succs : BooleanArray(0 downto 0);
  signal place_72_token : boolean;
  signal place_73_preds : BooleanArray(0 downto 0);
  signal place_73_succs : BooleanArray(0 downto 0);
  signal place_73_token : boolean;
  signal place_77_preds : BooleanArray(0 downto 0);
  signal place_77_succs : BooleanArray(0 downto 0);
  signal place_77_token : boolean;
  signal place_80_preds : BooleanArray(0 downto 0);
  signal place_80_succs : BooleanArray(0 downto 0);
  signal place_80_token : boolean;
  signal place_81_preds : BooleanArray(0 downto 0);
  signal place_81_succs : BooleanArray(0 downto 0);
  signal place_81_token : boolean;
  signal place_82_preds : BooleanArray(0 downto 0);
  signal place_82_succs : BooleanArray(0 downto 0);
  signal place_82_token : boolean;
  signal place_83_preds : BooleanArray(0 downto 0);
  signal place_83_succs : BooleanArray(0 downto 0);
  signal place_83_token : boolean;
  signal place_84_preds : BooleanArray(0 downto 0);
  signal place_84_succs : BooleanArray(0 downto 0);
  signal place_84_token : boolean;
  signal place_85_preds : BooleanArray(0 downto 0);
  signal place_85_succs : BooleanArray(0 downto 0);
  signal place_85_token : boolean;
  signal place_86_preds : BooleanArray(0 downto 0);
  signal place_86_succs : BooleanArray(0 downto 0);
  signal place_86_token : boolean;
  signal place_87_preds : BooleanArray(0 downto 0);
  signal place_87_succs : BooleanArray(0 downto 0);
  signal place_87_token : boolean;
  signal place_88_preds : BooleanArray(0 downto 0);
  signal place_88_succs : BooleanArray(0 downto 0);
  signal place_88_token : boolean;
  signal place_89_preds : BooleanArray(0 downto 0);
  signal place_89_succs : BooleanArray(0 downto 0);
  signal place_89_token : boolean;
  signal place_90_preds : BooleanArray(0 downto 0);
  signal place_90_succs : BooleanArray(0 downto 0);
  signal place_90_token : boolean;
  signal place_91_preds : BooleanArray(0 downto 0);
  signal place_91_succs : BooleanArray(0 downto 0);
  signal place_91_token : boolean;
  signal place_92_preds : BooleanArray(0 downto 0);
  signal place_92_succs : BooleanArray(0 downto 0);
  signal place_92_token : boolean;
  signal place_93_preds : BooleanArray(0 downto 0);
  signal place_93_succs : BooleanArray(0 downto 0);
  signal place_93_token : boolean;
  signal place_94_preds : BooleanArray(0 downto 0);
  signal place_94_succs : BooleanArray(0 downto 0);
  signal place_94_token : boolean;
  signal place_95_preds : BooleanArray(0 downto 0);
  signal place_95_succs : BooleanArray(0 downto 0);
  signal place_95_token : boolean;
  signal place_96_preds : BooleanArray(0 downto 0);
  signal place_96_succs : BooleanArray(0 downto 0);
  signal place_96_token : boolean;
  signal place_97_preds : BooleanArray(0 downto 0);
  signal place_97_succs : BooleanArray(0 downto 0);
  signal place_97_token : boolean;
  signal place_98_preds : BooleanArray(0 downto 0);
  signal place_98_succs : BooleanArray(0 downto 0);
  signal place_98_token : boolean;
  signal place_99_preds : BooleanArray(0 downto 0);
  signal place_99_succs : BooleanArray(0 downto 0);
  signal place_99_token : boolean;
  signal place_100_preds : BooleanArray(0 downto 0);
  signal place_100_succs : BooleanArray(0 downto 0);
  signal place_100_token : boolean;
  signal place_101_preds : BooleanArray(0 downto 0);
  signal place_101_succs : BooleanArray(0 downto 0);
  signal place_101_token : boolean;
  signal place_102_preds : BooleanArray(0 downto 0);
  signal place_102_succs : BooleanArray(0 downto 0);
  signal place_102_token : boolean;
  signal place_103_preds : BooleanArray(0 downto 0);
  signal place_103_succs : BooleanArray(0 downto 0);
  signal place_103_token : boolean;
  signal place_104_preds : BooleanArray(0 downto 0);
  signal place_104_succs : BooleanArray(0 downto 0);
  signal place_104_token : boolean;
  signal place_105_preds : BooleanArray(0 downto 0);
  signal place_105_succs : BooleanArray(0 downto 0);
  signal place_105_token : boolean;
  signal place_106_preds : BooleanArray(0 downto 0);
  signal place_106_succs : BooleanArray(0 downto 0);
  signal place_106_token : boolean;
  signal place_107_preds : BooleanArray(0 downto 0);
  signal place_107_succs : BooleanArray(0 downto 0);
  signal place_107_token : boolean;
  signal place_108_preds : BooleanArray(0 downto 0);
  signal place_108_succs : BooleanArray(0 downto 0);
  signal place_108_token : boolean;
  signal place_109_preds : BooleanArray(0 downto 0);
  signal place_109_succs : BooleanArray(0 downto 0);
  signal place_109_token : boolean;

  signal transition_1_symbol_out : boolean;
  signal transition_1_preds : BooleanArray(0 downto 0);
  signal transition_2_symbol_out : boolean;
  signal transition_2_preds : BooleanArray(0 downto 0);
  signal transition_3_symbol_out : boolean;
  signal transition_3_preds : BooleanArray(0 downto 0);
  signal transition_4_symbol_out : boolean;
  signal transition_4_preds : BooleanArray(1 downto 0);
  signal transition_6_symbol_out : boolean;
  signal transition_6_preds : BooleanArray(0 downto 0);
  signal transition_7_symbol_out : boolean;
  signal transition_7_preds : BooleanArray(0 downto 0);
  signal transition_8_symbol_out : boolean;
  signal transition_8_preds : BooleanArray(0 downto 0);
  signal transition_9_symbol_out : boolean;
  signal transition_9_preds : BooleanArray(0 downto 0);
  signal transition_10_symbol_out : boolean;
  signal transition_10_preds : BooleanArray(0 downto 0);
  signal transition_12_symbol_out : boolean;
  signal transition_12_preds : BooleanArray(0 downto 0);
  signal transition_13_symbol_out : boolean;
  signal transition_13_preds : BooleanArray(0 downto 0);
  signal transition_15_symbol_out : boolean;
  signal transition_15_preds : BooleanArray(0 downto 0);
  signal transition_16_symbol_out : boolean;
  signal transition_16_preds : BooleanArray(0 downto 0);
  signal transition_18_symbol_out : boolean;
  signal transition_18_preds : BooleanArray(0 downto 0);
  signal transition_19_symbol_out : boolean;
  signal transition_19_preds : BooleanArray(0 downto 0);
  signal transition_20_symbol_out : boolean;
  signal transition_20_preds : BooleanArray(0 downto 0);
  signal transition_21_symbol_out : boolean;
  signal transition_21_preds : BooleanArray(0 downto 0);
  signal transition_22_symbol_out : boolean;
  signal transition_22_preds : BooleanArray(0 downto 0);
  signal transition_23_symbol_out : boolean;
  signal transition_23_preds : BooleanArray(0 downto 0);
  signal transition_28_symbol_out : boolean;
  signal transition_28_preds : BooleanArray(0 downto 0);
  signal transition_29_symbol_out : boolean;
  signal transition_29_preds : BooleanArray(0 downto 0);
  signal transition_31_symbol_out : boolean;
  signal transition_31_preds : BooleanArray(0 downto 0);
  signal transition_32_symbol_out : boolean;
  signal transition_32_preds : BooleanArray(0 downto 0);
  signal transition_34_symbol_out : boolean;
  signal transition_34_preds : BooleanArray(0 downto 0);
  signal transition_35_symbol_out : boolean;
  signal transition_35_preds : BooleanArray(0 downto 0);
  signal transition_37_symbol_out : boolean;
  signal transition_37_preds : BooleanArray(0 downto 0);
  signal transition_38_symbol_out : boolean;
  signal transition_38_preds : BooleanArray(0 downto 0);
  signal transition_40_symbol_out : boolean;
  signal transition_40_preds : BooleanArray(0 downto 0);
  signal transition_41_symbol_out : boolean;
  signal transition_41_preds : BooleanArray(0 downto 0);
  signal transition_43_symbol_out : boolean;
  signal transition_43_preds : BooleanArray(0 downto 0);
  signal transition_44_symbol_out : boolean;
  signal transition_44_preds : BooleanArray(0 downto 0);
  signal transition_46_symbol_out : boolean;
  signal transition_46_preds : BooleanArray(0 downto 0);
  signal transition_47_symbol_out : boolean;
  signal transition_47_preds : BooleanArray(0 downto 0);
  signal transition_49_symbol_out : boolean;
  signal transition_49_preds : BooleanArray(0 downto 0);
  signal transition_50_symbol_out : boolean;
  signal transition_50_preds : BooleanArray(0 downto 0);
  signal transition_51_symbol_out : boolean;
  signal transition_51_preds : BooleanArray(0 downto 0);
  signal transition_52_symbol_out : boolean;
  signal transition_52_preds : BooleanArray(0 downto 0);
  signal transition_53_symbol_out : boolean;
  signal transition_53_preds : BooleanArray(0 downto 0);
  signal transition_54_symbol_out : boolean;
  signal transition_54_preds : BooleanArray(0 downto 0);
  signal transition_58_symbol_out : boolean;
  signal transition_58_preds : BooleanArray(1 downto 0);
  signal transition_60_symbol_out : boolean;
  signal transition_60_preds : BooleanArray(0 downto 0);
  signal transition_61_symbol_out : boolean;
  signal transition_61_preds : BooleanArray(0 downto 0);
  signal transition_63_symbol_out : boolean;
  signal transition_63_preds : BooleanArray(0 downto 0);
  signal transition_64_symbol_out : boolean;
  signal transition_64_preds : BooleanArray(0 downto 0);
  signal transition_65_symbol_out : boolean;
  signal transition_65_preds : BooleanArray(0 downto 0);
  signal transition_66_symbol_out : boolean;
  signal transition_66_preds : BooleanArray(0 downto 0);
  signal transition_67_symbol_out : boolean;
  signal transition_67_preds : BooleanArray(0 downto 0);
  signal transition_68_symbol_out : boolean;
  signal transition_68_preds : BooleanArray(0 downto 0);
  signal transition_69_symbol_out : boolean;
  signal transition_69_preds : BooleanArray(0 downto 0);
  signal transition_74_symbol_out : boolean;
  signal transition_74_preds : BooleanArray(0 downto 0);
  signal transition_75_symbol_out : boolean;
  signal transition_75_preds : BooleanArray(0 downto 0);
  signal transition_76_symbol_out : boolean;
  signal transition_76_preds : BooleanArray(1 downto 0);
  signal transition_78_symbol_out : boolean;
  signal transition_78_preds : BooleanArray(0 downto 0);
  signal transition_79_symbol_out : boolean;
  signal transition_79_preds : BooleanArray(0 downto 0);

begin
  place_0_preds(0) <= transition_2_symbol_out;
  place_0_succs(0) <= transition_1_symbol_out;
  place_0 : place
    generic map(marking => true)
    port map(
      preds => place_0_preds,
      succs => place_0_succs,
      token => place_0_token,
      clk   => clk,
      reset => reset);

  place_5_preds(0) <= transition_8_symbol_out;
  place_5_succs(0) <= transition_6_symbol_out;
  place_5_succs(1) <= transition_7_symbol_out;
  place_5 : place
    generic map(marking => false)
    port map(
      preds => place_5_preds,
      succs => place_5_succs,
      token => place_5_token,
      clk   => clk,
      reset => reset);

  place_11_preds(0) <= transition_13_symbol_out;
  place_11_succs(0) <= transition_12_symbol_out;
  place_11 : place
    generic map(marking => false)
    port map(
      preds => place_11_preds,
      succs => place_11_succs,
      token => place_11_token,
      clk   => clk,
      reset => reset);

  place_14_preds(0) <= transition_16_symbol_out;
  place_14_succs(0) <= transition_15_symbol_out;
  place_14 : place
    generic map(marking => false)
    port map(
      preds => place_14_preds,
      succs => place_14_succs,
      token => place_14_token,
      clk   => clk,
      reset => reset);

  place_17_preds(0) <= transition_19_symbol_out;
  place_17_succs(0) <= transition_18_symbol_out;
  place_17 : place
    generic map(marking => false)
    port map(
      preds => place_17_preds,
      succs => place_17_succs,
      token => place_17_token,
      clk   => clk,
      reset => reset);

  place_24_preds(0) <= transition_20_symbol_out;
  place_24_succs(0) <= transition_21_symbol_out;
  place_24 : place
    generic map(marking => false)
    port map(
      preds => place_24_preds,
      succs => place_24_succs,
      token => place_24_token,
      clk   => clk,
      reset => reset);

  place_25_preds(0) <= transition_21_symbol_out;
  place_25_succs(0) <= transition_22_symbol_out;
  place_25 : place
    generic map(marking => false)
    port map(
      preds => place_25_preds,
      succs => place_25_succs,
      token => place_25_token,
      clk   => clk,
      reset => reset);

  place_26_preds(0) <= transition_22_symbol_out;
  place_26_succs(0) <= transition_23_symbol_out;
  place_26 : place
    generic map(marking => false)
    port map(
      preds => place_26_preds,
      succs => place_26_succs,
      token => place_26_token,
      clk   => clk,
      reset => reset);

  place_27_preds(0) <= transition_29_symbol_out;
  place_27_succs(0) <= transition_28_symbol_out;
  place_27 : place
    generic map(marking => false)
    port map(
      preds => place_27_preds,
      succs => place_27_succs,
      token => place_27_token,
      clk   => clk,
      reset => reset);

  place_30_preds(0) <= transition_32_symbol_out;
  place_30_succs(0) <= transition_31_symbol_out;
  place_30 : place
    generic map(marking => false)
    port map(
      preds => place_30_preds,
      succs => place_30_succs,
      token => place_30_token,
      clk   => clk,
      reset => reset);

  place_33_preds(0) <= transition_35_symbol_out;
  place_33_succs(0) <= transition_34_symbol_out;
  place_33 : place
    generic map(marking => false)
    port map(
      preds => place_33_preds,
      succs => place_33_succs,
      token => place_33_token,
      clk   => clk,
      reset => reset);

  place_36_preds(0) <= transition_38_symbol_out;
  place_36_succs(0) <= transition_37_symbol_out;
  place_36 : place
    generic map(marking => false)
    port map(
      preds => place_36_preds,
      succs => place_36_succs,
      token => place_36_token,
      clk   => clk,
      reset => reset);

  place_39_preds(0) <= transition_41_symbol_out;
  place_39_succs(0) <= transition_40_symbol_out;
  place_39 : place
    generic map(marking => false)
    port map(
      preds => place_39_preds,
      succs => place_39_succs,
      token => place_39_token,
      clk   => clk,
      reset => reset);

  place_42_preds(0) <= transition_44_symbol_out;
  place_42_succs(0) <= transition_43_symbol_out;
  place_42 : place
    generic map(marking => false)
    port map(
      preds => place_42_preds,
      succs => place_42_succs,
      token => place_42_token,
      clk   => clk,
      reset => reset);

  place_45_preds(0) <= transition_47_symbol_out;
  place_45_succs(0) <= transition_46_symbol_out;
  place_45 : place
    generic map(marking => false)
    port map(
      preds => place_45_preds,
      succs => place_45_succs,
      token => place_45_token,
      clk   => clk,
      reset => reset);

  place_48_preds(0) <= transition_50_symbol_out;
  place_48_succs(0) <= transition_49_symbol_out;
  place_48 : place
    generic map(marking => false)
    port map(
      preds => place_48_preds,
      succs => place_48_succs,
      token => place_48_token,
      clk   => clk,
      reset => reset);

  place_55_preds(0) <= transition_51_symbol_out;
  place_55_succs(0) <= transition_52_symbol_out;
  place_55 : place
    generic map(marking => false)
    port map(
      preds => place_55_preds,
      succs => place_55_succs,
      token => place_55_token,
      clk   => clk,
      reset => reset);

  place_56_preds(0) <= transition_52_symbol_out;
  place_56_succs(0) <= transition_53_symbol_out;
  place_56 : place
    generic map(marking => false)
    port map(
      preds => place_56_preds,
      succs => place_56_succs,
      token => place_56_token,
      clk   => clk,
      reset => reset);

  place_57_preds(0) <= transition_53_symbol_out;
  place_57_succs(0) <= transition_54_symbol_out;
  place_57 : place
    generic map(marking => false)
    port map(
      preds => place_57_preds,
      succs => place_57_succs,
      token => place_57_token,
      clk   => clk,
      reset => reset);

  place_59_preds(0) <= transition_61_symbol_out;
  place_59_succs(0) <= transition_60_symbol_out;
  place_59 : place
    generic map(marking => false)
    port map(
      preds => place_59_preds,
      succs => place_59_succs,
      token => place_59_token,
      clk   => clk,
      reset => reset);

  place_62_preds(0) <= transition_64_symbol_out;
  place_62_preds(1) <= transition_65_symbol_out;
  place_62_succs(0) <= transition_63_symbol_out;
  place_62 : place
    generic map(marking => false)
    port map(
      preds => place_62_preds,
      succs => place_62_succs,
      token => place_62_token,
      clk   => clk,
      reset => reset);

  place_70_preds(0) <= transition_66_symbol_out;
  place_70_succs(0) <= transition_67_symbol_out;
  place_70 : place
    generic map(marking => false)
    port map(
      preds => place_70_preds,
      succs => place_70_succs,
      token => place_70_token,
      clk   => clk,
      reset => reset);

  place_71_preds(0) <= transition_67_symbol_out;
  place_71_succs(0) <= transition_68_symbol_out;
  place_71 : place
    generic map(marking => false)
    port map(
      preds => place_71_preds,
      succs => place_71_succs,
      token => place_71_token,
      clk   => clk,
      reset => reset);

  place_72_preds(0) <= transition_68_symbol_out;
  place_72_succs(0) <= transition_69_symbol_out;
  place_72 : place
    generic map(marking => false)
    port map(
      preds => place_72_preds,
      succs => place_72_succs,
      token => place_72_token,
      clk   => clk,
      reset => reset);

  place_73_preds(0) <= transition_75_symbol_out;
  place_73_succs(0) <= transition_74_symbol_out;
  place_73 : place
    generic map(marking => false)
    port map(
      preds => place_73_preds,
      succs => place_73_succs,
      token => place_73_token,
      clk   => clk,
      reset => reset);

  place_77_preds(0) <= transition_79_symbol_out;
  place_77_succs(0) <= transition_78_symbol_out;
  place_77 : place
    generic map(marking => false)
    port map(
      preds => place_77_preds,
      succs => place_77_succs,
      token => place_77_token,
      clk   => clk,
      reset => reset);

  place_80_preds(0) <= transition_4_symbol_out;
  place_80_succs(0) <= transition_8_symbol_out;
  place_80 : place
    generic map(marking => false)
    port map(
      preds => place_80_preds,
      succs => place_80_succs,
      token => place_80_token,
      clk   => clk,
      reset => reset);

  place_81_preds(0) <= transition_7_symbol_out;
  place_81_succs(0) <= transition_35_symbol_out;
  place_81 : place
    generic map(marking => false)
    port map(
      preds => place_81_preds,
      succs => place_81_succs,
      token => place_81_token,
      clk   => clk,
      reset => reset);

  place_82_preds(0) <= transition_15_symbol_out;
  place_82_succs(0) <= transition_19_symbol_out;
  place_82 : place
    generic map(marking => false)
    port map(
      preds => place_82_preds,
      succs => place_82_succs,
      token => place_82_token,
      clk   => clk,
      reset => reset);

  place_83_preds(0) <= transition_18_symbol_out;
  place_83_succs(0) <= transition_20_symbol_out;
  place_83 : place
    generic map(marking => false)
    port map(
      preds => place_83_preds,
      succs => place_83_succs,
      token => place_83_token,
      clk   => clk,
      reset => reset);

  place_84_preds(0) <= transition_3_symbol_out;
  place_84_succs(0) <= transition_16_symbol_out;
  place_84 : place
    generic map(marking => false)
    port map(
      preds => place_84_preds,
      succs => place_84_succs,
      token => place_84_token,
      clk   => clk,
      reset => reset);

  place_85_preds(0) <= transition_23_symbol_out;
  place_85_succs(0) <= transition_4_symbol_out;
  place_85 : place
    generic map(marking => false)
    port map(
      preds => place_85_preds,
      succs => place_85_succs,
      token => place_85_token,
      clk   => clk,
      reset => reset);

  place_86_preds(0) <= transition_28_symbol_out;
  place_86_succs(0) <= transition_32_symbol_out;
  place_86 : place
    generic map(marking => false)
    port map(
      preds => place_86_preds,
      succs => place_86_succs,
      token => place_86_token,
      clk   => clk,
      reset => reset);

  place_87_preds(0) <= transition_31_symbol_out;
  place_87_succs(0) <= transition_4_symbol_out;
  place_87 : place
    generic map(marking => false)
    port map(
      preds => place_87_preds,
      succs => place_87_succs,
      token => place_87_token,
      clk   => clk,
      reset => reset);

  place_88_preds(0) <= transition_3_symbol_out;
  place_88_succs(0) <= transition_29_symbol_out;
  place_88 : place
    generic map(marking => false)
    port map(
      preds => place_88_preds,
      succs => place_88_succs,
      token => place_88_token,
      clk   => clk,
      reset => reset);

  place_89_preds(0) <= transition_34_symbol_out;
  place_89_succs(0) <= transition_38_symbol_out;
  place_89 : place
    generic map(marking => false)
    port map(
      preds => place_89_preds,
      succs => place_89_succs,
      token => place_89_token,
      clk   => clk,
      reset => reset);

  place_90_preds(0) <= transition_37_symbol_out;
  place_90_succs(0) <= transition_65_symbol_out;
  place_90 : place
    generic map(marking => false)
    port map(
      preds => place_90_preds,
      succs => place_90_succs,
      token => place_90_token,
      clk   => clk,
      reset => reset);

  place_91_preds(0) <= transition_40_symbol_out;
  place_91_succs(0) <= transition_44_symbol_out;
  place_91 : place
    generic map(marking => false)
    port map(
      preds => place_91_preds,
      succs => place_91_succs,
      token => place_91_token,
      clk   => clk,
      reset => reset);

  place_92_preds(0) <= transition_43_symbol_out;
  place_92_succs(0) <= transition_58_symbol_out;
  place_92 : place
    generic map(marking => false)
    port map(
      preds => place_92_preds,
      succs => place_92_succs,
      token => place_92_token,
      clk   => clk,
      reset => reset);

  place_93_preds(0) <= transition_9_symbol_out;
  place_93_succs(0) <= transition_41_symbol_out;
  place_93 : place
    generic map(marking => false)
    port map(
      preds => place_93_preds,
      succs => place_93_succs,
      token => place_93_token,
      clk   => clk,
      reset => reset);

  place_94_preds(0) <= transition_46_symbol_out;
  place_94_succs(0) <= transition_50_symbol_out;
  place_94 : place
    generic map(marking => false)
    port map(
      preds => place_94_preds,
      succs => place_94_succs,
      token => place_94_token,
      clk   => clk,
      reset => reset);

  place_95_preds(0) <= transition_49_symbol_out;
  place_95_succs(0) <= transition_58_symbol_out;
  place_95 : place
    generic map(marking => false)
    port map(
      preds => place_95_preds,
      succs => place_95_succs,
      token => place_95_token,
      clk   => clk,
      reset => reset);

  place_96_preds(0) <= transition_9_symbol_out;
  place_96_succs(0) <= transition_47_symbol_out;
  place_96 : place
    generic map(marking => false)
    port map(
      preds => place_96_preds,
      succs => place_96_succs,
      token => place_96_token,
      clk   => clk,
      reset => reset);

  place_97_preds(0) <= transition_58_symbol_out;
  place_97_succs(0) <= transition_51_symbol_out;
  place_97 : place
    generic map(marking => false)
    port map(
      preds => place_97_preds,
      succs => place_97_succs,
      token => place_97_token,
      clk   => clk,
      reset => reset);

  place_98_preds(0) <= transition_54_symbol_out;
  place_98_succs(0) <= transition_61_symbol_out;
  place_98 : place
    generic map(marking => false)
    port map(
      preds => place_98_preds,
      succs => place_98_succs,
      token => place_98_token,
      clk   => clk,
      reset => reset);

  place_99_preds(0) <= transition_60_symbol_out;
  place_99_succs(0) <= transition_64_symbol_out;
  place_99 : place
    generic map(marking => false)
    port map(
      preds => place_99_preds,
      succs => place_99_succs,
      token => place_99_token,
      clk   => clk,
      reset => reset);

  place_100_preds(0) <= transition_1_symbol_out;
  place_100_succs(0) <= transition_13_symbol_out;
  place_100 : place
    generic map(marking => false)
    port map(
      preds => place_100_preds,
      succs => place_100_succs,
      token => place_100_token,
      clk   => clk,
      reset => reset);

  place_101_preds(0) <= transition_63_symbol_out;
  place_101_succs(0) <= transition_10_symbol_out;
  place_101 : place
    generic map(marking => false)
    port map(
      preds => place_101_preds,
      succs => place_101_succs,
      token => place_101_token,
      clk   => clk,
      reset => reset);

  place_102_preds(0) <= transition_69_symbol_out;
  place_102_succs(0) <= transition_76_symbol_out;
  place_102 : place
    generic map(marking => false)
    port map(
      preds => place_102_preds,
      succs => place_102_succs,
      token => place_102_token,
      clk   => clk,
      reset => reset);

  place_103_preds(0) <= transition_10_symbol_out;
  place_103_succs(0) <= transition_66_symbol_out;
  place_103 : place
    generic map(marking => false)
    port map(
      preds => place_103_preds,
      succs => place_103_succs,
      token => place_103_token,
      clk   => clk,
      reset => reset);

  place_104_preds(0) <= transition_12_symbol_out;
  place_104_succs(0) <= transition_3_symbol_out;
  place_104 : place
    generic map(marking => false)
    port map(
      preds => place_104_preds,
      succs => place_104_succs,
      token => place_104_token,
      clk   => clk,
      reset => reset);

  place_105_preds(0) <= transition_76_symbol_out;
  place_105_succs(0) <= transition_75_symbol_out;
  place_105 : place
    generic map(marking => false)
    port map(
      preds => place_105_preds,
      succs => place_105_succs,
      token => place_105_token,
      clk   => clk,
      reset => reset);

  place_106_preds(0) <= transition_74_symbol_out;
  place_106_succs(0) <= transition_79_symbol_out;
  place_106 : place
    generic map(marking => false)
    port map(
      preds => place_106_preds,
      succs => place_106_succs,
      token => place_106_token,
      clk   => clk,
      reset => reset);

  place_107_preds(0) <= transition_10_symbol_out;
  place_107_succs(0) <= transition_76_symbol_out;
  place_107 : place
    generic map(marking => false)
    port map(
      preds => place_107_preds,
      succs => place_107_succs,
      token => place_107_token,
      clk   => clk,
      reset => reset);

  place_108_preds(0) <= transition_78_symbol_out;
  place_108_succs(0) <= transition_2_symbol_out;
  place_108 : place
    generic map(marking => false)
    port map(
      preds => place_108_preds,
      succs => place_108_succs,
      token => place_108_token,
      clk   => clk,
      reset => reset);

  place_109_preds(0) <= transition_6_symbol_out;
  place_109_succs(0) <= transition_9_symbol_out;
  place_109 : place
    generic map(marking => false)
    port map(
      preds => place_109_preds,
      succs => place_109_succs,
      token => place_109_token,
      clk   => clk,
      reset => reset);

  transition_1_preds(0) <= place_0_token;
  transition_1 : transition
    port map(
      preds      => transition_1_preds,
      symbol_out => transition_1_symbol_out,
      symbol_in  => true);

  transition_2_preds(0) <= place_108_token;
  transition_2 : transition
    port map(
      preds      => transition_2_preds,
      symbol_out => transition_2_symbol_out,
      symbol_in  => true);

  transition_3_preds(0) <= place_104_token;
  transition_3 : transition
    port map(
      preds      => transition_3_preds,
      symbol_out => transition_3_symbol_out,
      symbol_in  => true);

  transition_4_preds(0) <= place_85_token;
  transition_4_preds(1) <= place_87_token;
  transition_4 : transition
    port map(
      preds      => transition_4_preds,
      symbol_out => transition_4_symbol_out,
      symbol_in  => true);

  transition_6_preds(0) <= place_5_token;
  transition_6 : transition
    port map(
      preds      => transition_6_preds,
      symbol_out => transition_6_symbol_out,
      symbol_in  => LambdaIn(1));

  transition_7_preds(0) <= place_5_token;
  transition_7 : transition
    port map(
      preds      => transition_7_preds,
      symbol_out => transition_7_symbol_out,
      symbol_in  => LambdaIn(2));

  transition_8_preds(0) <= place_80_token;
  LambdaOut(1) <= transition_8_symbol_out;
  transition_8 : transition
    port map(
      preds      => transition_8_preds,
      symbol_out => transition_8_symbol_out,
      symbol_in  => true);

  transition_9_preds(0) <= place_109_token;
  transition_9 : transition
    port map(
      preds      => transition_9_preds,
      symbol_out => transition_9_symbol_out,
      symbol_in  => true);

  transition_10_preds(0) <= place_101_token;
  transition_10 : transition
    port map(
      preds      => transition_10_preds,
      symbol_out => transition_10_symbol_out,
      symbol_in  => true);

  transition_12_preds(0) <= place_11_token;
  transition_12 : transition
    port map(
      preds      => transition_12_preds,
      symbol_out => transition_12_symbol_out,
      symbol_in  => LambdaIn(3));

  transition_13_preds(0) <= place_100_token;
  LambdaOut(2) <= transition_13_symbol_out;
  transition_13 : transition
    port map(
      preds      => transition_13_preds,
      symbol_out => transition_13_symbol_out,
      symbol_in  => true);

  transition_15_preds(0) <= place_14_token;
  transition_15 : transition
    port map(
      preds      => transition_15_preds,
      symbol_out => transition_15_symbol_out,
      symbol_in  => LambdaIn(4));

  transition_16_preds(0) <= place_84_token;
  LambdaOut(3) <= transition_16_symbol_out;
  transition_16 : transition
    port map(
      preds      => transition_16_preds,
      symbol_out => transition_16_symbol_out,
      symbol_in  => true);

  transition_18_preds(0) <= place_17_token;
  transition_18 : transition
    port map(
      preds      => transition_18_preds,
      symbol_out => transition_18_symbol_out,
      symbol_in  => LambdaIn(5));

  transition_19_preds(0) <= place_82_token;
  LambdaOut(4) <= transition_19_symbol_out;
  transition_19 : transition
    port map(
      preds      => transition_19_preds,
      symbol_out => transition_19_symbol_out,
      symbol_in  => true);

  transition_20_preds(0) <= place_83_token;
  LambdaOut(5) <= transition_20_symbol_out;
  transition_20 : transition
    port map(
      preds      => transition_20_preds,
      symbol_out => transition_20_symbol_out,
      symbol_in  => true);

  transition_21_preds(0) <= place_24_token;
  transition_21 : transition
    port map(
      preds      => transition_21_preds,
      symbol_out => transition_21_symbol_out,
      symbol_in  => LambdaIn(6));

  transition_22_preds(0) <= place_25_token;
  LambdaOut(6) <= transition_22_symbol_out;
  transition_22 : transition
    port map(
      preds      => transition_22_preds,
      symbol_out => transition_22_symbol_out,
      symbol_in  => true);

  transition_23_preds(0) <= place_26_token;
  transition_23 : transition
    port map(
      preds      => transition_23_preds,
      symbol_out => transition_23_symbol_out,
      symbol_in  => LambdaIn(7));

  transition_28_preds(0) <= place_27_token;
  transition_28 : transition
    port map(
      preds      => transition_28_preds,
      symbol_out => transition_28_symbol_out,
      symbol_in  => LambdaIn(8));

  transition_29_preds(0) <= place_88_token;
  LambdaOut(7) <= transition_29_symbol_out;
  transition_29 : transition
    port map(
      preds      => transition_29_preds,
      symbol_out => transition_29_symbol_out,
      symbol_in  => true);

  transition_31_preds(0) <= place_30_token;
  transition_31 : transition
    port map(
      preds      => transition_31_preds,
      symbol_out => transition_31_symbol_out,
      symbol_in  => LambdaIn(9));

  transition_32_preds(0) <= place_86_token;
  LambdaOut(8) <= transition_32_symbol_out;
  transition_32 : transition
    port map(
      preds      => transition_32_preds,
      symbol_out => transition_32_symbol_out,
      symbol_in  => true);

  transition_34_preds(0) <= place_33_token;
  transition_34 : transition
    port map(
      preds      => transition_34_preds,
      symbol_out => transition_34_symbol_out,
      symbol_in  => LambdaIn(10));

  transition_35_preds(0) <= place_81_token;
  LambdaOut(9) <= transition_35_symbol_out;
  transition_35 : transition
    port map(
      preds      => transition_35_preds,
      symbol_out => transition_35_symbol_out,
      symbol_in  => true);

  transition_37_preds(0) <= place_36_token;
  transition_37 : transition
    port map(
      preds      => transition_37_preds,
      symbol_out => transition_37_symbol_out,
      symbol_in  => LambdaIn(11));

  transition_38_preds(0) <= place_89_token;
  LambdaOut(10) <= transition_38_symbol_out;
  transition_38 : transition
    port map(
      preds      => transition_38_preds,
      symbol_out => transition_38_symbol_out,
      symbol_in  => true);

  transition_40_preds(0) <= place_39_token;
  transition_40 : transition
    port map(
      preds      => transition_40_preds,
      symbol_out => transition_40_symbol_out,
      symbol_in  => LambdaIn(12));

  transition_41_preds(0) <= place_93_token;
  LambdaOut(11) <= transition_41_symbol_out;
  transition_41 : transition
    port map(
      preds      => transition_41_preds,
      symbol_out => transition_41_symbol_out,
      symbol_in  => true);

  transition_43_preds(0) <= place_42_token;
  transition_43 : transition
    port map(
      preds      => transition_43_preds,
      symbol_out => transition_43_symbol_out,
      symbol_in  => LambdaIn(13));

  transition_44_preds(0) <= place_91_token;
  LambdaOut(12) <= transition_44_symbol_out;
  transition_44 : transition
    port map(
      preds      => transition_44_preds,
      symbol_out => transition_44_symbol_out,
      symbol_in  => true);

  transition_46_preds(0) <= place_45_token;
  transition_46 : transition
    port map(
      preds      => transition_46_preds,
      symbol_out => transition_46_symbol_out,
      symbol_in  => LambdaIn(14));

  transition_47_preds(0) <= place_96_token;
  LambdaOut(13) <= transition_47_symbol_out;
  transition_47 : transition
    port map(
      preds      => transition_47_preds,
      symbol_out => transition_47_symbol_out,
      symbol_in  => true);

  transition_49_preds(0) <= place_48_token;
  transition_49 : transition
    port map(
      preds      => transition_49_preds,
      symbol_out => transition_49_symbol_out,
      symbol_in  => LambdaIn(15));

  transition_50_preds(0) <= place_94_token;
  LambdaOut(14) <= transition_50_symbol_out;
  transition_50 : transition
    port map(
      preds      => transition_50_preds,
      symbol_out => transition_50_symbol_out,
      symbol_in  => true);

  transition_51_preds(0) <= place_97_token;
  LambdaOut(15) <= transition_51_symbol_out;
  transition_51 : transition
    port map(
      preds      => transition_51_preds,
      symbol_out => transition_51_symbol_out,
      symbol_in  => true);

  transition_52_preds(0) <= place_55_token;
  transition_52 : transition
    port map(
      preds      => transition_52_preds,
      symbol_out => transition_52_symbol_out,
      symbol_in  => LambdaIn(16));

  transition_53_preds(0) <= place_56_token;
  LambdaOut(16) <= transition_53_symbol_out;
  transition_53 : transition
    port map(
      preds      => transition_53_preds,
      symbol_out => transition_53_symbol_out,
      symbol_in  => true);

  transition_54_preds(0) <= place_57_token;
  transition_54 : transition
    port map(
      preds      => transition_54_preds,
      symbol_out => transition_54_symbol_out,
      symbol_in  => LambdaIn(17));

  transition_58_preds(0) <= place_92_token;
  transition_58_preds(1) <= place_95_token;
  transition_58 : transition
    port map(
      preds      => transition_58_preds,
      symbol_out => transition_58_symbol_out,
      symbol_in  => true);

  transition_60_preds(0) <= place_59_token;
  transition_60 : transition
    port map(
      preds      => transition_60_preds,
      symbol_out => transition_60_symbol_out,
      symbol_in  => LambdaIn(18));

  transition_61_preds(0) <= place_98_token;
  LambdaOut(17) <= transition_61_symbol_out;
  transition_61 : transition
    port map(
      preds      => transition_61_preds,
      symbol_out => transition_61_symbol_out,
      symbol_in  => true);

  transition_63_preds(0) <= place_62_token;
  transition_63 : transition
    port map(
      preds      => transition_63_preds,
      symbol_out => transition_63_symbol_out,
      symbol_in  => LambdaIn(19));

  transition_64_preds(0) <= place_99_token;
  LambdaOut(18) <= transition_64_symbol_out;
  transition_64 : transition
    port map(
      preds      => transition_64_preds,
      symbol_out => transition_64_symbol_out,
      symbol_in  => true);

  transition_65_preds(0) <= place_90_token;
  LambdaOut(19) <= transition_65_symbol_out;
  transition_65 : transition
    port map(
      preds      => transition_65_preds,
      symbol_out => transition_65_symbol_out,
      symbol_in  => true);

  transition_66_preds(0) <= place_103_token;
  LambdaOut(20) <= transition_66_symbol_out;
  transition_66 : transition
    port map(
      preds      => transition_66_preds,
      symbol_out => transition_66_symbol_out,
      symbol_in  => true);

  transition_67_preds(0) <= place_70_token;
  transition_67 : transition
    port map(
      preds      => transition_67_preds,
      symbol_out => transition_67_symbol_out,
      symbol_in  => LambdaIn(20));

  transition_68_preds(0) <= place_71_token;
  LambdaOut(21) <= transition_68_symbol_out;
  transition_68 : transition
    port map(
      preds      => transition_68_preds,
      symbol_out => transition_68_symbol_out,
      symbol_in  => true);

  transition_69_preds(0) <= place_72_token;
  transition_69 : transition
    port map(
      preds      => transition_69_preds,
      symbol_out => transition_69_symbol_out,
      symbol_in  => LambdaIn(21));

  transition_74_preds(0) <= place_73_token;
  transition_74 : transition
    port map(
      preds      => transition_74_preds,
      symbol_out => transition_74_symbol_out,
      symbol_in  => LambdaIn(22));

  transition_75_preds(0) <= place_105_token;
  LambdaOut(22) <= transition_75_symbol_out;
  transition_75 : transition
    port map(
      preds      => transition_75_preds,
      symbol_out => transition_75_symbol_out,
      symbol_in  => true);

  transition_76_preds(0) <= place_102_token;
  transition_76_preds(1) <= place_107_token;
  transition_76 : transition
    port map(
      preds      => transition_76_preds,
      symbol_out => transition_76_symbol_out,
      symbol_in  => true);

  transition_78_preds(0) <= place_77_token;
  transition_78 : transition
    port map(
      preds      => transition_78_preds,
      symbol_out => transition_78_symbol_out,
      symbol_in  => LambdaIn(23));

  transition_79_preds(0) <= place_106_token;
  LambdaOut(23) <= transition_79_symbol_out;
  transition_79 : transition
    port map(
      preds      => transition_79_preds,
      symbol_out => transition_79_symbol_out,
      symbol_in  => true);

end architecture default_arch;