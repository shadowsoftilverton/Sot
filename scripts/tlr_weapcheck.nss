//::///////////////////////////////////////////////
//:: Tailoring - If RightHand Item is Valid
//:: Also check to see if weapon copying is allowed
//:: tlr_weapcheck.nss
//:: Copyright (c) 2006 Stacy L. Ropella
//:://////////////////////////////////////////////
/*
    Checks to make sure there is a valid item
    equipped in the PC's right hand slot & in the
    model's right hand slot
*/
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: Created On: January 29, 2006
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oSelf = OBJECT_SELF;
    object oPC = GetPCSpeaker();

    object oPCWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    object oTlrWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oSelf);

    return GetIsObjectValid(oPCWeapon) && GetIsObjectValid(oTlrWeapon) &&
           GetBaseItemType(oPCWeapon) == GetBaseItemType(oTlrWeapon);
}
