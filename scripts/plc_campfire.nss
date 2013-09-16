#include "engine"
#include "aps_include"
#include "inc_camp"

void main() {
    object oPC = GetLastUsedBy();

    if(GetIsPC(oPC)) {
        SetLocalInt(oPC, "REST_ENABLED", TRUE);
        SetPersistentInt(oPC, "SYS_CAMP_REST_TIMER", 5);
        AssignCommand(oPC, ActionRest());
        SendMessageToPC(oPC, "You are able to rest here.");
        DoCampRestTimer(oPC);
    }
}
