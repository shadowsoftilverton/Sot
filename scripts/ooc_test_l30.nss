#include "engine"
#include "aps_include"

void main() {
    object oPC = GetPCSpeaker();

    SetXP(oPC, 435000);
    SetPersistentInt_player(GetName(oPC), GetPCPlayerName(oPC), "TEST_CHARACTER", 1);
}
