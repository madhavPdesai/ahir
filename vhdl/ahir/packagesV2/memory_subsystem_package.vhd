
library ieee;
use ieee.std_logic_1164.all;

package memory_subsystem_package is

  component memory_subsystem
    generic (
      num_loads       : natural;
      num_stores      : natural;
      addr_width      : natural;
      data_width      : natural;
      tag_width       : natural;
      number_of_banks : natural; -- must be a power of 2!
      mux_degree      : natural;
      demux_degree    : natural;
      base_bank_addr_width: natural;
      base_bank_data_width: natural);
    port (
      lr_addr_in  : in  std_logic_vector((num_loads*addr_width)-1 downto 0);
      lr_req_in   : in  std_logic_vector(num_loads-1 downto 0);
      lr_ack_out  : out std_logic_vector(num_loads-1 downto 0);
      lr_tag_in   : in  std_logic_vector((num_loads*tag_width)-1 downto 0);
      lc_data_out : out std_logic_vector((num_loads*data_width)-1 downto 0);
      lc_req_in   : in  std_logic_vector(num_loads-1 downto 0);
      lc_ack_out  : out std_logic_vector(num_loads-1 downto 0);
      lc_tag_out  : out std_logic_vector((num_loads*tag_width)-1 downto 0);
      sr_addr_in  : in  std_logic_vector((num_stores*addr_width)-1 downto 0);
      sr_data_in  : in  std_logic_vector((num_stores*data_width)-1 downto 0);
      sr_req_in   : in  std_logic_vector(num_stores-1 downto 0);
      sr_ack_out  : out std_logic_vector(num_stores-1 downto 0);
      sr_tag_in   : in  std_logic_vector((num_stores*tag_width)-1 downto 0);
      sc_req_in   : in  std_logic_vector(num_stores-1 downto 0);
      sc_ack_out  : out std_logic_vector(num_stores-1 downto 0);
      sc_tag_out  : out std_logic_vector((num_stores*tag_width)-1 downto 0);
      clock       : in  std_logic;
      reset       : in  std_logic);
  end component;


  component register_bank 
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
  end component register_bank;

  component  dummy_read_only_memory_subsystem 
  generic(num_loads             : natural := 5;
          addr_width            : natural := 9;
          data_width            : natural := 5;
          tag_width             : natural := 7);
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
    -- clock, reset
    ------------------------------------------------------------------------------
    clock : in std_logic;  -- only rising edge is used to trigger activity.
    reset : in std_logic               -- active high.
    );
   end component dummy_read_only_memory_subsystem;

   component dummy_write_only_memory_subsystem is
  	generic( num_stores            : natural := 10;
          addr_width            : natural := 9;
          data_width            : natural := 5;
          tag_width             : natural := 7);
  	port(
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
    end component dummy_write_only_memory_subsystem;

component ordered_memory_subsystem is
  generic(num_loads             : natural := 5;
          num_stores            : natural := 10;
          addr_width            : natural := 9;
          data_width            : natural := 5;
          tag_width             : natural := 7;
          time_stamp_width      : natural := 0;
          number_of_banks       : natural := 1;
          mux_degree            : natural := 10;
          demux_degree          : natural := 10;
	  base_bank_addr_width  : natural := 8;
	  base_bank_data_width  : natural := 8);
  port(
    ------------------------------------------------------------------------------
    -- load request ports
    ------------------------------------------------------------------------------
    lr_addr_in : in std_logic_vector((num_loads*addr_width)-1 downto 0);

    -- req/ack pair:
    -- when both are asserted, time-stamp is set on load request.
    lr_req_in  : in  std_logic_vector(num_loads-1 downto 0);
    lr_ack_out : out std_logic_vector(num_loads-1 downto 0);

    -- tag + timestamp: tag will be returned on completion..
    lr_tag_in : in std_logic_vector((num_loads*(tag_width+time_stamp_width))-1 downto 0);

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
    sr_tag_in : in std_logic_vector((num_stores*(tag_width+time_stamp_width))-1 downto 0);

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
end component ordered_memory_subsystem;

component UnorderedMemorySubsystem is
  generic(num_loads             : natural := 5;
          num_stores            : natural := 10;
          addr_width            : natural := 9;
          data_width            : natural := 5;
          tag_width             : natural := 7;
          -- number_of_banks       : natural := 1; (will always be 1 in this memory)
          mux_degree            : natural := 10;
          demux_degree          : natural := 10;
	  base_bank_addr_width  : natural := 8;
	  base_bank_data_width  : natural := 8);
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
end component UnorderedMemorySubsystem;


end memory_subsystem_package;
