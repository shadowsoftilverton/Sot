#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Good Hope                                                            //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 17, 2011                                 //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    object oTarget = GetSpellTargetObject();
    location lTarget = GetLocation(oTarget);
    effect eVis = EffectVisualEffect(VFX_IMP_RESTORATION_LESSER);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_HOLY_20);
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
    float fDelay;

    if(nMetaMagic == METAMAGIC_EXTEND)
        nDuration *= 2;

    //Apply Impact
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lTarget);

    //Get the first target in the radius around the caster
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lTarget);
    while(GetIsObjectValid(oTarget))
    {
        if(GetIsReactionTypeFriendly(oTarget) || GetFactionEqual(oTarget))
        {
            fDelay = GetRandomDelay(0.4, 1.1);
            //Fire spell cast at event for target
            SignalEvent(oTarget, EventSpellCastAt(oTarget, GetSpellId(), FALSE));
            //Apply VFX impact and bonus effects
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration)));
        }
        //Get the next target in the specified area around the caster
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lTarget);
    }
}
