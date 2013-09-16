//Created by 420 for the CEP
//Determine value of new cloak
//Based on script tlr_buyoutfit.nss by Jake E. Fitch
void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_CLOAK, OBJECT_SELF);

    //-- int iCost = GetGoldPieceValue(oItem) * 2;
    //int iCost = GetLocalInt(OBJECT_SELF, "CURRENTPRICE");
/*
    if (GetGold(oPC) < iCost) {
        SendMessageToPC(oPC, "This outfit costs" + IntToString(iCost) + " gold!");
        return;
    }
*/

    //TakeGoldFromCreature(iCost, oPC, TRUE);

    object oPCCopy = CopyItem(oItem, oPC, TRUE);
    SetName(oPCCopy, GetName(oPC) +"'s Custom Cloak");
}
