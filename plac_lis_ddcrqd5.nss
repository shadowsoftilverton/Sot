void main()
{
    object oChest=GetObjectByTag("plc_lis_ddscralt");
    object oChest2=GetObjectByTag("plc_lis_ddpotalt");
    object oDoor;
    object oTarget;
    object oObject;
    object oPC=GetLastUsedBy();

//If already open piss off
    oDoor=GetNearestObjectByTag("door_lis_ddcr3q2");
    if (GetIsOpen(oDoor)==TRUE)
    {return;}

 //Check if nanna has a scroll
    if (GetTag(OBJECT_SELF)==GetTag(oChest))
    {
        SetLocalInt(oChest, "solved", 0);
        oObject = GetFirstItemInInventory(oChest);

        while (oObject!=OBJECT_INVALID)
        {
            if (GetBaseItemType(oObject)==BASE_ITEM_SCROLL)
            {
                if (GetLocalInt(oChest, "solved")!=1)
                {
                    SetLocalString(oChest, "item", GetTag(oObject));
                    SetLocalInt(OBJECT_SELF,"book",0);
                }
                SetLocalInt(oChest, "solved",1);
            }
            if (GetBaseItemType(oObject)==BASE_ITEM_SPELLSCROLL)
            {
                if (GetLocalInt(oChest, "solved")!=1)
                {
                    SetLocalString(oChest, "item", GetTag(oObject));
                    SetLocalInt(OBJECT_SELF,"book",0);
                }
                SetLocalInt(oChest, "solved",1);
            }
            if (GetBaseItemType(oObject)==BASE_ITEM_ENCHANTED_SCROLL)
            {
                if (GetLocalInt(oChest, "solved")!=1)
                {
                    SetLocalString(oChest, "item", GetTag(oObject));
                    SetLocalInt(OBJECT_SELF,"book",0);
                }
                SetLocalInt(oChest, "solved",1);
            }
            if (GetBaseItemType(oObject)==BASE_ITEM_BOOK)
            {
                if (GetLocalInt(oChest, "solved")!=1)
                {
                    SetLocalString(oChest, "item", GetTag(oObject));
                    SetLocalInt(OBJECT_SELF,"book",1);
                }
                SetLocalInt(oChest, "solved",1);
            }
            oObject=GetNextItemInInventory(oChest);
        }
    }
//Check if papa has a potion
    if (GetTag(OBJECT_SELF)==GetTag(oChest2))
    {
        SetLocalInt(oChest2, "solved", 0);
        oObject = GetFirstItemInInventory(oChest2);

        while (oObject!=OBJECT_INVALID)
        {
            if (GetBaseItemType(oObject)==BASE_ITEM_POTIONS)
            {
                if (GetLocalInt(oChest2, "solved")!=1)
                    {SetLocalString(oChest2, "item", GetTag(oObject));}
                SetLocalInt(oChest2, "solved",1);
            }
            if (GetBaseItemType(oObject)==BASE_ITEM_ENCHANTED_POTION)
            {
                if (GetLocalInt(oChest2, "solved")!=1)
                    {SetLocalString(oChest2, "item", GetTag(oObject));}
                SetLocalInt(oChest2, "solved",1);
            }
            oObject=GetNextItemInInventory(oChest2);
        }
    }
//if this is the scroll altar and it got solved... do that "solved message".
    if (GetTag(OBJECT_SELF)==GetTag(oChest))
    {
        if (GetLocalInt(oChest, "solved")==1)
        {
            oTarget=GetItemPossessedBy(oChest, GetLocalString(oChest, "item"));
            DestroyObject(oTarget);
            if(GetLocalInt(oChest,"book")!=1)
                {FloatingTextStringOnCreature("[The scroll unfolds and the magical chant on it disappears as if read, before the scroll itself crumbles.]", oPC, FALSE);}
            else
                {FloatingTextStringOnCreature("[The book opens and pages are flipped through rapidly, the text on the pages disappearing as they turn, before the book crumbles into dust.]", oPC, FALSE);}
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SMOKE_PUFF), GetLocation(oChest));
        DelayCommand(6.0, FloatingTextStringOnCreature("[...and then it grows forth out of the dust in one of the book cases...]", oPC));
        oTarget=GetObjectByTag("wp_lis_ddcr3_bt"+IntToString(d6(1)));
        DelayCommand(6.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SMOKE_PUFF), GetLocation(oTarget)));
        }
        else
        {FloatingTextStringOnCreature("[It almost feels as if the statues by the altar lets out a small sigh...]", oPC, FALSE);}
    }

//if this is the potion altar and it got solved... do that "solved message".
    if (GetTag(OBJECT_SELF)==GetTag(oChest2))
    {
        if (GetLocalInt(oChest2, "solved")==1)
        {
            oTarget=GetItemPossessedBy(oChest2, GetLocalString(oChest2, "item"));
            DestroyObject(oTarget);
            FloatingTextStringOnCreature("[The potion bottle stirs slightly, before the potion disappear in a glimmer as if poured or drunk. Then the vial dissipates into fine dust.]", oPC, FALSE);
            oTarget=GetObjectByTag("plac_lis_ddcr3st");
            DelayCommand(6.0, FloatingTextStringOnCreature("[...and then the tube in the back of the room seems to come alive...]", oPC));
            DelayCommand(6.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_LOS_HOLY_10), GetLocation(oTarget)));
            DelayCommand(6.5, AssignCommand(oTarget, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE)));
        }
        else
        {
            FloatingTextStringOnCreature("[It almost feels as if the statues by the altar lets out a small sigh...]", oPC, FALSE);
            oTarget=GetObjectByTag("plac_lis_ddcr3st");
            AssignCommand(oTarget, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
        }
    }




//Unless both are solved, exit script
    if (GetLocalInt(oChest, "solved")+GetLocalInt(oChest2, "solved")!=2)
    {return;}

//do the "solved" thing
//Open the door, and lock it after a short delay. Some extra delay for suspension, and a little VFX


    DelayCommand(15.0, FloatingTextStringOnCreature("[And then, after a brief while, you hear a distant rumbling.]", oPC,FALSE));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SMOKE_PUFF), GetLocation(oChest));


    DelayCommand(15.0,PlaySound("as_dr_stonvlgop1"));
    DelayCommand(17.0,PlaySound("as_dr_x2tib1op"));
    DelayCommand(17.0, ActionOpenDoor(oDoor));
    DelayCommand(1200.0, ActionCloseDoor(oDoor));
    DelayCommand(1201.0, SetLocked(oDoor, TRUE));
    DelayCommand(15.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_PWSTUN), GetLocation(oDoor)));
    oTarget=GetObjectByTag("plac_lis_ddcr3st");
    DelayCommand(600.0, AssignCommand(oTarget, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE)));
    DelayCommand(600.0, SetLocalInt(oChest, "solved",0));
    DelayCommand(600.0, SetLocalInt(oChest2, "solved", 0));
}
