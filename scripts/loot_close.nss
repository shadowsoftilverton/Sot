#include "engine"

#include "inc_loot"

void DoDestroyContents(){
    if(GetIsOpen(OBJECT_SELF)) return;

    object oItem = GetFirstItemInInventory();

    while(GetIsObjectValid(oItem)){
        DestroyObject(oItem);

        oItem = GetNextItemInInventory();
    }
}

void main()
{
    SetLocalInt(OBJECT_SELF, LOOT_VAR_NO_SPAWN, TRUE);

    if(!GetIsDungeonInstance(GetArea(OBJECT_SELF))){
        float fResetTime = GetLocalFloat(OBJECT_SELF, LOOT_VAR_RESET_TIME);

        if(fResetTime <= 0.0) fResetTime = 1800.0;

        DelayCommand(fResetTime, DoDestroyContents());
        DelayCommand(fResetTime, SetLocalInt(OBJECT_SELF, LOOT_VAR_NO_SPAWN, FALSE));
    }
}
