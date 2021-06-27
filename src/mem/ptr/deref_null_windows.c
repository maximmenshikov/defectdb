#include <stdio.h>
#include <Windows.h>
#include <exception>

int main()
{
    __try
    {
        // harmful actions
    }
    __except(EXCEPTION_EXECUTE_HANDLER)
    {
        // do actions on exception
    }
    return 0;
}