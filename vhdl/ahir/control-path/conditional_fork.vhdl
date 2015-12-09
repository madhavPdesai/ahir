-- conditional-fork.
--    forward in-transition to out-transitions if triggers are enabled.
-- written by Madhav P. Desai, December 2015.
library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.Types.all;
use ahir.subprograms.all;
use ahir.BaseComponents.all;
use ahir.Utilities.all;

-- for a transition on in-transition, produce a transition on an out-transitions 
-- if the trigger is enabled (disable all triggers when the out-transition is fired).
entity conditional_fork is
       generic (place_capacity: integer := 1; 
			ntriggers: integer; name : string := "anonConditionalRepeater");
       port (triggers: in BooleanArray(0 to ntriggers-1);
			in_transition: in Boolean;
			out_transitions: out BooleanArray(0 to ntriggers-1);
			clk: in std_logic; reset: in std_logic);
end entity conditional_fork;

architecture Basic of conditional_fork is
    signal trig_places, trig_clears: BooleanArray(0 to ntriggers-1);
    signal in_trans_place, in_trans_clear: Boolean;
begin
    TrigPlaces: for I in 0 to (ntriggers-1) generate
	placeBlock: block
	  signal place_pred, place_succ: BooleanArray(0 downto 0);
        begin
	  place_pred(0) <= triggers(I);
	  place_succ(0) <= trig_clears(I);

          -- a bypass place: in order to speed up loop turnaround times.
	  pI: place_with_bypass generic map(capacity => place_capacity, marking => 0,
		     name => name & ":trigplaces:" & Convert_To_String(I))
		  port map(place_pred,place_succ,trig_places(I),clk,reset);
        end block;
    end generate TrigPlaces;

    inTransPlaceBlock: block
      signal place_pred, place_succ: BooleanArray(0 downto 0);
    begin
      place_pred(0) <= in_transition;
      place_succ(0) <= in_trans_clear;

      -- a bypass place: in order to speed up loop turnaround times.
      pI: place_with_bypass generic map(capacity => place_capacity, marking => 0,
		     name => name & ":inTransPlace:")
		  port map(place_pred,place_succ,in_trans_place,clk,reset);
    end block;

    cGen: for I in 0 to ntriggers-1 generate
	trig_clears(I) <= in_trans_place and trig_places(I);
	out_transitions(I) <= trig_clears(I);
    end generate cGen;
  
     -- clear in-transition when any of the trigs are cleared.
     in_trans_clear <= OrReduce(trig_clears);

end Basic;

