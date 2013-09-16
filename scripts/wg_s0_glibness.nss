#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Glibness                                                             //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 7, 2011                                  //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    object oPC = OBJECT_SELF;
    int nCasterLevel = GetCasterLevel(oPC);
    int nMetaMagic = GetMetaMagicFeat();
    float fDuration = 10.0 * 60.0 * nCasterLevel;

    if(nMetaMagic == METAMAGIC_EXTEND)
        fDuration *= 2.0;

    effect eBluff = EffectSkillIncrease(SKILL_BLUFF, 30);
    effect eVis = EffectVisualEffect(VFX_FNF_SMOKE_PUFF);
    eBluff = EffectLinkEffects(eBluff, eVis);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBluff, oPC, fDuration);
}
