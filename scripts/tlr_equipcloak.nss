//Created by 420 for the CEP
//Equip Cloak
//Based on script tlr_equiphelm.nss by Stacy L. Ropella
void main()
{
object oModel = OBJECT_SELF;
if (GetItemPossessedBy(oModel, "mil_cloak") == OBJECT_INVALID)
   {
      CreateItemOnObject("mil_cloak", oModel, 1);
      object oCloak = (GetItemPossessedBy(oModel, "mil_cloak"));
      DelayCommand(0.5f, AssignCommand(OBJECT_SELF, ActionEquipItem(oCloak, INVENTORY_SLOT_CLOAK)));

   }
else
   {
       object oCloak = (GetItemPossessedBy(oModel, "mil_cloak"));
       DelayCommand(0.5f, AssignCommand(OBJECT_SELF, ActionEquipItem(oCloak, INVENTORY_SLOT_CLOAK)));
   }

}
