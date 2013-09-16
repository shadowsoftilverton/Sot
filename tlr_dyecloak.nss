//::///////////////////////////////////////////////
//:: Tailoring - Dye Item
//:: tlr_dyeitem.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*
    Dye the item.
*/
//:://////////////////////////////////////////////
//:: Created By: Jake E. Fitch (Milambus Mandragon)
//:: Created On: March 8, 2004
//:://////////////////////////////////////////////
void main()
{
    object oPC = OBJECT_SELF;

    int iMaterialToDye = GetLocalInt(oPC, "MaterialToDye");
    int iColorGroup = GetLocalInt(oPC, "ColorGroup");
    int iColorToDye = GetLocalInt(oPC, "ColorToDye");

    int iColor = (iColorGroup * 8) + iColorToDye;
    object oItem = GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC);

    if (GetIsObjectValid(oItem)) {
        // Dye the item
        object oDyedItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_COLOR, iMaterialToDye, iColor, TRUE);
        DestroyObject(oItem);

        // Equip the armor
       DelayCommand(0.5f, AssignCommand(oPC, ActionEquipItem(oDyedItem, INVENTORY_SLOT_CLOAK)));
    }
}
