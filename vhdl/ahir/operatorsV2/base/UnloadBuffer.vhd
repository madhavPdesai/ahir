library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity UnloadBuffer is
  generic (buffer_size: integer := 2; data_width : integer := 32);
  port (write_req: in std_logic;
        write_ack: out std_logic;
        write_data: in std_logic_vector(data_width-1 downto 0);
        unload_req: in boolean;
        unload_ack: out boolean;
        read_data: out std_logic_vector(data_width-1 downto 0);
        clk : in std_logic;
        reset: in std_logic);
end UnloadBuffer;

architecture default_arch of UnloadBuffer is

  signal pop_req, pop_ack, push_req, push_ack: std_logic_vector(0 downto 0);
  signal pipe_data_out:  std_logic_vector(data_width-1 downto 0);

  signal output_register : std_logic_vector(data_width-1 downto 0);

  signal unload_req_reg, unload_req_token  : boolean;
  signal unload_ack_sig : boolean;
  
begin  -- default_arch

  -- the input pipe.
  bufPipe : PipeBase generic map (
    num_reads  => 1,
    num_writes => 1,
    data_width => data_width,
    lifo_mode  => false,
    depth      => buffer_size)
    port map (
      read_req   => pop_req,
      read_ack   => pop_ack,
      read_data  => pipe_data_out,
      write_req  => push_req,
      write_ack  => push_ack,
      write_data => write_data,
      clk        => clk,
      reset      => reset);
  push_req(0) <= write_req;
  write_ack <= push_ack(0);

  -- unload_req needs to be registered..
  -- (it behaves like a place)
  process(clk,reset)
  begin

    if(clk'event and clk = '1') then
      if(reset = '1') then
        unload_req_reg <= false;
      else
        if(unload_req) then
          unload_req_reg <= true;
        elsif(unload_ack_sig) then
          unload_req_reg <= false;
        end if;
      end if;
    end if;
  end process;
  unload_req_token <= unload_req_reg or unload_req;
  

  -- the output register handler.
  process(clk,reset, unload_req, pop_ack)
    variable load_output : boolean;
  begin

    -- pop from the pipe if unload_req is true and
    -- if the pipe has something available.
    load_output := unload_req_token and (pop_ack(0) = '1');


    -- issue the pop to the pipe if it is to be
    -- unloaded
    if(load_output) then
      pop_req(0) <= '1';
    else
      pop_req(0) <= '0';
    end if;

    -- the unload_ack pulse is delayed.
    if(clk'event and clk  = '1') then

      if(reset = '1') then
        unload_ack_sig <= false;
      else
        if(load_output) then
          unload_ack_sig <= true;
        else
          unload_ack_sig <= false;
        end if;
      end if;


      if(load_output) then
        output_register <= pipe_data_out;
      end if;
    end if;
  end process;
  unload_ack <= unload_ack_sig;

  read_data <= output_register;

end default_arch;
