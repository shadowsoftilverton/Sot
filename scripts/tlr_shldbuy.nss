//::///////////////////////////////////////////////
//:: Tailoring - Check for Valid Shield on NPC
//:: Also check to see if shield buying is allowed
//:: tlr_shldbuy.nss
//:://////////////////////////////////////////////
/*
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: from Mandragon's mil_tailor
//:://////////////////////////////////////////////
*/
int StartingConditional()
{
    return GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, OBJECT_SELF));
}
