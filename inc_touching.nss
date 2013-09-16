#include "engine"
#include "nwnx_structs"

void DisableTouching(object oPC);
void EnableTouching(object oPC);

void DisableTouching(object oPC) {
    effect eLoop = GetFirstEffect(oPC);
    while(GetIsEffectValid(eLoop)) {
        if(GetEffectSpellId(eLoop) == TOUCHING_SPELL_ID) RemoveEffect(oPC, eLoop);

        eLoop = GetNextEffect(oPC);
    }
}

void EnableTouching(object oPC) {
    effect eGhost = EffectCutsceneGhost();
    eGhost = SupernaturalEffect(eGhost);
    SetEffectSpellId(eGhost, TOUCHING_SPELL_ID);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPC);
}
