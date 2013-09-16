#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Heroism                                                              //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 17, 2011                                 //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_RESTORATION_LESSER);
    effect eAttack = EffectAttackIncrease(2);
    effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL ,2);
    effect eDamageIncrease = EffectDamageIncrease(2, DAMAGE_TYPE_BLUDGEONING);
    effect eSkillIncrease = EffectSkillIncrease(SKILL_ALL_SKILLS, 2);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eAttack, eSave);
    eLink = EffectLinkEffects(eLink, eDamageIncrease);
    eLink = EffectLinkEffects(eLink, eSkillIncrease);
    eLink = EffectLinkEffects(eLink, eDur);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();

    if(nMetaMagic == METAMAGIC_EXTEND)
        nDuration *= 2;

    if(GetIsObjectValid(oTarget)) {
        if(GetIsReactionTypeFriendly(oTarget) || GetFactionEqual(oTarget)) {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
        }
    }
}
