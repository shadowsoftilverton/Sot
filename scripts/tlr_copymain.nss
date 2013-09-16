//::///////////////////////////////////////////////
//:: Tailoring - Copy Main Weapon
//:: tlr_copymain.nss
//::
//:://////////////////////////////////////////////
/*
    Copy the model's weapon appearance to the
    PC's weapon
*/
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: from Mandragon's mil_tailor
//:://////////////////////////////////////////////

object oPC = GetPCSpeaker();

object CopyItemAppearance(object oSourceWeap, object oTarget);

void main()
{
    object oNPCItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, OBJECT_SELF);
    object oPCItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);

    //int iCost = FloatToInt(IntToFloat(GetGoldPieceValue(oPCItem)) * 0.2f);
    //int iCost = GetGoldPieceValue(oNPCItem) + FloatToInt(IntToFloat(GetGoldPieceValue(oPCItem)) * 0.2f);
    /*int iCost = GetLocalInt(OBJECT_SELF, "CURRENTPRICE");
    if (GetGold(oPC) < iCost)
    {
        SendMessageToPC(oPC, "This weapon costs " + IntToString(iCost) + " gold to copy!");
        return;
    }


    TakeGoldFromCreature(iCost, oPC, TRUE);*/

    // Copy the appearance
    object oNew = CopyItemAppearance(oNPCItem, oPCItem);
    SetLocalInt(oNew, "mil_EditingItem", TRUE);

    // Copy the item back to the PC
    object oOnPC = CopyItem(oNew, oPC, TRUE);
    DestroyObject(oNew);

    // Equip the item
    DelayCommand(0.5f, AssignCommand(oPC, ActionEquipItem(oOnPC, INVENTORY_SLOT_RIGHTHAND)));

    // Set item editable again
    DelayCommand(3.0f, DeleteLocalInt(oOnPC, "mil_EditingItem"));
}

object CopyItemAppearance(object oSourceWeap, object oCurrent)
{

    int iSourceWeapValue;
    object oNew;

////// Copy To Item
    oNew = CopyItem(oCurrent, GetPCSpeaker(), TRUE);
    DestroyObject(oCurrent);

////// Copy Colors
    // Top
    iSourceWeapValue = GetItemAppearance(oSourceWeap, ITEM_APPR_TYPE_WEAPON_COLOR, ITEM_APPR_WEAPON_COLOR_TOP);
    oCurrent = oNew;
    oNew = CopyItemAndModify(oCurrent, ITEM_APPR_TYPE_WEAPON_COLOR, ITEM_APPR_WEAPON_COLOR_TOP, iSourceWeapValue, TRUE);
    DestroyObject(oCurrent);

    // Middle
    iSourceWeapValue = GetItemAppearance(oSourceWeap, ITEM_APPR_TYPE_WEAPON_COLOR, ITEM_APPR_WEAPON_COLOR_MIDDLE);
    oCurrent = oNew;
    oNew = CopyItemAndModify(oCurrent, ITEM_APPR_TYPE_WEAPON_COLOR, ITEM_APPR_WEAPON_COLOR_MIDDLE, iSourceWeapValue, TRUE);
    DestroyObject(oCurrent);

    // Bottom
    iSourceWeapValue = GetItemAppearance(oSourceWeap, ITEM_APPR_TYPE_WEAPON_COLOR, ITEM_APPR_WEAPON_COLOR_BOTTOM);
    oCurrent = oNew;
    oNew = CopyItemAndModify(oCurrent, ITEM_APPR_TYPE_WEAPON_COLOR, ITEM_APPR_WEAPON_COLOR_BOTTOM, iSourceWeapValue, TRUE);
    DestroyObject(oCurrent);

////// Copy Design
    // Top
    iSourceWeapValue = GetItemAppearance(oSourceWeap, ITEM_APPR_TYPE_WEAPON_MODEL, ITEM_APPR_WEAPON_MODEL_TOP);
    oCurrent = oNew;
    oNew = CopyItemAndModify(oCurrent, ITEM_APPR_TYPE_WEAPON_MODEL, ITEM_APPR_WEAPON_MODEL_TOP, iSourceWeapValue, TRUE);
    DestroyObject(oCurrent);

    // Middle
    iSourceWeapValue = GetItemAppearance(oSourceWeap, ITEM_APPR_TYPE_WEAPON_MODEL, ITEM_APPR_WEAPON_MODEL_MIDDLE);
    oCurrent = oNew;
    oNew = CopyItemAndModify(oCurrent, ITEM_APPR_TYPE_WEAPON_MODEL, ITEM_APPR_WEAPON_MODEL_MIDDLE, iSourceWeapValue, TRUE);
    DestroyObject(oCurrent);

    // Bottom
    iSourceWeapValue = GetItemAppearance(oSourceWeap, ITEM_APPR_TYPE_WEAPON_MODEL, ITEM_APPR_WEAPON_MODEL_BOTTOM);
    oCurrent = oNew;
    oNew = CopyItemAndModify(oCurrent, ITEM_APPR_TYPE_WEAPON_MODEL, ITEM_APPR_WEAPON_MODEL_BOTTOM, iSourceWeapValue, TRUE);
    DestroyObject(oCurrent);

    return oNew;
}
