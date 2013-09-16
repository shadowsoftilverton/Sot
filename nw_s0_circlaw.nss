//:: Magic Circle Against Law

#include "x2_inc_spellhook"
void main() {
    if (!X2PreSpellCastCode()) return;

    effect eAOE = EffectAreaOfEffect(AOE_MOB_CIRCCHAOS);
    effect eVis = EffectVisualEffect(VFX_DUR_PROTECTION_EVIL_MINOR);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eEvil = EffectVisualEffect(VFX_IMP_EVIL_HELP);

    effect eLink = EffectLinkEffects(eAOE, eVis);
    eLink = EffectLinkEffects(eLink, eDur);

    object oTarget = GetSpellTargetObject();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    if (nDuration < 1) nDuration = 1;
    if (nMetaMagic == METAMAGIC_EXTEND) nDuration = nDuration *2;
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_MAGIC_CIRCLE_AGAINST_LAW, FALSE));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eEvil, oTarget);
}
