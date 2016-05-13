entity ram_1xRW_1024x256_32_Operator is
	port (clk, reset: in std_logic;
		addr: in std_logic_vector(9 downto 0);
		din:  in std_logic_vector(255 downto 0);
		tagin: in std_logic_vector(31 downto 0);
		init_flag, wr_bar: in std_logic_vector(0 downto 0);
		dout: out std_logic_vector(255 downto 0);
		tagout: out std_logic_vector(31 downto 0);
		sample_req, update_req: in Boolean;
		sample_ack, update_ack: out Boolean;
		);
end entity;

architecture Behave of ram_1xRW_1024x256_32_Operator is
	type MemState is (Run_State, Init_State);
	signal mem_state: MemState;
begin
end Behave;
