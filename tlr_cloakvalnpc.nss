//Created by 420 for the CEP
//Check for Valid Cloak on NPC
//Based on script tlr_helmvalidnpc.nss by Stacy L. Ropella
int StartingConditional()
{
    object oModel = OBJECT_SELF;

    if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CLOAK, oModel)))
    return TRUE;

 return FALSE;
}
