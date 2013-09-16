//Created by 420 for the CEP
//Set Leather 2 color for cloak
//Based on script tlr_leather2.nss by Jake E. Fitch

#include "tlr_include"

void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_CLOAK, OBJECT_SELF);
    int iMaterialToDye = ITEM_APPR_ARMOR_COLOR_LEATHER2;

    SetLocalInt(OBJECT_SELF, "MaterialToDye", iMaterialToDye);

    int iColor = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_COLOR, iMaterialToDye);

    SendMessageToPC(oPC, "Current Color: " + ClothColor(iColor));
}
