//::///////////////////////////////////////////////
//:: Tailoring - Set Model to Default Appearance
//:: tlr_default.nss
//:: Copyright (c) 2006 Stacy L. Ropella
//:://////////////////////////////////////////////
/*
    Sets model's clothes to default and destroys
    any equipped weapons, along with anything in
    model's inventory
*/
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: Created On: January 29, 2006
//:://////////////////////////////////////////////

void main()
{
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, OBJECT_SELF), 0.0);
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, OBJECT_SELF), 0.0);
    ExecuteScript("tlr_reset", OBJECT_SELF);
}
