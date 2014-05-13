`timescale 1ns/1ns
//----------------------------------------------------------------------------
// This software is Copyright © 2012 The Regents of the University of 
// California. All Rights Reserved.
//
// Permission to copy, modify, and distribute this software and its 
// documentation for educational, research and non-profit purposes, without 
// fee, and without a written agreement is hereby granted, provided that the 
// above copyright notice, this paragraph and the following three paragraphs 
// appear in all copies.
//
// Permission to make commercial use of this software may be obtained by 
// contacting:
// Technology Transfer Office
// 9500 Gilman Drive, Mail Code 0910
// University of California
// La Jolla, CA 92093-0910
// (858) 534-5815
// invent@ucsd.edu
// 
// This software program and documentation are copyrighted by The Regents of 
// the University of California. The software program and documentation are 
// supplied "as is", without any accompanying services from The Regents. The 
// Regents does not warrant that the operation of the program will be 
// uninterrupted or error-free. The end-user understands that the program was 
// developed for research purposes and is advised not to rely exclusively on 
// the program for any reason.
// 
// IN NO EVENT SHALL THE UNIVERSITY OF CALIFORNIA BE LIABLE TO
// ANY PARTY FOR DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR
// CONSEQUENTIAL DAMAGES, INCLUDING LOST PROFITS, ARISING
// OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION,
// EVEN IF THE UNIVERSITY OF CALIFORNIA HAS BEEN ADVISED OF
// THE POSSIBILITY OF SUCH DAMAGE. THE UNIVERSITY OF
// CALIFORNIA SPECIFICALLY DISCLAIMS ANY WARRANTIES,
// INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
// MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
// THE SOFTWARE PROVIDED HEREUNDER IS ON AN "AS IS" BASIS, 
// AND THE UNIVERSITY OF CALIFORNIA HAS NO OBLIGATIONS TO
// PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR
// MODIFICATIONS.
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
// Filename:			riffa_endpoint.v
// Version:				1.00.a
// Verilog Standard:	Verilog-2001
// Description:			Generates the appropriate riffa_endpoint based on the 
// 						data width.
// Author:				Matt Jacobsen
// History:				@mattj: Version 2.0
//-----------------------------------------------------------------------------
module riffa_endpoint #(
	parameter C_PCI_DATA_WIDTH = 9'd64,
	parameter C_NUM_CHNL = 4'd12
)
(
	input CLK,
	input RST_IN,
	output RST_OUT,

	input [C_PCI_DATA_WIDTH-1:0] M_AXIS_RX_TDATA,
	input [(C_PCI_DATA_WIDTH/8)-1:0] M_AXIS_RX_TKEEP,
	input M_AXIS_RX_TLAST,
	input M_AXIS_RX_TVALID,
	output M_AXIS_RX_TREADY,
	input [6:0] M_AXIS_RBAR_HIT,
	input [4:0] IS_SOF,
	input [4:0] IS_EOF,
	input RERR_FWD,
	
	output [C_PCI_DATA_WIDTH-1:0] S_AXIS_TX_TDATA,
	output [(C_PCI_DATA_WIDTH/8)-1:0] S_AXIS_TX_TKEEP,
	output S_AXIS_TX_TLAST,
	output S_AXIS_TX_TVALID,
	output S_AXIS_SRC_DSC,
	input S_AXIS_TX_TREADY,
	
	input [15:0] COMPLETER_ID,
	input CFG_BUS_MSTR_ENABLE,	
	input [5:0] CFG_LINK_WIDTH,			// cfg_lstatus[9:4] (from Link Status Register): 000001=x1, 000010=x2, 000100=x4, 001000=x8, 001100=x12, 010000=x16, 100000=x32, others=? 
	input [1:0] CFG_LINK_RATE,			// cfg_lstatus[1:0] (from Link Status Register): 01=2.5GT/s, 10=5.0GT/s, others=?
	input [2:0] MAX_READ_REQUEST_SIZE,	// cfg_dcommand[14:12] (from Device Control Register): 000=128B, 001=256B, 010=512B, 011=1024B, 100=2048B, 101=4096B
	input [2:0] MAX_PAYLOAD_SIZE, 		// cfg_dcommand[7:5] (from Device Control Register): 000=128B, 001=256B, 010=512B, 011=1024B
	input INTR_LEGACY_CLR,				// Pulsed high to ack the legacy interrupt and clear it
	input CFG_INTERRUPT_MSIENABLE,		// 1 if MSI interrupts are enable, 0 if only legacy are supported
	output CFG_INTERRUPT_ASSERT,		// Legacy interrupt message type
	input CFG_INTERRUPT_RDY,			// High when interrupt is able to be sent
	output CFG_INTERRUPT,				// High to request interrupt, when both CFG_INTERRUPT_RDY and CFG_INTERRUPT are high, interrupt is sent
	
	input [C_NUM_CHNL-1:0] CHNL_RX_CLK, 
	output [C_NUM_CHNL-1:0] CHNL_RX, 
	input [C_NUM_CHNL-1:0] CHNL_RX_ACK, 
	output [C_NUM_CHNL-1:0] CHNL_RX_LAST, 
	output [(C_NUM_CHNL*32)-1:0] CHNL_RX_LEN, 
	output [(C_NUM_CHNL*31)-1:0] CHNL_RX_OFF, 
	output [(C_NUM_CHNL*C_PCI_DATA_WIDTH)-1:0] CHNL_RX_DATA, 
	output [C_NUM_CHNL-1:0] CHNL_RX_DATA_VALID, 
	input [C_NUM_CHNL-1:0] CHNL_RX_DATA_REN,
	
	input [C_NUM_CHNL-1:0] CHNL_TX_CLK, 
	input [C_NUM_CHNL-1:0] CHNL_TX, 
	output [C_NUM_CHNL-1:0] CHNL_TX_ACK,
	input [C_NUM_CHNL-1:0] CHNL_TX_LAST, 
	input [(C_NUM_CHNL*32)-1:0] CHNL_TX_LEN, 
	input [(C_NUM_CHNL*31)-1:0] CHNL_TX_OFF, 
	input [(C_NUM_CHNL*C_PCI_DATA_WIDTH)-1:0] CHNL_TX_DATA, 
	input [C_NUM_CHNL-1:0] CHNL_TX_DATA_VALID, 
	output [C_NUM_CHNL-1:0] CHNL_TX_DATA_REN
);

generate
if (C_PCI_DATA_WIDTH == 9'd32) begin : endpoint32
	riffa_endpoint_32 #(
		.C_PCI_DATA_WIDTH(C_PCI_DATA_WIDTH),
		.C_NUM_CHNL(C_NUM_CHNL)
	) endpoint (
		.CLK(CLK),
		.RST_IN(RST_IN),
		.RST_OUT(RST_OUT),

		.M_AXIS_RX_TDATA(M_AXIS_RX_TDATA),
		.M_AXIS_RX_TLAST(M_AXIS_RX_TLAST),
		.M_AXIS_RX_TVALID(M_AXIS_RX_TVALID),
		.M_AXIS_RX_TREADY(M_AXIS_RX_TREADY),
		.M_AXIS_RBAR_HIT(M_AXIS_RBAR_HIT),
		.RERR_FWD(RERR_FWD),
		
		.S_AXIS_TX_TDATA(S_AXIS_TX_TDATA),
		.S_AXIS_TX_TLAST(S_AXIS_TX_TLAST),
		.S_AXIS_TX_TVALID(S_AXIS_TX_TVALID),
		.S_AXIS_SRC_DSC(S_AXIS_SRC_DSC),
		.S_AXIS_TX_TREADY(S_AXIS_TX_TREADY),
		
		.COMPLETER_ID(COMPLETER_ID),
		.CFG_BUS_MSTR_ENABLE(CFG_BUS_MSTR_ENABLE),	
		.CFG_LINK_WIDTH(CFG_LINK_WIDTH),
		.CFG_LINK_RATE(CFG_LINK_RATE),
		.MAX_READ_REQUEST_SIZE(MAX_READ_REQUEST_SIZE),
		.MAX_PAYLOAD_SIZE(MAX_PAYLOAD_SIZE), 
		.INTR_LEGACY_CLR(INTR_LEGACY_CLR),
		.CFG_INTERRUPT_MSIENABLE(CFG_INTERRUPT_MSIENABLE),
		.CFG_INTERRUPT_ASSERT(CFG_INTERRUPT_ASSERT),
		.CFG_INTERRUPT_RDY(CFG_INTERRUPT_RDY),
		.CFG_INTERRUPT(CFG_INTERRUPT),
		
		.CHNL_RX_CLK(CHNL_RX_CLK), 
		.CHNL_RX(CHNL_RX), 
		.CHNL_RX_ACK(CHNL_RX_ACK),
		.CHNL_RX_LAST(CHNL_RX_LAST), 
		.CHNL_RX_LEN(CHNL_RX_LEN), 
		.CHNL_RX_OFF(CHNL_RX_OFF), 
		.CHNL_RX_DATA(CHNL_RX_DATA), 
		.CHNL_RX_DATA_VALID(CHNL_RX_DATA_VALID), 
		.CHNL_RX_DATA_REN(CHNL_RX_DATA_REN),
		
		.CHNL_TX_CLK(CHNL_TX_CLK), 
		.CHNL_TX(CHNL_TX), 
		.CHNL_TX_ACK(CHNL_TX_ACK),
		.CHNL_TX_LAST(CHNL_TX_LAST), 
		.CHNL_TX_LEN(CHNL_TX_LEN), 
		.CHNL_TX_OFF(CHNL_TX_OFF), 
		.CHNL_TX_DATA(CHNL_TX_DATA), 
		.CHNL_TX_DATA_VALID(CHNL_TX_DATA_VALID), 
		.CHNL_TX_DATA_REN(CHNL_TX_DATA_REN)
	);
end
else if (C_PCI_DATA_WIDTH == 9'd64) begin : endpoint64
	riffa_endpoint_64 #(
		.C_PCI_DATA_WIDTH(C_PCI_DATA_WIDTH),
		.C_NUM_CHNL(C_NUM_CHNL)
	) endpoint (
		.CLK(CLK),
		.RST_IN(RST_IN),
		.RST_OUT(RST_OUT),

		.M_AXIS_RX_TDATA(M_AXIS_RX_TDATA),
		.M_AXIS_RX_TKEEP(M_AXIS_RX_TKEEP),
		.M_AXIS_RX_TLAST(M_AXIS_RX_TLAST),
		.M_AXIS_RX_TVALID(M_AXIS_RX_TVALID),
		.M_AXIS_RX_TREADY(M_AXIS_RX_TREADY),
		.M_AXIS_RBAR_HIT(M_AXIS_RBAR_HIT),
		.RERR_FWD(RERR_FWD),
		
		.S_AXIS_TX_TDATA(S_AXIS_TX_TDATA),
		.S_AXIS_TX_TKEEP(S_AXIS_TX_TKEEP),
		.S_AXIS_TX_TLAST(S_AXIS_TX_TLAST),
		.S_AXIS_TX_TVALID(S_AXIS_TX_TVALID),
		.S_AXIS_SRC_DSC(S_AXIS_SRC_DSC),
		.S_AXIS_TX_TREADY(S_AXIS_TX_TREADY),
		
		.COMPLETER_ID(COMPLETER_ID),
		.CFG_BUS_MSTR_ENABLE(CFG_BUS_MSTR_ENABLE),	
		.CFG_LINK_WIDTH(CFG_LINK_WIDTH),
		.CFG_LINK_RATE(CFG_LINK_RATE),
		.MAX_READ_REQUEST_SIZE(MAX_READ_REQUEST_SIZE),
		.MAX_PAYLOAD_SIZE(MAX_PAYLOAD_SIZE), 
		.INTR_LEGACY_CLR(INTR_LEGACY_CLR),
		.CFG_INTERRUPT_MSIENABLE(CFG_INTERRUPT_MSIENABLE),
		.CFG_INTERRUPT_ASSERT(CFG_INTERRUPT_ASSERT),
		.CFG_INTERRUPT_RDY(CFG_INTERRUPT_RDY),
		.CFG_INTERRUPT(CFG_INTERRUPT),
		
		.CHNL_RX_CLK(CHNL_RX_CLK), 
		.CHNL_RX(CHNL_RX), 
		.CHNL_RX_ACK(CHNL_RX_ACK),
		.CHNL_RX_LAST(CHNL_RX_LAST), 
		.CHNL_RX_LEN(CHNL_RX_LEN), 
		.CHNL_RX_OFF(CHNL_RX_OFF), 
		.CHNL_RX_DATA(CHNL_RX_DATA), 
		.CHNL_RX_DATA_VALID(CHNL_RX_DATA_VALID), 
		.CHNL_RX_DATA_REN(CHNL_RX_DATA_REN),
		
		.CHNL_TX_CLK(CHNL_TX_CLK), 
		.CHNL_TX(CHNL_TX), 
		.CHNL_TX_ACK(CHNL_TX_ACK),
		.CHNL_TX_LAST(CHNL_TX_LAST), 
		.CHNL_TX_LEN(CHNL_TX_LEN), 
		.CHNL_TX_OFF(CHNL_TX_OFF), 
		.CHNL_TX_DATA(CHNL_TX_DATA), 
		.CHNL_TX_DATA_VALID(CHNL_TX_DATA_VALID), 
		.CHNL_TX_DATA_REN(CHNL_TX_DATA_REN)
	);
end
else if (C_PCI_DATA_WIDTH == 9'd128) begin : endpoint128
	riffa_endpoint_128 #(
		.C_PCI_DATA_WIDTH(C_PCI_DATA_WIDTH),
		.C_NUM_CHNL(C_NUM_CHNL)
	) endpoint (
		.CLK(CLK),
		.RST_IN(RST_IN),
		.RST_OUT(RST_OUT),
		
		.M_AXIS_RX_TDATA(M_AXIS_RX_TDATA),
		.M_AXIS_RX_TVALID(M_AXIS_RX_TVALID),
		.M_AXIS_RX_TREADY(M_AXIS_RX_TREADY),
		.M_AXIS_RBAR_HIT(M_AXIS_RBAR_HIT),
		.IS_SOF(IS_SOF),
		.IS_EOF(IS_EOF),
		.RERR_FWD(RERR_FWD),
		
		.S_AXIS_TX_TDATA(S_AXIS_TX_TDATA),
		.S_AXIS_TX_TKEEP(S_AXIS_TX_TKEEP),
		.S_AXIS_TX_TLAST(S_AXIS_TX_TLAST),
		.S_AXIS_TX_TVALID(S_AXIS_TX_TVALID),
		.S_AXIS_SRC_DSC(S_AXIS_SRC_DSC),
		.S_AXIS_TX_TREADY(S_AXIS_TX_TREADY),
		
		.COMPLETER_ID(COMPLETER_ID),
		.CFG_BUS_MSTR_ENABLE(CFG_BUS_MSTR_ENABLE),	
		.CFG_LINK_WIDTH(CFG_LINK_WIDTH),
		.CFG_LINK_RATE(CFG_LINK_RATE),
		.MAX_READ_REQUEST_SIZE(MAX_READ_REQUEST_SIZE),
		.MAX_PAYLOAD_SIZE(MAX_PAYLOAD_SIZE), 
		.INTR_LEGACY_CLR(INTR_LEGACY_CLR),
		.CFG_INTERRUPT_MSIENABLE(CFG_INTERRUPT_MSIENABLE),
		.CFG_INTERRUPT_ASSERT(CFG_INTERRUPT_ASSERT),
		.CFG_INTERRUPT_RDY(CFG_INTERRUPT_RDY),
		.CFG_INTERRUPT(CFG_INTERRUPT),
		
		.CHNL_RX_CLK(CHNL_RX_CLK), 
		.CHNL_RX(CHNL_RX), 
		.CHNL_RX_ACK(CHNL_RX_ACK),
		.CHNL_RX_LAST(CHNL_RX_LAST), 
		.CHNL_RX_LEN(CHNL_RX_LEN), 
		.CHNL_RX_OFF(CHNL_RX_OFF), 
		.CHNL_RX_DATA(CHNL_RX_DATA), 
		.CHNL_RX_DATA_VALID(CHNL_RX_DATA_VALID), 
		.CHNL_RX_DATA_REN(CHNL_RX_DATA_REN),
		
		.CHNL_TX_CLK(CHNL_TX_CLK), 
		.CHNL_TX(CHNL_TX), 
		.CHNL_TX_ACK(CHNL_TX_ACK),
		.CHNL_TX_LAST(CHNL_TX_LAST), 
		.CHNL_TX_LEN(CHNL_TX_LEN), 
		.CHNL_TX_OFF(CHNL_TX_OFF), 
		.CHNL_TX_DATA(CHNL_TX_DATA), 
		.CHNL_TX_DATA_VALID(CHNL_TX_DATA_VALID), 
		.CHNL_TX_DATA_REN(CHNL_TX_DATA_REN)
	);
end
endgenerate

endmodule

