#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Calm Emotions                                                        //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 7, 2011                                  //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void RemoveEmotionalEffects(object oTarget) {
    effect eLoop = GetFirstEffect(oTarget);

    while(GetIsEffectValid(eLoop)) {
        if(GetEffectSpellId(eLoop) == SPELL_BLESS ||
           GetEffectSpellId(eLoop) == SPELL_FEAR ||
           GetEffectSpellId(eLoop) == SPELL_BANE ||
           GetEffectSpellId(eLoop) == SPELL_CRUSHING_DESPAIR ||
           GetEffectSpellId(eLoop) == SPELL_EMOTION_COURAGE ||
           GetEffectSpellId(eLoop) == SPELL_EMOTION_HOPE ||
           GetEffectSpellId(eLoop) == SPELLEFFECT_BARD_SONG_COURAGE ||
           GetEffectSpellId(eLoop) == SPELLABILITY_BARBARIAN_RAGE) {
               RemoveEffect(oTarget, eLoop);
        }

        eLoop = GetNextEffect(oTarget);
    }
}

void main() {
    if(!X2PreSpellCastCode())
        return;

    object oTarget = GetSpellTargetObject();
    int nDC = GetSpellSaveDC();
    effect eVisual = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
    float fRange = FeetToMeters(20.0);
    location lTarget = GetLocation(oTarget);

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVisual, lTarget);

    object oCreature = GetFirstObjectInShape(SHAPE_SPHERE, fRange, lTarget);

    while(GetIsObjectValid(oCreature)) {
        if(!MyResistSpell(OBJECT_SELF, oCreature) && !MySavingThrow(SAVING_THROW_WILL, oCreature, nDC, SAVING_THROW_TYPE_MIND_SPELLS)) {
            RemoveEmotionalEffects(oCreature);

            if(GetHasEffect(EFFECT_TYPE_FRIGHTENED, oCreature))
                RemoveSpecificEffect(EFFECT_TYPE_FRIGHTENED, oCreature);
        }
    }
}
