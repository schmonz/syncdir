#include <dlfcn.h>
#include <stdio.h>
#include <stdlib.h>

static int checked_noisy = 0;
static int be_noisy = 0;

int (*real_open)();
int (*real_close)();
int (*real_link)();
int (*real_unlink)();
int (*real_rename)();
int (*real_fsync)();

static void log_failure(const char *which)
{
  if (be_noisy) fprintf(stderr, "syncdir: can't load system %s()\n", which);
}

void load_real_syscalls()
{
  if (!checked_noisy && getenv("SYNCDIRDEBUG"))
    be_noisy = 1;

  if (!real_open && !(real_open = dlsym(RTLD_NEXT, "open")))
    log_failure("open");
  if (!real_close && !(real_close = dlsym(RTLD_NEXT, "close")))
    log_failure("close");
  if (!real_link && !(real_link = dlsym(RTLD_NEXT, "link")))
    log_failure("link");
  if (!real_unlink && !(real_unlink = dlsym(RTLD_NEXT, "unlink")))
    log_failure("unlink");
  if (!real_rename && !(real_rename = dlsym(RTLD_NEXT, "rename")))
    log_failure("rename");
  if (!real_fsync && !(real_fsync = dlsym(RTLD_NEXT, "fsync")))
    log_failure("fsync");
}
