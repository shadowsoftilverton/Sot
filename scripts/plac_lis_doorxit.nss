//A script to use for the inside of quest doors, so people always can get out.
//It opens the nearest door and leaves it open for 10 minutes.
//By: LostInSpace

void main()
{

    object oPC = GetLastUsedBy();
    object oTarget;
    oTarget = GetNearestObject(OBJECT_TYPE_DOOR);

    //If it's not a PC entering, or the door is already open, abort the script
    if (!GetIsPC(oPC)) return;
    if (GetIsOpen(oTarget)) return;

    //Open the door, and then close and lock it after 60 seconds
    AssignCommand(oTarget, ActionOpenDoor(oTarget));
    PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    SetUseableFlag(OBJECT_SELF,FALSE);
    DelayCommand(60.0, AssignCommand(oTarget, ActionCloseDoor(oTarget)));
    DelayCommand(60.0, SetLocked(oTarget, TRUE));
    DelayCommand(60.0, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    DelayCommand(60.0, SetUseableFlag(OBJECT_SELF,TRUE));

}

