library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Subprograms.all;
use ahir.Utilities.all;

entity BinaryEncoder is
  generic (iwidth: integer := 3; owidth: integer := 3);
  port(din: in std_logic_vector(iwidth-1 downto 0);
       dout: out std_logic_vector(owidth-1 downto 0));
end BinaryEncoder;


architecture LowLevel of BinaryEncoder is
  signal ival : integer range 0 to iwidth-1;
  constant awidth : integer := Minimum(Maximum(Ceil_Log2(iwidth),1),owidth);
begin  -- LowLevel

  process(din)
    variable ivar : integer range 0 to iwidth-1;
  begin
    ivar := 0;
    for I in 0 to iwidth-1 loop
      if(din(I) = '1') then
        ivar := I;
        exit;
      end if;
    end loop;
    ival <= ivar;
  end process;

  process(ival)
    variable doutvar : std_logic_vector(owidth-1 downto 0);
  begin
    doutvar := (others => '0');
    doutvar(awidth-1 downto 0) := To_SLV(To_Unsigned(ival,awidth));
    dout <= doutvar;
  end process;
    

end LowLevel;
