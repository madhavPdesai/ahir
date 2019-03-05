#include <prog.h>

// check uints only
uint32_t uint_x[6];
uint32_t uint_y[6];

uint32_t uint_arith[3];
uint32_t uint_cmp[6];
uint32_t uint_shift[2];

uint16_t uint16_t_x[6];
uint16_t uint16_t_y[6];

uint16_t uint16_t_arith[3];
uint16_t uint16_t_cmp[6];
uint16_t uint16_t_shift[2];

float float_x[6];
float float_y[6];

float float_arith[3];
float float_cmp[6];

int test_ints()
{
  uint32_t cmp_vector = 0;
  uint32_t result = 0;
  uint32_t i;
  
  uint_arith[0] = uint_x[0] + uint_y[0];
  uint_arith[1] = uint_x[1] - uint_y[1];
  uint_arith[2] = uint_x[2] * uint_y[2];

  uint_cmp[0] = uint_x[0] > uint_y[0];
  uint_cmp[1] = uint_x[1] >= uint_y[1];
  uint_cmp[2] = uint_x[2] < uint_y[2];
  uint_cmp[3] = uint_x[3] <= uint_y[3];
  uint_cmp[4] = uint_x[4] == uint_y[4];
  uint_cmp[5] = uint_x[5] != uint_y[5];

  for (i = 0; i < 6; i++)
    cmp_vector = cmp_vector & (uint_cmp[i] << (i << 2));

  uint_shift[0] = uint_x[0] >> 4;
  uint_shift[1] = uint_y[0] << 4;

  result = uint_arith[0];
  result &= uint_arith[1];
  result |= uint_arith[2];
  
  result ^= uint_shift[0];
  result ^= uint_shift[1];

  result += cmp_vector;

#ifdef RUN
  printf("%x\n", result);
#endif
  return result;
}

uint16_t test_uint16_ts()
{
  uint16_t cmp_vector = 0;
  uint16_t result = 0;
  int i;
  
  uint16_t_arith[0] = uint16_t_x[0] + uint16_t_y[0];
  uint16_t_arith[1] = uint16_t_x[1] - uint16_t_y[1];
  uint16_t_arith[2] = uint16_t_x[2] * uint16_t_y[2];

  uint16_t_cmp[0] = uint16_t_x[0] > uint16_t_y[0];
  uint16_t_cmp[1] = uint16_t_x[1] >= uint16_t_y[1];
  uint16_t_cmp[2] = uint16_t_x[2] < uint16_t_y[2];
  uint16_t_cmp[3] = uint16_t_x[3] <= uint16_t_y[3];
  uint16_t_cmp[4] = uint16_t_x[4] == uint16_t_y[4];
  uint16_t_cmp[5] = uint16_t_x[5] != uint16_t_y[5];

  for (i = 0; i < 6; i++)
    cmp_vector = cmp_vector & (uint16_t_cmp[i] << (i << 2));

  uint16_t_shift[0] = uint16_t_x[0] >> 4;
  uint16_t_shift[1] = uint16_t_y[0] << 4;

  result = uint16_t_arith[0];
  result &= uint16_t_arith[1];
  result |= uint16_t_arith[2];
  
  result ^= uint16_t_shift[0];
  result ^= uint16_t_shift[1];

  result += cmp_vector;

#ifdef RUN
  printf("%x\n", result);
#endif
  return result;
}

float test_floats()
{
  uint32_t cmp_vector = 0;
  float result = 0;
  int i;
  
  float_arith[0] = float_x[0] + float_y[0];
  float_arith[1] = float_x[1] - float_y[1];
  float_arith[2] = float_x[2] * float_y[2];

  float_cmp[0] = float_x[0] > float_y[0];
  float_cmp[1] = float_x[1] >= float_y[1];
  float_cmp[2] = float_x[2] < float_y[2];
  float_cmp[3] = float_x[3] <= float_y[3];
  float_cmp[4] = float_x[4] == float_y[4];
  float_cmp[5] = float_x[5] != float_y[5];

  for (i = 0; i < 6; i++)
    cmp_vector = cmp_vector & (((uint32_t)float_cmp[i]) << (i << 2));

  result = float_arith[0];
  result += float_arith[1];
  result -= float_arith[2];
  
  result += cmp_vector;

#ifdef RUN
  printf("%f\n", result);
#endif
  return result;
}

#define next(x) ((x & 0x00100000) >> 20) ^ ((x & 0x00000100) >> 8) | (x << 1)

uint32_t start (void)
{
  int i;
  uint32_t reg = 0x5B5AB714;
  
  for (i = 0; i < 6; i++) {
    reg = next(reg);
    uint_x[i] = reg;
    
    reg = next(reg);
    uint_y[i] = reg;
  }

  for (i = 0; i < 6; i++) {
    reg = next(reg);
    uint16_t_x[i] = reg;
    
    reg = next(reg);
    uint16_t_y[i] = reg;
  }

  i = 0;
  float_x[i++] = 0.055237;
  float_x[i++] = 0.615051;
  float_x[i++] = -1.964783;
  float_x[i++] = 0.054016;
  float_x[i++] = 0.800354;
  float_x[i++] = 1.106262;

  i = 0;
  float_y[i++] = -0.324402;
  float_y[i++] = -1.755798;
  float_y[i++] = 1.130188;
  float_y[i++] = -0.162537;
  float_y[i++] = 0.073059;
  float_y[i++] = 0.309631;

  return test_ints() ^ (uint32_t)test_floats() ^ test_uint16_ts();
}
