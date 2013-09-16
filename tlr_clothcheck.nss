//::///////////////////////////////////////////////
//:: Tailoring - Check for Valid Clothing on PC & Model
//:: Also check to see if clothing copying is allowed
//:: tlr_clothcheck.nss
//:://////////////////////////////////////////////
/*
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: from Mandragon's mil_tailor
//:://////////////////////////////////////////////
*/
int StartingConditional()
{
    object oPC = GetPCSpeaker();

    return GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CHEST, oPC));
}
