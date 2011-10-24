
library ieee;
use ieee.std_logic_1164.all;
library ahir;

use ahir.types.all;
use ahir.subprograms.all;
use ahir.utilities.all;
use ahir.basecomponents.all;

entity output_queues_cut_down is
  generic ( Port_Id_LSB_Index : integer; Port_Id_Width: integer);
  port(
    out_data_0 : out std_logic_vector(63 downto 0);
    out_ctrl_0 : out std_logic_vector( 7 downto 0);
    out_rdy_0  : in std_logic;
    out_wr_0   : out std_logic;

    out_data_2 : out std_logic_vector(63 downto 0);
    out_ctrl_2 : out std_logic_vector( 7 downto 0);
    out_rdy_2  : in std_logic;
    out_wr_2   : out std_logic;

    out_data_4 : out std_logic_vector(63 downto 0);
    out_ctrl_4 : out std_logic_vector( 7 downto 0);
    out_rdy_4 : in std_logic;
    out_wr_4   : out std_logic;

    out_data_6 : out std_logic_vector(63 downto 0);
    out_ctrl_6 : out std_logic_vector( 7 downto 0);
    out_rdy_6 : in std_logic;
    out_wr_6   : out std_logic;        
    
    in_data : in std_logic_vector(63 downto 0);
    in_ctrl : in std_logic_vector(7 downto 0);
    in_rdy  : out std_logic;
    in_wr   : in std_logic;
  
    clk: in std_logic;
    reset : in std_logic
  );
  
end output_queues_cut_down;


architecture Behave of output_queues_cut_down is

  type DataWords is array (natural range <>) of std_logic_vector(63 downto 0);
  type ControlWords is array (natural range <>) of std_logic_vector(7 downto 0);
  type ControlDataWords is array (natural range <>) of std_logic_vector(71 downto 0);  

  signal queue_in, queue_out : ControlDataWords( 3 downto 0);
  signal out_data : DataWords(3 downto 0);
  signal out_ctrl : ControlWords(7 downto 0);
  
  signal queue_rdy, push_req, push_ack, nearly_full, pop_ack, pop_req, out_wr, out_rdy : std_logic_vector(3 downto 0);

  signal port_id : std_logic_vector(Port_Id_Width-1 downto 0);
  signal sel_port : std_logic_vector(3 downto 0);

  signal port_is_active : std_logic_vector(3 downto 0);
  signal port_is_active_reg : std_logic_vector(3 downto 0);
  signal port_is_active_final : std_logic_vector(3 downto 0);
  signal infifo_pop : std_logic_vector(3 downto 0);


  component ProtocolMatchingFifo is
    generic(queue_depth: integer := 3; data_width: integer := 72);
    port(clk: in std_logic;
         reset: in std_logic;
         data_in: in std_logic_vector(data_width-1 downto 0);
         push_req: in std_logic;
         push_ack : out std_logic;
         nearly_full: out std_logic;
         data_out: out std_logic_vector(data_width-1 downto 0);
         pop_ack : out std_logic;
         pop_req: in std_logic);
  end component ProtocolMatchingFifo;

  component SimpleSmallFifo is
    generic(queue_depth: integer := 2; data_width: integer := 72);
    port(clk: in std_logic;
         reset: in std_logic;
         data_in: in std_logic_vector(data_width-1 downto 0);
         push_req: in std_logic;
         push_ack : out std_logic;
         nearly_full: out std_logic;
         data_out: out std_logic_vector(data_width-1 downto 0);
         pop_ack : out std_logic;
         pop_req: in std_logic);
  end component SimpleSmallFifo;

  signal infifo_push_req, infifo_push_ack : std_logic;
  signal infifo_pop_req, infifo_pop_ack : std_logic;
  signal infifo_data_in, infifo_data_out : std_logic_vector(71 downto 0);
  signal infifo_nearly_full : std_logic;
  
begin  -- Behave

  ------------------------------------------------------------------------------
  -- write to an input queue
  -----------------------------------------------------------------------------
  infifo : SimpleSmallFifo generic map (
    queue_depth => 2,
    data_width  => 72)
    port map (
      clk         => clk,
      reset       => reset,
      data_in     => infifo_data_in,
      data_out    => infifo_data_out,
      push_req    => infifo_push_req,
      push_ack    => infifo_push_ack,
      nearly_full => infifo_nearly_full,
      pop_ack     => infifo_pop_ack,
      pop_req     => infifo_pop_req);

  infifo_push_req <= in_wr;
  infifo_data_in  <= (in_ctrl & in_data);
  in_rdy <= not infifo_nearly_full;

  
  infifo_pop_req <= infifo_pop(0) or infifo_pop(1) or infifo_pop(2) or infifo_pop(3);



  -----------------------------------------------------------------------------
  -- demultiplexing
  -----------------------------------------------------------------------------

  port_id <= infifo_data_out(Port_Id_Width+Port_Id_LSB_Index-1 downto Port_Id_LSB_Index);

  -- port 0 is the default.
  sel_port(0) <= port_id(0) or not(sel_port(1) or sel_port(2) or sel_port(3));
  sel_port(1) <= '1' when port_id = "00000100" else '0';
  sel_port(2) <= '1' when port_id = "00010000" else '0';
  sel_port(3) <= '1' when port_id = "01000000" else '0';

  out_wr_0 <= out_wr(0);
  out_wr_2 <= out_wr(1);
  out_wr_4 <= out_wr(2);
  out_wr_6 <= out_wr(3);

  out_rdy(0) <= out_rdy_0;
  out_rdy(1) <= out_rdy_2;
  out_rdy(2) <= out_rdy_4;
  out_rdy(3) <= out_rdy_6;

  out_data_0 <= out_data(0);
  out_data_2 <= out_data(1);
  out_data_4 <= out_data(2);
  out_data_6 <= out_data(3);

  out_ctrl_0 <= out_ctrl(0);
  out_ctrl_2 <= out_ctrl(1);
  out_ctrl_4 <= out_ctrl(2);
  out_ctrl_6 <= out_ctrl(3);
  

  -----------------------------------------------------------------------------
  -- queues
  -----------------------------------------------------------------------------
  QueueGen: for Q in 0 to 3 generate

    -- this is registered below, indicates that queue Q is to be written into.
    port_is_active(Q) <= '1' when ((infifo_data_out(71 downto 64) = "11111111")
                                   and (sel_port(Q) = '1')
                                   and (infifo_pop_ack = '1'))
                         else '0';

    -- register
    process(clk,reset)
    begin
      if(clk'event and clk = '1') then
        if(reset = '1') then
          port_is_active_reg(Q) <= '0';
        else
          if port_is_active(Q) then
            port_is_active_reg(Q) <= '1';
          elsif in_ctrl /= "00000000" then
            port_is_active_reg(Q) <= '0';
          end if;
        end if;
      end if;
    end process;

    -- bypass
    port_is_active_final(Q) <= port_is_active(Q) or port_is_active_reg(Q);

    -- pop to infifo
    infifo_pop(Q) <= port_is_active_final(Q) and push_ack(Q);

    -- if infifo has data, then push into Q.
    push_req(Q)  <= port_is_active_final(Q) and infifo_pop_ack;


    -- input to queue always from infifo
    queue_in(Q) <= infifo_data_out;    


    -- output side interface
    pop_req(Q) <= out_rdy(Q);
    out_wr(Q) <= pop_ack(Q);

    out_data(Q) <= queue_out(Q)(63 downto 0);
    out_ctrl(Q) <= queue_out(Q)(71 downto 64);

    -- the queue
    oq: ProtocolMatchingFifo
      generic map (queue_depth => 2048, data_width => 72)
      port map (
      clk => clk,
      reset => reset,
      data_in => queue_in(Q),
      data_out => queue_out(Q),
      push_req => push_req(Q),
      push_ack => push_ack(Q),
      nearly_full => nearly_full(Q),
      pop_ack => pop_ack(Q),
      pop_req => pop_req(Q));
    
  end generate QueueGen;
  

end Behave;
