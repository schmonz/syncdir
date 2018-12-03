#include <dlfcn.h>

int main(void) {
  if (dlsym(RTLD_NEXT, "foo")) return 1;
  return 0;
}
