#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Glitterdust                                                          //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 17, 2011                                 //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    object oTarget;
    effect eCessate = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect ePenalty = EffectSkillDecrease(SKILL_HIDE, 40);
    effect ePenaltyLink = EffectLinkEffects(eCessate, ePenalty);
    effect ePenatlyLink = EffectLinkEffects(EffectVisualEffect(VFX_DUR_PIXIEDUST),ePenaltyLink);
    float fDelay;
    effect eBlindDur = EffectVisualEffect(VFX_DUR_BLIND);
    effect eBlind = EffectBlindness();
    effect eBlindLink = EffectLinkEffects(eBlindDur, eBlind);
    eBlindLink = EffectLinkEffects(eBlindLink, ePenalty);

    effect eImpact = EffectVisualEffect(VFX_FNF_BLINDDEAF);
    int nMetaMagic = GetMetaMagicFeat();

    int nDuration = GetCasterLevel(OBJECT_SELF);
    location lSpell = GetSpellTargetLocation();

    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration * 2;

    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eImpact, lSpell, RoundsToSeconds(nDuration));

    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lSpell);
    while(GetIsObjectValid(oTarget))
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        fDelay = GetDistanceBetweenLocations(GetLocation(oTarget), lSpell)/20;

        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePenaltyLink, oTarget, RoundsToSeconds(nDuration)));
        RemoveSpecificEffect(EFFECT_TYPE_INVISIBILITY, oTarget);
        RemoveSpecificEffect(EFFECT_TYPE_IMPROVEDINVISIBILITY, oTarget);
        if(!MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC()))
        {
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlindLink, oTarget, RoundsToSeconds(nDuration)));
        }

        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lSpell);
    }
}
