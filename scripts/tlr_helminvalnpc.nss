//::///////////////////////////////////////////////
//:: Tailoring - Check for Invalid Helmet on NPC
//:: tlr_helminvalnpc.nss
//:://////////////////////////////////////////////
/*
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: from Mandragon's mil_tailor
//:://////////////////////////////////////////////
*/
int StartingConditional()
{
    object oModel = OBJECT_SELF;

    if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_HEAD, oModel)))
    return FALSE;

 return TRUE;
}
