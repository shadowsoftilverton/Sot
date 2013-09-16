//----------------------------------------------------------------------------//
//Shadows of Tilverton - Persistent Storage System
//Author: Stephen "Invictus"
//----------------------------------------------------------------------------//

#include "engine"
#include "aps_include"

//----------------------------------------------------------------------------//

const int MAX_PERSISTENT_OBJECTS_PER_CONTAINER = 25;

//----------------------------------------------------------------------------//

void LoadPersistentItemsFromContainer(object oContainer);
void ClearPersistentObjectsFromContainer(object oContainer);
void PersistAllItemsFromContainer(object oContainer, object oOpener);

//----------------------------------------------------------------------------//

void LoadPersistentItemsFromContainer(object oContainer) {
    int nObject;
    object oObject;

    for(nObject = 0; nObject < MAX_PERSISTENT_OBJECTS_PER_CONTAINER; nObject++) {
        oObject = GetPersistentObject_player("OBJECT", GetTag(oContainer), IntToString(nObject));

        if(!GetIsObjectValid(oObject)) return;

        CopyItem(oObject, oContainer, TRUE);
    }
}

void ClearPersistentObjectsFromContainer(object oContainer) {
    ClearPersistentVariables_player("OBJECT", GetTag(oContainer));
}

void PersistAllItemsFromContainer(object oContainer, object oOpener) {
    int nObject = 0;
    object oObject;

    oObject = GetFirstItemInInventory(oContainer);
    while(GetIsObjectValid(oObject)) {
        nObject++;
        oObject = GetNextItemInInventory(oContainer);
    }

    if(nObject > MAX_PERSISTENT_OBJECTS_PER_CONTAINER) {
        SendMessageToPC(oOpener, "You are attempting to store too many items in this container. You will need to remove " + IntToString(MAX_PERSISTENT_OBJECTS_PER_CONTAINER - nObject) + " items for storage to persist.");
        return;
    }

    ClearPersistentObjectsFromContainer(oContainer);

    nObject = 0;
    oObject = GetFirstItemInInventory(oContainer);
    while(GetIsObjectValid(oObject)) {
        if(CopyItem(oObject, OBJECT_INVALID, TRUE) == OBJECT_INVALID) {
            SendMessageToPC(oOpener, "You are attempting to place a bag which holds other objects into this container. This is not allowed. You will need to remove this bag.");
            return;
        }

        SetPersistentObject_player("OBJECT", GetTag(oContainer), IntToString(nObject), oObject);
        DestroyObject(oObject);
        oObject = GetNextItemInInventory(oContainer);
    }

    SendMessageToPC(oOpener, "All items persisted without issue.");
}
