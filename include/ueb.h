#ifndef UEBH__
#define UEBH__

#include <stdbool.h>

struct ueb_config {
  char **argv;
  int argc;

  bool verbose;
};

struct ueb {
  int tickc;
};

int ueb_tick(struct ueb *ueb);

int ueb_main(struct ueb_config *cfg);

#endif
