library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity InterlockBuffer is
  generic (name: string; buffer_size: integer := 2; 
  in_data_width : integer := 32;
  out_data_width : integer := 32;
  flow_through: boolean := false;
  bypass_flag : boolean := false;
  full_rate : boolean);
  port (write_req: in boolean;
        write_ack: out boolean;
        write_data: in std_logic_vector(in_data_width-1 downto 0);
        read_req: in boolean;
        read_ack: out boolean;
        read_data: out std_logic_vector(out_data_width-1 downto 0);
        clk : in std_logic;
        reset: in std_logic);
end InterlockBuffer;

architecture default_arch of InterlockBuffer is

  constant data_width: integer := Minimum(in_data_width,out_data_width);

  signal buf_write_req, buf_write_ack: std_logic;
  signal buf_write_data, buf_read_data:  std_logic_vector(data_width-1 downto 0);

  type LoadFsmState is (l_idle, l_busy);
  signal l_fsm_state : LoadFsmState;
  
begin  -- default_arch

  -- interlock buffer must have buffer-size > 0
  assert buffer_size > 0 report " interlock buffer size must be > 0 " severity failure;
  
  flowThrough: if flow_through generate

    write_ack <= write_req;
    read_ack <= read_req;

    inSmaller: if in_data_width <= out_data_width generate
      process(write_data)
        variable rvar : std_logic_vector(out_data_width-1 downto 0);
      begin
        rvar := (others => '0');
        rvar(in_data_width-1 downto 0) := write_data;
        read_data <= rvar;
      end process;
    end generate inSmaller;

    outSmaller: if out_data_width < in_data_width generate
      read_data <= write_data(out_data_width-1 downto 0);
    end generate outSmaller;

  end generate flowThrough;

  NoFlowThrough: if (not flow_through) generate


    synchBuf: if (buffer_size = 1) generate
	sbuf: PipelineSynchBuffer
		generic map (name => name & " synch-buffer ",
				in_data_width => in_data_width,
				out_data_width => out_data_width,
				full_rate => full_rate)
		port map(
				write_req => write_req,
				write_ack => write_ack,
				write_data => write_data,
				read_req => read_req,
				read_ack => read_ack,
				read_data => read_data,
				clk => clk, reset => reset
			);

    end generate synchBuf;

    interlockBuf: if (buffer_size > 1) generate
      inSmaller: if in_data_width <= out_data_width generate
        buf_write_data <= write_data;
  
        process(buf_read_data)
          begin
          read_data <= (others => '0');
          read_data(data_width-1 downto 0)  <= buf_read_data;
        end process;
      end generate inSmaller;
  
      outSmaller: if out_data_width < in_data_width generate
        buf_write_data <= write_data(data_width-1 downto 0);
        read_data  <= buf_read_data;
      end generate outSmaller;
  
      -- write FSM to pipe.
      process(clk,reset, l_fsm_state, buf_write_ack, write_req)
        variable nstate : LoadFsmState;
      begin
        nstate := l_fsm_state;
        buf_write_req <= '0';
        write_ack <= false;
        if(l_fsm_state = l_idle) then
	  if(write_req) then
            buf_write_req <= '1';
            if(buf_write_ack = '1') then
              write_ack <= true;
            else
              nstate := l_busy;
            end if;
	  end if;
        else
	  buf_write_req <= '1';
	  if(buf_write_ack = '1') then
            nstate := l_idle;
            write_ack <= true;
	  end if;
        end if;
  
        if(clk'event and clk = '1') then
	  if(reset = '1') then
            l_fsm_state <= l_idle;
	  else
            l_fsm_state <= nstate;
	  end if;
        end if;
      end process;
  
      -- the unload buffer.
      buf : UnloadBuffer generic map (
        name =>  name & " buffer ",
        data_width => data_width,
        buffer_size => buffer_size, 
        bypass_flag => bypass_flag)
        port map (
          write_req   => buf_write_req,
          write_ack   => buf_write_ack,
          write_data  => buf_write_data,
          unload_req  => read_req,
          unload_ack  => read_ack,
          read_data   => buf_read_data,
          clk         => clk,
          reset       => reset);

    end generate interlockBuf;
  end generate NoFlowThrough;

end default_arch;
