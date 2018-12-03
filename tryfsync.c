#include <sys/syscall.h>
#include <unistd.h>

int main(void) {
  return syscall(SYS_fsync, 1);
}
