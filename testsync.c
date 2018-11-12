#include <unistd.h>
#include <fcntl.h>
#include <string.h>

void msg(const char* m)
{
  write(1, m, strlen(m));
}

int main(int argc, char* argv[])
{
  int fd;
  char* file1 = argv[1];
  char* file2 = argv[2];
  if(argc < 3) {
    msg("usage: testsync file1 file2\n");
    return 1;
  }
  fd = open(file1, O_WRONLY|O_CREAT|O_EXCL, 0666);
  close(fd);
  link(file1, file2);
  unlink(file1);
  rename(file2, file1);
  return 0;
}
