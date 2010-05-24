library ahir;
use ahir.types.all;
use ahir.subprograms.all;


package trickery is

  function "&" (x : ApInt; y : ApInt) return ApInt;

  procedure unflatten (signal holes : out ApIntArray; pigeons : in  ApInt);

end trickery;

package body trickery is

  procedure unflatten (signal holes : out ApIntArray; pigeons : in  ApInt) is
    alias lineup : ApInt(0 to pigeons'length - 1) is pigeons;
    variable p : integer := 0;
  begin
    assert holes'length(1) * holes'length(2) = pigeons'length
      report "holes and pigeons don't match"
      severity error;
    
    p := 0;
    for i in holes'range(1) loop
      for j in holes'range(2) loop
        holes(i,j) <= lineup(p);
        p := p + 1;
      end loop;  -- j
    end loop;  -- i
  end procedure unflatten;

  function "&" (x : ApInt; y : ApInt) return ApInt is
    variable z : ApInt(0 to x'length + y'length - 1);
  begin
    z(0 to x'length - 1) := x;
    z(x'length to z'length - 1) := y;
    return z;
  end function "&";


end trickery;
