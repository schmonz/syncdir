#include <sys/syscall.h>

#define SYS_OPEN(FILE,FLAG,MODE) syscall(SYS_open, FILE, FLAG, MODE)
#define SYS_CLOSE(FD) syscall(SYS_close, FD)
#define SYS_LINK(OLD,NEW) syscall(SYS_link, OLD, NEW)
#define SYS_UNLINK(PATH) syscall(SYS_unlink, PATH)
#define SYS_RENAME(OLD,NEW) syscall(SYS_rename, OLD, NEW)
#define SYS_FSYNC(FD) syscall(SYS_fsync, FD)
