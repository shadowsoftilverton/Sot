#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Spider Climb                                                         //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 16 2011                                  //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    float fDuration = 10.0 * 60.0 * nCasterLevel;

    effect eVis = EffectVisualEffect(VFX_IMP_HASTE);

    if(nMetaMagic == METAMAGIC_EXTEND)
        fDuration = fDuration * 2.0;

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, OBJECT_SELF, fDuration);
}
