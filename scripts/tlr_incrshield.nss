//::///////////////////////////////////////////////
//:: Tailoring - Increment Shield
//:: tlr_incrshield.nss
//:: Copyright (c) 2006 Stacy L. Ropella
//:://////////////////////////////////////////////
/*
    Increments appearances for an equipped shield
*/
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: Created On: January 28, 2006
//:://////////////////////////////////////////////

#include "tlr_items_inc"

void main()
{
    object oNPC = OBJECT_SELF;
    object oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oNPC);
    RemakeShield(oNPC, oItem, PART_NEXT);
}
