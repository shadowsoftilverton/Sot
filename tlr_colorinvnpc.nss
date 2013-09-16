//::///////////////////////////////////////////////
//:: Tailoring - Color Invalid NPC Weapon
//:: tlr_colorinvnpc.nss
//:: Copyright (c) 2006 Stacy L. Ropella
//:://////////////////////////////////////////////
/*
    Tests for invalid colors on weapon parts
*/
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: Created On: February 20, 2006
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iTop = GetItemAppearance(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, OBJECT_SELF), ITEM_APPR_TYPE_WEAPON_COLOR, ITEM_APPR_WEAPON_COLOR_TOP);
    int iMiddle = GetItemAppearance(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, OBJECT_SELF), ITEM_APPR_TYPE_WEAPON_COLOR, ITEM_APPR_WEAPON_COLOR_MIDDLE);
    int iBottom  = GetItemAppearance(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, OBJECT_SELF), ITEM_APPR_TYPE_WEAPON_COLOR, ITEM_APPR_WEAPON_COLOR_BOTTOM);
    string sOne;
    string sTwo;
    string sThree;

    if (iTop > 4)
        sOne = " <Top> ";
    if (iMiddle > 4)
        sTwo = " <Middle> ";
    if (iBottom > 4)
        sThree = " <Bottom> ";
    SetCustomToken(9879, sOne+sTwo+sThree);

    if (iTop > 4 || iMiddle > 4 || iBottom > 4)
        return TRUE;
    else
        return FALSE;

}
