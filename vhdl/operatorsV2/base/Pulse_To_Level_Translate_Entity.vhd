library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

-- operates in two possible modes.
--
-- in push_mode, rL/aL sends data which is accepted by rR/aR.
-- aL does not wait for aR.
--
-- in pull_mode, rL/aL accepts data which is sent by rR/aR.
-- rL -> rR is 0 delay, but aR -> aL MUST have a delay.
--
entity Pulse_To_Level_Translate_Entity is
  generic ( suppr_imm_ack : boolean := true; push_mode : boolean := false);
  port( rL : in boolean;
        rR : out std_logic;
        aL : out boolean;
        aR : in std_logic;
        en : out std_logic;
        clk : in std_logic;
        reset : in std_logic);
end entity;

architecture Behave of Pulse_To_Level_Translate_Entity is
  type PullModeState is (Idle,Ack,Waiting);
begin  -- Behave

  Pull_Mode: if not push_mode generate
    -- purpose: FSM for pull mode.
    PullModeBlock: block
      signal pull_mode_state : PullModeState;
    begin  -- block PullModeBlock

      process(clk)
        variable nstate : PullModeState;
      begin
        nstate := pull_mode_state;

        if(reset = '1') then
          nstate := Idle;
        else
          
          case pull_mode_state is
            when Idle =>
              if(rL) then
                if(aR = '1') then
                  nstate := Ack;
                else
                  nstate := Waiting;
                end if;
              end if;
            when Ack =>
              nstate := Idle;
            when Waiting =>
              if(aR = '1') then
                nstate := Ack;
              end if;
            when others => null;
          end case;

        end if;

        if(clk'event and clk = '1') then
          pull_mode_state <= nstate;
        end if;
      end process;


      rR <= '1' when ((pull_mode_state = Idle) and rL) or (pull_mode_state = Waiting) else '0';
      aL <= true when (pull_mode_state = Ack) else false;
      
      eN <= '0'; 
    end block PullModeBlock;
    
  end generate Pull_Mode;

  PushMode: if push_mode generate
    -- purpose: FSM for push mode.
    PushModeBlock: block
      signal pulse_state : std_logic;
      signal level_state : std_logic;
      signal start_level : boolean;
      signal finish_pulse : boolean;
    begin  -- block PushModeBlock
      

      process(clk)
        variable nstate : std_logic;
      begin
        nstate := pulse_state;
        
        if(reset = '1') then
          nstate := '0';
        else
          case pulse_state is
            when '0' =>
              if(rL and (level_state = '0')) then
                nstate := '1';
              end if;
            when '1' =>
              if(push_mode) then
                -- in push mode, dont wait until level_state has gone
                -- back to '0'
                nstate := '0';
              else
                if(level_state = '0') then
                  nstate := '0';
                end if;
              end if;
            when others => null;
          end case;
        end if;

        if(clk'event and clk = '1') then
          pulse_state <= nstate;
        end if;
      end process;

      -- in push mode, aL doesnt need to wait for ackR.
      aL <= true when (pulse_state = '1') and ((level_state = '0') or push_mode) else false;
      
      start_level <= true when (pulse_state = '0') and (level_state = '0') and rL else false;
      eN <= '1' when start_level else '0';
      

      process(clk)
        variable nstate : std_logic;
      begin
        nstate := level_state;
        
        if(reset = '1') then
          nstate := '0';
        else
          case level_state is
            when '0' =>
              if(start_level) then
                nstate := '1';
              end if;
            when '1' =>
              if(aR = '1') then
                nstate := '0';
              end if;
            when others => null;
          end case;
        end if;

        if(clk'event and clk = '1') then
          level_state <= nstate;
        end if;
      end process;
      rR <= '1' when level_state = '1' else '0';
      finish_pulse <= true when (level_state = '1') and (aR = '1') else false;
    end block PushModeBlock;
  end generate PushMode;
  
end Behave;
