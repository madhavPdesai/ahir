#define VEC_SIZE   4
#define OMEGA      2

// functions.
void init();
void TxHControl(uint32_t val);
void TxVControl(uint32_t val);

// top-level, free running functions.
void TxValues();
void dispatcher();
void collector();

/* 
 *
 * macros
 *
 */
#define __WHC(Row,Col,val) write_uint32("h_control_pipe_" #Row #Col,val)
#define __WVC(Row,Col,val) write_uint32("v_control_pipe_" #Row #Col,val)
#define __WHD(Row,Col,val) write_float32("h_data_pipe_" #Row #Col,val)
#define __WVD(Row,Col,val) write_float32("h_data_pipe_" #Row #Col,val)
#define __RVR(Row,Col,val) {val = read_float32("v_result_pipe_" #Row #Col);}

