///////////////////////////////////////////////////////////////////////////////
//
// Module: registers.v
// Project: CPCI (cpci)
// Description: Project specific register defines
//
//              NetFPGA PCI interface
//
///////////////////////////////////////////////////////////////////////////////

// -------------------------------------
//   Version Information
// -------------------------------------

// CPCI version number (major number)
`define CPCI_VERSION_ID       24'h000004

// CPCI revision number (minor number)
`define CPCI_REVISION_ID      8'h01


// -------------------------------------
//   Constants
// -------------------------------------

// ===== File: lib/verilog/core/common/xml/global.xml =====

// Maximum number of phy ports
`define MAX_PHY_PORTS                 4

// PCI address bus width
`define PCI_ADDR_WIDTH                32

// PCI data bus width
`define PCI_DATA_WIDTH                32

// PCI byte enable bus width
`define PCI_BE_WIDTH                  4

// CPCI--CNET address bus width. This is byte addresses even though bottom bits are zero.
`define CPCI_CNET_ADDR_WIDTH          27

// CPCI--CNET data bus width
`define CPCI_CNET_DATA_WIDTH          32

// CPCI--Virtex address bus width. This is byte addresses even though bottom bits are zero.
`define CPCI_NF2_ADDR_WIDTH           27

// CPCI--Virtex data bus width
`define CPCI_NF2_DATA_WIDTH           32

// DMA data bus width
`define DMA_DATA_WIDTH                32

// DMA control bus width
`define DMA_CTRL_WIDTH                4

// CPCI debug bus width
`define CPCI_DEBUG_DATA_WIDTH         29

// SRAM address width
`define SRAM_ADDR_WIDTH               19

// SRAM data width
`define SRAM_DATA_WIDTH               36

// DRAM address width
`define DRAM_ADDR_WIDTH               24


// ===== File: lib/verilog/core/common/xml/nf_defines.xml =====

// Clock period of 125 MHz clock in ns
`define FAST_CLK_PERIOD               8

// Clock period of 62.5 MHz clock in ns
`define SLOW_CLK_PERIOD               16

// Header value used by the IO queues
`define IO_QUEUE_STAGE_NUM            8'hff

// Data path data width
`define DATA_WIDTH                    64

// Data path control width
`define CTRL_WIDTH                    8


// ===== File: projects/cpci/include/cpci_regs.xml =====

// Default maximum time for DMA transfers (in clock cycles)
`define CPCI_DMA_XFER_TIME_DEFAULT    30000

// Default maximum number of retries for DMA transactions
`define CPCI_DMA_RETRIES_DEFAULT      16'hffff

// Default maximum Virtex register read time
`define CPCI_CNET_READ_TIME_DEFAULT   4000

// Number of PCI cycles in an interation
`define CPCI_P_MAX_DEFAULT            3333333

// Expected number of CPCI-Virtex clocks in the PCI period defined above
`define CPCI_N_EXP_DEFAULT            6250000



// -------------------------------------
//   Modules
// -------------------------------------

// Tag/address widths
`define CPCI_BLOCK_ADDR_WIDTH  0
`define CPCI_REG_ADDR_WIDTH    20

// Module tags
`define CPCI_BLOCK_ADDR  0'h0


// -------------------------------------
//   Registers
// -------------------------------------

// Name: cpci
// Description: CPCI registers
// File: projects/cpci/include/cpci_regs.xml
`define CPCI_ID                   20'h0
`define CPCI_BOARD_ID             20'h1
`define CPCI_CTRL                 20'h2
`define CPCI_RESET                20'h3
`define CPCI_ERROR                20'h4
`define CPCI_DUMMY                20'h8
`define CPCI_INTERRUPT_MASK       20'h10
`define CPCI_INTERRUPT_STATUS     20'h11
`define CPCI_CNET_CLK_SEL         20'h14
`define CPCI_REPROG_DATA          20'h40
`define CPCI_REPROG_STATUS        20'h41
`define CPCI_REPROG_CTRL          20'h42
`define CPCI_DMA_ADDR_I           20'h50
`define CPCI_DMA_ADDR_E           20'h51
`define CPCI_DMA_SIZE_I           20'h52
`define CPCI_DMA_SIZE_E           20'h53
`define CPCI_DMA_CTRL_I           20'h54
`define CPCI_DMA_CTRL_E           20'h55
`define CPCI_DMA_QUEUE_STATUS     20'h56
`define CPCI_DMA_XFER_TIME        20'h60
`define CPCI_DMA_RETRIES          20'h61
`define CPCI_CNET_READ_TIME       20'h62
`define CPCI_DMA_INGRESS_PKT_CNT  20'h100
`define CPCI_DMA_EGRESS_PKT_CNT   20'h101
`define CPCI_CPCI_REG_READ_CNT    20'h102
`define CPCI_CPCI_REG_WRITE_CNT   20'h103
`define CPCI_CNET_REG_READ_CNT    20'h104
`define CPCI_CNET_REG_WRITE_CNT   20'h105
`define CPCI_CLOCK_CHECK_N_CLK    20'h140
`define CPCI_CLOCK_CHECK_P_MAX    20'h141
`define CPCI_CLOCK_CHECK_N_EXP    20'h142
`define CPCI_PCI_CLK_CNT          20'h144
`define CPCI_CPCI_RESET_CNT       20'h148



// -------------------------------------
//   Bitmasks
// -------------------------------------

// Type: cpci_id
// Description: CPCI ID
// File: projects/cpci/include/cpci_regs.xml
`define CPCI_ID_VERSION_POS_LO    0
`define CPCI_ID_VERSION_POS_HI    23
`define CPCI_ID_VERSION_WIDTH     24
`define CPCI_ID_REVISION_POS_LO   24
`define CPCI_ID_REVISION_POS_HI   31
`define CPCI_ID_REVISION_WIDTH    8

// Type: cpci_board_id
// Description: CPCI board ID
// File: projects/cpci/include/cpci_regs.xml
`define CPCI_BOARD_ID_JMPR_POS        0
`define CPCI_BOARD_ID_ROTARY_POS_LO   8
`define CPCI_BOARD_ID_ROTARY_POS_HI   11
`define CPCI_BOARD_ID_ROTARY_WIDTH    4

// Type: cpci_ctrl
// Description: Control register
// File: projects/cpci/include/cpci_regs.xml
`define CPCI_CTRL_LED_POS             0
`define CPCI_CTRL_CNET_RESET_POS      8
`define CPCI_CTRL_LITTLE_ENDIAN_POS   16

// Type: cpci_reset
// Description: Reset the board
// File: projects/cpci/include/cpci_regs.xml
`define CPCI_RESET_RESET_POS   0

// Type: cpci_error
// Description: CPCI error
// File: projects/cpci/include/cpci_regs.xml
`define CPCI_ERROR_CNET_RD_TIMEOUT_POS    25
`define CPCI_ERROR_CNET_ERR_POS           24
`define CPCI_ERROR_PROG_OVERFLOW_POS      17
`define CPCI_ERROR_PROG_ERROR_POS         16
`define CPCI_ERROR_DMA_TIMEOUT_POS        10
`define CPCI_ERROR_DMA_RETRY_EXPIRE_POS   9
`define CPCI_ERROR_DMA_BUF_OVERFLOW_POS   8
`define CPCI_ERROR_DMA_RD_SIZE_ERR_POS    6
`define CPCI_ERROR_DMA_WR_SIZE_ERR_POS    5
`define CPCI_ERROR_DMA_RD_ADDR_ERR_POS    4
`define CPCI_ERROR_DMA_WR_ADDR_ERR_POS    3
`define CPCI_ERROR_DMA_RD_MAC_ERR_POS     2
`define CPCI_ERROR_DMA_WR_MAC_ERR_POS     1
`define CPCI_ERROR_DMA_FATAL_ERR_POS      0

// Type: cpci_interrupt
// Description: CPCI error
// File: projects/cpci/include/cpci_regs.xml
`define CPCI_INTERRUPT_DMA_RD_DONE_POS               31
`define CPCI_INTERRUPT_DMA_WR_DONE_POS               30
`define CPCI_INTERRUPT_PHY_INTR_POS                  29
`define CPCI_INTERRUPT_DMA_QUEUE_STATUS_CHANGE_POS   9
`define CPCI_INTERRUPT_PKT_AVAIL_POS                 8
`define CPCI_INTERRUPT_CNET_ERR_POS                  5
`define CPCI_INTERRUPT_CNET_RD_TIMEOUT_POS           4
`define CPCI_INTERRUPT_PROG_ERROR_POS                3
`define CPCI_INTERRUPT_DMA_TIMEOUT_POS               2
`define CPCI_INTERRUPT_DMA_GENERAL_POS               1
`define CPCI_INTERRUPT_DMA_FATAL_POS                 0

// Type: cpci_cnet_clk_sel
// Description: CNET (Virtex) clock selection
// File: projects/cpci/include/cpci_regs.xml
`define CPCI_CNET_CLK_SEL_CLK_125_POS   0

// Type: cpci_reprog_status
// Description: CNET (Virtex) reprogramming status
// File: projects/cpci/include/cpci_regs.xml
`define CPCI_REPROG_STATUS_REPROG_POS   0
`define CPCI_REPROG_STATUS_EMPTY_POS    1
`define CPCI_REPROG_STATUS_DONE_POS     8
`define CPCI_REPROG_STATUS_INIT_POS     16

// Type: cpci_reprog_ctrl
// Description: CNET (Virtex) reprogramming control
// File: projects/cpci/include/cpci_regs.xml
`define CPCI_REPROG_CTRL_RESET_POS   0

// Type: cpci_dma_ctrl
// Description: DMA control
// File: projects/cpci/include/cpci_regs.xml
`define CPCI_DMA_CTRL_NF2_IS_OWNER_POS   0
`define CPCI_DMA_CTRL_PORT_POS_LO        8
`define CPCI_DMA_CTRL_PORT_POS_HI        9
`define CPCI_DMA_CTRL_PORT_WIDTH         2

// Type: cpci_dma_queue_status
// Description: DMA queue status
// File: projects/cpci/include/cpci_regs.xml
`define CPCI_DMA_QUEUE_STATUS_PKT_AVAIL_POS_LO    16
`define CPCI_DMA_QUEUE_STATUS_PKT_AVAIL_POS_HI    31
`define CPCI_DMA_QUEUE_STATUS_PKT_AVAIL_WIDTH     16
`define CPCI_DMA_QUEUE_STATUS_CAN_WR_PKT_POS_LO   0
`define CPCI_DMA_QUEUE_STATUS_CAN_WR_PKT_POS_HI   15
`define CPCI_DMA_QUEUE_STATUS_CAN_WR_PKT_WIDTH    16



