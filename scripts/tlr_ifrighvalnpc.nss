//::///////////////////////////////////////////////
//:: Tailoring - If Right Hand Item is Valid on NPC
//:: tlr_ifrighvalnpc.nss
//:: Copyright (c) 2006 Stacy L. Ropella
//:://////////////////////////////////////////////
/*
    Checks to make sure there is a valid item
    equipped in the NPC's right hand slot
*/
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: Created On: February 20, 2006
//:://////////////////////////////////////////////
int StartingConditional()
{
    if (GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, OBJECT_SELF)))
        return TRUE;
    else
        return FALSE;
}
