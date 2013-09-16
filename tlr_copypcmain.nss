#include "engine"

//::///////////////////////////////////////////////
//:: Tailoring - Copy Main Weapon
//:: tlr_copypcmain.nss
//:: Copyright (c) 2006 Stacy L. Ropella
//:://////////////////////////////////////////////
/*
    Copy the PC's main weapon to model
*/
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: Created On: January 29, 2006
//:://////////////////////////////////////////////

object CopyItemAppearance(object oSourceWeap, object oTarget);

void main()
{
    object oNPC = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oNPC);
    object oPCItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);

    //Destroy anything the NPC may have in its right hand slot
    if(GetIsObjectValid(oWeapon))
        DestroyObject(oWeapon);

    //Create the PC's weapon on the NPC
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

    int iTop = GetItemAppearance(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, GetPCSpeaker()), ITEM_APPR_TYPE_WEAPON_COLOR, ITEM_APPR_WEAPON_COLOR_TOP);
    int iMiddle = GetItemAppearance(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, GetPCSpeaker()), ITEM_APPR_TYPE_WEAPON_COLOR, ITEM_APPR_WEAPON_COLOR_MIDDLE);
    int iBottom  = GetItemAppearance(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, GetPCSpeaker()), ITEM_APPR_TYPE_WEAPON_COLOR, ITEM_APPR_WEAPON_COLOR_BOTTOM);

    //Copy the appearance
    object oNew = CopyItemAppearance(oPCItem, oNPCItem);
    SetLocalInt(oNew, "mil_EditingItem", TRUE);

    //Copy the item back to the NPC
    object oOnNPC = CopyItem(oNew, oNPC, TRUE);
    DestroyObject(oNew);

    //Equip the item
       DelayCommand(0.5f, AssignCommand(oNPC, ActionEquipItem(oOnNPC, INVENTORY_SLOT_RIGHTHAND)));

    //Set item editable again
    DelayCommand(3.0f, DeleteLocalInt(oOnNPC, "mil_EditingItem"));
}

object CopyItemAppearance(object oSourceWeap, object oCurrent)
{
    int iSourceWeapValue;
    object oNew;

////// Copy To Item
    oNew = CopyItem(oCurrent, OBJECT_SELF, TRUE);
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
