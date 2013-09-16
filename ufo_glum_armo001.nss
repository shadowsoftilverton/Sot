#include "engine"

void main()
{
    object oTarget = GetEnteringObject();
    effect eZap = EffectVisualEffect(57);
    effect eSTR = EffectAbilityDecrease(ABILITY_STRENGTH, 4);
    effect eCON = EffectAbilityDecrease(ABILITY_CONSTITUTION, 2);
    effect eAC = EffectACDecrease(2, AC_DODGE_BONUS, AC_VS_DAMAGE_TYPE_ALL);
    effect eLink = EffectLinkEffects(eSTR, eCON);
    eLink = EffectLinkEffects(eAC, eLink);
    string sResRef = GetResRef(oTarget);

    if(sResRef == "cns_guld_plat")
    {
        int nCurse = GetLocalInt(oTarget, "IsCursed");

        if(nCurse == 0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eZap, oTarget);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget);
            SetLocalInt(oTarget, "IsCursed", 1);
        }
    }
}
