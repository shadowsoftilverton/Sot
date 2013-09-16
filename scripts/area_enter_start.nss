void main()
{
    object oPC = GetEnteringObject();

    if(!GetIsPC(oPC) || GetIsDM(oPC) || GetIsDMPossessed(oPC))
    {
        return;
    }

    if(GetHitDice(oPC) == 1)
    {
        object oItem = GetFirstItemInInventory(oPC);
        object oClothes = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);

        DestroyObject(oClothes);

        while(GetIsObjectValid(oItem))
        {
            DestroyObject(oItem);

            oItem = GetNextItemInInventory(oPC);
        }
    }
}
