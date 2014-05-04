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
// Filename:			rx_engine_128.v
// Version:				1.00.a
// Verilog Standard:	Verilog-2001
// Description:			Receive engine for PCIe using AXI interface from Xilinx 
//						PCIe Endpoint core.
// Author:				Matt Jacobsen
// History:				@mattj: Version 2.0
// Additional Comments: Very good PCIe header reference:
// http://www.pzk-agro.com/0321156307_ch04lev1sec5.html#ch04lev4sec14
// Also byte swap each payload word due to Xilinx incorrect mapping, see
// http://forums.xilinx.com/t5/PCI-Express/PCI-Express-payload-required-to-be-Big-Endian-by-specification/td-p/285551
//-----------------------------------------------------------------------------
`define FMT_RXENG128_RD32	7'b00_00000
`define FMT_RXENG128_WR32	7'b10_00000
`define FMT_RXENG128_RD64	7'b01_00000
`define FMT_RXENG128_WR64	7'b11_00000
`define FMT_RXENG128_CPL	7'b00_01010
`define FMT_RXENG128_CPLD	7'b10_01010

`define S_RXENG128_REQ_PARSE		2'd0
`define S_RXENG128_REQ_ASSIGN		2'd1
`define S_RXENG128_REQ_DATA			2'd2

`define S_RXENG128_CPL_PARSE		2'b11
`define S_RXENG128_CPL_NO_DATA		2'b10
`define S_RXENG128_CPL_DATA			2'b01
`define S_RXENG128_CPL_DATA_CONT	2'b00

module rx_engine_128 #(
	parameter C_PCI_DATA_WIDTH = 9'd128,
	parameter C_NUM_CHNL = 4'd12,
	// Local parameters
	parameter C_PCI_DATA_WORD_WIDTH = clog2((C_PCI_DATA_WIDTH/32)+1)
)
(
	input CLK,
	input RST,
	// Receive
	input [C_PCI_DATA_WIDTH-1:0] M_AXIS_RX_TDATA,
	input M_AXIS_RX_TVALID,
	output M_AXIS_RX_TREADY,
	input [6:0] M_AXIS_RBAR_HIT,
	input [4:0] IS_SOF,
	input [4:0] IS_EOF,
	input RERR_FWD,
	// Received read/write memory requests
	output REQ_WR,													// Memory write request
	input REQ_WR_DONE,												// Memory write completed
	output REQ_RD,													// Memory read request
	input REQ_RD_DONE,												// Memory read complete
	output [9:0] REQ_LEN,											// Memory length (1DW)
	output [29:0] REQ_ADDR,											// Memory address (bottom 2 bits are always 00)
	output [31:0] REQ_DATA,											// Memory write data
	output [3:0] REQ_BE,											// Memory byte enables
	output [2:0] REQ_TC,											// Memory traffic class
	output REQ_TD,                  								// Memory packet digest
	output REQ_EP,      											// Memory poisoned packet
	output [1:0] REQ_ATTR,											// Memory packet relaxed ordering, no snoop
	output [15:0] REQ_ID,											// Memory requestor id
	output [7:0] REQ_TAG,											// Memory packet tag
	// Received read completions
	output [C_PCI_DATA_WIDTH-1:0] ENG_DATA,							// Engine data 
	output [(C_NUM_CHNL*C_PCI_DATA_WORD_WIDTH)-1:0] MAIN_DATA_EN,	// Main data enable
	output [C_NUM_CHNL-1:0] MAIN_DONE,								// Main data complete
	output [C_NUM_CHNL-1:0] MAIN_ERR,								// Main data completed with error
	output [(C_NUM_CHNL*C_PCI_DATA_WORD_WIDTH)-1:0] SG_RX_DATA_EN,	// Scatter gather for RX data enable
	output [C_NUM_CHNL-1:0] SG_RX_DONE,								// Scatter gather for RX data complete
	output [C_NUM_CHNL-1:0] SG_RX_ERR,								// Scatter gather for RX data completed with error
	output [(C_NUM_CHNL*C_PCI_DATA_WORD_WIDTH)-1:0] SG_TX_DATA_EN,	// Scatter gather for TX data enable
	output [C_NUM_CHNL-1:0] SG_TX_DONE,								// Scatter gather for TX data complete
	output [C_NUM_CHNL-1:0] SG_TX_ERR								// Scatter gather for TX data completed with error
);

`include "common_functions.v"


reg		[2:0]						rFmtLo=0, _rFmtLo=0;
reg		[2:0]						rFmtHi=0, _rFmtHi=0;
reg		[C_PCI_DATA_WIDTH-1:0]		rDataIn=0, _rDataIn=0;
reg									rValid=0, _rValid=0;
reg									rEOF=0, _rEOF=0;
reg		[1:0]						rEOFPos=0, _rEOFPos=0;
reg		[2:0]						rEOFCount=0, _rEOFCount=0;
reg									rLenOneLo=0, _rLenOneLo=0;
reg									rLenOneHi=0, _rLenOneHi=0;
reg									rCplErrLo=0, _rCplErrLo=0;
reg									rCplErrHi=0, _rCplErrHi=0;

reg		[1:0]						rReqState=`S_RXENG128_REQ_PARSE, _rReqState=`S_RXENG128_REQ_PARSE;
reg		[29:0]						rReqAddr=0, _rReqAddr=0;
reg		[31:0]						rReqData=0, _rReqData=0;
reg									rReqWen=0, _rReqWen=0;
reg		[2:0]						rTC=0, _rTC=0;
reg									rTD=0, _rTD=0;
reg									rEP=0, _rEP=0;
reg		[1:0]						rAttr=0, _rAttr=0;
reg		[9:0]						rReqLen=0, _rReqLen=0;
reg		[15:0]						rReqId=0, _rReqId=0;
reg		[7:0]						rReqTag=0, _rReqTag=0;
reg		[3:0]						rBE=0, _rBE=0;
reg									rRNW=0, _rRNW=0;
reg		[2:0]						rNextTC=0, _rNextTC=0;
reg									rNextTD=0, _rNextTD=0;
reg									rNextEP=0, _rNextEP=0;
reg		[1:0]						rNextAttr=0, _rNextAttr=0;
reg		[9:0]						rNextReqLen=0, _rNextReqLen=0;
reg		[15:0]						rNextReqId=0, _rNextReqId=0;
reg		[7:0]						rNextReqTag=0, _rNextReqTag=0;
reg		[3:0]						rNextBE=0, _rNextBE=0;
reg									rNextRNW=0, _rNextRNW=0;
reg									rNext4DWHeader=0, _rNext4DWHeader=0;

(* fsm_encoding = "user" *)
reg		[1:0]						rCplState=`S_RXENG128_CPL_PARSE, _rCplState=`S_RXENG128_CPL_PARSE;
reg		[C_PCI_DATA_WIDTH-1:0]		rData={C_PCI_DATA_WIDTH{1'b0}}, _rData={C_PCI_DATA_WIDTH{1'b0}};
reg									rLastCPLD=0, _rLastCPLD=0;
reg		[5:0]						rShft=0, _rShft=0;
reg									rOutValid=0, _rOutValid=0;
reg		[2:0]						rDataEn=0, _rDataEn=0;
reg									rDone=0, _rDone=0;
reg									rErr=0, _rErr=0;
reg									rNextCplErr=0, _rNextCplErr=0;
reg									rNextLastCPLD=0, _rNextLastCPLD=0;

reg		[C_PCI_DATA_WIDTH-1:0]				rDataOut={C_PCI_DATA_WIDTH{1'b0}}, _rDataOut={C_PCI_DATA_WIDTH{1'b0}};
reg		[(3*16*C_PCI_DATA_WORD_WIDTH)-1:0]	rDataOutEn={3*16*C_PCI_DATA_WORD_WIDTH{1'd0}}, _rDataOutEn={3*16*C_PCI_DATA_WORD_WIDTH{1'd0}};
reg		[(3*16)-1:0]						rDataDone={3*16{1'd0}}, _rDataDone={3*16{1'd0}};
reg		[(3*16)-1:0]						rDataErr={3*16{1'd0}}, _rDataErr={3*16{1'd0}};

wire	[31:0]						wReqData = {rReqData[7:0], rReqData[15:8], rReqData[23:16], rReqData[31:24]};
wire	[C_PCI_DATA_WIDTH-1:0]		wDataOut = {rDataOut[103:96], rDataOut[111:104], rDataOut[119:112], rDataOut[127:120],
												rDataOut[71:64], rDataOut[79:72], rDataOut[87:80], rDataOut[95:88],
												rDataOut[39:32], rDataOut[47:40], rDataOut[55:48], rDataOut[63:56],
												rDataOut[07:00], rDataOut[15:08], rDataOut[23:16], rDataOut[31:24]};


assign M_AXIS_RX_TREADY = 1;

assign ENG_DATA = wDataOut;

assign MAIN_DATA_EN = rDataOutEn[(0*16*C_PCI_DATA_WORD_WIDTH) +:(C_NUM_CHNL*C_PCI_DATA_WORD_WIDTH)];
assign MAIN_DONE = rDataDone[(0*16) +:C_NUM_CHNL];
assign MAIN_ERR = rDataErr[(0*16) +:C_NUM_CHNL];

assign SG_RX_DATA_EN = rDataOutEn[(1*16*C_PCI_DATA_WORD_WIDTH) +:(C_NUM_CHNL*C_PCI_DATA_WORD_WIDTH)];
assign SG_RX_DONE = rDataDone[(1*16) +:C_NUM_CHNL];
assign SG_RX_ERR = rDataErr[(1*16) +:C_NUM_CHNL];

assign SG_TX_DATA_EN = rDataOutEn[(2*16*C_PCI_DATA_WORD_WIDTH) +:(C_NUM_CHNL*C_PCI_DATA_WORD_WIDTH)];
assign SG_TX_DONE = rDataDone[(2*16) +:C_NUM_CHNL];
assign SG_TX_ERR = rDataErr[(2*16) +:C_NUM_CHNL];


// Handle servicing write & read memory requests in a separate state machine.
rx_engine_req #( 
	.C_NUM_CHNL(C_NUM_CHNL)
) rxEngReq (
	.CLK(CLK), 
	.RST(RST), 
	.REQ_WR(REQ_WR), 
	.REQ_WR_DONE(REQ_WR_DONE), 
	.REQ_RD(REQ_RD), 
	.REQ_RD_DONE(REQ_RD_DONE), 
	.REQ_LEN(REQ_LEN), 
	.REQ_ADDR(REQ_ADDR), 
	.REQ_DATA(REQ_DATA), 
	.REQ_BE(REQ_BE), 
	.REQ_TC(REQ_TC), 
	.REQ_TD(REQ_TD), 
	.REQ_EP(REQ_EP), 
	.REQ_ATTR(REQ_ATTR), 
	.REQ_ID(REQ_ID), 
	.REQ_TAG(REQ_TAG),
	.WEN(rReqWen),
	.RNW(rRNW),
	.LEN(rReqLen), 
	.ADDR(rReqAddr), 
	.DATA(wReqData), 
	.BE(rBE), 
	.TC(rTC), 
	.TD(rTD), 
	.EP(rEP), 
	.ATTR(rAttr), 
	.ID(rReqId), 
	.TAG(rReqTag)
);


// Handle receiving data from PCIe receive channel.
always @ (posedge CLK) begin
	rFmtLo <= #1 (RST ? 3'd0 : _rFmtLo);
	rFmtHi <= #1 (RST ? 3'd0 : _rFmtHi);
	rValid <= #1 (RST ? 1'd0 : _rValid);
	rDataIn <= #1 _rDataIn;
	rEOF <= #1 _rEOF;
	rEOFPos <= #1 _rEOFPos;
	rEOFCount <= #1 _rEOFCount;
	rLenOneLo <= #1 _rLenOneLo;
	rLenOneHi <= #1 _rLenOneHi;
	rCplErrLo <= #1 _rCplErrLo;
	rCplErrHi <= #1 _rCplErrHi;
end

always @ (*) begin
	_rDataIn = rDataIn;
	_rValid = rValid;
	_rEOF = rEOF;
	_rEOFPos = rEOFPos;
	_rEOFCount = rEOFCount;
	_rLenOneLo = rLenOneLo;
	_rLenOneHi = rLenOneHi;
	_rFmtLo = rFmtLo;
	_rFmtHi = rFmtHi;
	_rCplErrLo = rCplErrLo;
	_rCplErrHi = rCplErrHi;
	
	// Buffer the incoming data
	_rDataIn = M_AXIS_RX_TDATA;
	_rValid = (M_AXIS_RX_TVALID & !RERR_FWD);
	_rEOF = IS_EOF[4];
	_rEOFPos = IS_EOF[3:2] & {2{IS_EOF[4]}};
	_rEOFCount = (IS_EOF[3:2] + 1'd1) & {3{IS_EOF[4]}};
	_rLenOneLo = (M_AXIS_RX_TDATA[9:0] == 10'd1);
	_rLenOneHi = (M_AXIS_RX_TDATA[73:64] == 10'd1);
	_rCplErrLo = (M_AXIS_RX_TDATA[47:45] != 3'b000); // Completion status code
	_rCplErrHi = (M_AXIS_RX_TDATA[111:109] != 3'b000); // Completion status code

	// Direct the main FSM with what kind of packet this represents
	case (M_AXIS_RX_TDATA[30:24])
		`FMT_RXENG128_RD32 :	_rFmtLo = 3'd1 & ({3{M_AXIS_RX_TVALID & !RERR_FWD & IS_SOF[4] & !IS_SOF[3]}});
		`FMT_RXENG128_RD64 :	_rFmtLo = 3'd1 & ({3{M_AXIS_RX_TVALID & !RERR_FWD & IS_SOF[4] & !IS_SOF[3]}});
		`FMT_RXENG128_WR32 :	_rFmtLo = 3'd2 & ({3{M_AXIS_RX_TVALID & !RERR_FWD & IS_SOF[4] & !IS_SOF[3]}});
		`FMT_RXENG128_WR64 :	_rFmtLo = 3'd2 & ({3{M_AXIS_RX_TVALID & !RERR_FWD & IS_SOF[4] & !IS_SOF[3]}});
		`FMT_RXENG128_CPL  :	_rFmtLo = 3'd4 & ({3{M_AXIS_RX_TVALID & !RERR_FWD & IS_SOF[4] & !IS_SOF[3]}});
		`FMT_RXENG128_CPLD :	_rFmtLo = 3'd6 & ({3{M_AXIS_RX_TVALID & !RERR_FWD & IS_SOF[4] & !IS_SOF[3]}});
		default			   :	_rFmtLo = 3'd0;
	endcase
	case (M_AXIS_RX_TDATA[94:88])
		`FMT_RXENG128_RD32 :	_rFmtHi = 3'd1 & ({3{M_AXIS_RX_TVALID & !RERR_FWD & IS_SOF[4] & IS_SOF[3]}});
		`FMT_RXENG128_RD64 :	_rFmtHi = 3'd1 & ({3{M_AXIS_RX_TVALID & !RERR_FWD & IS_SOF[4] & IS_SOF[3]}});
		`FMT_RXENG128_WR32 :	_rFmtHi = 3'd2 & ({3{M_AXIS_RX_TVALID & !RERR_FWD & IS_SOF[4] & IS_SOF[3]}});
		`FMT_RXENG128_WR64 :	_rFmtHi = 3'd2 & ({3{M_AXIS_RX_TVALID & !RERR_FWD & IS_SOF[4] & IS_SOF[3]}});
		`FMT_RXENG128_CPL  :	_rFmtHi = 3'd4 & ({3{M_AXIS_RX_TVALID & !RERR_FWD & IS_SOF[4] & IS_SOF[3]}});
		`FMT_RXENG128_CPLD :	_rFmtHi = 3'd6 & ({3{M_AXIS_RX_TVALID & !RERR_FWD & IS_SOF[4] & IS_SOF[3]}});
		default			   :	_rFmtHi = 3'd0;
	endcase
end


// Handle receiving memory reads and writes.
wire [C_PCI_DATA_WIDTH-1:0] wDataIn64bShftA = (rDataIn>>(32*rDataIn[29]));
wire [C_PCI_DATA_WIDTH-1:0] wDataIn64bShftB = (rDataIn>>(32*rNext4DWHeader));
always @ (posedge CLK) begin
	rReqState <= #1 (RST ? `S_RXENG128_REQ_PARSE : _rReqState);
	rReqWen <= #1 (RST ? 1'd0 : _rReqWen);
	rTC <= #1 _rTC;
	rTD <= #1 _rTD;
	rEP <= #1 _rEP;
	rAttr <= #1 _rAttr;
	rReqLen <= #1 _rReqLen;
	rReqId <= #1 _rReqId;
	rReqTag <= #1 _rReqTag;
	rBE <= #1 _rBE;
	rRNW <= #1 _rRNW;
	rReqData <= #1 _rReqData;
	rReqAddr <= #1 _rReqAddr;
	rNextTC <= #1 _rNextTC;
	rNextTD <= #1 _rNextTD;
	rNextEP <= #1 _rNextEP;
	rNextAttr <= #1 _rNextAttr;
	rNextReqLen <= #1 _rNextReqLen;
	rNextReqId <= #1 _rNextReqId;
	rNextReqTag <= #1 _rNextReqTag;
	rNextBE <= #1 _rNextBE;
	rNextRNW <= #1 _rNextRNW;
	rNext4DWHeader <= #1 _rNext4DWHeader;
end

always @ (*) begin
	_rReqState = rReqState;
	_rTC = rTC;
	_rTD = rTD;
	_rEP = rEP;
	_rAttr = rAttr;
	_rReqLen = rReqLen;
	_rReqId = rReqId;
	_rReqTag = rReqTag;
	_rBE = rBE;
	_rRNW = rRNW;
	_rReqData = rReqData;
	_rReqAddr = rReqAddr;
	_rReqWen = rReqWen;
	
	_rNextTC = (rValid ? rDataIn[86:84] : rNextTC);
	_rNextTD = (rValid ? rDataIn[79] : rNextTD);
	_rNextEP = (rValid ? rDataIn[78] : rNextEP);
	_rNextAttr = (rValid ? rDataIn[77:76] : rNextAttr);
	_rNextReqLen = (rValid ? rDataIn[73:64] : rNextReqLen);
	_rNextReqId = (rValid ? rDataIn[127:112] : rNextReqId);
	_rNextReqTag = (rValid ? rDataIn[111:104] : rNextReqTag);
	_rNextBE = (rValid ? rDataIn[99:96] : rNextBE);
	_rNextRNW = (rValid ? rFmtHi[0] : rNextRNW);
	_rNext4DWHeader = (rValid ? rDataIn[93] : rNext4DWHeader);

	case (rReqState)

	`S_RXENG128_REQ_PARSE : begin
		_rTC = rDataIn[22:20];
		_rTD = rDataIn[15];
		_rEP = rDataIn[14];
		_rAttr = rDataIn[13:12];
		_rReqLen = rDataIn[9:0];
		_rReqId = rDataIn[63:48];
		_rReqTag = rDataIn[47:40];
		_rBE = rDataIn[35:32];	
		_rRNW = rFmtLo[0];
		_rReqAddr = wDataIn64bShftA[95:66];
		_rReqData = rDataIn[127:96];
		_rReqWen = rLenOneLo & (rFmtLo == 3'd1 || (rFmtLo == 3'd2 && !rDataIn[29])); // !64 bit
		// rFmtHi/rFmtLo non-zero if the packet is valid, only one will have a non-zero value
		case ({rFmtHi, rFmtLo}) 
			{3'd1, 3'd0} :	_rReqState = (rLenOneHi ? `S_RXENG128_REQ_ASSIGN : `S_RXENG128_REQ_PARSE);
			{3'd0, 3'd2} :	_rReqState = (rLenOneLo & rDataIn[29] ? `S_RXENG128_REQ_DATA : `S_RXENG128_REQ_PARSE); // 64 bit
			{3'd2, 3'd0} :	_rReqState = (rLenOneHi ? `S_RXENG128_REQ_ASSIGN : `S_RXENG128_REQ_PARSE);
			default      :	_rReqState = `S_RXENG128_REQ_PARSE;
		endcase

	end 

	`S_RXENG128_REQ_ASSIGN : begin
		_rTC = rNextTC;
		_rTD = rNextTD;
		_rEP = rNextEP;
		_rAttr = rNextAttr;
		_rReqLen = rNextReqLen;
		_rReqId = rNextReqId;
		_rReqTag = rNextReqTag;
		_rBE = rNextBE;	
		_rRNW = rNextRNW;
		_rReqAddr = wDataIn64bShftB[31:2];
		_rReqData = wDataIn64bShftB[63:32];
		_rReqWen = rValid;
		if (rValid) begin
			case (rFmtHi) 
				3'd1 :	_rReqState = (rLenOneHi ? `S_RXENG128_REQ_ASSIGN : `S_RXENG128_REQ_PARSE);
				3'd2 :	_rReqState = (rLenOneHi ? `S_RXENG128_REQ_ASSIGN : `S_RXENG128_REQ_PARSE);
				default :	_rReqState = `S_RXENG128_REQ_PARSE;
			endcase
		end
	end

	`S_RXENG128_REQ_DATA : begin
		_rReqData = rDataIn[31:0];
		_rReqWen = rValid;
		if (rValid) begin
			case (rFmtHi) 
				3'd1 :	_rReqState = (rLenOneHi ? `S_RXENG128_REQ_ASSIGN : `S_RXENG128_REQ_PARSE);
				3'd2 :	_rReqState = (rLenOneHi ? `S_RXENG128_REQ_ASSIGN : `S_RXENG128_REQ_PARSE);
				default :	_rReqState = `S_RXENG128_REQ_PARSE;
			endcase
		end
	end

	default : begin
		_rReqState = `S_RXENG128_REQ_PARSE;
	end

	endcase
end


// Handle cpls and cplds.
always @ (posedge CLK) begin
	rCplState <= #1 (RST ? `S_RXENG128_CPL_PARSE : _rCplState);
	rDataEn <= #1 (RST ? 3'd0 : _rDataEn);
	rDone <= #1 (RST ? 1'd0 : _rDone);
	rErr <= #1 (RST ? 1'd0 : _rErr);
	rLastCPLD <= #1 _rLastCPLD;
	rData <= #1 _rData;
	rNextCplErr <= #1 _rNextCplErr;
	rNextLastCPLD <= #1 _rNextLastCPLD;
	rOutValid <= #1 _rOutValid;
	rShft <= #1 _rShft;
end

always @ (*) begin
	_rCplState = rCplState;
	_rLastCPLD = rLastCPLD;
	_rDataEn = rDataEn;
	_rDone = rDone;
	_rErr = rErr;
	_rShft = rShft;

	_rOutValid = rValid;
	_rData = (rDataIn>>(32*rCplState)); // See state values
	_rNextCplErr = (rValid ? rCplErrHi : rNextCplErr); // Completion status code
	_rNextLastCPLD = (rValid ? (rDataIn[107:96] == (rDataIn[73:64]<<2)) : rNextLastCPLD); // byte_count == length ?

	case (rCplState)

	`S_RXENG128_CPL_PARSE : begin
		_rShft = rDataIn[77:72]; // Tag
		_rDataEn = (rFmtLo[2] & rFmtLo[1]); // 1 if rFmtLo == 6
		_rErr = (rFmtLo[2] & rCplErrLo); // If rFmtLo == 4 or rFmtLo == 6
		_rDone = (rFmtLo[2] & (!rFmtLo[1] | rEOF)); // If rFmtLo == 4 or (rFmtLo == 6 && length == 1)
		// Save for S_RXENG128_CPL_DATA_CONT
		_rLastCPLD = (rDataIn[43:32] == (rDataIn[9:0]<<2)); // byte_count == length ?
		// rFmtHi/rFmtLo non-zero if the packet is valid, only one will have a non-zero value
		case ({rFmtHi, rFmtLo}) 
			{3'd0, 3'd4} :	_rCplState = `S_RXENG128_CPL_PARSE;
			{3'd4, 3'd0} :	_rCplState = `S_RXENG128_CPL_NO_DATA;
			{3'd0, 3'd6} :	_rCplState = (`S_RXENG128_CPL_PARSE & {2{(rEOF | rCplErrLo)}}); // Changes to S_RXENG128_CPL_DATA_CONT
			{3'd6, 3'd0} :	_rCplState = `S_RXENG128_CPL_DATA;
			default      :	_rCplState = `S_RXENG128_CPL_PARSE;
		endcase
	end 

	`S_RXENG128_CPL_NO_DATA : begin
		_rShft = rDataIn[13:8]; // Tag
		_rDataEn = 0;
		_rErr = rNextCplErr;
		_rDone = 1;
		if (rValid) begin
			case (rFmtHi) 
				3'd4 :	_rCplState = `S_RXENG128_CPL_NO_DATA;
				3'd6 :	_rCplState = `S_RXENG128_CPL_DATA;
				default :	_rCplState = `S_RXENG128_CPL_PARSE;
			endcase
		end
	end

	`S_RXENG128_CPL_DATA : begin
		_rShft = rDataIn[13:8]; // Tag
		_rDataEn = ({2{!rEOF}} | rEOFPos);
		_rErr = rNextCplErr;
		_rDone = (rEOF & rNextLastCPLD);
		// Save for S_RXENG128_CPL_DATA_CONT
		_rLastCPLD = rNextLastCPLD;
		if (rValid) begin
			if (rEOF) begin // Ends in this packet
				case (rFmtHi) 
					3'd4 :	_rCplState = `S_RXENG128_CPL_NO_DATA;
					3'd6 :	_rCplState = `S_RXENG128_CPL_DATA;
					default :	_rCplState = `S_RXENG128_CPL_PARSE;
				endcase
			end
			else if (rNextCplErr) begin // Bad completion code
				_rCplState = `S_RXENG128_CPL_PARSE;
			end
			else begin // Continues past this packet, send 1 DW now
				_rCplState = `S_RXENG128_CPL_DATA_CONT;
			end
		end
	end

	`S_RXENG128_CPL_DATA_CONT : begin // Process TLP until end
		_rDataEn = (rEOFCount | {!rEOF, 2'd0});
		_rErr = 0;
		_rDone = (rEOF & rLastCPLD);
		if (rValid) begin // Process and write until last packet
			if (rEOF) begin
				case (rFmtHi) 
					3'd4 :	_rCplState = `S_RXENG128_CPL_NO_DATA;
					3'd6 :	_rCplState = `S_RXENG128_CPL_DATA;
					default :	_rCplState = `S_RXENG128_CPL_PARSE;
				endcase
			end
		end
	end
	
	endcase
end


// Output the data and enables
always @ (posedge CLK) begin
	rDataOutEn <= #1 (RST ? 3'd0 : _rDataOutEn);
	rDataDone <= #1 (RST ? 1'd0 : _rDataDone);
	rDataErr <= #1 (RST ? 1'd0 : _rDataErr);
	rDataOut <= #1 _rDataOut;
end

always @ (*) begin
	_rDataOutEn = (({3{rOutValid}} & rDataEn)<<(C_PCI_DATA_WORD_WIDTH*rShft));
	_rDataDone = ((rOutValid & (rDone | rErr))<<rShft);
	_rDataErr = ((rOutValid & rErr)<<rShft);
	_rDataOut = rData;
end


endmodule
