#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Greater Heroism                                                      //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 17, 2011                                 //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_RESTORATION_LESSER);
    effect eAttack = EffectAttackIncrease(4);
    effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, 4);
    effect eDamageIncrease = EffectDamageIncrease(4, DAMAGE_TYPE_BLUDGEONING);
    effect eSkillIncrease = EffectSkillIncrease(SKILL_ALL_SKILLS, 4);
    effect eHPIncrease = EffectTemporaryHitpoints(GetCasterLevel(OBJECT_SELF));
    effect eFearImmune = EffectImmunity(IMMUNITY_TYPE_FEAR);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eAttack, eSave);
    eLink = EffectLinkEffects(eLink, eDamageIncrease);
    eLink = EffectLinkEffects(eLink, eSkillIncrease);
    eLink = EffectLinkEffects(eLink, eHPIncrease);
    eLink = EffectLinkEffects(eLink, eFearImmune);
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
