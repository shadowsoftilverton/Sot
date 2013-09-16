// =============================================================================
// Horse Widget Script - Invictus, Oct. 31 2011
// =============================================================================

#include "x2_inc_switches"
#include "inc_horse"

const string HORSE_NAME = "Warhorse";
const string HORSE_TAG = "X3_HVYWARHORSE";
const string HORSE_RESREF = "x3_hvywarhorse";

void main() {
    int nEvent = GetUserDefinedItemEventNumber();
    if(nEvent != X2_ITEM_EVENT_ACTIVATE) return;

    object oPC = GetItemActivator();
    object oTarget = GetItemActivatedTarget();

    HorseWidgetAction(oPC, oTarget, HORSE_NAME, HORSE_TAG, HORSE_RESREF);
}
