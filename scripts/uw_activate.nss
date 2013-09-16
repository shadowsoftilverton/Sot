#include "engine"

//::///////////////////////////////////////////////
//:: UW_ACTIVATE.NSS
//:: Silver Marches File
//:://////////////////////////////////////////////
/*
    Activation script for the Utility Wand.
*/
//:://////////////////////////////////////////////
//:: Created By: Ashton Shapcott
//:: Created On: Aug. 4, 2009
//:://////////////////////////////////////////////
//:: Modified By: Ashton Shapcott
//:: Modified On: Oct. 10, 2010
//:: - Minor modifications to get it ready for Silver
//::   Marches.
//::
//:: Modified By: Ashton Shapcott
//:: Modified On: Oct. 14, 2010
//:: - Removed rest-based activation support. Now runs
//::   on feats or items.
//::
//:: Modified By: Ashton Shapcott
//:: Modified On: Nov. 2, 2010
//:: - Removed item-based activation support. Now
//::   runs purely on feats.

#include "uw_inc"

void main()
{
    object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    location lLoc = GetSpellTargetLocation();

    int nType = GetObjectType(oTarget);

    SendMessageToPC(oPC, "Target Type: " + IntToString(nType));

    if (oPC == oTarget || nType == OBJECT_TYPE_ITEM || nType == OBJECT_TYPE_CREATURE ||
        nType == OBJECT_TYPE_DOOR || nType == OBJECT_TYPE_PLACEABLE){
        AssignCommand(oPC, ActionStartConversation(oPC, UW_MENU, TRUE, FALSE));
    } else if(GetIsDM(oPC) && nType == 0) {
        AssignCommand(oPC, ActionStartConversation(oPC, UW_MENU, TRUE, FALSE));
    } else {
        SendUtilityErrorMessageToPC(oPC, UW_MSG_INVALID_TARGET);
        return;
    }

    SetUtilityTarget(oPC, oTarget);
    SetUtilityLocation(oPC, lLoc);
}
