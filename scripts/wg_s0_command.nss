#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Command                                                              //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 7, 2011                                  //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    int nSpell = GetSpellId();
    object oTarget = GetSpellTargetObject();

    if(oTarget == OBJECT_SELF)
        return;

    int nDC = GetSpellSaveDC();
    int nDuration = 1;
    int nMetaMagic = GetMetaMagicFeat();

    if(nMetaMagic == METAMAGIC_EXTEND)
        nDuration *= 2;

    float fDuration = RoundsToSeconds(nDuration);

    effect eVisual = EffectVisualEffect(VFX_FNF_HOWL_MIND);
    effect eDamageType;
    effect eDuration;

    if(!MyResistSpell(OBJECT_SELF, oTarget) && !MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_SPELL)) {
        switch(nSpell) {
            case SPELL_COMMAND_APPROACH: {
                eDamageType = EffectConfused();
                eDuration = EffectVisualEffect(VFX_DUR_CESSATE_NEUTRAL);
                eDuration = EffectLinkEffects(eDur, EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DOMINATED));
                eDamageType = EffectLinkEffects(eDamageType, eDuration);

                } break;
            case SPELL_COMMAND_DROP: {
                eDamageType = EffectMissChance(100, MISS_CHANCE_TYPE_NORMAL);
                eDuration = EffectVisualEffect(VFX_DUR_MAGICAL_SIGHT);
                eDamageType = EffectLinkEffects(eDamageType, eDuration);

                } break;
            case SPELL_COMMAND_FALL: {
                eDamageType = EffectKnockdown();
                eDamageType = EffectLinkEffects(eDamageType, EffectParalyze());
                eDuration = EffectVisualEffect(VFX_DUR_PARALYZED);
                eDamageType = EffectLinkEffects(eDamageType, eDuration);
                eDuration = EffectLinkEffects(eDuration, EffectVisualEffect(VFX_DUR_AURA_PULSE_GREY_WHITE));

                } break;
            case SPELL_COMMAND_FLEE: {
                eDamageType = EffectFrightened();
                eDuration = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
                eDamageType = EffectLinkEffects(eDamageType, eDuration);

                } break;
            case SPELL_COMMAND_HALT: {
                eDamageType = EffectCutsceneParalyze();
                eDuration = EffectVisualEffect(VFX_DUR_PARALYZED);
                eDamageType = EffectLinkEffects(eDamageType, eDuration);
                eDuration = EffectLinkEffects(eDuration, EffectVisualEffect(VFX_DUR_AURA_COLD));

                } break;
        }

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDamageType, oTarget, fDuration);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget);
    }
}
