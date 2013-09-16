#include "x2_inc_switches"

#include "nwnx_structs"

void main() {
    int nEvent = GetUserDefinedItemEventNumber();

    if(nEvent == X2_ITEM_EVENT_ACTIVATE) {
        object oPC   = GetItemActivator();
        object oItem = GetItemActivatedTarget();

        if(GetObjectType(oItem) != OBJECT_TYPE_ITEM) return;

        SendMessageToPC(oPC, "----------------");
        SendMessageToPC(oPC, "Walking Item Properties on: <" + GetName(oItem) + ">.\n");

        itemproperty ip = GetFirstItemProperty(oItem);

        while(GetIsItemPropertyValid(ip)){
            SendMessageToPC(oPC, "--> Walking Property <" + Get2DAString("itempropdef", "Label", GetItemPropertyInteger(ip, 0)) + ">.");
            SendMessageToPC(oPC, "----> Spell ID: <" + IntToString(GetItemPropertySpellId(ip)) + ">.");
            SendMessageToPC(oPC, "----> Duration: <" + FloatToString(GetItemPropertyDurationRemaining(ip)) + "/" + FloatToString(GetItemPropertyDuration(ip)) + ">.");

            int j;

            for(j = 0; j < 16; j++){
                GetItemPropertyInteger(ip, j);

                SendMessageToPC(oPC, "----> Property #" + IntToString(j) + ": <" + IntToString(GetItemPropertyInteger(ip, j)) + ">.");
            }

            ip = GetNextItemProperty(oItem);
        }
    }
}
