//::///////////////////////////////////////////////
//:: Tailoring - Check for Valid Helmet on NPC
//:: Also check to see if helm buying is allowed
//:: tlr_helmbuy.nss
//:://////////////////////////////////////////////
/*
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: from Mandragon's mil_tailor
//:://////////////////////////////////////////////
*/
int StartingConditional()
{
    return GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_HEAD, OBJECT_SELF));
}
