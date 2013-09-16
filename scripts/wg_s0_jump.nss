#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Jump                                                                 //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 10 2011                                  //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    effect eVis = EffectVisualEffect(VFX_IMP_HASTE);
    effect eAth;
    float fDuration = 60.0 * nCasterLevel;
    int nMetaMagic = GetMetaMagicFeat();
    int nModify = 10;

    if(nMetaMagic == METAMAGIC_EXTEND)
        fDuration = fDuration * 2.0;

    if(nCasterLevel > 4)
        nModify += 10;

    if(nCasterLevel > 8)
        nModify += 10;

    eAth = EffectSkillIncrease(SKILL_ATHLETICS, nModify);

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAth, OBJECT_SELF, fDuration);
}
