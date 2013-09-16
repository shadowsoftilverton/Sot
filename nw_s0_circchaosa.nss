//::///////////////////////////////////////////////
//:: Magic Cirle Against Chaos
//:: NW_S0_CircChaosA
//:://////////////////////////////////////////////
/*
    Add basic protection from chaos effects to
    entering allies.
*/
#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main() {
    object oTarget = GetEnteringObject();
    if(GetIsFriend(oTarget, GetAreaOfEffectCreator())) {
        //Declare major variables
        int nDuration = GetCasterLevel(OBJECT_SELF);
        //effect eVis = EffectVisualEffect(VFX_IMP_GOOD_HELP);
        effect eLink = CreateProtectionFromAlignmentLink(ALIGNMENT_CHAOTIC);

        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_MAGIC_CIRCLE_AGAINST_CHAOS, FALSE));

        //Apply the VFX impact and effects
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget);
     }
}
