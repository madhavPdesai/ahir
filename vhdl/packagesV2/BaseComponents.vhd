library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;

package BaseComponents is

  -----------------------------------------------------------------------------
  -- control path components
  -----------------------------------------------------------------------------
  
  component place
    generic (
      marking : boolean); 
    port (
      preds : in  BooleanArray;
      succs : in  BooleanArray;
      token : out boolean;
      clk   : in  std_logic;
      reset : in  std_logic); 
  end component;

  component transition
    port (
      preds      : in BooleanArray;
      symbol_in  : in boolean;
      symbol_out : out boolean); 
  end component;

  -----------------------------------------------------------------------------
  -- miscellaneous
  -----------------------------------------------------------------------------
  component BypassRegister 
  generic(data_width: integer; enable_bypass: boolean); 
  port (
    clk, reset : in  std_logic;
    enable     : in  std_logic;
    data_in     : in  std_logic_vector(data_width-1 downto 0);
    data_out    : out std_logic_vector(data_width-1 downto 0));
  end component BypassRegister;


  -----------------------------------------------------------------------------
  -- operator base components
  -----------------------------------------------------------------------------
  component GenericCombinationalOperator 
  generic
    (
      operator_id   : string;          -- operator id
      input1_is_int : Boolean := true; -- false means float
      input1_characteristic_width : integer := 0; -- characteristic width if input1 is float
      input1_mantissa_width       : integer := 0; -- mantissa width if input1 is float
      iwidth_1      : integer;    -- width of input1
      input2_is_int : Boolean := true; -- false means float
      input2_characteristic_width : integer := 0; -- characteristic width if input2 is float
      input2_mantissa_width       : integer := 0; -- mantissa width if input2 is float
      iwidth_2      : integer;    -- width of input2
      num_inputs    : integer := 2;    -- can be 1 or 2.
      output_is_int : Boolean := true;  -- false means that the output is a float
      output_characteristic_width : integer := 0;
      output_mantissa_width       : integer := 0;
      owidth        : integer;          -- width of output.
      constant_operand : std_logic_vector; -- constant operand.. (it is always the second operand)
      use_constant  : boolean := false
      );
  port (
    data_in       : in  std_logic_vector(iwidth_1 + iwidth_2 - 1 downto 0);
    result      : out std_logic_vector(owidth-1 downto 0)
    );
  end component GenericCombinationalOperator;

  component UnsharedOperatorBase 
    generic
      (
        operator_id   : string;          -- operator id
        input1_is_int : Boolean := true; -- false means float
        input1_characteristic_width : integer := 0; -- characteristic width if input1 is float
        input1_mantissa_width       : integer := 0; -- mantissa width if input1 is float
        iwidth_1      : integer;    -- width of input1
        input2_is_int : Boolean := true; -- false means float
        input2_characteristic_width : integer := 0; -- characteristic width if input2 is float
        input2_mantissa_width       : integer := 0; -- mantissa width if input2 is float
        iwidth_2      : integer;    -- width of input2
        num_inputs    : integer := 2;    -- can be 1 or 2.
        output_is_int : Boolean := true;  -- false means that the output is a float
        output_characteristic_width : integer := 0;
        output_mantissa_width       : integer := 0;
        owidth        : integer;          -- width of output.
        constant_operand : std_logic_vector; -- constant operand.. (it is always the second operand)
        use_constant  : boolean := false;  -- if true, the second operand is
                                           -- assumed to be the generic
        zero_delay    : boolean := false;  -- if true, operator result is
                                           -- registered, but with a bypass, so
                                           -- that the result is available immediately.
        flow_through  : boolean := false  -- if true, operator is combinational
        );
    port (
      -- req -> ack follow pulse protocol
      reqL:  in Boolean;
      ackL : out Boolean;
      reqR : in Boolean;
      ackR:  out Boolean;
      -- operands.
      dataL      : in  std_logic_vector(iwidth_1 + iwidth_2 - 1 downto 0);
      dataR      : out std_logic_vector(owidth-1 downto 0);
      clk, reset : in  std_logic);
  end component UnsharedOperatorBase;

  component SplitOperatorBase
    generic
      (
        operator_id   : string;          -- operator id
        input1_is_int : Boolean := true; -- false means float
        input1_characteristic_width : integer := 0; -- characteristic width if input1 is float
        input1_mantissa_width       : integer := 0; -- mantissa width if input1 is float
        iwidth_1      : integer;    -- width of input1
        input2_is_int : Boolean := true; -- false means float
        input2_characteristic_width : integer := 0; -- characteristic width if input2 is float
        input2_mantissa_width       : integer := 0; -- mantissa width if input2 is float
        iwidth_2      : integer;    -- width of input2
        num_inputs    : integer := 2;    -- can be 1 or 2.
        output_is_int : Boolean := true;  -- false means that the output is a float
        output_characteristic_width : integer := 0;
        output_mantissa_width       : integer := 0;
        owidth        : integer;          -- width of output.
        constant_operand : std_logic_vector; -- constant operand.. (it is always the second operand)
        twidth        : integer;          -- tag width
        use_constant  : boolean := false;  -- if true, the second operand is
                                           -- provided by the generic.
        zero_delay    : boolean := false  -- if true, the result is registered,
                                          -- but with a bypass, so that it is
                                          -- available immediately.
        );
    port (
      -- req/ack follow level protocol
      reqR: out std_logic;
      ackR: in std_logic;
      reqL: in std_logic;
      ackL : out  std_logic;
      -- tagL is passed out to tagR
      tagL       : in  std_logic_vector(twidth-1 downto 0);
      -- input array consists of m sets of 1 or 2 possibly concatenated
      -- operands.
      dataL      : in  std_logic_vector(iwidth_1 + iwidth_2 - 1 downto 0);
      dataR      : out std_logic_vector(owidth-1 downto 0);
      -- tagR is received from tagL, concurrent
      -- with dataR
      tagR       : out std_logic_vector(twidth-1 downto 0);
      clk, reset : in  std_logic);
  end component SplitOperatorBase;


  component SplitOperatorShared
    generic
      (
        operator_id   : string;          -- operator id
        input1_is_int : Boolean := true; -- false means float
        input1_characteristic_width : integer := 0; -- characteristic width if input1 is float
        input1_mantissa_width       : integer := 0; -- mantissa width if input1 is float
        iwidth_1      : integer;    -- width of input1
        input2_is_int : Boolean := true; -- false means float
        input2_characteristic_width : integer := 0; -- characteristic width if input2 is float
        input2_mantissa_width       : integer := 0; -- mantissa width if input2 is float
        iwidth_2      : integer;    -- width of input2
        num_inputs    : integer := 2;    -- can be 1 or 2.
        output_is_int : Boolean := true;  -- false means that the output is a float
        output_characteristic_width : integer := 0;
        output_mantissa_width       : integer := 0;
        owidth        : integer;          -- width of output.
        constant_operand : std_logic_vector; -- constant operand.. (it is always the second operand)
        use_constant  : boolean := false;
        zero_delay    : boolean := false;
        no_arbitration: boolean := false;
        num_reqs : integer  -- how many requesters?
        );

    port (
      -- req/ack follow level protocol
      reqL                     : in BooleanArray(num_reqs-1 downto 0);
      ackR                     : out BooleanArray(num_reqs-1 downto 0);
      ackL                     : out BooleanArray(num_reqs-1 downto 0);
      reqR                     : in  BooleanArray(num_reqs-1 downto 0);
      -- input data consists of concatenated pairs of ips
      dataL                    : in std_logic_vector(((iwidth_1 + iwidth_2)*num_reqs)-1 downto 0);
      -- output data consists of concatenated pairs of ops.
      dataR                    : out std_logic_vector((owidth*num_reqs)-1 downto 0);
      -- with dataR
      clk, reset              : in std_logic);
  end component SplitOperatorShared;


  component SplitOperatorSharedTB 
    generic
      ( g_num_req: integer := 2;
        operator_id: string := "ApIntSle";
        zero_delay : boolean := false;
        verbose_mode: boolean := false;
        input_data_width: integer := 8;
        output_data_width: integer := 1;
        num_ips : integer := 2;
        tb_id : string := "anonymous"
        );
  end component SplitOperatorSharedTB;

  -----------------------------------------------------------------------------
  -- register operator
  -----------------------------------------------------------------------------
  component RegisterBase 
      generic(in_data_width: integer; out_data_width : integer);
      port(din: in std_logic_vector(in_data_width-1 downto 0);
           dout: out std_logic_vector(out_data_width-1 downto 0);
           req: in boolean;
           ack: out boolean;
           clk,reset: in std_logic);
  end component RegisterBase;

  -----------------------------------------------------------------------------
  -- repeater
  -----------------------------------------------------------------------------
  component RepeaterBase 
    generic(data_width: integer := 32);
    port(clk: in std_logic;
       reset: in std_logic;
       data_in: in std_logic_vector(data_width-1 downto 0);
       req_in: in std_logic;
       ack_out : out std_logic;
       data_out: out std_logic_vector(data_width-1 downto 0);
       req_out : out std_logic;
       ack_in: in std_logic);
   end component RepeaterBase;

  component ShiftRepeaterBase 
   generic(data_width: integer := 32; number_of_stages: natural := 1);
    port(clk: in std_logic;
       reset: in std_logic;
       data_in: in std_logic_vector(data_width-1 downto 0);
       req_in: in std_logic;
       ack_out : out std_logic;
       data_out: out std_logic_vector(data_width-1 downto 0);
       req_out : out std_logic;
       ack_in: in std_logic);
  end component ShiftRepeaterBase;

  -----------------------------------------------------------------------------
  -- pipe
  -----------------------------------------------------------------------------
  component PipeBase 
    
    generic (num_reads: integer;
             num_writes: integer;
             data_width: integer;
             depth: integer := 1);
    port (
      read_req       : in  std_logic_vector(num_reads-1 downto 0);
      read_ack       : out std_logic_vector(num_reads-1 downto 0);
      read_data      : out std_logic_vector((num_reads*data_width)-1 downto 0);
      write_req       : in  std_logic_vector(num_writes-1 downto 0);
      write_ack       : out std_logic_vector(num_writes-1 downto 0);
      write_data      : in std_logic_vector((num_writes*data_width)-1 downto 0);
      clk, reset : in  std_logic);
    
  end component PipeBase;


  -----------------------------------------------------------------------------
  -- phi,branch,select
  -----------------------------------------------------------------------------

  component PhiBase 
    generic (
      num_reqs   : integer;
      data_width : integer);
    port (
      req                 : in  BooleanArray(num_reqs-1 downto 0);
      ack                 : out Boolean;
      idata               : in  std_logic_vector((num_reqs*data_width)-1 downto 0);
      odata               : out std_logic_vector(data_width-1 downto 0);
      clk, reset          : in std_logic);
  end component PhiBase;


  component BranchBase
    generic (
      condition_width : integer);
    port (condition: in std_logic_vector(condition_width-1 downto 0);
          clk,reset: in std_logic;
          req: in Boolean;
          ack0: out Boolean;
          ack1: out Boolean);
  end component;

  component SelectBase 
    generic(data_width: integer);
    port(x,y: in std_logic_vector(data_width-1 downto 0);
         sel: in std_logic_vector(0 downto 0);
         req: in boolean;
         z: out std_logic_vector(data_width-1 downto 0);
         ack: out boolean;
         clk,reset: in std_logic);
  end component SelectBase;


  -----------------------------------------------------------------------------
  -- mux/demux
  -----------------------------------------------------------------------------
  
  component InputMuxBase 
    generic ( iwidth: integer;
              owidth: integer;
              twidth: integer;
              nreqs: integer;
              no_arbitration: Boolean);
    port (
      -- req/ack follow pulse protocol
      reqL                 : in  BooleanArray(nreqs-1 downto 0);
      ackL                 : out BooleanArray(nreqs-1 downto 0);
      dataL                : in  std_logic_vector(iwidth-1 downto 0);
      -- output side req/ack level protocol
      reqR                 : out std_logic;
      ackR                 : in  std_logic;
      dataR                : out std_logic_vector(owidth-1 downto 0);
      -- tag specifies the requester index 
      tagR                : out std_logic_vector(twidth-1 downto 0);
      clk, reset          : in std_logic);
  end component InputMuxBase;


  component OutputDeMuxBase 
    generic(iwidth: integer;
            owidth: integer;
            twidth: integer;
            nreqs: integer;
            no_arbitration: Boolean);
    port (
      -- req/ack follow level protocol
      reqL                 : in  std_logic;
      ackL                 : out std_logic;
      dataL                : in  std_logic_vector(iwidth-1 downto 0);
      -- tag identifies index to which demux
      -- should happen
      tagL                 : in std_logic_vector(twidth-1 downto 0);
      -- reqR/ackR follow pulse protocol
      -- and are of length n
      reqR                : in BooleanArray(nreqs-1 downto 0);
      ackR                : out  BooleanArray(nreqs-1 downto 0);
      -- dataR is array(n,m) 
      dataR               : out std_logic_vector(owidth-1 downto 0);
      clk, reset          : in std_logic);
  end component OutputDeMuxBase;


  -----------------------------------------------------------------------------
  -- arbiters
  -----------------------------------------------------------------------------
  component CallArbiter
    generic(num_reqs: integer;
            call_data_width: integer;
            return_data_width: integer;
            tag_length: integer);
    port ( -- ready/ready handshake on all ports
      -- ports for the caller
      call_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
      call_acks   : out std_logic_vector(num_reqs-1 downto 0);
      call_data   : in  std_logic_vector((num_reqs*call_data_width)-1 downto 0);
      -- call port connected to the called module
      call_mreq   : out std_logic;
      call_mack   : in  std_logic;
      call_mdata  : out std_logic_vector(call_data_width-1 downto 0);
      call_mtag   : out std_logic_vector(tag_length-1 downto 0);
      -- similarly for return, initiated by the caller
      return_reqs : in  std_logic_vector(num_reqs-1 downto 0);
      return_acks : out std_logic_vector(num_reqs-1 downto 0);
      return_data : out std_logic_vector((num_reqs*return_data_width)-1 downto 0);
      -- return from function
      -- function to assert mreq arbiter to return mack
      -- ( NOTE: It has to be this way, the arbiter should
      -- accept the return value if it has room)
      return_mreq : in std_logic;
      return_mack : out std_logic;
      return_mdata : in  std_logic_vector(return_data_width-1 downto 0);
      return_mtag : in  std_logic_vector(tag_length-1 downto 0);
      clk: in std_logic;
      reset: in std_logic);
  end component CallArbiter;

  component CallArbiterUnitary
    generic(num_reqs: integer;
            call_data_width: integer;
            return_data_width: integer;
            caller_tag_length: integer;
            callee_tag_length: integer);
    port ( -- ready/ready handshake on all ports
      -- ports for the caller
      call_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
      call_acks   : out std_logic_vector(num_reqs-1 downto 0);
      call_data   : in  std_logic_vector((num_reqs*call_data_width)-1 downto 0);
      call_tag    : in  std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
      -- similarly for return, initiated by the caller
      return_reqs   : in  std_logic_vector(num_reqs-1 downto 0);
      return_acks   : out std_logic_vector(num_reqs-1 downto 0);
      return_data   : out std_logic_vector((num_reqs*return_data_width)-1 downto 0);
      return_tag    : out  std_logic_vector((num_reqs*caller_tag_length)-1 downto 0);
      -- ports connected to the called module
      call_start   : out std_logic;
      call_fin   : in  std_logic;
      call_in_args  : out std_logic_vector(call_data_width-1 downto 0);
      call_in_tag   : out std_logic_vector(callee_tag_length-1 downto 0);
      -- from the called module
      call_out_args : in  std_logic_vector(return_data_width-1 downto 0);
      call_out_tag : in  std_logic_vector(callee_tag_length-1 downto 0);
      clk: in std_logic;
      reset: in std_logic);
  end component CallArbiterUnitary;

  component CallMediator
    port (
      call_req: in std_logic;
      call_ack: out std_logic;
      enable_call_data: out std_logic;
      return_req: in std_logic;
      return_ack: out std_logic;
      enable_return_data: out std_logic;
      start: out std_logic;
      fin: in std_logic;
      clk: in std_logic;
      reset: in std_logic);
  end component CallMediator;

  -----------------------------------------------------------------------------
  -- IO ports
  -----------------------------------------------------------------------------
  component InputPort
    generic (num_reqs: integer;
             data_width: integer;
             no_arbitration: boolean);
    port (
      -- pulse interface with the data-path
      req        : in  BooleanArray(num_reqs-1 downto 0);
      ack        : out BooleanArray(num_reqs-1 downto 0);
      data       : out std_logic_vector((num_reqs*data_width)-1 downto 0);
      -- ready/ready interface with outside world
      oreq       : out std_logic;
      oack       : in  std_logic;
      odata      : in  std_logic_vector(data_width-1 downto 0);
      clk, reset : in  std_logic);
  end component;


  component InputPortLevel
    generic (num_reqs: integer; 
             data_width: integer;  
             no_arbitration: boolean);
    port (
      -- ready/ready interface with the requesters
      req       : in  std_logic_vector(num_reqs-1 downto 0);
      ack       : out std_logic_vector(num_reqs-1 downto 0);
      data      : out std_logic_vector((num_reqs*data_width)-1 downto 0);
      -- ready/ready interface with outside world
      oreq       : out std_logic;
      oack       : in  std_logic;
      odata      : in  std_logic_vector(data_width-1 downto 0);
      clk, reset : in  std_logic);
    
  end component InputPortLevel;


  component OutputPort
    generic(num_reqs: integer;
            data_width: integer;
            no_arbitration: boolean);
    port (
      req        : in  BooleanArray(num_reqs-1 downto 0);
      ack        : out BooleanArray(num_reqs-1 downto 0);
      data       : in  std_logic_vector((num_reqs*data_width)-1 downto 0);
      oreq       : out std_logic;
      oack       : in  std_logic;
      odata      : out std_logic_vector(data_width-1 downto 0);
      clk, reset : in  std_logic);
  end component;

  component OutputPortLevel
    generic(num_reqs: integer;
            data_width: integer;
            no_arbitration: boolean);
    port (
      req       : in  std_logic_vector(num_reqs-1 downto 0);
      ack       : out std_logic_vector(num_reqs-1 downto 0);
      data      : in  std_logic_vector((num_reqs*data_width)-1 downto 0);
      oreq       : out std_logic;
      oack       : in  std_logic;
      odata      : out std_logic_vector(data_width-1 downto 0);
      clk, reset : in  std_logic);
  end component;


  -----------------------------------------------------------------------------
  -- load/store
  -----------------------------------------------------------------------------
  component LoadReqShared
    generic
      (
	addr_width: integer;
      	num_reqs : integer; -- how many requesters?
	tag_length: integer;
	no_arbitration: Boolean
        );
    port (
      -- req/ack follow pulse protocol
      reqL                     : in BooleanArray(num_reqs-1 downto 0);
      ackL                     : out BooleanArray(num_reqs-1 downto 0);
      -- concatenated address corresponding to access
      dataL                    : in std_logic_vector((addr_width*num_reqs)-1 downto 0);
      -- address to memory
      maddr                   : out std_logic_vector(addr_width-1 downto 0);
      mtag                    : out std_logic_vector(tag_length-1 downto 0);
      mreq                    : out std_logic;
      mack                    : in std_logic;
      -- clock, reset (active high)
      clk, reset              : in std_logic);
  end component LoadReqShared;

  component StoreReqShared
    generic
      (
	addr_width: integer;
	data_width : integer;
      	num_reqs : integer; -- how many requesters?
	tag_length: integer;
	no_arbitration: Boolean
        );
    port (
      -- req/ack follow pulse protocol
      reqL                     : in BooleanArray(num_reqs-1 downto 0);
      ackL                     : out BooleanArray(num_reqs-1 downto 0);
      -- address corresponding to access
      addr                    : in std_logic_vector((addr_width*num_reqs)-1 downto 0);
      data                    : in std_logic_vector((data_width*num_reqs)-1 downto 0);
      -- address to memory
      maddr                   : out std_logic_vector(addr_width-1 downto 0);
      mdata                   : out std_logic_vector(data_width-1 downto 0);
      mtag                    : out std_logic_vector(tag_length-1 downto 0);
      mreq                    : out std_logic;
      mack                    : in std_logic;
      -- clock, reset (active high)
      clk, reset              : in std_logic);
  end component StoreReqShared;


  component LoadCompleteShared
    generic
      (
        data_width: integer;
        tag_length:  integer;
        num_reqs : integer;
        no_arbitration: boolean
        );
    port (
      -- req/ack follow level protocol
      reqR                     : in BooleanArray(num_reqs-1 downto 0);
      ackR                     : out BooleanArray(num_reqs-1 downto 0);
      dataR                    : out std_logic_vector((data_width*num_reqs)-1 downto 0);
      -- output data consists of concatenated pairs of ops.
      mdata                    : in std_logic_vector(data_width-1 downto 0);
      mreq                     : out std_logic;
      mack                     : in  std_logic;
      mtag                     : in std_logic_vector(tag_length-1 downto 0);
      -- with dataR
      clk, reset              : in std_logic);
  end component LoadCompleteShared;

  component StoreCompleteShared
    generic (num_reqs: integer;
             tag_length: integer);
    port (
      -- in requester array, pulse protocol
      -- more than one requester can be active
      -- at any time
      reqR : in BooleanArray(num_reqs-1 downto 0);
      -- out ack array, pulse protocol
      -- more than one ack can be sent back
      -- at any time.
      --
      -- Note: req -> ack delay can be 0
      ackR : out BooleanArray(num_reqs-1 downto 0);
      -- mreq goes out to memory as 
      -- a response to mack.
      mreq : out std_logic;
      mack : in  std_logic;
      -- mtag to distinguish the 
      -- requesters.
      mtag : in std_logic_vector(tag_length-1 downto 0);
      -- rising edge of clock is used
      clk : in std_logic;
      -- synchronous reset, active high
      reset : in std_logic);
  end component StoreCompleteShared;

end BaseComponents;
