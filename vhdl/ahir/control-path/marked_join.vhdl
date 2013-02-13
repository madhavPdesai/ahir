library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.Types.all;
use ahir.subprograms.all;
use ahir.BaseComponents.all;
use ahir.utilities.all;

entity marked_join is
  generic(place_capacity : integer := 1; bypass : boolean := false; name : string := "anon");
  port ( preds      : in   BooleanArray;
         marked_preds : in BooleanArray;
    	symbol_out : out  boolean;
	clk: in std_logic;
	reset: in std_logic);
end marked_join;

architecture default_arch of marked_join is
  signal symbol_out_sig : BooleanArray(0 downto 0);
  signal place_sigs: BooleanArray(preds'range);
  signal mplace_sigs: BooleanArray(marked_preds'range);  
  constant H: integer := preds'high;
  constant L: integer := preds'low;

  constant MH: integer := marked_preds'high;
  constant ML: integer := marked_preds'low;  

begin  -- default_arch
  
  placegen: for I in H downto L generate
    placeBlock: block
	signal place_pred: BooleanArray(0 downto 0);
    begin
	place_pred(0) <= preds(I);
      bypassgen: if (bypass) generate
	pI: place_with_bypass
		generic map(capacity => place_capacity, 
				marking => 0,
				name => name & ":" & Convert_To_String(I) )
		port map(place_pred,symbol_out_sig,place_sigs(I),clk,reset);
      end generate bypassgen;

      nobypassgen: if (not bypass) generate
	pI: place
		generic map(capacity => place_capacity, 
				marking => 0,
				name => name & ":" & Convert_To_String(I) )
		port map(place_pred,symbol_out_sig,place_sigs(I),clk,reset);
      end generate nobypassgen;
    end block;
  end generate placegen;

  -- the marked places
  mplacegen: for I in MH downto ML generate
    mplaceBlock: block
	signal place_pred: BooleanArray(0 downto 0);
    begin
	place_pred(0) <= marked_preds(I);
	mpI: place generic map(capacity => place_capacity, marking => 1,
				 name => name & ":marked:" & Convert_To_String(I) )
		port map(place_pred,symbol_out_sig,mplace_sigs(I),clk,reset);
    end block;
  end generate mplacegen;
  
  -- The transition is enabled only when all preds are true.
  symbol_out_sig(0) <= AndReduce(place_sigs) and AndReduce(mplace_sigs);
  symbol_out <= symbol_out_sig(0);

end default_arch;
