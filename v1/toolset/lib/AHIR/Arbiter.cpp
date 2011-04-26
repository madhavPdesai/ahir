#include "Arbiter.hpp"

#include <assert.h>

using namespace ahir;

void Arbiter::register_client(Client *client)
{
  assert(!find_client(client->id));
  clients[client->id] = client;
}

Client* Arbiter::find_client(const std::string &id)
{
  if (clients.find(id) != clients.end())
    return clients[id];
  else
    return NULL;
}
