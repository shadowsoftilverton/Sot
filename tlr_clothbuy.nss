//::///////////////////////////////////////////////
//:: Tailoring - Check for Valid Clothing on Model
//:: Also check to see if clothing buying is allowed
//:: tlr_clothbuy.nss
//:://////////////////////////////////////////////
/*
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: from Mandragon's mil_tailor
//:://////////////////////////////////////////////
*/

int StartingConditional()
{
    return GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CHEST, OBJECT_SELF));
}
