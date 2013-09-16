//Created by 420 for the CEP
//Remove Cloak
//Based on script tlr_removehelm.nss by Stacy L. Ropella
void main()
{
    object oCloak = GetItemInSlot(INVENTORY_SLOT_CLOAK, OBJECT_SELF);
    DelayCommand(0.5f, AssignCommand(OBJECT_SELF, ActionUnequipItem(oCloak)));
}

