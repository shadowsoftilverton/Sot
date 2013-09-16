#include "engine"

// Handles instance transitions.

#include "inc_areas"

void main()
{
    object oSelf = OBJECT_SELF;

    object oPC = GetClickingObject();

    object oTarget = GetLocalObject(oSelf, AREA_LV_TRANS_POINTER);

    SendMessageToPC(oPC, "Trying to port you to area: " + GetName(GetArea(oTarget)));

    AssignCommand(oPC, JumpToLocation(GetLocation(oTarget)));

    if(GetLocalInt(oSelf, LV_DOORWAY_IS_EXIT)) {
        // CHECK IF INSTANCE IS OCCUPIED AND DESTROY IF NOT.
    }
}
