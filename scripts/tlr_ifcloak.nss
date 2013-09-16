//Created by 420 for the CEP
//Check for a valid cloak in conversation
//Based on script tlr_color0.nss by Stacy L. Ropella
int StartingConditional()
{
    if (GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CLOAK, GetPCSpeaker())))
        return TRUE;
    else
        return FALSE;
}
