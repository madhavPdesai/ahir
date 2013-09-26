library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.BaseComponents.all;

entity SelectWithInputBuffers is
  generic(name: string; 
	  data_width: integer; 
	  x_buffering: integer; 
	  y_buffering: integer; 
	  sel_buffering: integer;
          x_is_constant: boolean;
          y_is_constant: boolean;
          sel_is_constant: boolean;
	  z_buffering: integer;
	  flow_through: boolean := false);
  port(x,y: in std_logic_vector(data_width-1 downto 0);
       sel: in std_logic_vector(0 downto 0);
       req_x: in boolean;
       ack_x: out boolean;
       req_y: in boolean;
       ack_y: out boolean;
       req_sel: in boolean;
       ack_sel: out boolean;
       req_z : in boolean;
       ack_z : out boolean;
       z: out std_logic_vector(data_width-1 downto 0);
       clk,reset: in std_logic);
end SelectWithInputBuffers;


architecture arch of SelectWithInputBuffers is 
	constant  cZero : std_logic_vector(data_width-1 downto 0) := (others => '0');
	signal buffered_x : std_logic_vector(data_width-1 downto 0);
	signal accept_x, ready_x, kill_x: std_logic;


	signal buffered_y : std_logic_vector(data_width-1 downto 0);
	signal accept_y, ready_y, kill_y: std_logic;

	signal buffered_sel : std_logic_vector(data_width-1 downto 0);
	signal accept_sel, ready_sel, kill_sel: std_logic;

	signal obuf_write_data : std_logic_vector(data_width-1 downto 0);
        signal obuf_write_req, obuf_write_ack: std_logic;

begin
	-- slight issue here... some problem cases exist.
	-- for example: select is constant 1, x is constant.
        --              select is constant 0, y is constant.
        --              select, x, y are all constants. 
	-- In such cases, it is assumed that the select operation
	-- will be replaced by a constant at a higher level. 
	assert not (x_is_constant and y_is_constant and sel_is_constant) 
		report "all three inputs to select cannot be constants" severity failure;

     noFlowThrough: if (not flow_through) generate
	nonConstX: if not x_is_constant generate 
	  rb_x: ReceiveBuffer generic map( name => name & " receive-buffer_x",
					buffer_size =>  x_buffering,
					data_width => data_width,
					kill_counter_range => 65535)
		port map(write_req => req_x,
			 write_ack => ack_x,
			 write_data => x,
		   	 read_req => accept_x,
			 read_ack => ready_x,
			 kill => kill_x,
			 read_data => buffered_x,
			 clk => clk,
			 reset => reset);
        end generate nonConstX;

        constX: if x_is_constant generate
		buffered_x <= x;
		ready_x <= '1';
        end generate constX;

        nonConstY: if not y_is_constant generate
	  rb_y: ReceiveBuffer generic map( name => name & " receive-buffer_y",
					buffer_size => y_buffering,
					data_width => data_width,
					kill_counter_range => 65535)
		port map(write_req => req_y,
			 write_ack => ack_y,
			 write_data => x,
		   	 read_req => accept_y,
			 read_ack => ready_y,
			 kill => kill_y,
			 read_data => buffered_y,
			 clk => clk,
			 reset => reset);
        end generate nonConstY;

        constY: if y_is_constant generate
		buffered_y <= y;
		ready_y <= '1';
        end generate constY;
 

	kill_sel <= '0';  -- select can never be killed (well, if x = y, yes, but let it be!).
        
        nonConstSel: if not sel_is_constant generate 
	  rb_sel: ReceiveBuffer generic map( name => name & " receive-buffer_sel",
					buffer_size => sel_buffering,
					data_width => data_width,
					kill_counter_range => 65535)
		port map(write_req => req_sel,
			 write_ack => ack_sel,
			 write_data => x,
		   	 read_req => accept_sel,
			 read_ack => ready_sel,
			 kill => kill_sel,
			 read_data => buffered_sel,
			 clk => clk,
			 reset => reset);
        end generate nonConstSel;

	
        constSel: if sel_is_constant generate
		buffered_sel <= sel;
		ready_sel <= '1';
        end generate constSel;


        obuf: UnloadBuffer generic map (name => name & " output-buffer for Select ",
					data_width => data_width,
					buffer_size => z_buffering)
		port map(write_req => obuf_write_req,
			  write_ack => obuf_write_ack,
			  write_data => obuf_write_data,
			  unload_req => req_Z,
			  unload_ack => ack_Z,
			  read_data => Z,
			  clk => clk,
			  reset => reset);
				
	-- logic.
	-- if select is valid and non-zero, and if X is valid, then kill Y
        -- and sample X into output queue.
	-- if select is valid and zero, and if Y is valid, then kill X
        -- and sample Y into output queue.
	-- 
	process(ready_sel, ready_x, ready_y, buffered_sel, buffered_x, buffered_y)
	
	begin
		obuf_write_req <= '0';
		obuf_write_data <= cZero;
		accept_X <= '0';
		accept_Y <= '0';
		accept_Sel <= '0';
		kill_X <= '0';
		kill_Y <= '0';
		if(ready_sel = '1') then
			if(buffered_sel /= cZero) then
				if(ready_Y = '1') then
					accept_Sel <= '1';
					accept_Y <= '1';
					obuf_write_req <= '1';
					obuf_write_data <= buffered_Y;
					if(ready_X = '1') then
						accept_X <= '1';
					else
						kill_X <= '1';
					end if;
				end if;
			else
				if(ready_X = '1') then
					accept_Sel <= '1';
					accept_X <= '1';
					obuf_write_req <= '1';
					obuf_write_data <= buffered_X;
					if(ready_Y = '1') then
						accept_Y <= '1';
					else
						kill_Y <= '1';
					end if;
				end if;
			end if;
		end if;
	end process;
   end generate noFlowThrough;

   flowThrough: if (flow_through) generate
	--
	-- all dependencies must be handled in the control-path.
	-- the operator is just a combinational block.
	--
	ack_sel <= req_sel;
	ack_x <= req_x;
	ack_y <= req_y;
	ack_z <= req_z;
	z <= x when (sel /= cZero) else y;	
   end generate flowThrough;
   

end arch;

