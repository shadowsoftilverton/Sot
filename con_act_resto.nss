#include "engine"

void main() {
    object oCaster = GetLastSpeaker();
    object oPC = GetPCSpeaker();

    AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_RESTORATION, oPC, METAMAGIC_ANY, TRUE));
    TakeGoldFromCreature(500, oPC, TRUE);
}
