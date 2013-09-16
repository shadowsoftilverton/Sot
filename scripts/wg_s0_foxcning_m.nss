#include "engine"

//: Mass Fox's Cunning. +4 intelligence to all allies in AoE
//: Aazonis

#include "x2_inc_spellhook"
#include "nw_i0_spells"

void main()
{
    if(!X2PreSpellCastCode())
        return;

    object oTarget = GetSpellTargetObject();
    effect eInt;
    effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_NORMAL_20);
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nModify = 4;
    float fDuration = HoursToSeconds(nCasterLvl) / 3;
    int nMetaMagic = GetMetaMagicFeat();

    if (nMetaMagic == METAMAGIC_EMPOWER)
        nModify = nModify + (nModify / 2);

    if (nMetaMagic == METAMAGIC_EXTEND)
        fDuration = fDuration * 2.0;

    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FOXS_CUNNING, FALSE));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());

    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation());
    while (GetIsObjectValid(oTarget))
    {
        float fDelay = GetRandomDelay();

        if(!GetIsReactionTypeFriendly(oTarget)) {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            eInt = EffectAbilityIncrease(ABILITY_INTELLIGENCE, nModify);
            effect eLink = EffectLinkEffects(eInt, eDur);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
        }

        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation());
    }
}
