//Written by Ave (2012/04/13)
#include "engine"
void main()
{
     object oLever=OBJECT_SELF;
     AssignCommand(oLever, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
     SetLocalInt(oLever,"ave_d_openloop",0);
     object oExitDoor=GetObjectByTag("ave_d_exit");
     object oDeeperDoor=GetObjectByTag("ave_d_confirmdoor");
     object oExitDoor2=GetObjectByTag("ave_d_enter");
     SetLocked(oExitDoor,FALSE);
     AssignCommand(oExitDoor, ActionOpenDoor(oExitDoor));
     SetLocked(oExitDoor2,FALSE);
     AssignCommand(oExitDoor2, ActionOpenDoor(oExitDoor2));
     AssignCommand(oDeeperDoor, ActionCloseDoor(oDeeperDoor));
     SetLocked(oDeeperDoor,TRUE);
}
