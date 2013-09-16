void main()
{
    object oSelf = OBJECT_SELF;

    if(GetHasInventory(oSelf)){
        object oItem = GetFirstItemInInventory(oSelf);

        while(GetIsObjectValid(oItem)){
            ExecuteScript("gen_destroy_self", oItem);

            oItem = GetNextItemInInventory(oSelf);
        }

        oItem = GetItemInSlot(INVENTORY_SLOT_ARMS);
        DestroyObject(oItem);
        oItem = GetItemInSlot(INVENTORY_SLOT_ARROWS);
        DestroyObject(oItem);
        oItem = GetItemInSlot(INVENTORY_SLOT_BELT);
        DestroyObject(oItem);
        oItem = GetItemInSlot(INVENTORY_SLOT_BOLTS);
        DestroyObject(oItem);
        oItem = GetItemInSlot(INVENTORY_SLOT_BOOTS);
        DestroyObject(oItem);
        oItem = GetItemInSlot(INVENTORY_SLOT_BULLETS);
        DestroyObject(oItem);
        oItem = GetItemInSlot(INVENTORY_SLOT_CARMOUR);
        DestroyObject(oItem);
        oItem = GetItemInSlot(INVENTORY_SLOT_CHEST);
        DestroyObject(oItem);
        oItem = GetItemInSlot(INVENTORY_SLOT_CLOAK);
        DestroyObject(oItem);
        oItem = GetItemInSlot(INVENTORY_SLOT_CWEAPON_B);
        DestroyObject(oItem);
        oItem = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L);
        DestroyObject(oItem);
        oItem = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R);
        DestroyObject(oItem);
        oItem = GetItemInSlot(INVENTORY_SLOT_HEAD);
        DestroyObject(oItem);
        oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND);
        DestroyObject(oItem);
        oItem = GetItemInSlot(INVENTORY_SLOT_LEFTRING);
        DestroyObject(oItem);
        oItem = GetItemInSlot(INVENTORY_SLOT_NECK);
        DestroyObject(oItem);
        oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
        DestroyObject(oItem);
        oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTRING);
        DestroyObject(oItem);
        oItem = GetItemInSlot(NUM_INVENTORY_SLOTS);
        DestroyObject(oItem);

        TakeGoldFromCreature(GetGold(oSelf), oSelf, TRUE);
    }

    SetIsDestroyable(TRUE);
    DestroyObject(oSelf);
}
