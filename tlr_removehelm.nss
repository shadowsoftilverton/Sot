//::///////////////////////////////////////////////
//:: Tailoring - Remove Helm
//:: tlr_removehelm.nss
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: from Mandragon's mil_tailor
//:://////////////////////////////////////////////

void main()
{
    object oHelm = GetItemInSlot(INVENTORY_SLOT_HEAD, OBJECT_SELF);
    DelayCommand(0.5f, AssignCommand(OBJECT_SELF, ActionUnequipItem(oHelm)));
}

