library ahir;
use ahir.Types.all;
use ahir.subprograms.all;

entity transition is
  port (
    preds      : in   BooleanArray;
    symbol_in  : in   boolean;
    symbol_out : out  boolean);
end transition;

architecture default_arch of transition is
begin  -- default_arch

  -- The transition is enabled only when all preds are true.
  symbol_out <= symbol_in and AndReduce(preds);

end default_arch;
