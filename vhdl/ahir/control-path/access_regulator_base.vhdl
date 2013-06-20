library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.BaseComponents.all;
entity access_regulator_base is
  generic (num_slots: integer := 1);
  port (
    -- the req-ack pair being regulated.
    req   : in Boolean;
    ack   : out Boolean;
    -- the regulated versions of req/ack
    regulated_req : out Boolean;
    regulated_ack : in Boolean;
    -- transitions on the next two will
    -- open up a slot.
    release_req   : in Boolean;
    release_ack   : in Boolean;
    clk   : in  std_logic;
    reset : in  std_logic);

end access_regulator_base;

architecture default_arch of access_regulator_base is
  
   signal req_place_preds, req_place_succs : BooleanArray(0 downto 0);
   signal req_place_token : Boolean;

   signal release_req_place_preds, release_ack_place_preds: BooleanArray(0 downto 0);
   signal release_req_place_succs, release_ack_place_succs: BooleanArray(0 downto 0);
   signal release_req_place_token, release_ack_place_token: boolean;
   
   signal regulated_req_join_preds: BooleanArray(2 downto 0);
   signal regulated_req_token: Boolean; 
  
   signal regulated_req_join: boolean;
begin  -- default_arch

   req_place_preds(0) <= req;
   reqPlace: place_with_bypass 
	generic map(capacity => 1, marking => 0, name => "access_regulator:req_place")
	port map(preds => req_place_preds, 
			succs => req_place_succs, 
			token => req_place_token,
				clk => clk, reset => reset);


   -- the next two places manage the slots
   release_req_place_preds(0) <= release_req;
   releaseReqPlace: place 
	generic map(capacity => num_slots, marking => num_slots, name => "access_regulator:release_req_place")
	port map(preds => release_req_place_preds, 
			succs => release_req_place_succs, 
			token => release_req_place_token,
			clk => clk, reset => reset);

   release_ack_place_preds(0) <= release_ack;
   releaseAckPlace: place 
	generic map(capacity => num_slots, marking => num_slots, name => "access_regulator:release_ack_place")
	port map(preds => release_ack_place_preds, 
			succs => release_ack_place_succs, 
			token => release_ack_place_token,
				clk => clk, reset => reset);
   

   -- the join fires when all places have tokens. 
   regulated_req_join <= release_ack_place_token and release_req_place_token and req_place_token;
   release_ack_place_succs(0) <= regulated_req_join;
   release_req_place_succs(0) <= regulated_req_join;
   req_place_succs(0) <= regulated_req_join;


   -- the req that goes out.
   regulated_req <= regulated_req_join;

   -- ack from RHS is forwarded to the left.
   ack <= regulated_ack;
   
end default_arch;
