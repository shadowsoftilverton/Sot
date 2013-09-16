#include "engine"

#include "inc_bind"

void main()
{
    object oPC = GetLastUsedBy();

    if(GetPersistentInt_player(GetName(oPC), GetPCPlayerName(oPC), "TEST_CHARACTER") == 1) {
        FloatingTextStringOnCreature("You cannot enter the server with a test character. Please make a new character and avoid using the build tester if you desire to play the PC.", oPC, FALSE);
    } else if(GetXP(oPC) < 1) {
        FloatingTextStringOnCreature("You cannot enter the server without going through setup!", oPC, FALSE);
    } else {
        SetBindPoint(oPC, GetWaypointByTag("bp_ARA_EST"));
        ExecuteScript("plc_transition", OBJECT_SELF);
    }
}
