#include "portmap.h"
#include "libds/ds.h"

#include <sys/stat.h>
#include <stdlib.h>
#include <unistd.h>

#define TABLE_SIZE 7

static HASHTABLE portmap = NULL;

typedef struct _FileEntry 
{
  FILE *fd;
  int mode;
} FileEntry;

void init_portmap()
{
  /* assert(NULL == portmap); */

  portmap = htMake(TABLE_SIZE);
}

FILE* port2fifo(char *id, int rwbar)
{
  void *data;
  FILE *F = NULL;
  FileEntry *entry;
  
  if (NULL == portmap)
    init_portmap();

  data = htFind(portmap, id);

  if (NULL != data) {
    entry = (FileEntry*)data;
    /* assert(!((rwbar == 0) ^ (entry->mode == 0))); */
    return entry->fd;
  }

  if (rwbar != 0) {
    F = fopen(id, "r");
    while (!F) {
      sleep(5);
      F = fopen(id, "r");
    }
  } else {
    unlink(id);
    mkfifo(id, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
    F = fopen(id, "w");
  }

  entry = (FileEntry*)malloc(sizeof(FileEntry));
  entry->fd = F;
  entry->mode = rwbar;
  
  htAdd(portmap, id, (void *)entry);
  return F;
}
