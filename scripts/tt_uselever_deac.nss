void main()
{
    effect eVFX;
    object oTarget;
    object oPC = GetLastUsedBy();

    oTarget = GetObjectByTag("tt_dwarf_ironworks_core");
    SetLocalInt(oTarget, "lava_flow", 0);

    oTarget = GetObjectByTag("tt_trap_lava");
    DelayCommand(2.0, SetLocalInt(oTarget, "ContinuousDmg", 0));

    eVFX = EffectVisualEffect(VFX_FNF_SMOKE_PUFF);
    oTarget = GetObjectByTag("LavaShaft");
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oTarget);
    DestroyObject(oTarget, 3.0);

    oTarget = GetObjectByTag("tt_plc_lava");
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oTarget);
    DelayCommand(1.0, DestroyObject(oTarget, 3.0));

    oTarget = GetObjectByTag("tt_plc_lava");
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oTarget);
    DelayCommand(3.0, DestroyObject(oTarget, 3.0));

    FloatingTextStringOnCreature("You turn the wheel", oPC);



    oTarget = GetObjectByTag("tt_sound_vault");
    SoundObjectSetVolume(oTarget, 127);
    SoundObjectPlay(oTarget);
}











