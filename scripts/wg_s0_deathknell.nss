#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Death Knell                                                          //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 7, 2011                                  //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    object oTarget = GetSpellTargetObject();
    int nDC = GetSpellSaveDC();
    float fDuration = TurnsToSeconds(GetHitDice(oTarget) * 2); //2 turns per HD
    int nTouch = TouchAttackMelee(oTarget);

    if(!nTouch || GetCurrentHitPoints(oTarget) > -1 || GetIsImmune(oTarget, IMMUNITY_TYPE_DEATH))
        return;

    if(!MyResistSpell(OBJECT_SELF, oTarget) && !MySavingThrow(SAVING_THROW_WILL, oTarget, nDC)) {
        effect eDeath = EffectDeath();
        effect eHP = EffectTemporaryHitpoints(d8());
        effect eStr = EffectAbilityIncrease(ABILITY_STRENGTH, 2);
        effect eLink = EffectLinkEffects(eHP, eStr);

        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration);

        SetLocalInt(OBJECT_SELF, "wg_s0_deathknell", 1);    // This variable is checked for in GetCasterLevel...
        DelayCommand(fDuration, SetLocalInt(OBJECT_SELF, "wg_s0_deathknell", 0));
    }
}
