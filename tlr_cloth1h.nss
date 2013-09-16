//::///////////////////////////////////////////////
//:: Tailoring - Dye Cloth 1
//:: tlr_cloth1h.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*
    Set the material to be died to Leather 1.
*/
//:://////////////////////////////////////////////
//:: Created By: Jake E. Fitch (Milambus Mandragon)
//:: Created On: March 8, 2004
//:://////////////////////////////////////////////

#include "tlr_include"

void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_HEAD, OBJECT_SELF);
    int iMaterialToDye = ITEM_APPR_ARMOR_COLOR_CLOTH1;

    SetLocalInt(OBJECT_SELF, "MaterialToDye", iMaterialToDye);

    int iColor = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_COLOR, iMaterialToDye);

    SendMessageToPC(oPC, "Current Color: " + ClothColor(iColor));
}
