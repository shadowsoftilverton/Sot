#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Gaseous Form                                                         //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 17, 2011                                 //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_POLYMORPH);
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    float fDuration = 2.0 * 60.0 * nCasterLevel;
    effect eForm = EffectLinkEffects(EffectVisualEffect(425), EffectPolymorph(78));
    eForm = EffectLinkEffects(EffectImmunity(IMMUNITY_TYPE_CRITICAL_HIT), eForm);
    eForm = EffectLinkEffects(EffectImmunity(IMMUNITY_TYPE_POISON), eForm);
    eForm = EffectLinkEffects(EffectDamageReduction(20, DAMAGE_POWER_PLUS_ONE), eForm);

    if(nMetaMagic == METAMAGIC_EXTEND)
        fDuration *= 2.0;

    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eForm, oTarget, fDuration);
}

