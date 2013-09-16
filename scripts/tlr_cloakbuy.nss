//Created by 420 for the CEP
//Check for cloak and local int
//Based on script tlr_clothbuy.nss by Stacy L. Ropella
int StartingConditional()
{
    return GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CLOAK, OBJECT_SELF));
}
