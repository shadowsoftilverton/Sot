#include "engine"

void main() {
    object oCaster = GetLastSpeaker();
    object oPC = GetPCSpeaker();

    AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_REMOVE_CURSE, oPC, METAMAGIC_ANY, TRUE));
    TakeGoldFromCreature(750, oPC, TRUE);
}
