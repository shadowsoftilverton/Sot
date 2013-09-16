//::///////////////////////////////////////////////
//:: Tailor - Copy NPC Helmet TO PC
//:: tlr_copynpchelm.nss
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: from Mandragon's mil_tailor
//:://////////////////////////////////////////////

object oPC = GetPCSpeaker();

object CopyItemAppearance(object oSourceHelm, object oTarget);

void main()
{
    object oNPCItem = GetItemInSlot(INVENTORY_SLOT_HEAD, OBJECT_SELF);
    object oPCItem = GetItemInSlot(INVENTORY_SLOT_HEAD, oPC);

    //int iCost = GetGoldPieceValue(oNPCItem) + FloatToInt(IntToFloat(GetGoldPieceValue(oPCItem)) * 0.2f);
    /*int iCost = GetLocalInt(OBJECT_SELF, "CURRENTPRICE");

    if (GetGold(oPC) < iCost) {
        SendMessageToPC(oPC, "This outfit costs" + IntToString(iCost) + " gold to copy!");
        return;
    }


    TakeGoldFromCreature(iCost, oPC, TRUE);   */

    // Copy the appearance
    object oNew = CopyItemAppearance(oNPCItem, oPCItem);
    SetLocalInt(oNew, "mil_EditingItem", TRUE);

    // Copy the helmet back to the PC
    object oOnPC = CopyItem(oNew, oPC, TRUE);
    DestroyObject(oNew);

    // Equip the helmet
    DelayCommand(0.5f, AssignCommand(oPC, ActionEquipItem(oOnPC, INVENTORY_SLOT_HEAD)));

    // Set helmet editable again
    DelayCommand(3.0f, DeleteLocalInt(oOnPC, "mil_EditingItem"));
}

object CopyItemAppearance(object oSourceHelm, object oTarget) {
    object oHead = GetObjectByTag("ClothingBuilder");

    int iSourceHelmValue;
    object oCurrent, oNew;

////// Copy To Helmet
    oCurrent = oTarget;
    oNew = CopyItem(oCurrent, oHead, TRUE);
    DestroyObject(oCurrent);

////// Copy Colors
    // Cloth 1
    iSourceHelmValue = GetItemAppearance(oSourceHelm, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_CLOTH1);
    oCurrent = oNew;
    oNew = CopyItemAndModify(oCurrent, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_CLOTH1, iSourceHelmValue, TRUE);
    DestroyObject(oCurrent);

    // Cloth 2
    iSourceHelmValue = GetItemAppearance(oSourceHelm, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_CLOTH2);
    oCurrent = oNew;
    oNew = CopyItemAndModify(oCurrent, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_CLOTH2, iSourceHelmValue, TRUE);
    DestroyObject(oCurrent);

    // Leather 1
    iSourceHelmValue = GetItemAppearance(oSourceHelm, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_LEATHER1);
    oCurrent = oNew;
    oNew = CopyItemAndModify(oCurrent, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_LEATHER1, iSourceHelmValue, TRUE);
    DestroyObject(oCurrent);

    // Leather 2
    iSourceHelmValue = GetItemAppearance(oSourceHelm, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_LEATHER2);
    oCurrent = oNew;
    oNew = CopyItemAndModify(oCurrent, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_LEATHER2, iSourceHelmValue, TRUE);
    DestroyObject(oCurrent);

    // Metal 1
    iSourceHelmValue = GetItemAppearance(oSourceHelm, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_METAL1);
    oCurrent = oNew;
    oNew = CopyItemAndModify(oCurrent, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_METAL1, iSourceHelmValue, TRUE);
    DestroyObject(oCurrent);

    // Metal 2
    iSourceHelmValue = GetItemAppearance(oSourceHelm, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_METAL2);
    oCurrent = oNew;
    oNew = CopyItemAndModify(oCurrent, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_METAL2, iSourceHelmValue, TRUE);
    DestroyObject(oCurrent);


////// Copy Design
    // Helmet
    iSourceHelmValue = GetItemAppearance(oSourceHelm, ITEM_APPR_TYPE_ARMOR_MODEL, 0);
    oCurrent = oNew;
    oNew = CopyItemAndModify(oCurrent, ITEM_APPR_TYPE_ARMOR_MODEL, 0, iSourceHelmValue, TRUE);
    DestroyObject(oCurrent);

    return oNew;
}
