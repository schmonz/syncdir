extern int (*real_open)();
extern int (*real_close)();
extern int (*real_link)();
extern int (*real_unlink)();
extern int (*real_rename)();
extern int (*real_fsync)();

#define SYS_OPEN(FILE,FLAG,MODE) real_open(FILE, FLAG, MODE)
#define SYS_CLOSE(FD) real_close(FD)
#define SYS_LINK(OLD,NEW) real_link(OLD, NEW)
#define SYS_UNLINK(PATH) real_unlink(PATH)
#define SYS_RENAME(OLD,NEW) real_rename(OLD, NEW)
#define SYS_FSYNC(FD) real_fsync(FD)

void load_dlsym_syscalls(void);
#define load_real_syscalls(x) load_dlsym_syscalls(x)
