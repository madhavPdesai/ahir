library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.Types.all;
use ahir.subprograms.all;
use ahir.BaseComponents.all;
use ahir.utilities.all;

entity join_with_input is
  generic (place_capacity : integer := 1; bypass : boolean := false; name : string := "anon");
  port ( preds      : in   BooleanArray;
    	symbol_in  : in   boolean;
    	symbol_out : out  boolean;
	clk: in std_logic;
	reset: in std_logic);
end join_with_input;

architecture default_arch of join_with_input is
  signal symbol_out_sig : BooleanArray(0 downto 0);
  signal place_sigs: BooleanArray(preds'range);
  signal inp_place_sig: Boolean;
  constant H: integer := preds'high;
  constant L: integer := preds'low;
begin  -- default_arch
  
  Byp: if bypass generate 
    placegen: for I in H downto L generate
      placeBlock: block
	  signal place_pred: BooleanArray(0 downto 0);
      begin
	  place_pred(0) <= preds(I);
	  pI: place_with_bypass generic map(capacity => place_capacity, marking => 0,
				   name => name & ":" & Convert_To_String(I) )
		  port map(place_pred,symbol_out_sig,place_sigs(I),clk,reset);
      end block;
    end generate placegen;
    
    inplaceBlock: block
	  signal place_pred: BooleanArray(0 downto 0);
    begin
	  place_pred(0) <= symbol_in;
	  pI: place_with_bypass generic map(capacity => place_capacity, marking => 0,
				   name => name & ":inputplace")
		  port map(place_pred,symbol_out_sig,inp_place_sig,clk,reset);
    end block;
  end generate Byp;

  NoByp: if (not bypass) generate 
    placegen: for I in H downto L generate
      placeBlock: block
	  signal place_pred: BooleanArray(0 downto 0);
      begin
	  place_pred(0) <= preds(I);
	  pI: place generic map(capacity => place_capacity, marking => 0,
				   name => name & ":" & Convert_To_String(I) )
		  port map(place_pred,symbol_out_sig,place_sigs(I),clk,reset);
      end block;
    end generate placegen;
    
    inplaceBlock: block
	  signal place_pred: BooleanArray(0 downto 0);
    begin
	  -- note: input transitions are always bypassed, because they
	  --       always come with a delay (no need to incur an additional delay for them).
	  place_pred(0) <= symbol_in;
	  pI: place_with_bypass generic map(capacity => place_capacity, marking => 0,
				   name => name & ":inputplace")
		  port map(place_pred,symbol_out_sig,inp_place_sig,clk,reset);
    end block;
  end generate NoByp;


  -- The transition is enabled only when all preds are true.
  symbol_out_sig(0) <= inp_place_sig and AndReduce(place_sigs);
  symbol_out <= symbol_out_sig(0);
end default_arch;
