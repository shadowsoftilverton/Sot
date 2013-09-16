//::///////////////////////////////////////////////
//:: Tailoring - If Left Hand Item is Shield
//:: tlr_ifleftshield.nss
//:: Copyright (c) 2006 Stacy L. Ropella
//:://////////////////////////////////////////////
/*
    Checks to make sure there is a shield
    equipped in the PC's left hand slot
*/
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: Created On: January 29, 2006
//:://////////////////////////////////////////////

int StartingConditional()
{
    if(GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,GetPCSpeaker()))==BASE_ITEM_SMALLSHIELD
        || GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,GetPCSpeaker()))==BASE_ITEM_LARGESHIELD
        ||GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,GetPCSpeaker()))==BASE_ITEM_TOWERSHIELD)
        return TRUE;
    else
        return FALSE;
}
