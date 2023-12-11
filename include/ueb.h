#ifndef UEBH__
#define UEBH__

#include <stdbool.h>

struct ueb_config {
  char **argv;
  int argc;

  bool verbose;
};

int ueb_main(struct ueb_config *cfg);

#endif
