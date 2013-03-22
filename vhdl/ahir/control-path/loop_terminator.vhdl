-- loop-terminator element for use in pipelined loops.
-- written by Madhav P. Desai, December 2012.
library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.Types.all;
use ahir.subprograms.all;
use ahir.BaseComponents.all;


entity loop_terminator is
  
  generic (max_iterations_in_flight : integer := 4);
  port(loop_body_exit: in boolean;
       loop_continue: in boolean;
       loop_terminate: in boolean;
       loop_back: out boolean;
       loop_exit: out boolean;
       clk: in std_logic;
       reset: in std_logic);

end loop_terminator;

--
-- Let M = max iterations in flight.
--
-- initialize the counter (at reset) to M-1.
--
-- Anytime you see loop-body-exit, increment the
-- counter
--
-- if lc has arrived, and if the counter is > 0,
-- then emit loop-back, and decrement the counter.
--
-- if lt has arrived, wait until the counter reaches M
-- and then emit loop-exit, resetting the counter to M-1.
--
architecture Behave of loop_terminator is

  type FSMState is (idle, pending_continue, pending_exit);

  signal fsm_state : FSMState;
  signal available_iterations : integer range 0 to max_iterations_in_flight;

  signal lc_place_preds, lc_place_succs : BooleanArray(0 downto 0);
  signal clear_lc_place, lc_place_token : boolean;

  signal lt_place_preds, lt_place_succs : BooleanArray(0 downto 0);
  signal clear_lt_place, lt_place_token: boolean;

  signal lbe_place_preds, lbe_place_succs : BooleanArray(0 downto 0);
  signal clear_lbe_place, lbe_place_token: boolean;  
  
begin  -- Behave

  -- places to remember loop-continue, loop-terminate, loop-body-exit

  -- critical place: make it a bypass place in order to
  -- speed up loop turnaround times.  The clock period
  -- will not be an issue since the branch ack is 
  -- registered.
  lc_place : place_with_bypass generic map (
    capacity => 1,
    marking  => 0,
    name => "loop_terminator:lc_place")
    port map (
      preds => lc_place_preds,
      succs => lc_place_succs,
      token => lc_place_token,
      clk   => clk,
      reset => reset);
  lc_place_preds(0) <= loop_continue;
  lc_place_succs(0) <= clear_lc_place;

  lt_place : place generic map (
    capacity => 1,
    marking  => 0,
    name => "loop_terminator:lt_place")
    port map (
      preds => lt_place_preds,
      succs => lt_place_succs,
      token => lt_place_token,
      clk   => clk,
      reset => reset);
  lt_place_preds(0) <= loop_terminate;
  lt_place_succs(0) <= clear_lt_place;


  lbe_place : place generic map (
    capacity => 1,
    marking  => 0,
    name => "loop_terminator:lbe_place")
    port map (
      preds => lbe_place_preds,
      succs => lbe_place_succs,
      token => lbe_place_token,
      clk   => clk,
      reset => reset);
  lbe_place_preds(0) <= loop_body_exit;
  lbe_place_succs(0) <= clear_lbe_place;
  
  -- state machine:
  --   inputs
  --   lc_place_token, lt_place_token, lbe_place_token, available_iterations.
  --   outputs
  --   clear_lc_place, clear_lt_place, clear_lbe_place, loop_back,
  --   loop_exit, available_iterations.
  --   
  process(clk, reset,lc_place_token,lt_place_token,lbe_place_token,available_iterations)
    variable next_available_iterations : integer range 0 to max_iterations_in_flight;
    variable incr,decr,rst : boolean;
  begin
    -- all outputs are deasserted by default.
    loop_back <= false;
    loop_exit <= false;
    clear_lc_place <= false;
    clear_lt_place <= false;
    clear_lbe_place <= false;
    
    -- incr, decr, rst are used to manage count.
    incr := false;
    decr := false;
    if(reset = '1') then
      rst := true;
    else
      rst := false;
    end if;

    -- lbe always increments counter.
    if(lbe_place_token) then
      incr := true;
      clear_lbe_place <= true;
    end if;

    -- loop-continue? emit loop-back if count > 0..
    -- and decrement count, clear lc place.      
    if(lc_place_token and (available_iterations > 0)) then
      decr := true;
      loop_back <= true;
      clear_lc_place <= true;
    end if;

    -- loop-terminate? check if count = M, and emit loop_exit, reset counter.
    if(lt_place_token and (available_iterations = max_iterations_in_flight)) then
      rst := true;
      loop_exit <= true;
      clear_lt_place <= true;          
    end if;


    if(clk'event and clk = '1') then

      -- manage count.
      if(rst) then
        available_iterations <= max_iterations_in_flight - 1;
      elsif (incr and (not decr)) then
        available_iterations <= available_iterations + 1;
      elsif (decr and (not incr)) then
        available_iterations <= available_iterations - 1;
      end if;
      
    end if;
  end process;
  
end Behave;
