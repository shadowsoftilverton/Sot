#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Blur                                                                 //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 16, 2011                                 //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    float nDuration = 60.0 * nCasterLvl;

    if(nMetaMagic == METAMAGIC_EXTEND)
        nDuration *= 2.0;

    effect eVisual = EffectVisualEffect(VFX_DUR_ETHEREAL_VISAGE);
    effect eConcealment = EffectConcealment(20);
    eConcealment = EffectLinkEffects(eConcealment, eVisual);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eConcealment, OBJECT_SELF, nDuration);
}
