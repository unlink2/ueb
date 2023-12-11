#include "ueb.h"

int ueb_tick(struct ueb *ueb) {
  ueb->tickc++;

  return 0;
}

int ueb_main(struct ueb_config *cfg) { return 0; }
