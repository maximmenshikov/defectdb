#include <signal.h>
#include <string.h>

void
segv_handler(int sig)
{
    // do actions on segv
}

int main()
{
    signal(SIGSEGV, segv_handler);
    return 0;
}