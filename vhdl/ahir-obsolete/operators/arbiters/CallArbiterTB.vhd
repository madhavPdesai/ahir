library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.Components.all;

entity CallArbiterTB is
  generic
     ( g_num_req: integer := 2;
       verbose_mode: boolean := false;
       tb_id : string := "anonymous"
     );
end CallArbiterTB;

architecture Behave of CallArbiterTB is

    constant data_width : integer := 8;
    constant num_req : integer := g_num_req;
    constant tag_width : integer := Ceil_Log2(num_req);
    
    signal reqR, ackR, reqL, ackL : std_logic_vector(num_req-1 downto 0);
    signal din, dout : StdLogicArray2D(num_req-1 downto 0, data_width-1 downto 0);

    type   Data2D is array(natural range <>) of std_logic_vector(data_width-1 downto 0);
    signal din_raw, dout_raw: Data2D(num_req-1 downto 0);

    function Build_Data(tmp_addr: in Data2D) return StdLogicArray2D is
	variable tmp: StdLogicArray2D(num_req-1 downto 0, data_width-1 downto 0);
    begin
        for I in 0 to num_req-1 loop
            Insert(tmp,I,tmp_addr(I));
        end loop;
	return(tmp);
    end function Build_Data;

    constant def_colouring: NaturalArray(num_req-1 downto 0) := (0 => 0, others => 1);
    signal clock, reset : std_logic := '0';

    signal done_flag, success_flag: BooleanArray(num_req-1 downto 0);
begin

     clock <= not clock after 5 ns;

     process(done_flag)
     begin
        if(AndReduce(done_flag))then
           if(AndReduce(success_flag)) then
              assert false report "All Tests Have Passed in TB " & tb_id  severity note;
	   else
              assert false report "Some Tests Have Failed in TB " & tb_id severity error;
	   end if;
        end if;
     end process;
    
     process
     begin
	 reset <= '1';
         wait until clock = '1';
         reset <= '0' after 1 ns;
 	 wait;
     end process;

     din <= Build_Data(din_raw);

     GenBlockSend: for R in 0 to num_req-1 generate

       process 
         variable dv: natural;
	 variable counter: natural;
         variable td : std_logic_vector(data_width-1 downto 0);
       begin 
         reqL(R) <= '0';
         counter := 1;

         ----------------------------------------------------------------------
         -- first the request
         ----------------------------------------------------------------------
  	 dv := R + 2**(data_width-1);
         
         wait until reset = '0';
         
         while (dv < (2**data_width)-2) loop
           
           din_raw(R) <= (To_SLV(To_Unsigned(dv,data_width)));

           reqL(R) <= '1';
	   assert not verbose_mode report "Send request " & Convert_To_String(R) & "," &
		Convert_To_String(counter) & " started in TB " & tb_id severity note;
           while true loop
             wait until clock = '1';
             if(ackL(R) = '1') then
		assert not verbose_mode report "Send Request " & Convert_To_String(R) & "," &
			Convert_To_String(counter) & " completed in TB " & tb_id severity note;
                reqL(R)  <= '0';
               exit;
             end if;
           end loop;

	   dv := dv + num_req;
	   counter := counter  + 1;
         end loop;
	wait;
       end process;
     end generate GenBlockSend;

     GenBlockReceive: for R in 0 to num_req-1 generate
   
       dout_raw(R) <= Extract(dout,R);

       process 
         variable dv: natural;
	 variable counter: natural;
	 variable err_flag : boolean;
       begin 
         reqR(R) <= '0';	
         counter := 1;
 	 err_flag := false;

  	 dv := R + 2**(data_width-1);

         wait until reset = '0';

         while (dv < (2**data_width)-2) loop
           
           -- operation complete?
           reqR(R) <= '1';
	   assert not verbose_mode report "Receive request " & Convert_To_String(R) & "," &
		Convert_To_String(counter) & " started in TB " & tb_id severity note;
           while true loop
             wait until clock = '1';
             if(ackR(R) = '1') then
               reqR(R) <= '0';
               assert not verbose_mode report "Receive Request " & Convert_To_String(R) & "," &
			Convert_To_String(counter) & " completed in TB " & tb_id  severity note;
	
               if(To_SLV(To_Unsigned(dv,data_width)) /= (Extract(dout,R))) then
                 err_flag := true;
                 assert false report "Mismatch observed at " & Convert_To_String(R) & "," &
                   Convert_To_String(counter) & " in TB " & tb_id  severity note;                  
               end if;
               exit;
             end if;
             
           end loop;

	   dv := dv + num_req;
	   counter := counter  + 1;
         end loop;

	assert err_flag report "Send/Receive Tests Finished Successfully (" & Convert_To_String(R) & ") in TB "
			& tb_id
			severity note;
	assert (not err_flag) report "Send/Receive Tests Failed (" & Convert_To_String(R) & ") in TB "
			& tb_id
			severity error;

        done_flag(R) <= true;
        success_flag(R) <= not err_flag;
	wait;
       end process;
     end generate GenBlockReceive;

     --------------------------------------------------------------------------
     -- component instantiations: output port linked to input port
     --------------------------------------------------------------------------
     InstanceBlock: block
	signal ip_to_op_ack, op_to_ip_req: std_logic;
	signal op_to_ip_data: std_logic_vector(data_width-1 downto 0);
        signal op_to_ip_tag : std_logic_vector(tag_width-1 downto 0);
     begin
       carb: CallArbiter port map( call_reqs => reqL,
                                   call_acks => ackL,
                                   call_data => din,
                                   call_mreq => op_to_ip_req,
                                   call_mack => ip_to_op_ack,
                                   call_mdata => op_to_ip_data,
                                   call_mtag  => op_to_ip_tag,
                                   return_reqs => reqR,
                                   return_acks => ackR,
                                   return_data => dout,
                                   return_mreq => op_to_ip_req,
                                   return_mack => ip_to_op_ack,
                                   return_mdata => op_to_ip_data,
                                   return_mtag => op_to_ip_tag,
                                   clk => clock,
                                   reset => reset);
      end block;
end Behave;
