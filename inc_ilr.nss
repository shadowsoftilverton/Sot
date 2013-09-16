const int ITEM_TIER_INVALID = -1;

int GetTierOfItem(object oItem);
int GetTierMinLevel(int iTier);
int GetTierByLevel(int iLevel);
int GetIsItemEquippableWithILR(object oPC, object oItem);
void DoEquipActionsILR(object oPC, object oItem);
void DoAddILRtoItem(object oItem, int nTier);
void DoAddOwnerLevelToItem(object oItem, object oPC);

int GetTierOfItem(object oItem) {
    return GetLocalInt(oItem, "sys_ilr_tier");
}

int GetTierMinLevel(int iTier) {
    int iTierLevel;

    switch(iTier) {
        case 1: iTierLevel =  1; break;
        case 2: iTierLevel =  5; break;
        case 3: iTierLevel =  9; break;
        case 4: iTierLevel = 13; break;
        case 5: iTierLevel = 17; break;
        case 6: iTierLevel = 21; break;
        case 7: iTierLevel = 27; break;
    }
    if(iTier>7) iTierLevel = 33;

    return iTierLevel;
}

int GetTierByLevel(int iLevel) {
    int iTier;
         if(iLevel > 26) iTier = 7;
    else if(iLevel > 20) iTier = 6;
    else if(iLevel > 16) iTier = 5;
    else if(iLevel > 12) iTier = 4;
    else if(iLevel > 8)  iTier = 3;
    else if(iLevel > 4)  iTier = 2;
    else if(iLevel > 0)  iTier = 1;

    return iTier;
}

int GetIsItemEquippableWithILR(object oPC, object oItem) {
    int iTierLevel = GetTierMinLevel(GetTierOfItem(oItem));
    int iPCLevel = GetHitDice(oPC);

    return(iPCLevel >= iTierLevel);
}

void DoEquipActionsILR(object oPC, object oItem) {
    int iTier = GetTierOfItem(oItem);
    string sName = GetName(oItem);

    if(!iTier) {
        iTier = GetTierByLevel(GetHitDice(oPC));
        SendMessageToPC(oPC, sName + " lacks ILR. Configuring based upon item owner.");
        SetLocalInt(oItem, "sys_ilr_tier", iTier);
    }

    int iLevel = GetTierMinLevel(iTier);

    SendMessageToPC(oPC, sName + " is a tier " + IntToString(iTier) + " item and requires level " + IntToString(iLevel) + " to equip.");

    if(!GetIsItemEquippableWithILR(oPC, oItem)) {
        AssignCommand(oPC, ActionUnequipItem(oItem));
    }
}

void DoAddILRtoItem(object oItem, int nTier) {
    if(nTier > GetTierOfItem(oItem) || GetTierOfItem(oItem) == 0) {
        //SendMessageToAllDMs("Setting sys_ilr_tier to " + IntToString(nTier) + " on " + GetName(oItem) + ".");
        SetLocalInt(oItem, "sys_ilr_tier", nTier);
        //SendMessageToAllDMs("sys_ilr_tier set to " + IntToString(GetLocalInt(oItem, "sys_ilr_tier")) + " on " + GetName(oItem) + ".");
    }

    //SendMessageToAllDMs("DoAddILRtoItem terminating.");
}

void DoAddOwnerLevelToItem(object oItem, object oPC) {
    if(GetLocalInt(oItem, "sys_ilr_tier") == 0) SetLocalInt(oItem, "sys_ilr_tier", GetTierByLevel(GetHitDice(oPC)));
}
