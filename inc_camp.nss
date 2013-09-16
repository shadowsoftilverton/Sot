#include "aps_include"

void DoCampTimer(object oPC) {
    if(GetPersistentInt(oPC, "SYS_CAMP_DELAY") == 0) return;

    SetPersistentInt(oPC, "SYS_CAMP_DELAY", GetPersistentInt(oPC, "SYS_CAMP_DELAY") - 1);
    DelayCommand(60.0, DoCampTimer(oPC));
}

void DoCampRestTimer(object oPC) {
    if(GetPersistentInt(oPC, "SYS_CAMP_REST_TIMER") == 0) {
        SetLocalInt(oPC, "REST_ENABLED", FALSE);
        return;
    }

    SetPersistentInt(oPC, "SYS_CAMP_REST_TIMER", GetPersistentInt(oPC, "SYS_CAMP_REST_TIMER") - 1);
    DelayCommand(5.0, DoCampRestTimer(oPC));
}
