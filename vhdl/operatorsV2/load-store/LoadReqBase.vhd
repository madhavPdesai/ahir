library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.LoadStorePack.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity LoadReqBase is
  generic (
    addr_width : integer;
    data_width : integer;                -- as a multiple of LAU
    tag_width : integer
    );
  port (
    addr : in std_logic_vector(addr_width-1 downto 0);
    req : in std_logic;
    ack : out std_logic;
    tag: in std_logic_vector(tag_width-1 downto 0);
    mreq : out std_logic;
    mack : in  std_logic;
    maddr : out std_logic_vector(addr_width-1 downto 0);
    mtag : out std_logic_vector(tag_width-1 downto 0);
    clk : in std_logic;
    reset : in std_logic);
end LoadReqBase;

architecture Behave of LoadReqBase is
begin  -- Behave
    maddr <= addr;
    mreq  <= req;
    mtag  <= tag;
    ack   <= mack;
end Behave;
