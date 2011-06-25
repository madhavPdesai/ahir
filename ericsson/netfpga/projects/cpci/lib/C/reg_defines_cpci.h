/********************************************************
 *
 * C register defines file
 * Project: CPCI (cpci)
 * Description: NetFPGA PCI interface
 *
 ********************************************************/

#ifndef _REG_DEFINES_CPCI_
#define _REG_DEFINES_CPCI_

/* ========= Version Information ========= */

// CPCI version number (major number)
#define CPCI_VERSION_ID       0x000004

// CPCI revision number (minor number)
#define CPCI_REVISION_ID      0x01


/* ========= Constants ========= */

// ===== File: lib/verilog/core/common/xml/global.xml =====

// Maximum number of phy ports
#define MAX_PHY_PORTS                 4

// PCI address bus width
#define PCI_ADDR_WIDTH                32

// PCI data bus width
#define PCI_DATA_WIDTH                32

// PCI byte enable bus width
#define PCI_BE_WIDTH                  4

// CPCI--CNET address bus width. This is byte addresses even though bottom bits are zero.
#define CPCI_CNET_ADDR_WIDTH          27

// CPCI--CNET data bus width
#define CPCI_CNET_DATA_WIDTH          32

// CPCI--Virtex address bus width. This is byte addresses even though bottom bits are zero.
#define CPCI_NF2_ADDR_WIDTH           27

// CPCI--Virtex data bus width
#define CPCI_NF2_DATA_WIDTH           32

// DMA data bus width
#define DMA_DATA_WIDTH                32

// DMA control bus width
#define DMA_CTRL_WIDTH                4

// CPCI debug bus width
#define CPCI_DEBUG_DATA_WIDTH         29

// SRAM address width
#define SRAM_ADDR_WIDTH               19

// SRAM data width
#define SRAM_DATA_WIDTH               36

// DRAM address width
#define DRAM_ADDR_WIDTH               24


// ===== File: lib/verilog/core/common/xml/nf_defines.xml =====

// Clock period of 125 MHz clock in ns
#define FAST_CLK_PERIOD               8

// Clock period of 62.5 MHz clock in ns
#define SLOW_CLK_PERIOD               16

// Header value used by the IO queues
#define IO_QUEUE_STAGE_NUM            0xff

// Data path data width
#define DATA_WIDTH                    64

// Data path control width
#define CTRL_WIDTH                    8


// ===== File: projects/cpci/include/cpci_regs.xml =====

// Default maximum time for DMA transfers (in clock cycles)
#define CPCI_DMA_XFER_TIME_DEFAULT    30000

// Default maximum number of retries for DMA transactions
#define CPCI_DMA_RETRIES_DEFAULT      0xffff

// Default maximum Virtex register read time
#define CPCI_CNET_READ_TIME_DEFAULT   4000

// Number of PCI cycles in an interation
#define CPCI_P_MAX_DEFAULT            3333333

// Expected number of CPCI-Virtex clocks in the PCI period defined above
#define CPCI_N_EXP_DEFAULT            6250000


/* ========= Modules ========= */

// Module tags
#define CPCI_BASE_ADDR  0x0000000



/* ========== Registers ========== */

// Name: cpci (CPCI)
// Description: CPCI registers
// File: projects/cpci/include/cpci_regs.xml
#define CPCI_ID_REG                    0x0000000
#define CPCI_BOARD_ID_REG              0x0000004
#define CPCI_CTRL_REG                  0x0000008
#define CPCI_RESET_REG                 0x000000c
#define CPCI_ERROR_REG                 0x0000010
#define CPCI_DUMMY_REG                 0x0000020
#define CPCI_INTERRUPT_MASK_REG        0x0000040
#define CPCI_INTERRUPT_STATUS_REG      0x0000044
#define CPCI_CNET_CLK_SEL_REG          0x0000050
#define CPCI_REPROG_DATA_REG           0x0000100
#define CPCI_REPROG_STATUS_REG         0x0000104
#define CPCI_REPROG_CTRL_REG           0x0000108
#define CPCI_DMA_ADDR_I_REG            0x0000140
#define CPCI_DMA_ADDR_E_REG            0x0000144
#define CPCI_DMA_SIZE_I_REG            0x0000148
#define CPCI_DMA_SIZE_E_REG            0x000014c
#define CPCI_DMA_CTRL_I_REG            0x0000150
#define CPCI_DMA_CTRL_E_REG            0x0000154
#define CPCI_DMA_QUEUE_STATUS_REG      0x0000158
#define CPCI_DMA_XFER_TIME_REG         0x0000180
#define CPCI_DMA_RETRIES_REG           0x0000184
#define CPCI_CNET_READ_TIME_REG        0x0000188
#define CPCI_DMA_INGRESS_PKT_CNT_REG   0x0000400
#define CPCI_DMA_EGRESS_PKT_CNT_REG    0x0000404
#define CPCI_CPCI_REG_READ_CNT_REG     0x0000408
#define CPCI_CPCI_REG_WRITE_CNT_REG    0x000040c
#define CPCI_CNET_REG_READ_CNT_REG     0x0000410
#define CPCI_CNET_REG_WRITE_CNT_REG    0x0000414
#define CPCI_CLOCK_CHECK_N_CLK_REG     0x0000500
#define CPCI_CLOCK_CHECK_P_MAX_REG     0x0000504
#define CPCI_CLOCK_CHECK_N_EXP_REG     0x0000508
#define CPCI_PCI_CLK_CNT_REG           0x0000510
#define CPCI_CPCI_RESET_CNT_REG        0x0000520



/* ========== Bitmasks ========== */

// Type: cpci_id
// Description: CPCI ID
// File: projects/cpci/include/cpci_regs.xml

// Part 1: bit positions
#define CPCI_ID_VERSION_POS_LO    0
#define CPCI_ID_VERSION_POS_HI    23
#define CPCI_ID_VERSION_WIDTH     24
#define CPCI_ID_REVISION_POS_LO   24
#define CPCI_ID_REVISION_POS_HI   31
#define CPCI_ID_REVISION_WIDTH    8

// Part 2: masks/values
#define CPCI_ID_VERSION_MASK      0x00ffffff
#define CPCI_ID_REVISION_MASK     0xff000000

// Type: cpci_board_id
// Description: CPCI board ID
// File: projects/cpci/include/cpci_regs.xml

// Part 1: bit positions
#define CPCI_BOARD_ID_JMPR_POS        0
#define CPCI_BOARD_ID_ROTARY_POS_LO   8
#define CPCI_BOARD_ID_ROTARY_POS_HI   11
#define CPCI_BOARD_ID_ROTARY_WIDTH    4

// Part 2: masks/values
#define CPCI_BOARD_ID_JMPR            0x00000001
#define CPCI_BOARD_ID_ROTARY_MASK     0x00000f00

// Type: cpci_ctrl
// Description: Control register
// File: projects/cpci/include/cpci_regs.xml

// Part 1: bit positions
#define CPCI_CTRL_LED_POS             0
#define CPCI_CTRL_CNET_RESET_POS      8
#define CPCI_CTRL_LITTLE_ENDIAN_POS   16

// Part 2: masks/values
#define CPCI_CTRL_LED                 0x00000001
#define CPCI_CTRL_CNET_RESET          0x00000100
#define CPCI_CTRL_LITTLE_ENDIAN       0x00010000

// Type: cpci_reset
// Description: Reset the board
// File: projects/cpci/include/cpci_regs.xml

// Part 1: bit positions
#define CPCI_RESET_RESET_POS   0

// Part 2: masks/values
#define CPCI_RESET_RESET       0x1

// Type: cpci_error
// Description: CPCI error
// File: projects/cpci/include/cpci_regs.xml

// Part 1: bit positions
#define CPCI_ERROR_CNET_RD_TIMEOUT_POS    25
#define CPCI_ERROR_CNET_ERR_POS           24
#define CPCI_ERROR_PROG_OVERFLOW_POS      17
#define CPCI_ERROR_PROG_ERROR_POS         16
#define CPCI_ERROR_DMA_TIMEOUT_POS        10
#define CPCI_ERROR_DMA_RETRY_EXPIRE_POS   9
#define CPCI_ERROR_DMA_BUF_OVERFLOW_POS   8
#define CPCI_ERROR_DMA_RD_SIZE_ERR_POS    6
#define CPCI_ERROR_DMA_WR_SIZE_ERR_POS    5
#define CPCI_ERROR_DMA_RD_ADDR_ERR_POS    4
#define CPCI_ERROR_DMA_WR_ADDR_ERR_POS    3
#define CPCI_ERROR_DMA_RD_MAC_ERR_POS     2
#define CPCI_ERROR_DMA_WR_MAC_ERR_POS     1
#define CPCI_ERROR_DMA_FATAL_ERR_POS      0

// Part 2: masks/values
#define CPCI_ERROR_CNET_RD_TIMEOUT        0x02000000
#define CPCI_ERROR_CNET_ERR               0x01000000
#define CPCI_ERROR_PROG_OVERFLOW          0x00020000
#define CPCI_ERROR_PROG_ERROR             0x00010000
#define CPCI_ERROR_DMA_TIMEOUT            0x00000400
#define CPCI_ERROR_DMA_RETRY_EXPIRE       0x00000200
#define CPCI_ERROR_DMA_BUF_OVERFLOW       0x00000100
#define CPCI_ERROR_DMA_RD_SIZE_ERR        0x00000040
#define CPCI_ERROR_DMA_WR_SIZE_ERR        0x00000020
#define CPCI_ERROR_DMA_RD_ADDR_ERR        0x00000010
#define CPCI_ERROR_DMA_WR_ADDR_ERR        0x00000008
#define CPCI_ERROR_DMA_RD_MAC_ERR         0x00000004
#define CPCI_ERROR_DMA_WR_MAC_ERR         0x00000002
#define CPCI_ERROR_DMA_FATAL_ERR          0x00000001

// Type: cpci_interrupt
// Description: CPCI error
// File: projects/cpci/include/cpci_regs.xml

// Part 1: bit positions
#define CPCI_INTERRUPT_DMA_RD_DONE_POS               31
#define CPCI_INTERRUPT_DMA_WR_DONE_POS               30
#define CPCI_INTERRUPT_PHY_INTR_POS                  29
#define CPCI_INTERRUPT_DMA_QUEUE_STATUS_CHANGE_POS   9
#define CPCI_INTERRUPT_PKT_AVAIL_POS                 8
#define CPCI_INTERRUPT_CNET_ERR_POS                  5
#define CPCI_INTERRUPT_CNET_RD_TIMEOUT_POS           4
#define CPCI_INTERRUPT_PROG_ERROR_POS                3
#define CPCI_INTERRUPT_DMA_TIMEOUT_POS               2
#define CPCI_INTERRUPT_DMA_GENERAL_POS               1
#define CPCI_INTERRUPT_DMA_FATAL_POS                 0

// Part 2: masks/values
#define CPCI_INTERRUPT_DMA_RD_DONE                   0x80000000
#define CPCI_INTERRUPT_DMA_WR_DONE                   0x40000000
#define CPCI_INTERRUPT_PHY_INTR                      0x20000000
#define CPCI_INTERRUPT_DMA_QUEUE_STATUS_CHANGE       0x00000200
#define CPCI_INTERRUPT_PKT_AVAIL                     0x00000100
#define CPCI_INTERRUPT_CNET_ERR                      0x00000020
#define CPCI_INTERRUPT_CNET_RD_TIMEOUT               0x00000010
#define CPCI_INTERRUPT_PROG_ERROR                    0x00000008
#define CPCI_INTERRUPT_DMA_TIMEOUT                   0x00000004
#define CPCI_INTERRUPT_DMA_GENERAL                   0x00000002
#define CPCI_INTERRUPT_DMA_FATAL                     0x00000001

// Type: cpci_cnet_clk_sel
// Description: CNET (Virtex) clock selection
// File: projects/cpci/include/cpci_regs.xml

// Part 1: bit positions
#define CPCI_CNET_CLK_SEL_CLK_125_POS   0

// Part 2: masks/values
#define CPCI_CNET_CLK_SEL_CLK_125       0x1

// Type: cpci_reprog_status
// Description: CNET (Virtex) reprogramming status
// File: projects/cpci/include/cpci_regs.xml

// Part 1: bit positions
#define CPCI_REPROG_STATUS_REPROG_POS   0
#define CPCI_REPROG_STATUS_EMPTY_POS    1
#define CPCI_REPROG_STATUS_DONE_POS     8
#define CPCI_REPROG_STATUS_INIT_POS     16

// Part 2: masks/values
#define CPCI_REPROG_STATUS_REPROG       0x00000001
#define CPCI_REPROG_STATUS_EMPTY        0x00000002
#define CPCI_REPROG_STATUS_DONE         0x00000100
#define CPCI_REPROG_STATUS_INIT         0x00010000

// Type: cpci_reprog_ctrl
// Description: CNET (Virtex) reprogramming control
// File: projects/cpci/include/cpci_regs.xml

// Part 1: bit positions
#define CPCI_REPROG_CTRL_RESET_POS   0

// Part 2: masks/values
#define CPCI_REPROG_CTRL_RESET       0x1

// Type: cpci_dma_ctrl
// Description: DMA control
// File: projects/cpci/include/cpci_regs.xml

// Part 1: bit positions
#define CPCI_DMA_CTRL_NF2_IS_OWNER_POS   0
#define CPCI_DMA_CTRL_PORT_POS_LO        8
#define CPCI_DMA_CTRL_PORT_POS_HI        9
#define CPCI_DMA_CTRL_PORT_WIDTH         2

// Part 2: masks/values
#define CPCI_DMA_CTRL_NF2_IS_OWNER       0x00000001
#define CPCI_DMA_CTRL_PORT_MASK          0x00000300

// Type: cpci_dma_queue_status
// Description: DMA queue status
// File: projects/cpci/include/cpci_regs.xml

// Part 1: bit positions
#define CPCI_DMA_QUEUE_STATUS_PKT_AVAIL_POS_LO    16
#define CPCI_DMA_QUEUE_STATUS_PKT_AVAIL_POS_HI    31
#define CPCI_DMA_QUEUE_STATUS_PKT_AVAIL_WIDTH     16
#define CPCI_DMA_QUEUE_STATUS_CAN_WR_PKT_POS_LO   0
#define CPCI_DMA_QUEUE_STATUS_CAN_WR_PKT_POS_HI   15
#define CPCI_DMA_QUEUE_STATUS_CAN_WR_PKT_WIDTH    16

// Part 2: masks/values
#define CPCI_DMA_QUEUE_STATUS_PKT_AVAIL_MASK      0xffff0000
#define CPCI_DMA_QUEUE_STATUS_CAN_WR_PKT_MASK     0x0000ffff




#endif

