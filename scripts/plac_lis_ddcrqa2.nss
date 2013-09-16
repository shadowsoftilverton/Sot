//*************************************************************//
//This scripts is used for the Quill in the Demesne of the Damned
//statue puzzle in the Crypts. It checks the statues' alignments
//and then either opens doors or does failure stuff.
//
//By LostInSpace
//*************************************************************//
#include "nw_i0_2q4luskan"
void main()
{
    //Define Variables
    object oObject=OBJECT_SELF;
    object oPC=GetLastUsedBy();
    int iSolved=0;
    int iSolvedFacing;

    if (GetLocalInt(OBJECT_SELF,"attempts")==5)
    {
        FloatingTextStringOnCreature("[The pen refuses to budge, as if it was simply part of the quill.]", oPC);
        return;
    }
    //check the "solved" status of all statues
    int iStatFace1=(GetLocalInt(GetObjectByTag("plac_lis_ddcrst1"),"CFACING"));
    int iStatFace2=(GetLocalInt(GetObjectByTag("plac_lis_ddcrst2"),"CFACING"));
    int iStatFace3=(GetLocalInt(GetObjectByTag("plac_lis_ddcrst3"),"CFACING"));
    int iStatFace4=(GetLocalInt(GetObjectByTag("plac_lis_ddcrst4"),"CFACING"));
    int iStatFace5=(GetLocalInt(GetObjectByTag("plac_lis_ddcrst5"),"CFACING"));
    int iStatFace6=(GetLocalInt(GetObjectByTag("plac_lis_ddcrst6"),"CFACING"));
    int iStatFace7=(GetLocalInt(GetObjectByTag("plac_lis_ddcrst7"),"CFACING"));

    //add up the solved statues and test if all are solved, if so do the thing
    iSolvedFacing=(iStatFace1+iStatFace2+iStatFace3+iStatFace4+iStatFace5+iStatFace6+iStatFace7);

    //Introduce the event
    FloatingTextStringOnCreature("[As you touch the pen, it begins to float in the air, as if looking around, before it moves to write in the book...]", oPC);

    //Do Solve or Fail Event
    if (iSolvedFacing==7)
    {
        SetDescription(GetNearestObjectByTag("plc_lis_ddcrqd2t"), "");
        DelayCommand(10.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_PWSTUN), GetLocation(GetObjectByTag("wp_lis_effectwp2"))));
        DelayCommand(13.0, FloatingTextStringOnCreature("[...after a long pause, perhaps even hesitation, the pen begins to write in the book, completing both pages in a full story, as the statues sort of click in place.]", oPC));
        DelayCommand(13.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SMOKE_PUFF), GetLocation(GetObjectByTag("plac_lis_ddcrst1"))));
        DelayCommand(13.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SMOKE_PUFF), GetLocation(GetObjectByTag("plac_lis_ddcrst2"))));
        DelayCommand(13.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SMOKE_PUFF), GetLocation(GetObjectByTag("plac_lis_ddcrst3"))));
        DelayCommand(13.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SMOKE_PUFF), GetLocation(GetObjectByTag("plac_lis_ddcrst4"))));
        DelayCommand(13.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SMOKE_PUFF), GetLocation(GetObjectByTag("plac_lis_ddcrst5"))));
        DelayCommand(13.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SMOKE_PUFF), GetLocation(GetObjectByTag("plac_lis_ddcrst6"))));
        DelayCommand(13.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SMOKE_PUFF), GetLocation(GetObjectByTag("plac_lis_ddcrst7"))));

        DelayCommand(17.0,PlaySound("as_dr_stonvlgop1"));
        DelayCommand(19.0,PlaySound("as_dr_x2tib1op"));
        object oDoor=GetNearestObjectByTag("door_lis_ddcr2q1");
        object oDoor2=GetNearestObjectByTag("door_lis_ddcr2q2");
        object oDoor3=GetNearestObjectByTag("door_lis_ddcr2q3");
        object oDoor4=GetNearestObjectByTag("door_lis_ddcr2q4");
        DelayCommand(19.0, ActionOpenDoor(oDoor));
        DelayCommand(19.0, ActionOpenDoor(oDoor2));
        DelayCommand(19.0, ActionOpenDoor(oDoor3));
        DelayCommand(19.0, ActionOpenDoor(oDoor4));

        //Show visual effects for coolness
        effect eEffect1=EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
        object oEffectWP1=GetNearestObject(OBJECT_TYPE_WAYPOINT);
        DelayCommand(15.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect1, GetLocation(oEffectWP1)));

        //Spawn the Guardian (the guardian has the key to the next door, must happen!)
        //It is spawned here to avoid cheating past the puzzle
        DelayCommand(18.0, CreateObjectVoid(OBJECT_TYPE_CREATURE, "lis_const_ddgrdn", GetLocation(GetObjectByTag("wp_lis_ddqd2sgrd"))));

        //Make Statues Unuseable (prevent repeat spawns of guardian, etc
        SetUseableFlag(GetObjectByTag("plac_lis_ddcrst1"), FALSE);
        SetUseableFlag(GetObjectByTag("plac_lis_ddcrst2"), FALSE);
        SetUseableFlag(GetObjectByTag("plac_lis_ddcrst3"), FALSE);
        SetUseableFlag(GetObjectByTag("plac_lis_ddcrst4"), FALSE);
        SetUseableFlag(GetObjectByTag("plac_lis_ddcrst5"), FALSE);
        SetUseableFlag(GetObjectByTag("plac_lis_ddcrst6"), FALSE);
        SetUseableFlag(GetObjectByTag("plac_lis_ddcrst7"), FALSE);

        //Reset the puzzle (close doors and make the reset trigger active...)
        DelayCommand(1800.0,ActionCloseDoor(oDoor));
        DelayCommand(1800.0,ActionCloseDoor(oDoor2));
        DelayCommand(1800.0,ActionCloseDoor(oDoor3));
        DelayCommand(1500.0,SetLocalInt(GetObjectByTag("trig_lis_ddcrq2r"),"randomized",0));
    }
    else
    {
        DelayCommand(13.0, FloatingTextStringOnCreature("[...after a long pause, perhaps even hesitation, the pen scribbles a single line all over the pages: ''no entry for the false.'']", oPC));
        DelayCommand(13.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_LOS_EVIL_10), GetLocation(GetObjectByTag("plac_lis_ddcrst1"))));
        DelayCommand(13.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_LOS_EVIL_10), GetLocation(GetObjectByTag("plac_lis_ddcrst2"))));
        DelayCommand(13.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_LOS_EVIL_10), GetLocation(GetObjectByTag("plac_lis_ddcrst3"))));
        DelayCommand(13.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_LOS_EVIL_10), GetLocation(GetObjectByTag("plac_lis_ddcrst4"))));
        DelayCommand(13.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_LOS_EVIL_10), GetLocation(GetObjectByTag("plac_lis_ddcrst5"))));
        DelayCommand(13.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_LOS_EVIL_10), GetLocation(GetObjectByTag("plac_lis_ddcrst6"))));
        DelayCommand(13.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_LOS_EVIL_10), GetLocation(GetObjectByTag("plac_lis_ddcrst7"))));
        DelayCommand(13.5, AssignCommand(GetObjectByTag("plc_lis_ddcr2esc"), ActionCastSpellAtLocation(SPELL_WAIL_OF_THE_BANSHEE, GetLocation(OBJECT_SELF), METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
        iSolved=GetLocalInt(OBJECT_SELF,"attempts");
        iSolved=iSolved+1;
        SetLocalInt(OBJECT_SELF,"attempts",iSolved);
        if (iSolved>=2)
        {
            DelayCommand(16.0, AssignCommand(GetObjectByTag("plc_lis_ddcr2esc"), ActionCastSpellAtLocation(SPELL_MORDENKAINENS_DISJUNCTION, GetLocation(GetObjectByTag("wp_lis_effectwp3")), METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
            DelayCommand(16.0, AssignCommand(GetObjectByTag("plc_lis_ddcr2esc"), ActionCastSpellAtLocation(SPELL_MORDENKAINENS_DISJUNCTION, GetLocation(GetObjectByTag("wp_lis_effectwp4")), METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
            DelayCommand(16.0, AssignCommand(GetObjectByTag("plc_lis_ddcr2esc"), ActionCastSpellAtLocation(SPELL_MORDENKAINENS_DISJUNCTION, GetLocation(GetObjectByTag("wp_lis_effectwp5")), METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
            DelayCommand(16.0, AssignCommand(GetObjectByTag("plc_lis_ddcr2esc"), ActionCastSpellAtLocation(SPELL_MORDENKAINENS_DISJUNCTION, GetLocation(GetObjectByTag("wp_lis_effectwp6")), METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
            DelayCommand(18.0, AssignCommand(GetObjectByTag("plc_lis_ddcr2esc"), ActionCastSpellAtLocation(SPELL_STORM_OF_VENGEANCE, GetLocation(GetObjectByTag("wp_lis_effectwpc")), METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
        }
        if (iSolved>=3)
        {
            DelayCommand(22.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD), GetLocation(GetObjectByTag("wp_lis_effectwp4"))));
            DelayCommand(21.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), GetLocation(GetObjectByTag("wp_lis_effectwp5"))));

            DelayCommand(23.0, CreateObjectVoid(OBJECT_TYPE_CREATURE, "lis_skel_ddskelw", GetLocation(GetObjectByTag("wp_lis_effectwp4"))));
            DelayCommand(22.0, CreateObjectVoid(OBJECT_TYPE_CREATURE, "lis_skel_ddskelw", GetLocation(GetObjectByTag("wp_lis_effectwp5"))));
        }
        if (iSolved>=4)
        {
            DelayCommand(27.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), GetLocation(GetObjectByTag("wp_lis_effectwp3"))));
            DelayCommand(30.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), GetLocation(GetObjectByTag("wp_lis_effectwp6"))));

            DelayCommand(28.0, CreateObjectVoid(OBJECT_TYPE_CREATURE, "lis_skel_ddskela", GetLocation(GetObjectByTag("wp_lis_effectwp3"))));
            DelayCommand(31.0, CreateObjectVoid(OBJECT_TYPE_CREATURE, "lis_skel_ddskela", GetLocation(GetObjectByTag("wp_lis_effectwp6"))));
        }
        if (iSolved>=5)
        {
            DelayCommand(51.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), GetLocation(GetObjectByTag("wp_lis_effectwp5"))));
            DelayCommand(52.0, CreateObjectVoid(OBJECT_TYPE_CREATURE, "lis_und_ddwwiz", GetLocation(GetObjectByTag("wp_lis_effectwp"))));
            DelayCommand(600.0, SetLocalInt(OBJECT_SELF,"attempts",0));
        }
    }
}
