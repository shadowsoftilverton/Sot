#include "engine"

int StartingConditional() {
    object oPC = GetPCSpeaker();

    if(GetGold(oPC) >= 1000) return TRUE;

    return FALSE;
}
