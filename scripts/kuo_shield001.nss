void main()
{
    object oShield = GetItemActivated();
    object oHolder = GetItemPossessor(oShield);
    object oHitter = GetLastAttacker(oHolder);
    effect eSticky = EffectCutsceneParalyze();
    int nSTR = GetAbilityModifier(ABILITY_STRENGTH, oHitter);
    int nRandom = d4(3);
    int nSticky = nRandom - nSTR;
    if(nSticky < 0) nSticky = 1;
    float fDuration = IntToFloat(nSticky);

    if(GetDistanceBetween(oHolder, oHitter) < 2.5f)
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSticky, oHitter, fDuration);
        FloatingTextStringOnCreature("Your weapon gets stuck on the enemy's shield!", oHitter);
    }
}
