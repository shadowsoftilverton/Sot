//::///////////////////////////////////////////////
//:: Tailoring - Increase Torso
//:: tlr_increasetors.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Jake E. Fitch (Milambus Mandragon)
//:: Created On: March 9, 2004
//-- bloodsong meddling and adding restriction values
//:://////////////////////////////////////////////
#include "tlr_include"

// Get a Cached 2DA string, and if its not cached read it from the 2DA file and cache it.
string GetCachedACBonus(string sFile, int iRow);

void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, OBJECT_SELF);

    int iToModify = GetLocalInt(OBJECT_SELF, "ToModify");
    string s2DAFile = GetLocalString(OBJECT_SELF, "2DAFile");
    int iFilter = GetLocalInt(OBJECT_SELF, "TorsoFilter");

    int iNewApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, iToModify)+1;

    string s2DA_ACBonus = GetCachedACBonus(s2DAFile, iNewApp);
    //SendMessageToPC(oPC,"s2DA_ACBonus: " + s2DA_ACBonus);

//-- restriction list section vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

    int nGender = GetGender(OBJECT_SELF);

    while (StringToInt(s2DA_ACBonus) != iFilter ||
           TorsoIsInvalid(iNewApp, nGender)) //--END Restrictions ^^^^^^^
    {
        if (s2DA_ACBonus == "-2")
        {
            iNewApp = 1;
        }
        else
        {
            iNewApp++;
        }

        s2DA_ACBonus = GetCachedACBonus(s2DAFile, iNewApp);
        //SendMessageToPC(oPC,"s2DA_ACBonus: " + s2DA_ACBonus);
    }



    object oNewItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, iToModify, iNewApp, TRUE);

    DestroyObject(oItem);
    SendMessageToPC(oPC, "New Appearance: " + IntToString(iNewApp));

    AssignCommand(OBJECT_SELF, ActionEquipItem(oNewItem, INVENTORY_SLOT_CHEST));
}

string GetCachedACBonus(string sFile, int iRow) {
    string sACBonus = GetLocalString(GetModule(), sFile + IntToString(iRow));

    if (sACBonus == "") {
    sACBonus = Get2DAString(sFile, "ACBONUS", iRow);

        if (sACBonus == "") {
            sACBonus = "-1";

            string sCost = Get2DAString(sFile, "COSTMODIFIER", iRow);
            if (sCost == "" ){
            sACBonus = "-2";
            }
        }

        SetLocalString(GetModule(), sFile + IntToString(iRow), sACBonus);
    }

    return sACBonus;
}
