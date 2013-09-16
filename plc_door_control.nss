#include "engine"

void main()
{
    // Get self.
    object oLever = OBJECT_SELF;

    // Fetch the door tag.
    string sDoorTag = GetLocalString(oLever, "door_tag");

    // Fetch the door itself.
    object oDoor = GetObjectByTag(sDoorTag);

    // If the door doesn't exist, abandon the attempt.
    if(oDoor == OBJECT_INVALID){
        return;
    }

    // Fetch local variables.
    int iOpen = GetLocalInt(oLever, "open");
    int iClose = GetLocalInt(oLever, "close");
    int iUnlock = GetLocalInt(oLever, "unlock");
    int iLock = GetLocalInt(oLever, "lock");


    // Handle locking/unlocking first.
    if(GetLocked(oDoor) && iUnlock){
        SetLocked(oDoor, FALSE);
    } else if(iLock){
        ActionCloseDoor(oDoor);
        SetLocked(oDoor, TRUE);
        return;
    }

    // Then handle opening/closing.
    if(GetIsOpen(oDoor) && iClose){
        ActionCloseDoor(oDoor);
    } else if (iOpen){
        ActionOpenDoor(oDoor);
    }
}
