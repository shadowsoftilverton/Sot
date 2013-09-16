//Created by 420 for the CEP
//Check for Invalid Cloak on NPC
//Based on script tlr_helminvalnpc.nss by Stacy L. Ropella
int StartingConditional()
{
    object oModel = OBJECT_SELF;

    if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CLOAK, oModel)))
    return FALSE;

 return TRUE;
}
