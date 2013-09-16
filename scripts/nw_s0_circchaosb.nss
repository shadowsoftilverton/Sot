//::///////////////////////////////////////////////
//:: Magic Cirle Against Chaos
//:: NW_S0_CircChaosB

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main() {
    object oTarget = GetExitingObject();
    int bValid = FALSE;
    effect eAOE;
    if(GetHasSpellEffect(SPELL_MAGIC_CIRCLE_AGAINST_CHAOS, oTarget)) {
        eAOE = GetFirstEffect(oTarget);
        while (GetIsEffectValid(eAOE)) {
            if (GetEffectCreator(eAOE) == GetAreaOfEffectCreator()) {
                if(GetEffectSpellId(eAOE) == SPELL_MAGIC_CIRCLE_AGAINST_CHAOS) {
                    RemoveEffect(oTarget, eAOE);
                }
            }
            eAOE = GetNextEffect(oTarget);
        }
    }
}
