#include <sys/syscall.h>
#include <unistd.h>

int main(void) {
  syscall(5);
  return 0;
}
