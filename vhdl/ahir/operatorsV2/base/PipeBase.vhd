	library ieee;
	use ieee.std_logic_1164.all;

	library ahir;
	use ahir.Types.all;
	use ahir.Subprograms.all;
	use ahir.Utilities.all;
	use ahir.BaseComponents.all;

	entity PipeBase is
	  
	  generic (num_reads: integer;
		   num_writes: integer;
		   data_width: integer;
		   lifo_mode: boolean := false;
		   depth: integer := 1);
	  port (
	    read_req       : in  std_logic_vector(num_reads-1 downto 0);
	    read_ack       : out std_logic_vector(num_reads-1 downto 0);
    read_data      : out std_logic_vector((num_reads*data_width)-1 downto 0);
    write_req       : in  std_logic_vector(num_writes-1 downto 0);
    write_ack       : out std_logic_vector(num_writes-1 downto 0);
    write_data      : in std_logic_vector((num_writes*data_width)-1 downto 0);
    clk, reset : in  std_logic);
  
end PipeBase;

architecture default_arch of PipeBase is

  signal pipe_data, pipe_data_repeated : std_logic_vector(data_width-1 downto 0);
  signal pipe_req, pipe_ack, pipe_req_repeated, pipe_ack_repeated: std_logic;
  
  
begin  -- default_arch


  manyWriters: if (num_writes > 1) generate
    wmux : OutputPortLevel generic map (
      num_reqs       => num_writes,
      data_width     => data_width,
      no_arbitration => false)
      port map (
        req   => write_req,
        ack   => write_ack,
        data  => write_data,
        oreq  => pipe_req,                -- no cross-over, drives req
        oack  => pipe_ack,                -- no cross-over, receives ack
        odata => pipe_data,
        clk   => clk,
        reset => reset);
  end generate manyWriters;

  singleWriter: if (num_writes = 1) generate
     pipe_req <= write_req(0);
     write_ack(0) <= pipe_ack;
     pipe_data <= write_data;
  end generate singleWriter;

  Shallow: if (depth < 3) and (not lifo_mode) generate

    queue : QueueBase generic map (
      queue_depth => depth,
      data_width       => data_width)
      port map (
        push_req   => pipe_req,
        push_ack => pipe_ack,
        data_in  => pipe_data,
        pop_req  => pipe_req_repeated,
        pop_ack  => pipe_ack_repeated,
        data_out => pipe_data_repeated,
        clk      => clk,
        reset    => reset);
    
  end generate Shallow;

  DeepFifo: if (depth > 2) and (not lifo_mode) generate
    
    queue : SynchFifo generic map (
      queue_depth => depth,
      data_width       => data_width)
      port map (
        push_req   => pipe_req,
        push_ack => pipe_ack,
        data_in  => pipe_data,
        pop_req  => pipe_req_repeated,
        pop_ack  => pipe_ack_repeated,
        data_out => pipe_data_repeated,
        nearly_full => open,
        clk      => clk,
        reset    => reset);
    
  end generate DeepFifo;

  Lifo: if lifo_mode generate
    stack : SynchLifo generic map (
      queue_depth => depth,
      data_width       => data_width)
      port map (
        push_req   => pipe_req,
        push_ack => pipe_ack,
        data_in  => pipe_data,
        pop_req  => pipe_req_repeated,
        pop_ack  => pipe_ack_repeated,
        data_out => pipe_data_repeated,
        nearly_full => open,
        clk      => clk,
        reset    => reset);
  end generate Lifo;
  

  manyReaders: if (num_reads > 1) generate
    rmux : InputPortLevel generic map (
      num_reqs       => num_reads,
      data_width     => data_width,
      no_arbitration => false)
      port map (
        req => read_req,
        ack => read_ack,
        data => read_data,
        oreq => pipe_req_repeated,       
        oack => pipe_ack_repeated,       
        odata => pipe_data_repeated,
        clk => clk,
        reset => reset);
  end generate manyReaders;

  singleReader: if (num_reads = 1) generate
    read_ack(0) <= pipe_ack_repeated;
    pipe_req_repeated <= read_req(0);
    read_data <= pipe_data_repeated;
  end generate singleReader;
  

end default_arch;
