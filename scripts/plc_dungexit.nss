//----------------------------------------------------------------------------//
// A stripped-down plc_transition that serves a single purpose
// -- exiting dungeons
//----------------------------------------------------------------------------//

#include "engine"

void main() {
    object oPlaceable = OBJECT_SELF;
    object oPC = GetLastUsedBy();
    object oArea = GetArea(oPlaceable);
    object oWaypoint = GetObjectByTag(GetLocalString(oPlaceable, "wp_destination"));

    DelayCommand(1.0, AssignCommand(oPC, JumpToObject(oWaypoint)));
}
