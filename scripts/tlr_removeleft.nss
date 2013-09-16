//::///////////////////////////////////////////////
//:: Tailoring - Remove Offhand Item
//:: tlr_removeleft.nss
//:: Copyright (c) 2006 Stacy L. Ropella
//:://////////////////////////////////////////////
/*
    Removes (destroys) the NPC's offhand item
*/
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: Created On: January 29, 2006
//:://////////////////////////////////////////////

void main()
{
    object oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, OBJECT_SELF);
    DestroyObject(oItem);
}

