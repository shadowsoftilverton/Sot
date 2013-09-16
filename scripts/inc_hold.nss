#include "engine"
#include "NW_I0_SPELLS"

void HoldCreature(object oTarget, int nDC, int nDur, float fInterval){
    // Initialize effects.
    effect eParal = EffectParalyze();
    effect eVis = EffectVisualEffect(82);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eDur2 = EffectVisualEffect(VFX_DUR_PARALYZED);
    effect eDur3 = EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);
    effect eDur4 = EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION);

    effect eLink = EffectLinkEffects(eVis, eParal);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eDur2);
    eLink = EffectLinkEffects(eLink, eDur3);
    eLink = EffectLinkEffects(eLink, eDur4);

    // Do we fail our saving throw?
    if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC) && nDur > 0){
        // Explicitly decrement the duration.
        nDur -= nDur - FloatToInt(fInterval / 6);
        // Apply the hold effect.
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fInterval);
        // Delay another check.
        DelayCommand(fInterval, HoldCreature(oTarget, nDC, nDur, fInterval));
    }
}
