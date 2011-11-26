#include  <stdint.h>
#include  <readwrite.hh>
#include  <wrapper_lib.hh>

// this is a dummy function, which when compiled
// by clang, produces llvm byte-code which mimics
// click2llvm  generated code.
void round_robin()
{

	while(1)
	{
		uintptr_t pkt = read_uintptr("fromfpga_in0");
		write_uint32("tofpga_port_number", 0);	
		write_uintptr("tofpga0_out0", pkt);

		pkt = read_uintptr("fromfpga_in0");
		write_uint32("tofpga_port_number", 1);	
		write_uintptr("tofpga1_out0", pkt);

		pkt = read_uintptr("fromfpga_in0");
		write_uint32("tofpga_port_number", 2);	
		write_uintptr("tofpga2_out0", pkt);

		pkt = read_uintptr("fromfpga_in0");
		write_uint32("tofpga_port_number", 3);	
		write_uintptr("tofpga3_out0", pkt);


		pkt = read_uintptr("fromfpga_in0");
		ahir_packet_free((uint32_t) pkt);
	}

}




