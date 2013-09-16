//::///////////////////////////////////////////////
//:: Tailoring - Increase Item
//:: tlr_increaseitem.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Jake E. Fitch (Milambus Mandragon)
//:: Created On: March 8, 2004
//:://////////////////////////////////////////////

// Get a Cached 2DA string, and if its not cached read it from the 2DA file and cache it.
string GetCachedACBonus(string sFile, int iRow);

void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, OBJECT_SELF);

    int iToModify = GetLocalInt(OBJECT_SELF, "ToModify");
    string s2DAFile = GetLocalString(OBJECT_SELF, "2DAFile");
    //SendMessageToPC(oPC,"s2DAFile: " + s2DAFile);

    int iOpposite;

    switch(iToModify){
        case ITEM_APPR_ARMOR_MODEL_LBICEP: iOpposite = ITEM_APPR_ARMOR_MODEL_RBICEP; break;
        case ITEM_APPR_ARMOR_MODEL_RBICEP: iOpposite = ITEM_APPR_ARMOR_MODEL_LBICEP; break;

        case ITEM_APPR_ARMOR_MODEL_LFOOT: iOpposite = ITEM_APPR_ARMOR_MODEL_RFOOT; break;
        case ITEM_APPR_ARMOR_MODEL_RFOOT: iOpposite = ITEM_APPR_ARMOR_MODEL_LFOOT; break;

        case ITEM_APPR_ARMOR_MODEL_LFOREARM: iOpposite = ITEM_APPR_ARMOR_MODEL_RFOREARM; break;
        case ITEM_APPR_ARMOR_MODEL_RFOREARM: iOpposite = ITEM_APPR_ARMOR_MODEL_LFOREARM; break;

        case ITEM_APPR_ARMOR_MODEL_LHAND: iOpposite = ITEM_APPR_ARMOR_MODEL_RHAND; break;
        case ITEM_APPR_ARMOR_MODEL_RHAND: iOpposite = ITEM_APPR_ARMOR_MODEL_LHAND; break;

        case ITEM_APPR_ARMOR_MODEL_LSHIN: iOpposite = ITEM_APPR_ARMOR_MODEL_RSHIN; break;
        case ITEM_APPR_ARMOR_MODEL_RSHIN: iOpposite = ITEM_APPR_ARMOR_MODEL_LSHIN; break;

        case ITEM_APPR_ARMOR_MODEL_LSHOULDER: iOpposite = ITEM_APPR_ARMOR_MODEL_RSHOULDER; break;
        case ITEM_APPR_ARMOR_MODEL_RSHOULDER: iOpposite = ITEM_APPR_ARMOR_MODEL_LSHOULDER; break;

        case ITEM_APPR_ARMOR_MODEL_LTHIGH: iOpposite = ITEM_APPR_ARMOR_MODEL_RTHIGH; break;
        case ITEM_APPR_ARMOR_MODEL_RTHIGH: iOpposite = ITEM_APPR_ARMOR_MODEL_LTHIGH; break;
    }

    int iNewApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, iToModify);

    object oNewItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, iOpposite, iNewApp, TRUE);

    DestroyObject(oItem);
    SendMessageToPC(oPC, "New Appearance: " + IntToString(iNewApp));

    AssignCommand(OBJECT_SELF, ActionEquipItem(oNewItem, INVENTORY_SLOT_CHEST));
}

