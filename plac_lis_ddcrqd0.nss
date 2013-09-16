//This script opens the first "quest door" in the crypts under the demesne of the damned
//By: LostInSpace

void main()
{
    //define variables
    object oPC = GetLastUsedBy();
    object oTarget = GetNearestObjectByTag("door_ddcr1qd0");;

    //If not activated, activate, otherwise, deactivate
    if (GetLocalInt(OBJECT_SELF, "active")!=1)
    {
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        SetLocalInt(OBJECT_SELF,"active", 1);
    }
    else
    {
        PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
        SetLocalInt(OBJECT_SELF,"active", 0);
    }

    //if the door was open and someone fiddled, close it, and quit
    if (GetIsOpen(oTarget)==TRUE)
    {
        FloatingTextStringOnCreature("[As you pull the lever, you hear the sound of some chain mechanism inside the stone walls followed by the recognisable sound of a distant door slamming shut.]", oPC, TALKVOLUME_TALK);
        DelayCommand(1.0, PlaySound("as_dr_x2tid1cl"));
        DelayCommand(1.5, AssignCommand(oTarget, ActionCloseDoor(oTarget)));
        return;
    }

    //check if both are active, and if not, close the door if it is open!
    if (GetLocalInt(GetObjectByTag("plac_lis_ddcr1p1"), "active")==1 && GetLocalInt(GetObjectByTag("plac_lis_ddcr1p2"), "active")==1)
    {
        //play sounds and open door, and show messages
        DelayCommand(2.5, PlaySound("as_dr_x2tid1op"));
        DelayCommand(4.0, PlaySound("as_dr_woodvlgcl2"));
        DelayCommand(4.5, AssignCommand(oTarget, ActionOpenDoor(oTarget)));
        DelayCommand(0.5, FloatingTextStringOnCreature("[As you pull the lever, it snaps in place and you hear the sound of some chain mechanism inside the stone walls, followed by the sound of a door opening echoes through the halls.]", oPC, TALKVOLUME_TALK));

        //make levers unusable a little while
        SetUseableFlag(GetObjectByTag("plac_lis_ddcr1p1"), FALSE);
        SetUseableFlag(GetObjectByTag("plac_lis_ddcr1p2"), FALSE);

        //reset levers and close the door
        DelayCommand(120.0, SetUseableFlag(GetObjectByTag("plac_lis_ddcr1p1"), TRUE));
        DelayCommand(120.0, SetUseableFlag(GetObjectByTag("plac_lis_ddcr1p2"), TRUE));
        DelayCommand(120.0, SetLocalInt(GetObjectByTag("plac_lis_ddcr1p1"), "active",0));
        DelayCommand(120.0, SetLocalInt(GetObjectByTag("plac_lis_ddcr1p2"), "active",0));
        DelayCommand(120.0, AssignCommand(GetObjectByTag("plac_lis_ddcr1p1"), PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE)));
        DelayCommand(120.0, AssignCommand(GetObjectByTag("plac_lis_ddcr1p2"), PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE)));
        DelayCommand(1200.0, AssignCommand(oTarget, ActionCloseDoor(oTarget)));
        DelayCommand(1200.1, SetLocked(oTarget, TRUE));
     }
}

