//::///////////////////////////////////////////////
//:: Tailoring - Increase Helm
//:: tlr_increasehelm.nss
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: from Mandragon's mil_tailor
//:://////////////////////////////////////////////

#include "tlr_items_inc"

void main()
{
    object oModel = OBJECT_SELF;
    object oHelmet = GetItemInSlot(INVENTORY_SLOT_HEAD, oModel);
    RemakeHelm(oModel, oHelmet, PART_NEXT);
}
