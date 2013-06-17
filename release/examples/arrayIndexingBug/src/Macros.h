#define MaxNumFaces 1024
#define MaxNumCells 1024

#define EPSILON 1.0e-6

#define WUINT32BURST(p,b,n) {uint32_t j; for(j = 0; j < n; j++) {\
 write_uint32(p,b[j]); }}
#define WFLOAT64BURST(p,b,n) {uint32_t j; for(j = 0; j < n; j++){\
 write_float64(p,b[j]);  }}
#define RUINT32BURST(p,b,n) {uint32_t j; for(j = 0; j < n; j++){\
 b[j] = read_uint32(p); }}
#define RFLOAT64BURST(p,b,n) {uint32_t j; for(j = 0; j < n; j++){\
 b[j] = read_float64(p); }}

#define ORDER 16
