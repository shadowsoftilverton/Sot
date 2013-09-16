#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Hide from Undead                                                     //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 7, 2011                                  //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    float nDuration = TurnsToSeconds(nCasterLvl);

    if(nMetaMagic == METAMAGIC_EXTEND)
        nDuration *= 2.0;

    effect eVisual = EffectVisualEffect(VFX_DUR_IOUNSTONE_BLUE);
    effect eConcealment = VersusRacialTypeEffect(EffectConcealment(10), RACIAL_TYPE_UNDEAD);
    eConcealment = EffectLinkEffects(eConcealment, eVisual);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eConcealment, OBJECT_SELF, nDuration);
}
