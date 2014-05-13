`timescale 1ns/1ns
// A loopback design with Dual Mode transmission.
// Developed for testing scope of streaming applications
// using RIFFA over PCIe.

// H/W operates on down_clk
// frequency of down_clk can be controlled by parameter 'pcie_usr_clk_div' in riffa_top_v6_pcie_v2_5.v
// pcie_usr_clk_div must be an integer
// frequnecy = (1000/pcie_usr_clk) MHz
module chnl_tester #(
	parameter C_PCI_DATA_WIDTH = 9'd32,
	parameter C_NUM_CHNL = 4'd1
)
(
	input CLK,
	input down_clk,
	input RST,
	output CHNL_RX_CLK, 
	input CHNL_RX, 
	output CHNL_RX_ACK, 
	input CHNL_RX_LAST, 
	input [31:0] CHNL_RX_LEN, 
	input [30:0] CHNL_RX_OFF, 
	input [C_PCI_DATA_WIDTH-1:0] CHNL_RX_DATA, 
	input CHNL_RX_DATA_VALID, 
	output CHNL_RX_DATA_REN,
	
	output CHNL_TX_CLK, 
	output CHNL_TX, 
	input CHNL_TX_ACK, 
	output CHNL_TX_LAST, 
	output [31:0] CHNL_TX_LEN, 
	output [30:0] CHNL_TX_OFF, 
	output [C_PCI_DATA_WIDTH-1:0] CHNL_TX_DATA, 
	output CHNL_TX_DATA_VALID, 
	input CHNL_TX_DATA_REN
);

reg [C_PCI_DATA_WIDTH-1:0] rData={C_PCI_DATA_WIDTH{1'b0}};
reg [31:0] rLen=0;
reg [31:0] rCount=0;
reg rState=0;
reg [31:0] tCount=0;
reg [31:0] tCount_next = 0;
reg tState=0;
//reg [C_PCI_DATA_WIDTH-1:0] tData={C_PCI_DATA_WIDTH{1'b0}};
wire flag;
wire flag2;

assign CHNL_RX_CLK = down_clk;
assign CHNL_RX_ACK = (rState == 1'd1);
assign CHNL_RX_DATA_REN = ((rState == 1'd1) && (flag2==1));

assign CHNL_TX_CLK = down_clk;
assign CHNL_TX = (tState == 1'd1);
assign CHNL_TX_LAST = 1'd1;
assign CHNL_TX_LEN = rLen; // in words
assign CHNL_TX_OFF = 0;
assign CHNL_TX_DATA = rData;
assign CHNL_TX_DATA_VALID = ((flag == 1) && (tState == 1'd1));
assign flag = (tCount < rCount); 
assign flag2 = (tCount_next >= rCount); 

//Rx state machine
always @(posedge down_clk or posedge RST) begin
	if (RST) begin
		rLen <= #1 0;
		rCount <= #1 0;
		rState <= #1 0;
		rData <= #1 0;
	end
	else begin
		case (rState)
		
		1'd0: begin // Wait for start of RX, save length
			if (CHNL_RX) begin
				rLen <= #1 CHNL_RX_LEN;
				rCount <= #1 0;
				if (tState == 0) begin
					rState <= #1 1'd1;
				end
			end
		end
		
		1'd1: begin // Wait for last data in RX, save value
			if (CHNL_RX_DATA_VALID) begin
				rData <= #1 CHNL_RX_DATA;
				if (flag2==1) begin
					rCount <= #1 rCount + (C_PCI_DATA_WIDTH/32);
				end
			end
			if (rCount >= rLen)
				rState <= #1 1'd0;
		end
		endcase
	end
end



//Tx state machine
always @(posedge down_clk or posedge RST) begin
	if (RST) begin
		tCount <= #1 0;
		tCount_next <= #1 0;
		tState <= #1 0;
	//	tData <= #1 0;
	end
	else begin 
	   case (tState)
		1'd0: begin // Prepare for TX
			tCount <= #1 0;
			tCount_next <= #1 (C_PCI_DATA_WIDTH/32);
			if (rState == 1) begin
				tState <= #1 1'd1;
			end
		end

		1'd1: begin // Start TX after Rx has received atleast 1 value
		//	tData <= #1 rData;
			if (CHNL_TX_DATA_REN & flag) begin	
				tCount <= tCount_next;
				tCount_next <= #1 tCount_next + (C_PCI_DATA_WIDTH/32);
				if (tCount_next > rLen)
					tState <= #1 1'd0;
			end
		end
		
		endcase
	end
end


endmodule
