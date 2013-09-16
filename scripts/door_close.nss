#include "engine"

void main()
{
    // Declare variables.
    object oDoor = OBJECT_SELF;

    // Grab local variables.
    int iLock = GetLocalInt(oDoor, "lock");

    // If specified to lock on closing, do so.
    if(iLock){
        ActionLockObject(oDoor);
    }
}
