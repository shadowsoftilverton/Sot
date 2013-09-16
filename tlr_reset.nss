//::///////////////////////////////////////////////
//::MIL TAILOR: reset
//::                 onconv mil_tailor
//:://////////////////////////////////////////////
/*
   read the blueprint of our clothes
   destroy clothes
   create the standard blueprint and put it on

*/
//:://////////////////////////////////////////////
//:: Created By: bloodsong
//:: Modified By: stacy_19201325
//:: Edited by 420 for CEP to add cloak functionality
//:://////////////////////////////////////////////

void main()
{
    object oNext = GetFirstItemInInventory(OBJECT_SELF);
    while(GetIsObjectValid(oNext))
    {
        DestroyObject(oNext, 0.0);
        oNext = GetNextItemInInventory(OBJECT_SELF);
    }

    object oCloth = GetItemInSlot(INVENTORY_SLOT_CHEST);
    object oHelm = GetItemInSlot(INVENTORY_SLOT_HEAD);
    object oCloak = GetItemInSlot(INVENTORY_SLOT_CLOAK);
    string sBP = "mil_clothing668";
    string sHelm = "mil_clothing669";
    string sCloak = "mil_cloak";
    object oClothing;
    object oHelmet;

    DestroyObject(oCloth);
    DestroyObject(oHelm);
    DestroyObject(oCloak);

    object oNew = CreateItemOnObject(sBP);
    object oNewHelm = CreateItemOnObject(sHelm);
    CreateItemOnObject(sCloak);
    DelayCommand(0.5, ActionEquipItem(oNew, INVENTORY_SLOT_CHEST));
    //DelayCommand(0.5, ActionEquipItem(oNewHelm, INVENTORY_SLOT_HEAD));
}
