#include "engine"
#include "inc_mod"
#include "inc_crossserver"

void main() {
    object oPC = GetFirstPC();

    while(GetIsObjectValid(oPC)) {
        // Divine Grace replacement
        ClearDivineGraceFeatProperties(oPC);
        ApplyDivineGraceFeatProperties(oPC);

        // Cross-server functionality
        SendCrossTellsToPC(oPC);
        SendCrossShoutsToPC(oPC);

        oPC = GetNextPC();
    }
}
