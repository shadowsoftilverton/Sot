//Created by 420 for the CEP
//Next cloak model
//Based on script tlr_increasehelm.nss by Stacy L. Ropella

#include "tlr_items_inc"

void main()
{
    object oModel = OBJECT_SELF;
    object oCloak = GetItemInSlot(INVENTORY_SLOT_CLOAK, oModel);
    RemakeCloak(oModel, oCloak, PART_NEXT);
}
