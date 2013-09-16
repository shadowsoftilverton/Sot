//:: Magic Cirle Against Law
//:: NW_S0_CircLawA
#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main() {
    object oTarget = GetEnteringObject();
    if(GetIsFriend(oTarget, GetAreaOfEffectCreator())) {
        int nDuration = GetCasterLevel(OBJECT_SELF);
        effect eLink = CreateProtectionFromAlignmentLink(ALIGNMENT_LAWFUL);
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_MAGIC_CIRCLE_AGAINST_LAW, FALSE));
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget);
     }
}
