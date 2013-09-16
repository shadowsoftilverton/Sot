#include "engine"

//----------------------------------------------------------------------------//

#include "NW_I0_SPELLS"
#include "x2_i0_spells"
#include "x2_inc_spellhook"

//----------------------------------------------------------------------------//

void main() {
    object oTarget = GetEnteringObject();
    object oCreator = GetAreaOfEffectCreator();

    if(oTarget == oCreator) return;

    int nDC = 10 + GetLevelByClass(CLASS_TYPE_BATTLECAPTAIN);
    if(GetAbilityModifier(ABILITY_STRENGTH, oCreator) > GetAbilityModifier(ABILITY_CHARISMA, oCreator)) nDC += GetAbilityModifier(ABILITY_STRENGTH, oCreator);
    else nDC += GetAbilityModifier(ABILITY_CHARISMA, oCreator);

    if(spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, oCreator)) {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_TERRIFYING_PRESENCE));

        if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_FEAR))
            DelayCommand(GetRandomDelay(0.75, 1.75), ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectFrightened(), oTarget));
    }
}
