void main()
{
    //Define Variables
    object oObject=OBJECT_SELF;
    object oPC=GetLastUsedBy();
    int iActive=GetLocalInt(OBJECT_SELF,"active");
    int iSolved;
    object oDoor=GetNearestObjectByTag("door_lis_ddcr3q1");

    //if the door is open and you mess with the candles, close it!
    if (GetIsOpen(oDoor)==TRUE)
    {
        AssignCommand(oDoor, ActionCloseDoor(OBJECT_SELF));
        SetLocked(oDoor, TRUE);
        DelayCommand(1.0,PlaySound("as_dr_stonvlgop1"));
        DelayCommand(6.0,PlaySound("as_dr_x2ttu8cl"));
        FloatingTextStringOnCreature("[There is a scraping sound of chains moving in stone, followed by a distant metal creak and slam echoing through the dungeon.]", oPC);
    }

    //If unlit, light the Candle
    if (GetLocalInt(OBJECT_SELF, "active")!=1)
    {
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        SetLocalInt(OBJECT_SELF,"active", 1);
        RecomputeStaticLighting(GetArea(OBJECT_SELF));
    }
    else
    {
        PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
        SetLocalInt(OBJECT_SELF,"active", 0);
        RecomputeStaticLighting(GetArea(OBJECT_SELF));
    }

    //check if all are lit
    iSolved=(GetLocalInt(GetObjectByTag("plac_lis_ddcr3c1"),"active")+GetLocalInt(GetObjectByTag("plac_lis_ddcr3c2"),"active")+GetLocalInt(GetObjectByTag("plac_lis_ddcr3c3"),"active")+GetLocalInt(GetObjectByTag("plac_lis_ddcr3c4"),"active")+GetLocalInt(GetObjectByTag("plac_lis_ddcr3c5"),"active"));
    if (iSolved==5)
    {
        if (GetLocalInt(GetObjectByTag("plac_lis_ddcr3c6"),"active")==1) return;
        FloatingTextStringOnCreature("[There is a scraping sound of chains moving in stone, followed by a distant metal creak echoing through the dungeon.]", oPC);
        DelayCommand(1.0,PlaySound("as_dr_stonvlgop1"));
        DelayCommand(6.0,PlaySound("as_dr_x2ttu8op"));

        ActionOpenDoor(oDoor);
        //Show visual effects for coolness
        effect eEffect1=EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
        object oEffectWP1=GetNearestObject(OBJECT_TYPE_WAYPOINT);
        DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect1, GetLocation(oEffectWP1)));
        DelayCommand(1200.0,ActionCloseDoor(oDoor));
        //Reset the Candles
        DelayCommand(12.0, AssignCommand (GetObjectByTag("plac_lis_ddcr3c1"),PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE)));
        DelayCommand(12.0, SetLocalInt(GetObjectByTag("plac_lis_ddcr3c1"),"active", 0));
        DelayCommand(12.0, AssignCommand (GetObjectByTag("plac_lis_ddcr3c2"),PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE)));
        DelayCommand(12.0, SetLocalInt(GetObjectByTag("plac_lis_ddcr3c2"),"active", 0));
        DelayCommand(12.0, AssignCommand (GetObjectByTag("plac_lis_ddcr3c3"),PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE)));
        DelayCommand(12.0, SetLocalInt(GetObjectByTag("plac_lis_ddcr3c3"),"active", 0));
        DelayCommand(12.0, AssignCommand (GetObjectByTag("plac_lis_ddcr3c4"),PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE)));
        DelayCommand(12.0, SetLocalInt(GetObjectByTag("plac_lis_ddcr3c4"),"active", 0));
        DelayCommand(12.0, AssignCommand (GetObjectByTag("plac_lis_ddcr3c5"),PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE)));
        DelayCommand(12.0, SetLocalInt(GetObjectByTag("plac_lis_ddcr3c5"),"active", 0));
        DelayCommand(12.0, AssignCommand (GetObjectByTag("plac_lis_ddcr3c6"),PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE)));
        DelayCommand(12.0, SetLocalInt(GetObjectByTag("plac_lis_ddcr3c6"),"active", 0));


    }
}
