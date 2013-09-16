void main()
{
    string sTag=GetTag(OBJECT_SELF);
    string oToSpawn=GetLocalString(OBJECT_SELF, "ToSpawn");
    object oTarget;
    float fReturn=GetLocalFloat(OBJECT_SELF,"Return");
    float fFacing=GetFacing(OBJECT_SELF);
    float fTurn=GetLocalFloat(OBJECT_SELF,"TurnAngle");
    object oSpawn;
    location lTarget;
    object oPC=GetLastUsedBy();
    SetLocalFloat(OBJECT_SELF, "Facing",fFacing);


    if (GetLocalInt(OBJECT_SELF,"Used")==1)
    {return;}

    if (GetLocalInt(OBJECT_SELF,"Used")==0)
    {
        fFacing=fFacing+fTurn;
        SetFacing(fFacing);
        SetLocalInt(OBJECT_SELF, "Used", 1);
        oTarget=GetWaypointByTag(sTag);
        lTarget=GetLocation(oTarget);
        oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, oToSpawn, lTarget);
        FloatingTextStringOnCreature(GetLocalString(OBJECT_SELF, "Used"), oPC);
        if (fReturn>=1.0)
        {
            fFacing=GetLocalFloat(OBJECT_SELF, "Facing");
            DelayCommand(fReturn,SetFacing(fFacing));
            oTarget=GetNearestObjectByTag(oToSpawn);
            DelayCommand(fReturn, DestroyObject(oTarget));
            DelayCommand(fReturn,SetLocalInt(OBJECT_SELF, "Used", 0));
        }
    }
}
