#include <hierSystem.h>


string IntToStr(int u)
{
  ostringstream string_stream(ostringstream::out);
  string_stream << u;
  return(string_stream.str());
}
