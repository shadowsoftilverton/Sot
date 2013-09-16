#include "engine"

//::///////////////////////////////////////////////
//:: Tailoring - Copy Shield
//:: tlr_copypcoff.nss
//:: Copyright (c) 2006 Stacy L. Ropella
//:://////////////////////////////////////////////
/*
    Copy the PC's shield to model
*/
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: Created On: January 29, 2006
//:://////////////////////////////////////////////

object CopyItemAppearance(object oSource, object oTarget);

void main()
{
    object oNPC = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    object oShield = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oNPC);
    object oPCItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);

    //Destroy anything the NPC may have in its right hand slot
    if(GetIsObjectValid(oShield))
        DestroyObject(oShield);

    //Create the PC's shield on the NPC
    object oNPCItem = CreateItemOnObject(GetResRef(oPCItem), oNPC, 1);

    //Remove use-restriction properties from oNPCItem
    itemproperty ipProperty = GetFirstItemProperty(oNPCItem);
    while(GetIsItemPropertyValid(ipProperty))
    {
        if (GetItemPropertyType(ipProperty)==ITEM_PROPERTY_USE_LIMITATION_ALIGNMENT_GROUP
            ||GetItemPropertyType(ipProperty)==ITEM_PROPERTY_USE_LIMITATION_CLASS
            ||GetItemPropertyType(ipProperty)==ITEM_PROPERTY_USE_LIMITATION_RACIAL_TYPE
            ||GetItemPropertyType(ipProperty)==ITEM_PROPERTY_USE_LIMITATION_SPECIFIC_ALIGNMENT
            ||GetItemPropertyType(ipProperty)==ITEM_PROPERTY_USE_LIMITATION_TILESET)
            RemoveItemProperty(oNPCItem, ipProperty);

            ipProperty = GetNextItemProperty(oNPCItem);
    }
    //Copy the appearance
    object oNew = CopyItemAppearance(oPCItem, oNPCItem);
    SetLocalInt(oNew, "mil_EditingItem", TRUE);

    //Copy the item back to the NPC
    object oOnNPC = CopyItem(oNew, oNPC, TRUE);
    DestroyObject(oNew);

    //Equip the item
    DelayCommand(0.5f, AssignCommand(oNPC, ActionEquipItem(oOnNPC, INVENTORY_SLOT_LEFTHAND)));

    //Set item editable again
    DelayCommand(3.0f, DeleteLocalInt(oOnNPC, "mil_EditingItem"));
}

object CopyItemAppearance(object oSource, object oCurrent)
{
    int iSourceValue;
    object oNew;

    //Copy To Item
    oNew = CopyItem(oCurrent, OBJECT_SELF, TRUE);
    DestroyObject(oCurrent);

    //Copy Design
    iSourceValue = GetItemAppearance(oSource, ITEM_APPR_TYPE_SIMPLE_MODEL, 0);
    oCurrent = oNew;
    oNew = CopyItemAndModify(oCurrent, ITEM_APPR_TYPE_SIMPLE_MODEL, 0, iSourceValue, TRUE);
    DestroyObject(oCurrent);

    return oNew;
}
