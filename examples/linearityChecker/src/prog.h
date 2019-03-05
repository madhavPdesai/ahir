#define VEC_SIZE   8
#define NUM_VECS   64
#define NUM_CHUNKS 4
#define CHUNK_SIZE NUM_VECS*VEC_SIZE/NUM_CHUNKS

#define OMEGA      0
#define EPSILON    0.6

// mask
#define SEL_MASK ~((uint32_t) NUM_CHUNKS) 

// top-level, free running functions.
void dispatcher();
inline uint32_t innerLoop(float* X, float* Y, uint32_t vsize, float epsilon);

void dC00();
void dC01();
void dC02();
void dC03();

void dC11();
void dC12();
void dC13();

void dC22();
void dC23();

void dC33();
