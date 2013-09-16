//Created by 420 for the CEP
//Copy NPC cloak to PC cloak
//Based on script tlr_copynpchelm.nss by Stacy L. Ropella
object oPC = GetPCSpeaker();

object CopyItemAppearance(object oSource, object oTarget);
int CompareAC(object oFirst, object oSecond);

// Get a Cached 2DA string.  If its not cached read it from the 2DA file and cache it.
string GetCachedACBonus(string sFile, int iRow);

void main()
{
    object oNPCItem = GetItemInSlot(INVENTORY_SLOT_CLOAK, OBJECT_SELF);
    object oPCItem = GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC);

    //int iCost = GetGoldPieceValue(oNPCItem) + FloatToInt(IntToFloat(GetGoldPieceValue(oPCItem)) * 0.2f);
    /*int iCost = GetLocalInt(OBJECT_SELF, "CURRENTPRICE");

    if (GetGold(oPC) < iCost) {
        SendMessageToPC(oPC, "This outfit costs" + IntToString(iCost) + " gold to copy!");
        return;
    }

    TakeGoldFromCreature(iCost, oPC, TRUE);*/

    // Copy the appearance
    object oNew = CopyItemAppearance(oNPCItem, oPCItem);
    SetLocalInt(oNew, "mil_EditingItem", TRUE);

    // Copy the cloak back to the PC
    object oOnPC = CopyItem(oNew, oPC, TRUE);
    DestroyObject(oNew);

    // Equip the cloak
    DelayCommand(0.5f, AssignCommand(oPC, ActionEquipItem(oOnPC, INVENTORY_SLOT_CLOAK)));

    // Set cloak editable again
    DelayCommand(3.0f, DeleteLocalInt(oOnPC, "mil_EditingItem"));
}

object CopyItemAppearance(object oSource, object oTarget) {
    object oChest = GetObjectByTag("ClothingBuilder");

    int iSourceValue;
    object oCurrent, oNew;

////// Copy To Chest
    oCurrent = oTarget;
    oNew = CopyItem(oCurrent, oChest, TRUE);
    DestroyObject(oCurrent);

////// Copy Colors
    // Cloth 1
    iSourceValue = GetItemAppearance(oSource, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_CLOTH1);
    oCurrent = oNew;
    oNew = CopyItemAndModify(oCurrent, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_CLOTH1, iSourceValue, TRUE);
    DestroyObject(oCurrent);

    // Cloth 2
    iSourceValue = GetItemAppearance(oSource, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_CLOTH2);
    oCurrent = oNew;
    oNew = CopyItemAndModify(oCurrent, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_CLOTH2, iSourceValue, TRUE);
    DestroyObject(oCurrent);

    // Leather 1
    iSourceValue = GetItemAppearance(oSource, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_LEATHER1);
    oCurrent = oNew;
    oNew = CopyItemAndModify(oCurrent, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_LEATHER1, iSourceValue, TRUE);
    DestroyObject(oCurrent);

    // Leather 2
    iSourceValue = GetItemAppearance(oSource, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_LEATHER2);
    oCurrent = oNew;
    oNew = CopyItemAndModify(oCurrent, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_LEATHER2, iSourceValue, TRUE);
    DestroyObject(oCurrent);

    // Metal 1
    iSourceValue = GetItemAppearance(oSource, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_METAL1);
    oCurrent = oNew;
    oNew = CopyItemAndModify(oCurrent, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_METAL1, iSourceValue, TRUE);
    DestroyObject(oCurrent);

    // Metal 2
    iSourceValue = GetItemAppearance(oSource, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_METAL2);
    oCurrent = oNew;
    oNew = CopyItemAndModify(oCurrent, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_METAL2, iSourceValue, TRUE);
    DestroyObject(oCurrent);


////// Copy Design
    iSourceValue = GetItemAppearance(oSource, ITEM_APPR_TYPE_SIMPLE_MODEL, 0);
    oCurrent = oNew;
    oNew = CopyItemAndModify(oCurrent, ITEM_APPR_TYPE_SIMPLE_MODEL, 0, iSourceValue, TRUE);
    DestroyObject(oCurrent);

    return oNew;
}
