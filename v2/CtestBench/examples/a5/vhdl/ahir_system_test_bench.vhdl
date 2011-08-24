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
library work;
use work.vc_system_package.all;
use work.Utility_Package.all;
use work.Vhpi_Foreign.all;
entity ahir_system_Test_Bench is -- 
  -- 
end entity;
architecture VhpiLink of ahir_system_Test_Bench is -- 
  component ahir_system is -- 
    port (-- 
      main_inner_ret_val_x_x : out  std_logic_vector(31 downto 0);
      main_inner_tag_in: in std_logic_vector(0 downto 0);
      main_inner_tag_out: out std_logic_vector(0 downto 0);
      main_inner_start_req : in std_logic;
      main_inner_start_ack : out std_logic;
      main_inner_fin_req   : in std_logic;
      main_inner_fin_ack   : out std_logic;
      clk : in std_logic;
      reset : in std_logic;
      outpipe_pipe_read_data: out std_logic_vector(31 downto 0);
      outpipe_pipe_read_req : in std_logic_vector(0 downto 0);
      outpipe_pipe_read_ack : out std_logic_vector(0 downto 0)); -- 
    -- 
  end component;
  signal clk: std_logic := '0';
  signal reset: std_logic := '1';
  signal main_inner_ret_val_x_x :   std_logic_vector(31 downto 0);
  signal main_inner_tag_in: std_logic_vector(0 downto 0);
  signal main_inner_tag_out: std_logic_vector(0 downto 0);
  signal main_inner_start_req : std_logic := '0';
  signal main_inner_start_ack : std_logic := '0';
  signal main_inner_fin_req   : std_logic := '0';
  signal main_inner_fin_ack   : std_logic := '0';
  -- read from pipe outpipe
  signal outpipe_pipe_read_data: std_logic_vector(31 downto 0);
  signal outpipe_pipe_read_req : std_logic_vector(0 downto 0) := (others => '0');
  signal outpipe_pipe_read_ack : std_logic_vector(0 downto 0);
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
      obj_ref := Pack_String_To_VHPI_String("main_inner req");
      Vhpi_Get_Port_Value(obj_ref,val_string,1);
      main_inner_start_req <= To_Std_Logic(val_string);
      if main_inner_start_req = '1' then -- 
        while true loop --
          wait until clk = '1';
          if main_inner_start_ack = '1' then exit; end if;--
        end loop; 
        main_inner_start_req <= '0';
        main_inner_fin_req <= '1';
        while true loop -- 
          wait until clk = '1';
          if main_inner_fin_ack = '1' then exit; end if; --  
        end loop; 
        main_inner_fin_req <= '0';
        -- 
      end if; 
      obj_ref := Pack_String_To_Vhpi_String("main_inner ack");
      val_string := To_String(main_inner_fin_ack);
      Vhpi_Set_Port_Value(obj_ref,val_string,1);
      obj_ref := Pack_String_To_Vhpi_String("main_inner 0");
      val_string := Pack_SLV_To_Vhpi_String(main_inner_ret_val_x_x);
      Vhpi_Set_Port_Value(obj_ref,val_string,32);
      -- 
    end loop;
    --
  end process;
  process
  variable val_string, obj_ref: VhpiString;
  begin --
    wait until reset = '0';
    while true loop -- 
      wait until clk = '0';
      wait for 1 ns; 
      obj_ref := Pack_String_To_Vhpi_String("outpipe req");
      Vhpi_Get_Port_Value(obj_ref,val_string,1);
      outpipe_pipe_read_req <= Unpack_String(val_string,1);
      wait until clk = '1';
      obj_ref := Pack_String_To_Vhpi_String("outpipe ack");
      val_string := Pack_SLV_To_Vhpi_String(outpipe_pipe_read_ack);
      Vhpi_Set_Port_Value(obj_ref,val_string,1);
      obj_ref := Pack_String_To_Vhpi_String("outpipe 0");
      val_string := Pack_SLV_To_Vhpi_String(outpipe_pipe_read_data);
      Vhpi_Set_Port_Value(obj_ref,val_string,32);
      -- 
    end loop;
    --
  end process;
  ahir_system_instance: ahir_system -- 
    port map ( -- 
      main_inner_ret_val_x_x => main_inner_ret_val_x_x,
      main_inner_tag_in => main_inner_tag_in,
      main_inner_tag_out => main_inner_tag_out,
      main_inner_start_req => main_inner_start_req,
      main_inner_start_ack => main_inner_start_ack,
      main_inner_fin_req  => main_inner_fin_req, 
      main_inner_fin_ack  => main_inner_fin_ack ,
      clk => clk,
      reset => reset,
      outpipe_pipe_read_data  => outpipe_pipe_read_data, 
      outpipe_pipe_read_req  => outpipe_pipe_read_req, 
      outpipe_pipe_read_ack  => outpipe_pipe_read_ack ); -- 
  -- 
end VhpiLink;
