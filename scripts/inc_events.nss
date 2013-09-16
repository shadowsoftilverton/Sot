#include "engine"

// Signals evToRun for all objects sharing sTag.
void SignalEventToGroup(string sTag, event evToRun);

void SignalEventToGroup(string sTag, event evToRun){
    int i = 0;
    object oObj = GetObjectByTag(sTag, i);

    while(GetIsObjectValid(oObj)){
        SignalEvent(oObj, evToRun);

        oObj = GetObjectByTag(sTag, ++i);
   }
}
