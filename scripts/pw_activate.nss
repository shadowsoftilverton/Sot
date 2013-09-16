#include "engine"

//::///////////////////////////////////////////////
//:: MW_ACTIVATE.NSS
//:: Silver Marches File
//:://////////////////////////////////////////////
/*
    Activation script for the Puppet Wand. This is
    a component to the overall Utility Wand project.
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

    // Using the utility wand on the ground has different results.
    if(!GetIsObjectValid(oTarget)) oTarget = OBJECT_INVALID;

    int nType = GetObjectType(oTarget);

    // If we don't own the target, we report this as an error.
    if(!GetIsOwner(oPC, oTarget)) SendUtilityErrorMessageToPC(oPC, UW_MSG_INVALID_PUPPET);

    if (oPC == oTarget || nType == OBJECT_TYPE_ITEM || nType == OBJECT_TYPE_CREATURE ||
        nType == OBJECT_TYPE_DOOR || nType == OBJECT_TYPE_PLACEABLE){
        SetPuppet(oPC, oTarget);
    } else {
        // Backup code in case GetIsOwner passes unexpected results from a strange
        // target.
        SendUtilityErrorMessageToPC(oPC, UW_MSG_INVALID_TARGET);
        return;
    }
}
