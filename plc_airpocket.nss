void main()
{
    object oUser = GetLastUsedBy();
    effect eHold = EffectCutsceneParalyze();
    int nCON = GetAbilityModifier(ABILITY_CONSTITUTION, oUser) + 10;
    int nBreath = GetLocalInt(oUser, "DrownCount");
    eHold = SupernaturalEffect(eHold);

    nBreath = nBreath + 5;
    if(nBreath > nCON)  nBreath = nCON;

    if(GetActionMode(oUser, ACTION_MODE_STEALTH) == TRUE)   SetActionMode(oUser, ACTION_MODE_STEALTH, FALSE);

    SetLocalInt(oUser, "DrownCount", nBreath);
    FloatingTextStringOnCreature("You manage to get a breath of air.", oUser, FALSE);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHold, oUser, 4.0f);
}
