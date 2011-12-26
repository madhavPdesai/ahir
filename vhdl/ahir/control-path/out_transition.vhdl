library ahir;
use ahir.Types.all;
use ahir.subprograms.all;

entity out_transition is
  
  port (preds      : in   BooleanArray;
        symbol_out : out  boolean);

end out_transition;

architecture default_arch of out_transition is
begin  -- default_arch

  -- The transition is enabled only when all preds are true.
  symbol_out <= AndReduce(preds);

end default_arch;
