library ahir;
use ahir.Types.all;
use ahir.subprograms.all;

-- a short-hand model to implement a merge
-- from transitions to transitions.entity
entity transition_merge is
  port (
    preds      : in   BooleanArray;
    symbol_out : out  boolean);
end transition_merge;

architecture default_arch of transition_merge is
begin  -- default_arch

  -- The transition fires when any of its preds is true.
  symbol_out <= OrReduce(preds);

end default_arch;
