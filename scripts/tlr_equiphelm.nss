//::///////////////////////////////////////////////
//:: Tailor - Buy Helm
//:: tlr_buyhelm.nss
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: from Mandragon's mil_tailor
//:://////////////////////////////////////////////

void main()
{
object oModel = OBJECT_SELF;
if (GetItemPossessedBy(oModel, "mil_helm") == OBJECT_INVALID)
   {
      object oHelm = CreateItemOnObject("mil_helm", oModel);
      DelayCommand(0.5f, AssignCommand(OBJECT_SELF, ActionEquipItem(oHelm, INVENTORY_SLOT_HEAD)));

   }
else
   {
       object oHelm = (GetItemPossessedBy(oModel, "mil_helm"));
       DelayCommand(0.5f, AssignCommand(OBJECT_SELF, ActionEquipItem(oHelm, INVENTORY_SLOT_HEAD)));
   }

}
