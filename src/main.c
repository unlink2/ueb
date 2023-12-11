#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ueb.h"
#include <unistd.h>

#define UEB_NAME "ueb"
#define UEB_VER "0.0.1"

void ueb_help(void) {
  printf("%s\n", UEB_NAME);
  printf("Usage %s [-h] [-V] [-v]\n\n", UEB_NAME);
  printf("\t-h\tdisplay this help and exit\n");
  printf("\t-V\tdisplay version info and exit\n");
  printf("\t-v\tverbose output\n");
}

void ueb_version(void) { printf("%s version %s\n", UEB_NAME, UEB_VER); }

void ueb_getopt(int argc, char **argv, struct ueb_config *cfg) {
  int c = 0;
  while ((c = getopt(argc, argv, "hvV")) != -1) {
    switch (c) {
    case 'h':
      ueb_help();
      exit(0);
      break;
    case 'V':
      ueb_version();
      exit(0);
      break;
    case 'v':
      cfg->verbose = true;
      break;
    case '?':
      break;
    default:
      printf("%s: invalid option '%c'\nTry '%s -h' for more information.\n",
             UEB_NAME, c, UEB_NAME);
      exit(-1);
      break;
    }
  }

  cfg->argc = argc - optind;
  cfg->argv = argv + optind;
}

int main(int argc, char **argv) {
  // map args to cfg here
  struct ueb_config cfg;
  memset(&cfg, 0, sizeof(cfg));

  ueb_getopt(argc, argv, &cfg);

  int res = ueb_main(&cfg);

  return res;
}
