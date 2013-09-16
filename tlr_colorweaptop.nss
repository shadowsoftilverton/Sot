//::///////////////////////////////////////////////
//:: Tailoring - Color Weapon Top
//:: tlr_colorweaptop.nss
//:: Copyright (c) 2006 Stacy L. Ropella
//:://////////////////////////////////////////////
/*
    Changes the color on an equipped weapon
*/
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: Created On: January 29, 2006
//:://////////////////////////////////////////////

#include "tlr_items_inc"

void main()
{
    object oNPC = OBJECT_SELF;
    object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oNPC);
    ColorItem(oNPC, oItem, ITEM_APPR_WEAPON_MODEL_TOP, COLOR_NEXT);
}
