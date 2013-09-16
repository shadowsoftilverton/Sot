//::///////////////////////////////////////////////
//:: Tailoring - Decrement Shield
//:: tlr_decrshield.nss
//:: Copyright (c) 2006 Stacy L. Ropella
//:://////////////////////////////////////////////
/*
    Decrements appearances for an equipped shield
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
    RemakeShield(oNPC, oItem, PART_PREV);
}
