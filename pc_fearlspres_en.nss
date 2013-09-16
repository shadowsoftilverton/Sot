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
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_FEARLESS_PRESENCE));
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectImmunity(IMMUNITY_TYPE_FEAR), oTarget);
    }
}
