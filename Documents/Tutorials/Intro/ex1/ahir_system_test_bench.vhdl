library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.memory_subsystem_package.all;
use ahir.types.all;
use ahir.subprograms.all;
use ahir.components.all;
use ahir.basecomponents.all;
use ahir.operatorpackage.all;
use ahir.utilities.all;
use ahir.functionLibraryComponents.all;
library work;
use work.ahir_system_global_package.all;
library GhdlLink;
use GhdlLink.Utility_Package.all;
use GhdlLink.Vhpi_Foreign.all;
entity ahir_system_Test_Bench is -- 
  -- 
end entity;
architecture VhpiLink of ahir_system_Test_Bench is -- 
  component ahir_system is -- 
    port (-- 
      maxOfTwo_a : in  std_logic_vector(31 downto 0);
      maxOfTwo_b : in  std_logic_vector(31 downto 0);
      maxOfTwo_ret_val_x_x : out  std_logic_vector(31 downto 0);
      maxOfTwo_tag_in: in std_logic_vector(1 downto 0);
      maxOfTwo_tag_out: out std_logic_vector(1 downto 0);
      maxOfTwo_start_req : in std_logic;
      maxOfTwo_start_ack : out std_logic;
      maxOfTwo_fin_req   : in std_logic;
      maxOfTwo_fin_ack   : out std_logic;
      clk : in std_logic;
      reset : in std_logic); -- 
    -- 
  end component;
  signal clk: std_logic := '0';
  signal reset: std_logic := '1';
  signal maxOfTwo_a :  std_logic_vector(31 downto 0) := (others => '0');
  signal maxOfTwo_b :  std_logic_vector(31 downto 0) := (others => '0');
  signal maxOfTwo_ret_val_x_x :   std_logic_vector(31 downto 0);
  signal maxOfTwo_tag_in: std_logic_vector(1 downto 0);
  signal maxOfTwo_tag_out: std_logic_vector(1 downto 0);
  signal maxOfTwo_start_req : std_logic := '0';
  signal maxOfTwo_start_ack : std_logic := '0';
  signal maxOfTwo_fin_req   : std_logic := '0';
  signal maxOfTwo_fin_ack   : std_logic := '0';
  -- 
begin --
  -- clock/reset generation 
  clk <= not clk after 5 ns;
  process
  begin --
    Vhpi_Initialize;
    wait until clk = '1';
    reset <= '0';
    while true loop --
      wait until clk = '0';
      Vhpi_Listen;
      Vhpi_Send;
      --
    end loop;
    wait;
    --
  end process;
  -- connect all the top-level modules to Vhpi
  process
  variable val_string, obj_ref: VhpiString;
  begin --
    wait until reset = '0';
    while true loop -- 
      wait until clk = '0';
      wait for 1 ns;
      obj_ref := Pack_String_To_VHPI_String("maxOfTwo req");
      Vhpi_Get_Port_Value(obj_ref,val_string,1);
      maxOfTwo_start_req <= To_Std_Logic(val_string);
      obj_ref := Pack_String_To_Vhpi_String("maxOfTwo 0");
      Vhpi_Get_Port_Value(obj_ref,val_string, 32);
      maxOfTwo_a <= Unpack_String(val_string,32);
      obj_ref := Pack_String_To_Vhpi_String("maxOfTwo 1");
      Vhpi_Get_Port_Value(obj_ref,val_string, 32);
      maxOfTwo_b <= Unpack_String(val_string,32);
      wait for 0 ns;
      if maxOfTwo_start_req = '1' then -- 
        while true loop --
          wait until clk = '1';
          if maxOfTwo_start_ack = '1' then exit; end if;--
        end loop; 
        maxOfTwo_start_req <= '0';
        maxOfTwo_fin_req <= '1';
        while true loop -- 
          wait until clk = '1';
          if maxOfTwo_fin_ack = '1' then exit; end if; --  
        end loop; 
        maxOfTwo_fin_req <= '0';
        -- 
      end if; 
      obj_ref := Pack_String_To_Vhpi_String("maxOfTwo ack");
      val_string := To_String(maxOfTwo_fin_ack);
      Vhpi_Set_Port_Value(obj_ref,val_string,1);
      obj_ref := Pack_String_To_Vhpi_String("maxOfTwo 0");
      val_string := Pack_SLV_To_Vhpi_String(maxOfTwo_ret_val_x_x);
      Vhpi_Set_Port_Value(obj_ref,val_string,32);
      -- 
    end loop;
    --
  end process;
  ahir_system_instance: ahir_system -- 
    port map ( -- 
      maxOfTwo_a => maxOfTwo_a,
      maxOfTwo_b => maxOfTwo_b,
      maxOfTwo_ret_val_x_x => maxOfTwo_ret_val_x_x,
      maxOfTwo_tag_in => maxOfTwo_tag_in,
      maxOfTwo_tag_out => maxOfTwo_tag_out,
      maxOfTwo_start_req => maxOfTwo_start_req,
      maxOfTwo_start_ack => maxOfTwo_start_ack,
      maxOfTwo_fin_req  => maxOfTwo_fin_req, 
      maxOfTwo_fin_ack  => maxOfTwo_fin_ack ,
      clk => clk,
      reset => reset); -- 
  -- 
end VhpiLink;
