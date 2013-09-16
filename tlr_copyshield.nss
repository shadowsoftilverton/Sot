//::///////////////////////////////////////////////
//:: Tailoring - Copy Shield
//:: tlr_copyshield.nss
//::
//:://////////////////////////////////////////////
/*
    Copy the model's shield appearance to PC's shield
*/
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: from Mandragon's mil_tailor
//:://////////////////////////////////////////////


object oPC = GetPCSpeaker();

object CopyItemAppearance(object oSourceShield, object oTarget);

void main()
{
    object oNPCItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, OBJECT_SELF);
    object oPCItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);

    //int iCost = FloatToInt(IntToFloat(GetGoldPieceValue(oPCItem)) * 0.2f);
    //int iCost = GetGoldPieceValue(oNPCItem) + FloatToInt(IntToFloat(GetGoldPieceValue(oPCItem)) * 0.2f);
    /*int iCost = GetLocalInt(OBJECT_SELF, "CURRENTPRICE");
    if (GetGold(oPC) < iCost)
    {
        SendMessageToPC(oPC, "This shield costs " + IntToString(iCost) + " gold to copy!");
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
    DelayCommand(0.5f, AssignCommand(oPC, ActionEquipItem(oOnPC, INVENTORY_SLOT_LEFTHAND)));

    // Set item editable again
    DelayCommand(3.0f, DeleteLocalInt(oOnPC, "mil_EditingItem"));
}

object CopyItemAppearance(object oSourceShield, object oCurrent)
{
    int iSourceShieldValue;
    object oNew;

////// Copy To Item

    oNew = CopyItem(oCurrent, GetPCSpeaker(), TRUE);
    DestroyObject(oCurrent);


////// Copy Design
    // Shield
    iSourceShieldValue = GetItemAppearance(oSourceShield, ITEM_APPR_TYPE_SIMPLE_MODEL, 0);
    oCurrent = oNew;
    oNew = CopyItemAndModify(oCurrent, ITEM_APPR_TYPE_SIMPLE_MODEL, 0, iSourceShieldValue, TRUE);
    DestroyObject(oCurrent);

    return oNew;
}
