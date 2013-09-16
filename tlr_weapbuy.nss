//::///////////////////////////////////////////////
//:: Tailoring - Check for Valid Weapon on NPC
//:: Also check to see if weapon buying is allowed
//:: tlr_weapbuy.nss
//:://////////////////////////////////////////////
/*
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: from Mandragon's mil_tailor
//:://////////////////////////////////////////////
*/
int StartingConditional()
{
    return GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, OBJECT_SELF));
}
