#############################################################
#
# Perl register defines
#
# Project: CPCI (cpci)
# Description: NetFPGA PCI interface
#
#############################################################

package reg_defines_cpci;

use Exporter;

@ISA = ('Exporter');

@EXPORT = qw(
                CPCI_VERSION_ID
                CPCI_REVISION_ID
                MAX_PHY_PORTS
                PCI_ADDR_WIDTH
                PCI_DATA_WIDTH
                PCI_BE_WIDTH
                CPCI_CNET_ADDR_WIDTH
                CPCI_CNET_DATA_WIDTH
                CPCI_NF2_ADDR_WIDTH
                CPCI_NF2_DATA_WIDTH
                DMA_DATA_WIDTH
                DMA_CTRL_WIDTH
                CPCI_DEBUG_DATA_WIDTH
                SRAM_ADDR_WIDTH
                SRAM_DATA_WIDTH
                DRAM_ADDR_WIDTH
                FAST_CLK_PERIOD
                SLOW_CLK_PERIOD
                IO_QUEUE_STAGE_NUM
                DATA_WIDTH
                CTRL_WIDTH
                CPCI_DMA_XFER_TIME_DEFAULT
                CPCI_DMA_RETRIES_DEFAULT
                CPCI_CNET_READ_TIME_DEFAULT
                CPCI_P_MAX_DEFAULT
                CPCI_N_EXP_DEFAULT
                CPCI_BASE_ADDR
                CPCI_ID_REG
                CPCI_BOARD_ID_REG
                CPCI_CTRL_REG
                CPCI_RESET_REG
                CPCI_ERROR_REG
                CPCI_DUMMY_REG
                CPCI_INTERRUPT_MASK_REG
                CPCI_INTERRUPT_STATUS_REG
                CPCI_CNET_CLK_SEL_REG
                CPCI_REPROG_DATA_REG
                CPCI_REPROG_STATUS_REG
                CPCI_REPROG_CTRL_REG
                CPCI_DMA_ADDR_I_REG
                CPCI_DMA_ADDR_E_REG
                CPCI_DMA_SIZE_I_REG
                CPCI_DMA_SIZE_E_REG
                CPCI_DMA_CTRL_I_REG
                CPCI_DMA_CTRL_E_REG
                CPCI_DMA_QUEUE_STATUS_REG
                CPCI_DMA_XFER_TIME_REG
                CPCI_DMA_RETRIES_REG
                CPCI_CNET_READ_TIME_REG
                CPCI_DMA_INGRESS_PKT_CNT_REG
                CPCI_DMA_EGRESS_PKT_CNT_REG
                CPCI_CPCI_REG_READ_CNT_REG
                CPCI_CPCI_REG_WRITE_CNT_REG
                CPCI_CNET_REG_READ_CNT_REG
                CPCI_CNET_REG_WRITE_CNT_REG
                CPCI_CLOCK_CHECK_N_CLK_REG
                CPCI_CLOCK_CHECK_P_MAX_REG
                CPCI_CLOCK_CHECK_N_EXP_REG
                CPCI_PCI_CLK_CNT_REG
                CPCI_CPCI_RESET_CNT_REG
                CPCI_ID_VERSION_POS_LO
                CPCI_ID_VERSION_POS_HI
                CPCI_ID_VERSION_WIDTH
                CPCI_ID_REVISION_POS_LO
                CPCI_ID_REVISION_POS_HI
                CPCI_ID_REVISION_WIDTH
                CPCI_ID_VERSION_MASK
                CPCI_ID_REVISION_MASK
                CPCI_BOARD_ID_JMPR_POS     
                CPCI_BOARD_ID_ROTARY_POS_LO
                CPCI_BOARD_ID_ROTARY_POS_HI
                CPCI_BOARD_ID_ROTARY_WIDTH
                CPCI_BOARD_ID_JMPR         
                CPCI_BOARD_ID_ROTARY_MASK
                CPCI_CTRL_LED_POS          
                CPCI_CTRL_CNET_RESET_POS   
                CPCI_CTRL_LITTLE_ENDIAN_POS
                CPCI_CTRL_LED              
                CPCI_CTRL_CNET_RESET       
                CPCI_CTRL_LITTLE_ENDIAN    
                CPCI_RESET_RESET_POS
                CPCI_RESET_RESET    
                CPCI_ERROR_CNET_RD_TIMEOUT_POS 
                CPCI_ERROR_CNET_ERR_POS        
                CPCI_ERROR_PROG_OVERFLOW_POS   
                CPCI_ERROR_PROG_ERROR_POS      
                CPCI_ERROR_DMA_TIMEOUT_POS     
                CPCI_ERROR_DMA_RETRY_EXPIRE_POS
                CPCI_ERROR_DMA_BUF_OVERFLOW_POS
                CPCI_ERROR_DMA_RD_SIZE_ERR_POS 
                CPCI_ERROR_DMA_WR_SIZE_ERR_POS 
                CPCI_ERROR_DMA_RD_ADDR_ERR_POS 
                CPCI_ERROR_DMA_WR_ADDR_ERR_POS 
                CPCI_ERROR_DMA_RD_MAC_ERR_POS  
                CPCI_ERROR_DMA_WR_MAC_ERR_POS  
                CPCI_ERROR_DMA_FATAL_ERR_POS   
                CPCI_ERROR_CNET_RD_TIMEOUT     
                CPCI_ERROR_CNET_ERR            
                CPCI_ERROR_PROG_OVERFLOW       
                CPCI_ERROR_PROG_ERROR          
                CPCI_ERROR_DMA_TIMEOUT         
                CPCI_ERROR_DMA_RETRY_EXPIRE    
                CPCI_ERROR_DMA_BUF_OVERFLOW    
                CPCI_ERROR_DMA_RD_SIZE_ERR     
                CPCI_ERROR_DMA_WR_SIZE_ERR     
                CPCI_ERROR_DMA_RD_ADDR_ERR     
                CPCI_ERROR_DMA_WR_ADDR_ERR     
                CPCI_ERROR_DMA_RD_MAC_ERR      
                CPCI_ERROR_DMA_WR_MAC_ERR      
                CPCI_ERROR_DMA_FATAL_ERR       
                CPCI_INTERRUPT_DMA_RD_DONE_POS            
                CPCI_INTERRUPT_DMA_WR_DONE_POS            
                CPCI_INTERRUPT_PHY_INTR_POS               
                CPCI_INTERRUPT_DMA_QUEUE_STATUS_CHANGE_POS
                CPCI_INTERRUPT_PKT_AVAIL_POS              
                CPCI_INTERRUPT_CNET_ERR_POS               
                CPCI_INTERRUPT_CNET_RD_TIMEOUT_POS        
                CPCI_INTERRUPT_PROG_ERROR_POS             
                CPCI_INTERRUPT_DMA_TIMEOUT_POS            
                CPCI_INTERRUPT_DMA_GENERAL_POS            
                CPCI_INTERRUPT_DMA_FATAL_POS              
                CPCI_INTERRUPT_DMA_RD_DONE                
                CPCI_INTERRUPT_DMA_WR_DONE                
                CPCI_INTERRUPT_PHY_INTR                   
                CPCI_INTERRUPT_DMA_QUEUE_STATUS_CHANGE    
                CPCI_INTERRUPT_PKT_AVAIL                  
                CPCI_INTERRUPT_CNET_ERR                   
                CPCI_INTERRUPT_CNET_RD_TIMEOUT            
                CPCI_INTERRUPT_PROG_ERROR                 
                CPCI_INTERRUPT_DMA_TIMEOUT                
                CPCI_INTERRUPT_DMA_GENERAL                
                CPCI_INTERRUPT_DMA_FATAL                  
                CPCI_CNET_CLK_SEL_CLK_125_POS
                CPCI_CNET_CLK_SEL_CLK_125    
                CPCI_REPROG_STATUS_REPROG_POS
                CPCI_REPROG_STATUS_EMPTY_POS 
                CPCI_REPROG_STATUS_DONE_POS  
                CPCI_REPROG_STATUS_INIT_POS  
                CPCI_REPROG_STATUS_REPROG    
                CPCI_REPROG_STATUS_EMPTY     
                CPCI_REPROG_STATUS_DONE      
                CPCI_REPROG_STATUS_INIT      
                CPCI_REPROG_CTRL_RESET_POS
                CPCI_REPROG_CTRL_RESET    
                CPCI_DMA_CTRL_NF2_IS_OWNER_POS
                CPCI_DMA_CTRL_PORT_POS_LO
                CPCI_DMA_CTRL_PORT_POS_HI
                CPCI_DMA_CTRL_PORT_WIDTH
                CPCI_DMA_CTRL_NF2_IS_OWNER    
                CPCI_DMA_CTRL_PORT_MASK
                CPCI_DMA_QUEUE_STATUS_PKT_AVAIL_POS_LO
                CPCI_DMA_QUEUE_STATUS_PKT_AVAIL_POS_HI
                CPCI_DMA_QUEUE_STATUS_PKT_AVAIL_WIDTH
                CPCI_DMA_QUEUE_STATUS_CAN_WR_PKT_POS_LO
                CPCI_DMA_QUEUE_STATUS_CAN_WR_PKT_POS_HI
                CPCI_DMA_QUEUE_STATUS_CAN_WR_PKT_WIDTH
                CPCI_DMA_QUEUE_STATUS_PKT_AVAIL_MASK
                CPCI_DMA_QUEUE_STATUS_CAN_WR_PKT_MASK
            );


# -------------------------------------
#   Version Information
# -------------------------------------
# CPCI version number (major number)
sub CPCI_VERSION_ID ()      { 0x000004; }

# CPCI revision number (minor number)
sub CPCI_REVISION_ID ()     { 0x01; }


# -------------------------------------
#   Constants
# -------------------------------------

# ===== File: lib/verilog/core/common/xml/global.xml =====

# Maximum number of phy ports
sub MAX_PHY_PORTS ()                { 4;}

# PCI address bus width
sub PCI_ADDR_WIDTH ()               { 32;}

# PCI data bus width
sub PCI_DATA_WIDTH ()               { 32;}

# PCI byte enable bus width
sub PCI_BE_WIDTH ()                 { 4;}

# CPCI--CNET address bus width. This is byte addresses even though bottom bits are zero.
sub CPCI_CNET_ADDR_WIDTH ()         { 27;}

# CPCI--CNET data bus width
sub CPCI_CNET_DATA_WIDTH ()         { 32;}

# CPCI--Virtex address bus width. This is byte addresses even though bottom bits are zero.
sub CPCI_NF2_ADDR_WIDTH ()          { 27;}

# CPCI--Virtex data bus width
sub CPCI_NF2_DATA_WIDTH ()          { 32;}

# DMA data bus width
sub DMA_DATA_WIDTH ()               { 32;}

# DMA control bus width
sub DMA_CTRL_WIDTH ()               { 4;}

# CPCI debug bus width
sub CPCI_DEBUG_DATA_WIDTH ()        { 29;}

# SRAM address width
sub SRAM_ADDR_WIDTH ()              { 19;}

# SRAM data width
sub SRAM_DATA_WIDTH ()              { 36;}

# DRAM address width
sub DRAM_ADDR_WIDTH ()              { 24;}


# ===== File: lib/verilog/core/common/xml/nf_defines.xml =====

# Clock period of 125 MHz clock in ns
sub FAST_CLK_PERIOD ()              { 8;}

# Clock period of 62.5 MHz clock in ns
sub SLOW_CLK_PERIOD ()              { 16;}

# Header value used by the IO queues
sub IO_QUEUE_STAGE_NUM ()            { 0xff;}

# Data path data width
sub DATA_WIDTH ()                   { 64;}

# Data path control width
sub CTRL_WIDTH ()                   { 8;}


# ===== File: projects/cpci/include/cpci_regs.xml =====

# Default maximum time for DMA transfers (in clock cycles)
sub CPCI_DMA_XFER_TIME_DEFAULT ()   { 30000;}

# Default maximum number of retries for DMA transactions
sub CPCI_DMA_RETRIES_DEFAULT ()      { 0xffff;}

# Default maximum Virtex register read time
sub CPCI_CNET_READ_TIME_DEFAULT ()  { 4000;}

# Number of PCI cycles in an interation
sub CPCI_P_MAX_DEFAULT ()           { 3333333;}

# Expected number of CPCI-Virtex clocks in the PCI period defined above
sub CPCI_N_EXP_DEFAULT ()           { 6250000;}



## -------------------------------------
##   Modules
## -------------------------------------

# Module tags
sub CPCI_BASE_ADDR ()   { 0x0000000; }



# -------------------------------------
#   Registers
# -------------------------------------

# Name: cpci (CPCI)
# Description: CPCI registers
# File: projects/cpci/include/cpci_regs.xml
sub CPCI_ID_REG ()                    { 0x0000000;}
sub CPCI_BOARD_ID_REG ()              { 0x0000004;}
sub CPCI_CTRL_REG ()                  { 0x0000008;}
sub CPCI_RESET_REG ()                 { 0x000000c;}
sub CPCI_ERROR_REG ()                 { 0x0000010;}
sub CPCI_DUMMY_REG ()                 { 0x0000020;}
sub CPCI_INTERRUPT_MASK_REG ()        { 0x0000040;}
sub CPCI_INTERRUPT_STATUS_REG ()      { 0x0000044;}
sub CPCI_CNET_CLK_SEL_REG ()          { 0x0000050;}
sub CPCI_REPROG_DATA_REG ()           { 0x0000100;}
sub CPCI_REPROG_STATUS_REG ()         { 0x0000104;}
sub CPCI_REPROG_CTRL_REG ()           { 0x0000108;}
sub CPCI_DMA_ADDR_I_REG ()            { 0x0000140;}
sub CPCI_DMA_ADDR_E_REG ()            { 0x0000144;}
sub CPCI_DMA_SIZE_I_REG ()            { 0x0000148;}
sub CPCI_DMA_SIZE_E_REG ()            { 0x000014c;}
sub CPCI_DMA_CTRL_I_REG ()            { 0x0000150;}
sub CPCI_DMA_CTRL_E_REG ()            { 0x0000154;}
sub CPCI_DMA_QUEUE_STATUS_REG ()      { 0x0000158;}
sub CPCI_DMA_XFER_TIME_REG ()         { 0x0000180;}
sub CPCI_DMA_RETRIES_REG ()           { 0x0000184;}
sub CPCI_CNET_READ_TIME_REG ()        { 0x0000188;}
sub CPCI_DMA_INGRESS_PKT_CNT_REG ()   { 0x0000400;}
sub CPCI_DMA_EGRESS_PKT_CNT_REG ()    { 0x0000404;}
sub CPCI_CPCI_REG_READ_CNT_REG ()     { 0x0000408;}
sub CPCI_CPCI_REG_WRITE_CNT_REG ()    { 0x000040c;}
sub CPCI_CNET_REG_READ_CNT_REG ()     { 0x0000410;}
sub CPCI_CNET_REG_WRITE_CNT_REG ()    { 0x0000414;}
sub CPCI_CLOCK_CHECK_N_CLK_REG ()     { 0x0000500;}
sub CPCI_CLOCK_CHECK_P_MAX_REG ()     { 0x0000504;}
sub CPCI_CLOCK_CHECK_N_EXP_REG ()     { 0x0000508;}
sub CPCI_PCI_CLK_CNT_REG ()           { 0x0000510;}
sub CPCI_CPCI_RESET_CNT_REG ()        { 0x0000520;}



# -------------------------------------
#   Bitmasks
# -------------------------------------

# Type: cpci_id
# Description: CPCI ID
# File: projects/cpci/include/cpci_regs.xml

# Part 1: bit positions
sub CPCI_ID_VERSION_POS_LO  ()   { 0; }
sub CPCI_ID_VERSION_POS_HI  ()   { 23; }
sub CPCI_ID_VERSION_WIDTH   ()   { 24; }
sub CPCI_ID_REVISION_POS_LO ()   { 24; }
sub CPCI_ID_REVISION_POS_HI ()   { 31; }
sub CPCI_ID_REVISION_WIDTH  ()   { 8; }

# Part 2: masks/values
sub CPCI_ID_VERSION_MASK    ()   { 0x00ffffff; }
sub CPCI_ID_REVISION_MASK   ()   { 0xff000000; }

# Type: cpci_board_id
# Description: CPCI board ID
# File: projects/cpci/include/cpci_regs.xml

# Part 1: bit positions
sub CPCI_BOARD_ID_JMPR_POS      ()   { 0; }
sub CPCI_BOARD_ID_ROTARY_POS_LO ()   { 8; }
sub CPCI_BOARD_ID_ROTARY_POS_HI ()   { 11; }
sub CPCI_BOARD_ID_ROTARY_WIDTH  ()   { 4; }

# Part 2: masks/values
sub CPCI_BOARD_ID_JMPR          ()   { 0x00000001; }
sub CPCI_BOARD_ID_ROTARY_MASK   ()   { 0x00000f00; }

# Type: cpci_ctrl
# Description: Control register
# File: projects/cpci/include/cpci_regs.xml

# Part 1: bit positions
sub CPCI_CTRL_LED_POS           ()   { 0; }
sub CPCI_CTRL_CNET_RESET_POS    ()   { 8; }
sub CPCI_CTRL_LITTLE_ENDIAN_POS ()   { 16; }

# Part 2: masks/values
sub CPCI_CTRL_LED               ()   { 0x00000001; }
sub CPCI_CTRL_CNET_RESET        ()   { 0x00000100; }
sub CPCI_CTRL_LITTLE_ENDIAN     ()   { 0x00010000; }

# Type: cpci_reset
# Description: Reset the board
# File: projects/cpci/include/cpci_regs.xml

# Part 1: bit positions
sub CPCI_RESET_RESET_POS ()   { 0; }

# Part 2: masks/values
sub CPCI_RESET_RESET     ()   { 0x1; }

# Type: cpci_error
# Description: CPCI error
# File: projects/cpci/include/cpci_regs.xml

# Part 1: bit positions
sub CPCI_ERROR_CNET_RD_TIMEOUT_POS  ()   { 25; }
sub CPCI_ERROR_CNET_ERR_POS         ()   { 24; }
sub CPCI_ERROR_PROG_OVERFLOW_POS    ()   { 17; }
sub CPCI_ERROR_PROG_ERROR_POS       ()   { 16; }
sub CPCI_ERROR_DMA_TIMEOUT_POS      ()   { 10; }
sub CPCI_ERROR_DMA_RETRY_EXPIRE_POS ()   { 9; }
sub CPCI_ERROR_DMA_BUF_OVERFLOW_POS ()   { 8; }
sub CPCI_ERROR_DMA_RD_SIZE_ERR_POS  ()   { 6; }
sub CPCI_ERROR_DMA_WR_SIZE_ERR_POS  ()   { 5; }
sub CPCI_ERROR_DMA_RD_ADDR_ERR_POS  ()   { 4; }
sub CPCI_ERROR_DMA_WR_ADDR_ERR_POS  ()   { 3; }
sub CPCI_ERROR_DMA_RD_MAC_ERR_POS   ()   { 2; }
sub CPCI_ERROR_DMA_WR_MAC_ERR_POS   ()   { 1; }
sub CPCI_ERROR_DMA_FATAL_ERR_POS    ()   { 0; }

# Part 2: masks/values
sub CPCI_ERROR_CNET_RD_TIMEOUT      ()   { 0x02000000; }
sub CPCI_ERROR_CNET_ERR             ()   { 0x01000000; }
sub CPCI_ERROR_PROG_OVERFLOW        ()   { 0x00020000; }
sub CPCI_ERROR_PROG_ERROR           ()   { 0x00010000; }
sub CPCI_ERROR_DMA_TIMEOUT          ()   { 0x00000400; }
sub CPCI_ERROR_DMA_RETRY_EXPIRE     ()   { 0x00000200; }
sub CPCI_ERROR_DMA_BUF_OVERFLOW     ()   { 0x00000100; }
sub CPCI_ERROR_DMA_RD_SIZE_ERR      ()   { 0x00000040; }
sub CPCI_ERROR_DMA_WR_SIZE_ERR      ()   { 0x00000020; }
sub CPCI_ERROR_DMA_RD_ADDR_ERR      ()   { 0x00000010; }
sub CPCI_ERROR_DMA_WR_ADDR_ERR      ()   { 0x00000008; }
sub CPCI_ERROR_DMA_RD_MAC_ERR       ()   { 0x00000004; }
sub CPCI_ERROR_DMA_WR_MAC_ERR       ()   { 0x00000002; }
sub CPCI_ERROR_DMA_FATAL_ERR        ()   { 0x00000001; }

# Type: cpci_interrupt
# Description: CPCI error
# File: projects/cpci/include/cpci_regs.xml

# Part 1: bit positions
sub CPCI_INTERRUPT_DMA_RD_DONE_POS             ()   { 31; }
sub CPCI_INTERRUPT_DMA_WR_DONE_POS             ()   { 30; }
sub CPCI_INTERRUPT_PHY_INTR_POS                ()   { 29; }
sub CPCI_INTERRUPT_DMA_QUEUE_STATUS_CHANGE_POS ()   { 9; }
sub CPCI_INTERRUPT_PKT_AVAIL_POS               ()   { 8; }
sub CPCI_INTERRUPT_CNET_ERR_POS                ()   { 5; }
sub CPCI_INTERRUPT_CNET_RD_TIMEOUT_POS         ()   { 4; }
sub CPCI_INTERRUPT_PROG_ERROR_POS              ()   { 3; }
sub CPCI_INTERRUPT_DMA_TIMEOUT_POS             ()   { 2; }
sub CPCI_INTERRUPT_DMA_GENERAL_POS             ()   { 1; }
sub CPCI_INTERRUPT_DMA_FATAL_POS               ()   { 0; }

# Part 2: masks/values
sub CPCI_INTERRUPT_DMA_RD_DONE                 ()   { 0x80000000; }
sub CPCI_INTERRUPT_DMA_WR_DONE                 ()   { 0x40000000; }
sub CPCI_INTERRUPT_PHY_INTR                    ()   { 0x20000000; }
sub CPCI_INTERRUPT_DMA_QUEUE_STATUS_CHANGE     ()   { 0x00000200; }
sub CPCI_INTERRUPT_PKT_AVAIL                   ()   { 0x00000100; }
sub CPCI_INTERRUPT_CNET_ERR                    ()   { 0x00000020; }
sub CPCI_INTERRUPT_CNET_RD_TIMEOUT             ()   { 0x00000010; }
sub CPCI_INTERRUPT_PROG_ERROR                  ()   { 0x00000008; }
sub CPCI_INTERRUPT_DMA_TIMEOUT                 ()   { 0x00000004; }
sub CPCI_INTERRUPT_DMA_GENERAL                 ()   { 0x00000002; }
sub CPCI_INTERRUPT_DMA_FATAL                   ()   { 0x00000001; }

# Type: cpci_cnet_clk_sel
# Description: CNET (Virtex) clock selection
# File: projects/cpci/include/cpci_regs.xml

# Part 1: bit positions
sub CPCI_CNET_CLK_SEL_CLK_125_POS ()   { 0; }

# Part 2: masks/values
sub CPCI_CNET_CLK_SEL_CLK_125     ()   { 0x1; }

# Type: cpci_reprog_status
# Description: CNET (Virtex) reprogramming status
# File: projects/cpci/include/cpci_regs.xml

# Part 1: bit positions
sub CPCI_REPROG_STATUS_REPROG_POS ()   { 0; }
sub CPCI_REPROG_STATUS_EMPTY_POS  ()   { 1; }
sub CPCI_REPROG_STATUS_DONE_POS   ()   { 8; }
sub CPCI_REPROG_STATUS_INIT_POS   ()   { 16; }

# Part 2: masks/values
sub CPCI_REPROG_STATUS_REPROG     ()   { 0x00000001; }
sub CPCI_REPROG_STATUS_EMPTY      ()   { 0x00000002; }
sub CPCI_REPROG_STATUS_DONE       ()   { 0x00000100; }
sub CPCI_REPROG_STATUS_INIT       ()   { 0x00010000; }

# Type: cpci_reprog_ctrl
# Description: CNET (Virtex) reprogramming control
# File: projects/cpci/include/cpci_regs.xml

# Part 1: bit positions
sub CPCI_REPROG_CTRL_RESET_POS ()   { 0; }

# Part 2: masks/values
sub CPCI_REPROG_CTRL_RESET     ()   { 0x1; }

# Type: cpci_dma_ctrl
# Description: DMA control
# File: projects/cpci/include/cpci_regs.xml

# Part 1: bit positions
sub CPCI_DMA_CTRL_NF2_IS_OWNER_POS ()   { 0; }
sub CPCI_DMA_CTRL_PORT_POS_LO      ()   { 8; }
sub CPCI_DMA_CTRL_PORT_POS_HI      ()   { 9; }
sub CPCI_DMA_CTRL_PORT_WIDTH       ()   { 2; }

# Part 2: masks/values
sub CPCI_DMA_CTRL_NF2_IS_OWNER     ()   { 0x00000001; }
sub CPCI_DMA_CTRL_PORT_MASK        ()   { 0x00000300; }

# Type: cpci_dma_queue_status
# Description: DMA queue status
# File: projects/cpci/include/cpci_regs.xml

# Part 1: bit positions
sub CPCI_DMA_QUEUE_STATUS_PKT_AVAIL_POS_LO  ()   { 16; }
sub CPCI_DMA_QUEUE_STATUS_PKT_AVAIL_POS_HI  ()   { 31; }
sub CPCI_DMA_QUEUE_STATUS_PKT_AVAIL_WIDTH   ()   { 16; }
sub CPCI_DMA_QUEUE_STATUS_CAN_WR_PKT_POS_LO ()   { 0; }
sub CPCI_DMA_QUEUE_STATUS_CAN_WR_PKT_POS_HI ()   { 15; }
sub CPCI_DMA_QUEUE_STATUS_CAN_WR_PKT_WIDTH  ()   { 16; }

# Part 2: masks/values
sub CPCI_DMA_QUEUE_STATUS_PKT_AVAIL_MASK    ()   { 0xffff0000; }
sub CPCI_DMA_QUEUE_STATUS_CAN_WR_PKT_MASK   ()   { 0x0000ffff; }





1;

__END__
