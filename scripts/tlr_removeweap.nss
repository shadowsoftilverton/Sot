//::///////////////////////////////////////////////
//:: Tailoring - Remove Main Weapon
//:: tlr_removeweap.nss
//:: Copyright (c) 2006 Stacy L. Ropella
//:://////////////////////////////////////////////
/*
    Removes (destroys) the NPC's right-hand weapon
*/
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: Created On: January 29, 2006
//:://////////////////////////////////////////////

void main()
{
    object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, OBJECT_SELF);
    DestroyObject(oItem);
}

