#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Tree Shape                                                           //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 13, 2011                                 //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    float fDuration = HoursToSeconds(GetCasterLevel(OBJECT_SELF));
    int nMetaMagic = GetMetaMagicFeat();
    location lLocation = GetLocation(OBJECT_SELF);

    if(nMetaMagic == METAMAGIC_EXTEND)
        fDuration *= 2.0;

    effect eSanctuary = EffectSanctuary(1000);
    effect eImmobilize = EffectCutsceneImmobilize();
    effect eDominated = EffectCutsceneDominated();
    effect eVisual = EffectVisualEffect(VFX_IMP_POLYMORPH);
    effect eLink = EffectLinkEffects(eSanctuary, eImmobilize);
    eLink = EffectLinkEffects(eLink, eDominated);

    object oTree = CreateObject(OBJECT_TYPE_PLACEABLE, "wg_sp_treeshp", lLocation);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration);
    DestroyObject(oTree, fDuration);
}
