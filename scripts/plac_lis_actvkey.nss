//*************************************************************//
//This scripts spawns an object ("ToSpawn" blueprint resref)
//at the waypoint location with the same tag as the script owner
//and then removes it after an interval ("Return" float). It also
//plays the 'activate' and 'deactivate' animation on the script
//owner.
//
//By LostInSpace
//*************************************************************//

void main()
{
    string sTag=GetTag(OBJECT_SELF);
    string oToSpawn=GetLocalString(OBJECT_SELF, "ToSpawn");
    object oTarget;
    float fReturn=GetLocalFloat(OBJECT_SELF,"Return");
    object oSpawn;
    location lTarget;
    object oPC=GetLastUsedBy();


    if (GetLocalInt(OBJECT_SELF,"Used")==1)
    {return;}

    if (GetLocalInt(OBJECT_SELF,"Used")==0)
    {
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        SetLocalInt(OBJECT_SELF, "Used", 1);
        oTarget=GetWaypointByTag(sTag);
        lTarget=GetLocation(oTarget);
        oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, oToSpawn, lTarget);
        FloatingTextStringOnCreature(GetLocalString(OBJECT_SELF, "Used"), oPC);
        if (fReturn>=1.0)
        {
            DelayCommand(fReturn,PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
            oTarget=GetNearestObjectByTag(oToSpawn);
            DelayCommand(fReturn, DestroyObject(oTarget));
            DelayCommand(fReturn,SetLocalInt(OBJECT_SELF, "Used", 0));
        }
    }
}
