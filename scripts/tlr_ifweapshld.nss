//::///////////////////////////////////////////////
//:: Tailoring - If Either Hand Item is Valid and
//::        weapon or shield modifying is allowed
//:: tlr_ifweapshld.nss
//:: Copyright (c) 2006 Stacy L. Ropella
//:://////////////////////////////////////////////
/*
    Checks to make sure there is a valid item
    equipped in at least one of the PC's hand slots
    and weapon or shield modifying is allowed
*/
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: Created On: January 29, 2006
//:://////////////////////////////////////////////
int StartingConditional()
{
    if (GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, GetPCSpeaker())))
        return TRUE;
    else if (GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, GetPCSpeaker())))
        return TRUE;
    else
        return FALSE;
}
