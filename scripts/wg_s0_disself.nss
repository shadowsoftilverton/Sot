#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Disguise Self                                                        //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 16 2011                                  //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_ODD);
    effect eDis;
    float fDuration = 10 * 60.0 * nCasterLevel;
    int nMetaMagic = GetMetaMagicFeat();
    int nModify = 10;

    if(nMetaMagic == METAMAGIC_EXTEND)
        fDuration = fDuration * 2.0;

    eDis = EffectSkillIncrease(SKILL_DISGUISE, nModify);

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDis, OBJECT_SELF, fDuration);
}
