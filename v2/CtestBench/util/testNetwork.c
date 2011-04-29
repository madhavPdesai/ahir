#include <SocketLib.h>
#include <Vhpi.h>

#include <signal.h>


int main()
{

  Vhpi_Initialize();

  while(1)
    {
      Vhpi_Listen();
      usleep(1000);
    }
  
  return(0);
}
