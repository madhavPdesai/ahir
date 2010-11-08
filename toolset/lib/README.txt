Value:Scalar/Composite/Pointer
ScalarValue:(Type,bit-String)
CompositeValue:list<Value>
Pointer: string MemoryLocation.Id
MemoryLocation:(Value,base-Address,Id)
MemorySpace:  ({MemoryLocation},Id)
	- property: needs/does-not-need initialization
Storage: ({MemorySpaces},Id)
CP:({Transitions},{Places})
DP:({DPElements})
Module: (Storage + CP + DP + LN, Id)
	add_dpe(id,operation_name,data-type(including width))
	add_transition(id, input/output)
	add_place(id,initial-marking)
	control_flow(t,p / p,t / t,t)
	link_symbols(transition t, dpe, string dpe-ctrl-sig)
	add_wire(id, type)
	connect_wire(id, dpe, string dpe-port-name)
	add_memory_space(id) --inherited from Storage
	add_memory_location(id, mem-space-id) -- inherited from Storage
Program: (Storage + {Module}, Id)
	add_module(id..)
	mark_start_module(id)
	add_memory_space(id) --inherited from Storage
	add_memory_location(id, mem-space-id) -- inherited from Storage
	initialize(AHIR)
	unite(AHIR)
	
Utilities on Program
	share_operators
	link
	ahir2vhdl

TODO's

   - compile time relax if module definition not present
     but call to module exists.
	(but assert at link-time)
   - for each memory space, instantiate memory subsystem. 
	(based on memory-space description. provide LAU wide
 	 port to initialize the memory space)
   - default memory space needs to be initialized
   - other memory spaces may/may not need initialization
   - load/store operators and their association with memory spaces? 
	(key,value) attribute pair on load/store operators.
	define key
   - union of AHIR programs
   - constant operands in ahir2vhdl
