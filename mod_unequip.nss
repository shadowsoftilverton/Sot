//::///////////////////////////////////////////////
//:: Example XP2 OnItemEquipped
//:: x2_mod_def_unequ
//:: (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Put into: OnUnEquip Event
*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-07-16
//:://////////////////////////////////////////////
//:: Modified By: Deva Winblood
//:: Modified On: April 15th, 2008
//:: Added Support for Mounted Archery Feat penalties
//:://////////////////////////////////////////////

#include "x2_inc_switches"
#include "x3_inc_horse"
#include "inc_equipment"
#include "inc_mod"
#include "inc_modalfeats"
#include "ave_DuelEquip"
#include "inc_horses"

void main()
{
     object oItem = GetPCItemLastUnequipped();
     object oPC   = GetPCItemLastUnequippedBy();

    // -------------------------------------------------------------------------
    // Mounted benefits control
    // -------------------------------------------------------------------------
    if (GetWeaponRanged(oItem))
    {
        DeleteLocalInt(oPC,"bX3_M_ARCHERY");
        HORSE_SupportAdjustMountedArcheryPenalty(oPC);
    }

    // -------------------------------------------------------------------------
    // Generic Item Script Execution Code
    // If MODULE_SWITCH_EXECUTE_TAGBASED_SCRIPTS is set to TRUE on the module,
    // it will execute a script that has the same name as the item's tag
    // inside this script you can manage scripts for all events by checking against
    // GetUserDefinedItemEventNumber(). See x2_it_example.nss
    // -------------------------------------------------------------------------
    if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
    {
        SetUserDefinedItemEventNumber(X2_ITEM_EVENT_UNEQUIP);
        int nRet =   ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oItem),OBJECT_SELF);
        if (nRet == X2_EXECUTE_SCRIPT_END)
        {
           return;
        }
    }

    // ** SILVER MARCHES CODE ** //

    // The event actually fires before the equipment is removed, meaning there
    // needs to be a tiny delay in order for the properties to be applied
    // accurately.

    DoUnequipAdjustments(oPC, oItem);
    DoDeactivateModalFeats(oPC);
    if(GetLevelByClass(CLASS_TYPE_DUELIST, oPC) > 0)    ave_DuelEquip(oPC, OBJECT_INVALID);
    if(GetSkinInt(oPC, "bX3_IS_MOUNTED") == TRUE)       HorseMountedWeaponSwitchOut(oPC);
}
