#include "engine"
#include "ave_inv_inc"
#include "aps_include"

void main()
{
    object oPC=GetPCSpeaker();
    object oItem=GetFirstItemInInventory(oPC);
    while(GetIsObjectValid(oItem))
    {
        DoSetNotLoot(oItem);
        oItem=GetNextItemInInventory(oPC);
    }
    int nSlot=0;
    while(nSlot<18)
    {
        oItem=GetItemInSlot(nSlot,oPC);
        DoSetNotLoot(oItem);
        nSlot=nSlot+1;
    }
    SetPersistentInt(oPC,"ave_notloot_gold",GetGold(oPC));
}
