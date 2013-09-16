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

    if(GetIsFriend(oTarget, GetAreaOfEffectCreator())) {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_FINAL_STAND));
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectTemporaryHitpoints(GetMaxHitPoints(oTarget) / 2), oTarget);
    }
}
