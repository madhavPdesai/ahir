library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.mem_function_pack.all;
use ahir.merge_functions.all;
use ahir.mem_component_pack.all;

entity demerge_tree is
  generic (
    g_demux_degree: natural := 10;
    g_number_of_outputs: natural := 5;
    g_data_width: natural := 8;
    g_id_width: natural := 3;
    g_stage_id: natural := 0
    );       

  port (
    demerge_data_out : out std_logic_vector((g_data_width*g_number_of_outputs)-1 downto 0);
    demerge_ready_out  : out std_logic_vector(g_number_of_outputs-1 downto 0);
    demerge_accept_in   : in std_logic_vector(g_number_of_outputs-1 downto 0);
    demerge_data_in: in std_logic_vector(g_data_width-1 downto 0);
    demerge_ack_out : out std_logic;
    demerge_req_in  : in std_logic;
    demerge_sel_in: in std_logic_vector(g_id_width-1 downto 0);
    clock: in std_logic;
    reset: in std_logic);
  
end demerge_tree;



architecture opt_pipeline of demerge_tree is

    -- some notes:
    --     there are M outputs with k select bits.
    --     the tree is constructed recursively, using
    --     a basic recursion step as follows:
    --     1. from the k select bits, a logD bit 
    --        demux select input is built up.
    --     2. the demux outputs are grouped into
    --        a number of clusters. 
    constant c_demux_degree : natural := 2**Ceil_Log2(g_demux_degree); 
    
    constant demux_sel_width : natural := Ceil_Log2(c_demux_degree); 
    constant demux_data_width : natural := g_data_width + g_id_width; 

    constant residual_id_width: natural := g_id_width - (g_stage_id*demux_sel_width);

    constant group_left_index_array : NaturalArray(0 to c_demux_degree-1) :=
      Calculate_Group_Left_Ids(residual_id_width,g_number_of_outputs,c_demux_degree);
    
    constant group_right_index_array : NaturalArray(0 to c_demux_degree-1) :=
      Calculate_Group_Right_Ids(residual_id_width,g_number_of_outputs,c_demux_degree);
    
    constant group_size_array : NaturalArray(0 to c_demux_degree-1) :=
      Calculate_Group_Sizes(residual_id_width,g_number_of_outputs,c_demux_degree);

    constant section_l_index : integer := (g_id_width - (g_stage_id*demux_sel_width))-1; 
    constant section_r_index : integer := Maximum(0, (section_l_index - (demux_sel_width-1))); 
    constant section_width : integer := (section_l_index - section_r_index) + 1;
    
    
    constant demux_num_outputs : natural := Nonzero_Count(group_size_array);

    function Delay_Calculate(dmux_op: natural; req_op: natural) return natural is
	variable ret_var : natural;
    begin
	ret_var := 0;
	if(dmux_op < req_op) then ret_var := 1; end if;
	return(ret_var);
    end function Delay_Calculate;

    -- last stage of demux tree will be combinational.
    -- (ie delay_per_demux_stage will be 0 for the last stage, for others, it will be 1).
    constant delay_per_demux_stage : natural := Delay_Calculate(demux_num_outputs,g_number_of_outputs);
    
    signal demux_sel_in: std_logic_vector(demux_sel_width-1 downto 0);
    
    signal demux_sel_integer : natural;
    signal demux_data_in : std_logic_vector(demux_data_width-1 downto 0);
    signal demux_data_out : std_logic_vector(demux_num_outputs*demux_data_width - 1 downto 0);
    signal demux_req_in, demux_ack_out : std_logic;
    signal demux_req_out, demux_ack_in : std_logic_vector(demux_num_outputs-1 downto 0);
    
begin

  assert demux_num_outputs > 0 report "no outputs!" severity failure;

  process(demerge_sel_in)
  begin
    demux_sel_in <= (others => '0');
    demux_sel_in(section_width-1 downto 0) <= demerge_sel_in(section_l_index downto section_r_index);
  end process;
--  demux_sel_in <= demerge_sel_in((g_id_width - (g_stage_id*demux_sel_width))-1 downto (g_id_width-((g_stage_id+1)*demux_sel_width)));
  
  demux_sel_integer <= To_Integer(demux_sel_in);  -- for debug
  
  demux_data_in <= demerge_data_in & demerge_sel_in;

  demux_req_in <= demerge_req_in;
  demerge_ack_out <= demux_ack_out;
  
  demux : mem_demux generic map (
    g_data_width        => demux_data_width,
    g_id_width          => demux_sel_width,
    g_number_of_outputs => demux_num_outputs,
    g_delay_count => delay_per_demux_stage)
    port map (
      data_in  => demux_data_in,
      sel_in   => demux_sel_in,
      req_in   => demux_req_in,
      ack_out  => demux_ack_out,
      data_out => demux_data_out,
      req_out  => demux_req_out,
      ack_in   => demux_ack_in,
      clk      => clock,
      reset    => reset);

  trivial: if demux_num_outputs >= g_number_of_outputs generate
    unpack: for I in 0 to g_number_of_outputs-1 generate
      demerge_data_out((I+1)*g_data_width-1 downto I*g_data_width)
        <= demux_data_out((I+1)*demux_data_width-1 downto (I*demux_data_width) + g_id_width);
      demerge_ready_out(I) <= demux_req_out(I);
      demux_ack_in(I) <= demerge_accept_in(I);
    end generate unpack;
  end generate trivial;

  nontrivial: if demux_num_outputs < g_number_of_outputs generate
    unpack: for I in 0 to demux_num_outputs-1 generate

      assert(group_size_array(I) > 0) report "empty group!" severity failure;
      assert(group_left_index_array(I) >= group_right_index_array(I)) report "left-right bound issue" severity failure;
      
      demTree: demerge_tree_wrap -- for recursive instantiation (to keep ise and vsim happy)
        generic map (
          g_data_width => g_data_width,
          g_id_width   => g_id_width,
          g_number_of_outputs => group_size_array(I),
          g_stage_id => g_stage_id + 1,
          g_demux_degree => g_demux_degree)
        port map (
          demerge_data_out => demerge_data_out((group_left_index_array(I)+1)*g_data_width-1
                                               downto (group_right_index_array(I)*g_data_width)),
          demerge_ready_out => demerge_ready_out(group_left_index_array(I) downto group_right_index_array(I)),
          demerge_accept_in => demerge_accept_in(group_left_index_array(I) downto group_right_index_array(I)),
          demerge_data_in   => demux_data_out((I+1)*demux_data_width-1 downto (I*demux_data_width)+g_id_width),
          demerge_req_in  => demux_req_out(I),
          demerge_ack_out => demux_ack_in(I),
          demerge_sel_in  => demux_data_out((I*demux_data_width) + g_id_width-1 downto I*demux_data_width),
          clock => clock,
          reset => reset);
    end generate unpack;
  end generate nontrivial;
end opt_pipeline;




