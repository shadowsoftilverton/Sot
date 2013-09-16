//::///////////////////////////////////////////////////////
//:: Will show an effect (DeathEffect as defined below)
//:: and a line of text (DeathText as defined below) when
//:: a creature dies.
//::
//:: LostInSpace
//:://////////////////////////////////////////////

void main()
{
    ExecuteScript("x2_def_ondeath", OBJECT_SELF);

    //Show the effect defined
    effect eEffect;
    if (GetLocalString(OBJECT_SELF, "DeathEffect")!="")
    {
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="DISPEL") eEffect=EffectVisualEffect(VFX_FNF_DISPEL);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="DISJUNCTION") eEffect=EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="EEXPLOTION") eEffect=EffectVisualEffect(VFX_FNF_ELECTRIC_EXPLOSION);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="FIREBALL") eEffect=EffectVisualEffect(VFX_FNF_FIREBALL);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="AGEXPLOTION") eEffect=EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_ACID);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="EGEXPLOTION") eEffect=EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_EVIL);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="FGEXPLOTION") eEffect=EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_FIRE);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="GGEXPLOTION") eEffect=EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_GREASE);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="MGEXPLOTION") eEffect=EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_MIND);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="NGEXPLOTION") eEffect=EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_NATURE);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="GRUIN") eEffect=EffectVisualEffect(VFX_FNF_GREATER_RUIN);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="MHOWL") eEffect=EffectVisualEffect(VFX_FNF_HOWL_MIND);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="OHOWL") eEffect=EffectVisualEffect(VFX_FNF_HOWL_ODD);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="WCRYFEM") eEffect=EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY_FEMALE);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="WCRY") eEffect=EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="LOSE1") eEffect=EffectVisualEffect(VFX_FNF_LOS_EVIL_10);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="LOSE2") eEffect=EffectVisualEffect(VFX_FNF_LOS_EVIL_20);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="LOSE3") eEffect=EffectVisualEffect(VFX_FNF_LOS_EVIL_30);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="LOSH1") eEffect=EffectVisualEffect(VFX_FNF_LOS_HOLY_10);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="LOSH2") eEffect=EffectVisualEffect(VFX_FNF_LOS_HOLY_20);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="LOSH3") eEffect=EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="LOSN1") eEffect=EffectVisualEffect(VFX_FNF_LOS_NORMAL_10);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="LOSN2") eEffect=EffectVisualEffect(VFX_FNF_LOS_NORMAL_20);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="LOSN3") eEffect=EffectVisualEffect(VFX_FNF_LOS_NORMAL_30);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="MEXPLOTION") eEffect=EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="PWKILL") eEffect=EffectVisualEffect(VFX_FNF_PWKILL);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="PWSTUN") eEffect=EffectVisualEffect(VFX_FNF_PWSTUN);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="SSHAKE") eEffect=EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="SPUFF") eEffect=EffectVisualEffect(VFX_FNF_SMOKE_PUFF);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="SBURST") eEffect=EffectVisualEffect(VFX_FNF_SOUND_BURST);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="HSTRIKE") eEffect=EffectVisualEffect(VFX_FNF_STRIKE_HOLY);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="SCELESTIAL") eEffect=EffectVisualEffect(VFX_FNF_SUMMON_CELESTIAL);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="SEUNDEAD") eEffect=EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="SGATE") eEffect=EffectVisualEffect(VFX_FNF_SUMMON_GATE);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="SMONSTER1") eEffect=EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="SMONSTER2") eEffect=EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="SMONSTER3") eEffect=EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="SUNDEAD") eEffect=EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="TSTOP") eEffect=EffectVisualEffect(VFX_FNF_TIME_STOP);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="WBANSHEE") eEffect=EffectVisualEffect(VFX_FNF_WAIL_O_BANSHEES);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="WEIRD") eEffect=EffectVisualEffect(VFX_FNF_WEIRD);
        if (GetLocalString(OBJECT_SELF, "DeathEffect")=="WORD") eEffect=EffectVisualEffect(VFX_FNF_WORD);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, OBJECT_SELF);
    }

    //Show text (will appear above the one who killed it)
    if (GetLocalString(OBJECT_SELF,"DeathText")!="")
    {
        object oPC = GetLastKiller();
        while (GetIsObjectValid(GetMaster(oPC)))
       {
           oPC=GetMaster(oPC);
       }
        DelayCommand(2.50, FloatingTextStringOnCreature("["+GetLocalString(OBJECT_SELF,"DeathText")+"]", oPC));
    }

    //If it has last words, speak them!
    if (GetLocalString(OBJECT_SELF,"DeathWords")!="")
    {
        SpeakString("["+GetLocalString(OBJECT_SELF,"DeathWords"));
    }


}
