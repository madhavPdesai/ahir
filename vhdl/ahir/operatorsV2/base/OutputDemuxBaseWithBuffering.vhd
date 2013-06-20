library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

-------------------------------------------------------------------------------
-- a single level requester on the left, and nreq requesters on the right.
--
-- reqR -> ackR can be zero delay.
-- reqL -> ackL has at least a unit delay
--
-- This demux provides buffering for each output.
-- (potentially useful in loop-pipelining).
-------------------------------------------------------------------------------
entity OutputDeMuxBaseWithBuffering is
  generic(name: string;
          iwidth: integer := 4;
	  owidth: integer := 12;
	  twidth: integer := 2;
	  nreqs: integer := 3;
	  detailed_buffering_per_output: IntegerArray);
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
end OutputDeMuxBaseWithBuffering;

architecture Behave of OutputDeMuxBaseWithBuffering is
  signal ackL_array : std_logic_vector(nreqs-1 downto 0);
  alias buffer_sizes: IntegerArray(detailed_buffering_per_output'length-1 downto 0) is detailed_buffering_per_output;

begin  -- Behave
  assert(owidth = iwidth*nreqs) report "word-length mismatch in output demux" severity failure;

  bufGen: for I in 0 to nreqs-1 generate

    -- purpose: instantiate a buffer
    BufBlock: block
      signal write_req,write_ack : std_logic;
      signal unload_req,unload_ack : boolean;
      signal buf_data_in, buf_data_out : std_logic_vector(iwidth-1 downto 0);
      signal valid : std_logic;
    begin  -- block BufBlock

       ub : UnloadBuffer generic map (
         name => name & " buffer " & Convert_To_String(I),
         buffer_size => buffer_sizes(I),
         data_width  => iwidth)
         port map (
           write_req  => write_req,
           write_ack  => write_ack,
           write_data => buf_data_in,
           unload_req => unload_req,
           unload_ack => unload_ack,
           read_data  => buf_data_out,
           clk        => clk,
           reset      => reset);

      
      ---------------------------------------------------------------------------
      -- valid true if this I is mentioned in tag
      ---------------------------------------------------------------------------
      valid <= '1' when (reqL = '1') and (I = To_Integer(To_Unsigned(tagL))) else '0';
      write_req <= valid;
      ackL_array(I) <= write_ack when (valid = '1') else '0';

      -------------------------------------------------------------------------
      -- dataL goes to each buffer.
      -------------------------------------------------------------------------
      buf_data_in <= dataL;


      -------------------------------------------------------------------------
      -- unload side is straightforward
      -------------------------------------------------------------------------
      unload_req <= reqR(I);
      ackR(I) <= unload_ack;
      dataR(((I+1)*iwidth)-1 downto I*iwidth) <= buf_data_out;
      
    end block BufBlock;
  end generate bufGen;

  -- ack is OrReduced from the Demux combinations.
  ackL <= OrReduce(ackL_array);
end Behave;
