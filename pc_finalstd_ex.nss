#include "engine"

//----------------------------------------------------------------------------//

#include "NW_I0_SPELLS"
#include "x2_i0_spells"
#include "x2_inc_spellhook"

//----------------------------------------------------------------------------//

void main() {
    object oTarget = GetExitingObject();

    if(GetHasSpellEffect(SPELLABILITY_FINAL_STAND, oTarget)) {
        effect eLoop = GetFirstEffect(oTarget);

        while (GetIsEffectValid(eLoop)) {
            if(GetEffectCreator(eLoop) == GetAreaOfEffectCreator()) {
                if(GetEffectSpellId(eLoop) == SPELLABILITY_FINAL_STAND)
                    RemoveEffect(oTarget, eLoop);
            }

            eLoop = GetNextEffect(oTarget);
        }
    }
}
