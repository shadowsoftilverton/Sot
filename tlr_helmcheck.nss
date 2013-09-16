//::///////////////////////////////////////////////
//:: Tailoring - Check for Valid Helmet on PC & Model
//:: Also check to see if helm copying is allowed
//:: tlr_helmcheck.nss
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

    if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_HEAD, oPC))
        && GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_HEAD, OBJECT_SELF)))
    return TRUE;

 return FALSE;
}
