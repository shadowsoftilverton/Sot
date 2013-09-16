#include "engine"

void main()
{
    object oPC = OBJECT_SELF;
    location lLoc = GetSpellTargetLocation();
    SetLocalLocation(oPC, "EW_LOCATION", lLoc);
    AssignCommand(oPC, ActionStartConversation(oPC, "ew_menu", TRUE, FALSE));
}
