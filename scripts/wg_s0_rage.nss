#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Rage                                                                 //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 19, 2011                                 //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    object oTarget = GetSpellTargetObject();
    float fDuration = 1.0 * GetSkillRank(SKILL_CONCENTRATION) + GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();

    if(nMetaMagic == METAMAGIC_EXTEND)
        fDuration *= 2.0;

    effect eStr = EffectAbilityIncrease(ABILITY_STRENGTH, 2);
    effect eCon = EffectAbilityIncrease(ABILITY_CONSTITUTION, 2);
    effect eWill = EffectSavingThrowIncrease(SAVING_THROW_WILL, 1);
    effect eAC = EffectACDecrease(2);
    effect eLink = EffectLinkEffects(eStr, eCon);
    eLink = EffectLinkEffects(eLink, eWill);
    eLink = EffectLinkEffects(eLink, eAC);
    effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);

    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
}
