#include "engine"
#include "inc_persistency"

void main() {
    object oPC = GetLastOpenedBy();
    object oSelf = OBJECT_SELF;

    PersistAllItemsFromContainer(oSelf, oPC);
}
