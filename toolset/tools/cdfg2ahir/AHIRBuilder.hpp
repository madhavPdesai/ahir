#ifndef __AHIRBUILDER_HPP__
#define __AHIRBUILDER_HPP__

namespace hls
{
  class Program;
};

namespace ahir
{
  void cdfg2ahir(hls::Program *program);
}

#endif
