#include "engine"
#include "aps_include"

void main() {
    object oPC = GetPCSpeaker();

    SetXP(oPC, 190000);
    SetPersistentInt_player(GetName(oPC), GetPCPlayerName(oPC), "TEST_CHARACTER", 1);
}
