void main()
{
    int iStatFace1=(GetLocalInt(GetObjectByTag("plc_lis_ddcrfqd1"),"solved"));
    int iStatFace2=(GetLocalInt(GetObjectByTag("plc_lis_ddcrfqd2"),"solved"));
    int iStatFace3=(GetLocalInt(GetObjectByTag("plc_lis_ddcrfqd3"),"solved"));
    int iStatFace4=(GetLocalInt(GetObjectByTag("plc_lis_ddcrfqd4"),"solved"));
    object oDoor=GetNearestObjectByTag("door_lis_ddvlqd1");
    object oTarget;
    object oPC=GetLastUsedBy();
    int iChance;
    string sString;

    //if the door is open, no, nothing happens
    if (GetIsOpen(oDoor)==TRUE)
    {FloatingTextStringOnCreature("[As the door is open, nothing seems to happen.]", oPC); return;}

    //Show visual effects for coolness
    FloatingTextStringOnCreature("[The prisms sort of clicks in place, and sink slightly down onto their bases.]", oPC);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SMOKE_PUFF), GetLocation(GetObjectByTag("plc_lis_ddcrfqb1")));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SMOKE_PUFF), GetLocation(GetObjectByTag("plc_lis_ddcrfqb2")));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SMOKE_PUFF), GetLocation(GetObjectByTag("plc_lis_ddcrfqb3")));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SMOKE_PUFF), GetLocation(GetObjectByTag("plc_lis_ddcrfqb4")));


    //add up the solved statues and test if all are solved, if so open the door
    int iSolved=(iStatFace1+iStatFace2+iStatFace3+iStatFace4);
    if (iSolved==4)
    {
        DelayCommand(13.0, ActionOpenDoor(oDoor));
        DelayCommand(10.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_PWSTUN), GetLocation(oDoor)));

        //Close the door after a while
        DelayCommand(600.0,ActionCloseDoor(oDoor));
    }
    //otherwise do some other effect, and have the statues spew gas
    else
    {
        DelayCommand(10.0, FloatingTextStringOnCreature("[The statues give off a horrible howl, and open their mouths with a gurgling sound...]", oPC));
        oTarget = GetObjectByTag("wp_lis_ddvl_qd1f");
        DelayCommand(9.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_LOS_EVIL_10), GetLocation(GetObjectByTag("plc_lis_ddcrf_q1"))));
        DelayCommand(11.5, AssignCommand(GetNearestObjectByTag("plc_lis_ddcrf_q1"), ActionCastSpellAtLocation(SPELL_ACID_FOG, GetLocation(oTarget), METAMAGIC_EMPOWER, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
        oTarget = GetObjectByTag("wp_lis_ddvl_qd12");
        DelayCommand(9.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_LOS_EVIL_10), GetLocation(GetObjectByTag("plc_lis_ddcrf_q2"))));
        DelayCommand(11.5, AssignCommand(GetNearestObjectByTag("plc_lis_ddcrf_q2"), ActionCastSpellAtLocation(SPELL_FIREBALL, GetLocation(oTarget), METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
        oTarget = GetObjectByTag("wp_lis_ddvl_qd13");
        DelayCommand(9.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_LOS_EVIL_10), GetLocation(GetObjectByTag("plc_lis_ddcrf_q3"))));
        DelayCommand(11.5, AssignCommand(GetNearestObjectByTag("plc_lis_ddcrf_q3"), ActionCastSpellAtLocation(SPELL_FIREBALL, GetLocation(oTarget), METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
        oTarget = GetObjectByTag("wp_lis_ddvl_qd14");
        DelayCommand(9.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_LOS_EVIL_10), GetLocation(GetObjectByTag("plc_lis_ddcrf_q4"))));
        DelayCommand(11.5, AssignCommand(GetNearestObjectByTag("plc_lis_ddcrf_q4"), ActionCastSpellAtLocation(SPELL_ACID_FOG, GetLocation(oTarget), METAMAGIC_EMPOWER, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));

    }

    //finally, ALWAYS make the prisms unusable a while, and reset the puzzle randomly

    //randomisation of all four prisms
    oTarget=GetObjectByTag("plc_lis_ddcrfqd1");
    iChance=d4(1);
    if (iChance==1){sString=GetLocalString(oTarget, "symbol1");}
    if (iChance==2){sString=GetLocalString(oTarget, "symbol2");}
    if (iChance==3){sString=GetLocalString(oTarget, "symbol3");}
    if (iChance==4){sString=GetLocalString(oTarget, "symbol4");}
    SetDescription(oTarget, "This stone prism seems to be possible to turn, and on it symbols have been carved. The sides show " + GetLocalString(oTarget, "symbol1") + ", " + GetLocalString(oTarget, "symbol2") + ", " + GetLocalString(oTarget, "symbol3") + ", and " + GetLocalString(oTarget, "symbol4") +". It currently shows " + sString +".");
    SetLocalInt(oTarget,"current",iChance);
    SetLocalInt(oTarget,"solved",0);
    if (sString==GetLocalString(oTarget,"correct"))
    {SetLocalInt(oTarget,"solved",1);}

    oTarget=GetObjectByTag("plc_lis_ddcrfqd2");
    iChance=d4(1);
    if (iChance==1){sString=GetLocalString(oTarget, "symbol1");}
    if (iChance==2){sString=GetLocalString(oTarget, "symbol2");}
    if (iChance==3){sString=GetLocalString(oTarget, "symbol3");}
    if (iChance==4){sString=GetLocalString(oTarget, "symbol4");}
    SetDescription(oTarget, "This stone prism seems to be possible to turn, and on it symbols have been carved. The sides show " + GetLocalString(oTarget, "symbol1") + ", " + GetLocalString(oTarget, "symbol2") + ", " + GetLocalString(oTarget, "symbol3") + ", and " + GetLocalString(oTarget, "symbol4") +". It currently shows " + sString +".");
    SetLocalInt(oTarget,"current",iChance);
    SetLocalInt(oTarget,"solved",0);
    if (sString==GetLocalString(oTarget,"correct"))
    {SetLocalInt(oTarget,"solved",1);}

    oTarget=GetObjectByTag("plc_lis_ddcrfqd3");
    iChance=d4(1);
    if (iChance==1){sString=GetLocalString(oTarget, "symbol1");}
    if (iChance==2){sString=GetLocalString(oTarget, "symbol2");}
    if (iChance==3){sString=GetLocalString(oTarget, "symbol3");}
    if (iChance==4){sString=GetLocalString(oTarget, "symbol4");}
    SetDescription(oTarget, "This stone prism seems to be possible to turn, and on it symbols have been carved. The sides show " + GetLocalString(oTarget, "symbol1") + ", " + GetLocalString(oTarget, "symbol2") + ", " + GetLocalString(oTarget, "symbol3") + ", and " + GetLocalString(oTarget, "symbol4") +". It currently shows " + sString +".");
    SetLocalInt(oTarget,"current",iChance);
    SetLocalInt(oTarget,"solved",0);
    if (sString==GetLocalString(oTarget,"correct"))
    {SetLocalInt(oTarget,"solved",1);}

    oTarget=GetObjectByTag("plc_lis_ddcrfqd4");
    iChance=d4(1);
    if (iChance==1){sString=GetLocalString(oTarget, "symbol1");}
    if (iChance==2){sString=GetLocalString(oTarget, "symbol2");}
    if (iChance==3){sString=GetLocalString(oTarget, "symbol3");}
    if (iChance==4){sString=GetLocalString(oTarget, "symbol4");}
    SetDescription(oTarget, "This stone prism seems to be possible to turn, and on it symbols have been carved. The sides show " + GetLocalString(oTarget, "symbol1") + ", " + GetLocalString(oTarget, "symbol2") + ", " + GetLocalString(oTarget, "symbol3") + ", and " + GetLocalString(oTarget, "symbol4") +". It currently shows " + sString +".");
    SetLocalInt(oTarget,"current",iChance);
    SetLocalInt(oTarget,"solved",0);
    if (sString==GetLocalString(oTarget,"correct"))
    {SetLocalInt(oTarget,"solved",1);}

    //Make unuseable, and then with a delay, useable again
    SetUseableFlag(GetNearestObjectByTag("plc_lis_ddcrfqd1"),FALSE);
    SetUseableFlag(GetNearestObjectByTag("plc_lis_ddcrfqd2"),FALSE);
    SetUseableFlag(GetNearestObjectByTag("plc_lis_ddcrfqd3"),FALSE);
    SetUseableFlag(GetNearestObjectByTag("plc_lis_ddcrfqd4"),FALSE);
    DelayCommand(60.0, SetUseableFlag(GetNearestObjectByTag("plc_lis_ddcrfqd1"),TRUE));
    DelayCommand(60.0, SetUseableFlag(GetNearestObjectByTag("plc_lis_ddcrfqd2"),TRUE));
    DelayCommand(60.0, SetUseableFlag(GetNearestObjectByTag("plc_lis_ddcrfqd3"),TRUE));
    DelayCommand(60.0, SetUseableFlag(GetNearestObjectByTag("plc_lis_ddcrfqd4"),TRUE));

}
