#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Lullaby                                                              //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 16, 2011                                 //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    object oTarget = GetSpellTargetObject();
    effect ePenalties;
    effect eVis = EffectVisualEffect(VFX_IMP_DOOM);
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    float fDuration = RoundsToSeconds(nCasterLvl);
    int nMetaMagic = GetMetaMagicFeat();
    int nModify = 5;

    if (nMetaMagic == METAMAGIC_EXTEND)
        fDuration = fDuration * 2.0;

    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_LULLABY, FALSE));

    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetSpellTargetLocation());
    while (GetIsObjectValid(oTarget)) {
        if(!GetIsReactionTypeFriendly(oTarget)) {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ePenalties = EffectSkillDecrease(SKILL_LISTEN, nModify);
            ePenalties = EffectLinkEffects(ePenalties, EffectSkillDecrease(SKILL_SPOT, nModify));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePenalties, oTarget, fDuration);
        }

        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetSpellTargetLocation());
    }
}
