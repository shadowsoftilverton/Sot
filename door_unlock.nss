#include "engine"

void main()
{
    // Declare variables.
    object oDoor = OBJECT_SELF;

    // Fetch local variables.
    int iLockDelay = GetLocalInt(oDoor, "timer_lock");

    if(iLockDelay > 0){
        DelayCommand(IntToFloat(iLockDelay), ActionLockObject(oDoor));
    }
}
