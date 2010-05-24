entity operator_stub is
  
  generic (
    delay : natural := 1);

  port (
    symbol_in  : in  boolean;
    symbol_out : out boolean;
    clk        : in  std_logic;
    reset      : in  std_logic);

end operator_stub;

architecture default_arch of operator_stub is

begin  -- default_arch

  process (clk, reset)
    variable count : natural := delay;
    variable output : boolean := false;

    type StateType is (ready, pause);
    variable state : StateType := ready;
  begin  -- process
    output := false;
    
    if reset = '1' then
      state := ready;
    elsif clk'event and clk = '1' then  -- rising clock edge
      case state is
        when ready =>
          if symbol_in then
            if delay = 0 then
              output := true;
            else
              count := delay - 1;
              state := pause;
            end if;
          end if;

        when pause =>
          if count = 0 then
            output := true;
            state := ready;
          else
            count := count - 1;
          end if;
        when others => null;
      end case;
    end if;
    
    symbol_out <= output;
  end process;


end default_arch;
