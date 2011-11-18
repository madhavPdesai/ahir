library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.mem_function_pack.all;
use ahir.merge_functions.all;
use ahir.mem_component_pack.all;
use ahir.BaseComponents.all;

entity PipelinedMuxStage is 
  generic (g_data_width: integer := 10;
           g_number_of_inputs: integer := 8;
           g_number_of_outputs: integer := 1;
           g_tag_width : integer := 3  -- width of tag
           );            

  port(data_left: in  std_logic_vector((g_data_width*g_number_of_inputs)-1 downto 0);
       req_in : in std_logic_vector(g_number_of_inputs-1 downto 0);
       ack_out : out std_logic_vector(g_number_of_inputs-1 downto 0);
       data_right: out std_logic_vector((g_data_width*g_number_of_outputs)-1 downto 0);
       req_out : out std_logic_vector(g_number_of_outputs-1 downto 0);
       ack_in : in std_logic_vector(g_number_of_outputs-1 downto 0);
       clock: in std_logic;
       reset: in std_logic);

end PipelinedMuxStage;

architecture behave of PipelinedMuxStage is

  constant c_num_inputs_per_tree : integer := Ceiling(g_number_of_inputs,g_number_of_outputs);
  constant c_residual_num_inputs_per_tree : integer := (g_number_of_inputs - ((g_number_of_outputs-1)*c_num_inputs_per_tree));
  
  signal in_data : std_logic_vector((g_data_width*g_number_of_inputs)-1 downto 0);
  signal in_req,in_ack : std_logic_vector(g_number_of_inputs-1 downto 0);
  signal out_req,out_ack : std_logic_vector(g_number_of_outputs-1 downto 0);
  signal out_data : std_logic_vector((g_number_of_outputs*g_data_width)-1 downto 0);
  
  signal repeater_in, repeater_out : std_logic_vector((g_number_of_outputs*g_data_width)-1 downto 0);
  signal repeater_in_req,repeater_in_ack,repeater_out_req,repeater_out_ack : std_logic_vector(g_number_of_outputs-1 downto 0);

  
begin  -- behave

  assert g_number_of_inputs > 0 and g_number_of_outputs > 0 report "at least one i/p and o/p needed in merge-box with repeater" severity error;
  
  -- unpack input-side signals.
  genIn: for I in 0 to g_number_of_inputs-1 generate
    in_data((g_data_width*(I+1))-1 downto (g_data_width*I)) <=
      data_left((g_data_width*(I+1) -1) downto (g_data_width*I));
    in_req(I) <= req_in(I);
    ack_out(I) <= in_ack(I);
  end generate genIn;

  -- unpack output side signals.
  genOut: for I in 0 to g_number_of_outputs-1 generate
    repeater_in((g_data_width)*(I+1)-1 downto ((g_data_width)*I))
      <= out_data((g_data_width*(I+1))-1 downto (g_data_width*I));
    repeater_in_req(I) <= out_req(I);
    out_ack(I) <= repeater_in_ack(I);
    
    data_right((g_data_width*(I+1))-1 downto (g_data_width*I)) <=
          repeater_out((g_data_width)*(I+1)-1 downto ((g_data_width)*I));
    req_out(I) <= repeater_out_req(I);
    repeater_out_ack(I) <= ack_in(I);
  end generate genOut;

  -- now instantiate the comb.merge block followed by the
  -- repeater.
  ifgen: if g_number_of_outputs > 1 generate
    
    genLogic: for J in 0 to g_number_of_outputs-2 generate

      cmerge: CombinationalMux
        generic map(g_data_width        => g_data_width,
                    g_number_of_inputs  => c_num_inputs_per_tree)
        port map(in_data    => in_data    (((J+1)*c_num_inputs_per_tree*g_data_width)-1
                                           downto
                                           (J*c_num_inputs_per_tree*g_data_width)),
                 out_data   => out_data   ((J+1)*(g_data_width)-1 downto (J*g_data_width)),
                 in_req     => in_req     (((J+1)*c_num_inputs_per_tree)-1 downto (J*c_num_inputs_per_tree)),
                 in_ack     => in_ack     (((J+1)*c_num_inputs_per_tree)-1 downto (J*c_num_inputs_per_tree)),
                 out_req    => out_req    (J),
                 out_ack    => out_ack    (J));

      Rptr: QueueBase generic map(queue_depth => 2, data_width => g_data_width)
        port map(clk      => clock,
                 reset    => reset,
                 data_in  => repeater_in      ((J+1)*(g_data_width) -1 downto (J*(g_data_width))),
                 push_req   => repeater_in_req  (J),
                 push_ack  => repeater_in_ack  (J),
                 data_out => repeater_out     ((J+1)*(g_data_width) -1 downto (J*(g_data_width))),
                 pop_ack  => repeater_out_req (J),
                 pop_req   => repeater_out_ack (J));
      
    end generate genLogic;
  end generate ifgen;


  -- residual block
  cmerge: CombinationalMux
    generic map(g_data_width        => g_data_width,
                g_number_of_inputs  => c_residual_num_inputs_per_tree)
    port map(in_data    => in_data    ((g_number_of_inputs*g_data_width-1) downto
                                       ((g_number_of_inputs*g_data_width) -
                                        (c_residual_num_inputs_per_tree*g_data_width))),
             out_data   => out_data   ((g_number_of_outputs)*(g_data_width)-1 downto
                                       ((g_number_of_outputs-1)*g_data_width)),
             in_req     => in_req     (g_number_of_inputs-1 downto
                                       (g_number_of_inputs - c_residual_num_inputs_per_tree)),
             in_ack     => in_ack     (g_number_of_inputs-1 downto
                                       (g_number_of_inputs - c_residual_num_inputs_per_tree)),
             out_req    => out_req    (g_number_of_outputs-1),
             out_ack    => out_ack    (g_number_of_outputs-1));

  -- residual repeater
  Rptr: QueueBase generic map(queue_depth => 2, data_width => g_data_width)
    port map(clk      => clock,
             reset    => reset,
             data_in  => repeater_in      ((g_number_of_outputs)*(g_data_width) -1 downto ((g_number_of_outputs-1)*(g_data_width))),
             push_req   => repeater_in_req  (g_number_of_outputs-1),
             push_ack  => repeater_in_ack  (g_number_of_outputs-1),
             data_out => repeater_out     ((g_number_of_outputs)*(g_data_width) -1 downto ((g_number_of_outputs-1)*(g_data_width))),
             pop_ack  => repeater_out_req (g_number_of_outputs-1),
             pop_req   => repeater_out_ack (g_number_of_outputs-1));

end behave;
