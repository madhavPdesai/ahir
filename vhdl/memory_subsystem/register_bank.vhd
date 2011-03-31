library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.mem_function_pack.all;
use ahir.merge_functions.all;
use ahir.mem_component_pack.all;

-- memory subsystem guarantees that accesses to the same location
-- will take place in the order of the time-stamp assigned to each
-- access (tie breaks will be random). Time-stamp is set at the
-- point of acceptance of an access request.

entity register_bank is
  generic(num_loads             : natural := 5;
          num_stores            : natural := 10;
          addr_width            : natural := 9;
          data_width            : natural := 5;
          tag_width             : natural := 7;
          num_registers         : natural := 1);
  port(
    ------------------------------------------------------------------------------
    -- load request ports
    ------------------------------------------------------------------------------
    lr_addr_in : in std_logic_vector((num_loads*addr_width)-1 downto 0);

    -- req/ack pair:
    -- when both are asserted, time-stamp is set on load request.
    lr_req_in  : in  std_logic_vector(num_loads-1 downto 0);
    lr_ack_out : out std_logic_vector(num_loads-1 downto 0);

    -- tag for request, will be returned on completion.
    lr_tag_in : in std_logic_vector((num_loads*tag_width)-1 downto 0);

    ---------------------------------------------------------------------------
    -- load complete ports
    ---------------------------------------------------------------------------
    lc_data_out : out std_logic_vector((num_loads*data_width)-1 downto 0);

    -- req/ack pair:
    -- when both are asserted, user should latch data_out.
    lc_req_in  : in  std_logic_vector(num_loads-1 downto 0);
    lc_ack_out : out std_logic_vector(num_loads-1 downto 0);

    -- tag of completed request.
    lc_tag_out : out std_logic_vector((num_loads*tag_width)-1 downto 0);

    ------------------------------------------------------------------------------
    -- store request ports
    ------------------------------------------------------------------------------
    sr_addr_in : in std_logic_vector((num_stores*addr_width)-1 downto 0);
    sr_data_in : in std_logic_vector((num_stores*data_width)-1 downto 0);

    -- req/ack pair:
    -- when both are asserted, time-stamp is set on store request.
    sr_req_in  : in  std_logic_vector(num_stores-1 downto 0);
    sr_ack_out : out std_logic_vector(num_stores-1 downto 0);

    -- tag for request, will be returned on completion.
    sr_tag_in : in std_logic_vector((num_stores*tag_width)-1 downto 0);

    ---------------------------------------------------------------------------
    -- store complete ports
    ---------------------------------------------------------------------------
    -- req/ack pair:
    -- when both are asserted, user assumes that store is done.
    sc_req_in  : in  std_logic_vector(num_stores-1 downto 0);
    sc_ack_out : out std_logic_vector(num_stores-1 downto 0);

    -- tag of completed request.
    sc_tag_out : out std_logic_vector((num_stores*tag_width)-1 downto 0);

    ------------------------------------------------------------------------------
    -- clock, reset
    ------------------------------------------------------------------------------
    clock : in std_logic;  -- only rising edge is used to trigger activity.
    reset : in std_logic               -- active high.
    );
end entity register_bank;


-- architecture: synchronous R/W.
--               on destination conflict, writer with lowest index wins.
architecture Default of register_bank is
  type DataArray is array (natural range <>) of std_logic_vector(data_width-1 downto 0);
  type AddrArray is array (natural range <>) of std_logic_vector(addr_width-1 downto 0);

  signal register_array : DataArray(num_registers-1 downto 0);

  signal lr_ack_flag: std_logic_vector(num_loads-1 downto 0);
  signal sr_ack_flag : std_logic_vector(num_stores-1 downto 0);
  
  signal lc_ack_flag : std_logic_vector(num_loads-1 downto 0);
  signal sc_ack_flag : std_logic_vector(num_stores-1 downto 0);

  signal lc_data_out_sig : std_logic_vector((num_loads*data_width)-1 downto 0);
  signal sc_tag_out_sig : std_logic_vector((num_stores*tag_width)-1 downto 0);
  signal lc_tag_out_sig : std_logic_vector((num_loads*tag_width)-1 downto 0);
    


  
begin

  assert(2**addr_width >= num_registers) report "not enough address bits" severity failure;
  
  -- read/write will take one cycle
  process(clock,
          sr_addr_in,
          lr_addr_in,
          sr_req_in,
          lr_req_in,
          sc_ack_flag,
          lc_ack_flag,
          sr_tag_in,
          lr_tag_in,
          sc_req_in,
          lc_req_in,
          register_array)
    
    variable sc_ack_set, sc_ack_clear, sr_pending : std_logic_vector(num_stores-1 downto 0);
    variable lc_ack_set, lc_ack_clear, lr_pending : std_logic_vector(num_loads-1 downto 0);
    variable lc_data_out_var : std_logic_vector((num_loads*data_width)-1 downto 0);
    variable sc_tag_out_var : std_logic_vector((num_stores*tag_width)-1 downto 0);
    variable lc_tag_out_var : std_logic_vector((num_loads*tag_width)-1 downto 0);
    variable register_array_var : DataArray(num_registers-1 downto 0);
    
  begin


    sc_ack_set := (others => '0');
    sc_ack_clear := (others => '0');
    lc_ack_set := (others => '0');
    lc_ack_clear := (others => '0');
    
    sr_pending := (others => '0');
    lr_pending := (others => '0');

    lc_data_out_var := lc_data_out_sig;
    sc_tag_out_var := sc_tag_out_sig;
    lc_tag_out_var := lc_tag_out_sig;

    register_array_var := register_array;
    
    
    if(reset = '1') then
      sc_ack_clear := (others => '1');
      lc_ack_clear := (others => '1');
    else
      
      
      -- for each register.
      for REG  in 0 to num_registers-1 loop

        -- writes: for each reg, lowest index succeeds.
        for W in 0 to num_stores-1 loop
          -- if there is a store request.
          if(sr_req_in(W) = '1' and
             (sr_addr_in(((W+1)*addr_width)-1 downto W*addr_width) = Natural_To_SLV(REG,addr_width)))
          then
            -- sr_pending(W) := '1';
            if(sc_ack_flag(W) = '0' or sc_req_in(W) = '1') then

              -- room for operation
              sc_ack_set(W) := '1';
              register_array_var(REG) := sr_data_in(((W+1)*data_width)-1 downto W*data_width);
              sc_tag_out_var(((W+1)*tag_width)-1 downto W*tag_width) := sr_tag_in(((W+1)*tag_width)-1 downto W*tag_width);
              exit;                     -- lowest index succeeds.
              
            end if;
          end if;
        end loop;  -- W

        
        -- read from REG =>  all can succeed
        for R in 0 to num_loads-1 loop

          if(lr_req_in(R) = '1' and
             lr_addr_in(((R+1)*addr_width)-1 downto R*addr_width) = Natural_To_SLV(REG,addr_width))
          then
            -- lr_pending(R) := '1';
            if(lc_ack_flag(R) = '0' or lc_req_in(R) = '1') then
		-- set the lc_ack flag if the current flag is cleared
              lc_data_out_var(((R+1)*data_width)-1 downto R*data_width) := register_array(REG);
              lc_tag_out_var(((R+1)*tag_width)-1 downto R*tag_width) :=
                lr_tag_in(((R+1)*tag_width)-1 downto R*tag_width);
              lc_ack_set(R) := '1';
            end if;
          end if;
        end loop;  -- R
      end loop;  -- REG
    end if;      

    -- output latches and registers
    if(clock'event and clock = '1') then
      register_array <= register_array_var;
      lc_data_out_sig <= lc_data_out_var;
      lc_tag_out_sig <= lc_tag_out_var;
      sc_tag_out_sig <= sc_tag_out_var;
    end if;
    
    -- lc/sc ack clears.
    if(clock'event and clock = '1') then                
      for W in 0 to num_stores-1 loop

	-- if ack and req are both asserted, clear
	-- it unless asked to set it.
        if(sc_ack_flag(W) = '1' and sc_req_in(W) = '1') then
          sc_ack_clear(W) := '1';
        end if;

	-- set dominant!
        if(sc_ack_set(W) = '1') then
          sc_ack_flag(W) <= '1';
        elsif (sc_ack_clear(W) = '1') then
          sc_ack_flag(W) <= '0';
        end if;
      end loop;
    end if;      

    if(clock'event and clock = '1') then                
      for R in 0 to num_loads-1 loop

	-- if ack and req are both asserted, clear
	-- it unless asked to set it.
        if(lc_ack_flag(R) = '1' and lc_req_in(R) = '1') then
          lc_ack_clear(R) := '1';
        end if;

	-- set dominant!
        if(lc_ack_set(R) = '1') then
          lc_ack_flag(R) <= '1';
        elsif (lc_ack_clear(R) = '1') then
          lc_ack_flag(R) <= '0';
        end if;
        
      end loop;
    end if;      

    sr_ack_out <= sc_ack_set;
    lr_ack_out <= lc_ack_set;

  end process;

  sc_ack_out <= sc_ack_flag;
  lc_ack_out <= lc_ack_flag;
  lc_data_out <= lc_data_out_sig;
  lc_tag_out <= lc_tag_out_sig;
  sc_tag_out <= sc_tag_out_sig;
  
end Default;

