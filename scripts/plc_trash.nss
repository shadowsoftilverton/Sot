#include "engine"

void main()
{
    object oContainer = OBJECT_SELF;

    object oItem = GetFirstItemInInventory(oContainer);

    while(GetIsObjectValid(oItem)){
        DestroyObject(oItem);

        oItem = GetNextItemInInventory(oContainer);
    }
}
