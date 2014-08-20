#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <Pipes.h>
#include <SocketLib.h>
float fpadd32(float L,float R);
double fpadd64(double L,double R);
float fpmul32(float L,float R);
double fpmul64(double L,double R);
float fpsub32(float L,float R);
double fpsub64(double L,double R);
float fpu32(float L,float R,uint8_t OP_ID);
double fpu64(double L,double R,uint16_t OP_ID);
void getData();
void global_storage_initializer_();
void progx_xoptx_xo_storage_initializer_();
void sendResult();
void vectorSum();
void x_vectorSum_();
