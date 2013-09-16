#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Longstrider                                                          //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 13 2011                                  //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    effect eVis = EffectVisualEffect(VFX_IMP_HASTE);
    effect eSpeed;
    float fDuration = HoursToSeconds(nCasterLevel);
    int nMetaMagic = GetMetaMagicFeat();
    int nSpeedPercentage = 25;

    if(nMetaMagic == METAMAGIC_EXTEND)
        fDuration *= 2.0;

    eSpeed = EffectMovementSpeedIncrease(nSpeedPercentage);

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSpeed, OBJECT_SELF, fDuration);
}
