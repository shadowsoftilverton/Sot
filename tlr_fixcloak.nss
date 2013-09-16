//Created by 420 for the CEP
//Reequip cloak to fix graphic bug
void main()
{
object oCloak = GetItemInSlot(INVENTORY_SLOT_CLOAK, OBJECT_SELF);
AssignCommand(OBJECT_SELF, ActionUnequipItem(oCloak));
DelayCommand(2.0, AssignCommand(OBJECT_SELF, ActionEquipItem(oCloak, INVENTORY_SLOT_CLOAK)));
}
