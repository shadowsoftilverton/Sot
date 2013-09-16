//::///////////////////////////////////////////////
//:: Tailoring - Display Current Index
//:: tlr_displayindex.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Jake E. Fitch (Milambus Mandragon)
//:: Created On: March 9, 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, OBJECT_SELF);
    int iToModify = GetLocalInt(OBJECT_SELF, "ToModify");
    int iValue = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, iToModify);

    SetCustomToken(9876, IntToString(iValue));

    return TRUE;
}
