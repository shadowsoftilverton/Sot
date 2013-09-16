#include "engine"

//::///////////////////////////////////////////////
//:: MW_ACTIVATE.NSS
//:: Silver Marches File
//:://////////////////////////////////////////////
/*
    Activation script for the Modification Wand.
    This is a component to the overall Utility Wand
    project.
*/
//:://////////////////////////////////////////////
//:: Created By: Ashton Shapcott
//:: Created On: Apr. 10, 2011
//:://////////////////////////////////////////////

#include "uw_inc"

void main()
{
    object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    location lLoc = GetSpellTargetLocation();

    // Using the utility wand on the ground has different results.
    if(!GetIsObjectValid(oTarget)) oTarget = OBJECT_INVALID;

    int nType = GetObjectType(oTarget);

    if (oPC == oTarget || nType == OBJECT_TYPE_ITEM || nType == OBJECT_TYPE_CREATURE ||
        nType == OBJECT_TYPE_DOOR || nType == OBJECT_TYPE_PLACEABLE){
        AssignCommand(oPC, ActionStartConversation(oPC, MW_MENU, TRUE, FALSE));
    } else {
        SendUtilityErrorMessageToPC(oPC, UW_MSG_INVALID_TARGET);
        return;
    }

    SetUtilityTarget(oPC, oTarget);
    SetUtilityLocation(oPC, lLoc);
}
