#include <BGLWrap.hpp>

int main()
{
  char* vertices[] = { "a", "b", "c", "d" };
  Vertex V[4];
  Edge   E[4];
  GraphBase g;
  for(int idx = 0; idx < 4; idx++)
    {
      string vname = vertices[idx];
      V[idx] = g.Add_Vertex((void*) (&(vertices[idx])), vname);
      E[idx] = g.Add_Edge((void*) (&(vertices[idx])), (void*) (&(vertices[(idx+1)%4])));
    }
  g.Print(cout);


  UVertex UV[4];
  UEdge   UE[4];
  UGraphBase ug;
  for(int idx = 0; idx < 4; idx++)
    {
      string vname = vertices[idx];
      UV[idx] = ug.Add_Vertex((void*) (&(vertices[idx])), vname);
      UE[idx] = ug.Add_Edge((void*) (&(vertices[idx])), (void*) (&(vertices[(idx+1)%4])));
    }
  ug.Print(cout);
}
