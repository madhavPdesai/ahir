#include <ahir_system_wrapper.h>

Link free_list[FREE_LIST_SIZE];
Link* head;


// manage the freelist/queue
//
// put the freelist management in one function
// to avoid the need for mutex/locking.
//
// there is a single request queue and two 
// possible response queues (depending on
// the nature of the request).
//
void free_queue_manager()
{
  int i;

  // initialize the linked list.
  for(i = 0; i < FREE_LIST_SIZE-1; i++)
    {
      free_list[i].next = &(free_list[i+1]);
    }
  free_list[FREE_LIST_SIZE-1].next = NULL;
  head = &(free_list[0]);
	
  while(1)
    {

      // listen for the request.
      uint8_t command = read_uint8("free_queue_request");
      if(command == FREE_LIST_GET)
	{
	  // return head to free_queue_get
	  Link* ret = head;
	  if(head != NULL)
	    head = head->next;
	  write_pointer("free_queue_get", ret);
	}	
      else if(command == FREE_LIST_PUT)
	{
	  // prepend to list
	  Link* put_link = read_pointer("free_queue_put");
	  put_link->next = head;
	  head = put_link;
	}
#ifdef RUN
      else
	fprintf(stderr,"Error: unknown free list command\n");
#endif

    }
}


// the same algorithm as in Sameer's input-module (NetFPGAInput)
void input_module()
{
  while(1)
    {

      // ask for a free slot
      write_uint8("free_queue_request", FREE_LIST_GET);

      // read response
      Link* lptr  =  read_pointer("free_queue_get");

      if(lptr != NULL) // found a free slot?
	{

	  int word_index = 0;

	  // listen for packet.
	  while(1)
	    {
	      // read packet from NetFPGA_INCOMING_*
	      // and put it into lptr->pkt
	      uint64_t indata = read_uint64(NETFPGA_INCOMING_DATA);
	      uint8_t  inctrl = read_uint8(NETFPGA_INCOMING_CONTROL);

	      if(inctrl == 0)
		{
		  // start storing packet.
		  *((uint64_t*) & (lptr->pkt[word_index])) = indata;
		  
		  if(word_index == 0)
		    word_index += DATA_OFFSET_IN_PACKET;
		  else
		    word_index += 8;
		}
	      else
		break;
	    }
	  
		      
	  // forward the pointer to the processing
	  // subsystem (blocking write)
	  write_pointer(TO_AHIR_SYSTEM,lptr);
	}
    }
}

// same algorithm as in Sameer's VHDL implementation.
// 
// repeat forever
//   get a link pointer.
//   read the first word in the packet.
//   from the first word, extract the length in words/bytes.
//        length_in_words <= data(47 downto 32)
//        length_in_bytes <= data(15 downto 0)
//   send the first word as data, with ctrl = 0xff.
//   send the remaining words (except the last), with ctrl=0
//   send the last word with ctrl= (128 >> (length_in_words & 7))
// end repeat
void output_module()
{
  while(1)
    {
      // wait for a pointer from the AHIR system (blocking read)
      Link* lptr = read_pointer(FROM_AHIR_SYSTEM);

      if(lptr != NULL)
	{
	  

	  // Read the packet from lptr and send on data pipe.
	  int word_index = 0;
	  // first word.
	  uint8_t outctrl = 0xff;

	  uint64_t outdata = *((uint64_t*) &(lptr->pkt[0]));
	  uint16_t length_in_words = (uint16_t) ((outdata & WORD_LENGTH_MASK) >> 32);

	  write_uint64(NETFPGA_OUTGOING_DATA, outdata);
	  write_uint8(NETFPGA_OUTGOING_CONTROL, outctrl);	  

	  // remaining words, except for the last.
	  outctrl = 0;
	  for(word_index = 1; word_index < length_in_words-1; word_index++)
	    {
	      outdata =  *((uint64_t*) &(lptr->pkt[word_index*8]));
	      write_uint64(NETFPGA_OUTGOING_DATA, outdata);
	      write_uint8(NETFPGA_OUTGOING_CONTROL, outctrl);	  
	    }

	  // last word
	  outctrl = (128 >> ((uint8_t) length_in_words));
	  outdata =  *((uint64_t*) &(lptr->pkt[word_index*8]));
	  write_uint64(NETFPGA_OUTGOING_DATA, outdata);
	  write_uint8(NETFPGA_OUTGOING_CONTROL, outctrl);	  


	  // release the freelist slot
	  write_uint8("free_queue_request", FREE_LIST_PUT);
	  write_pointer("free_queue_put", lptr);
	}
    }
}

