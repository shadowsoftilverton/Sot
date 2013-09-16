#include "engine"

#include "inc_arrays"
#include "inc_events"

const string LV_CHANCE_TO_SPAWN = "plc_chance_to_spawn";
const string LV_BLUEPRINT_LIST = "plc_random_";
const string LV_IS_PLOT = "plc_is_plot";

void main()
{
    object oSelf = OBJECT_SELF;

    int nSpawnChance = GetLocalInt(oSelf, LV_CHANCE_TO_SPAWN);

    if(nSpawnChance < 1) nSpawnChance = 100;

    if(Random(100) + 1 <= nSpawnChance){
        int i = 0;

        string sEntry = GetStringArray(oSelf, LV_BLUEPRINT_LIST, i);

        while(sEntry != ""){
            sEntry = GetStringArray(oSelf, LV_BLUEPRINT_LIST, ++i);
        }

        if(i < 1) return;

        i = Random(i);

        sEntry = GetStringArray(oSelf, LV_BLUEPRINT_LIST, i);

        object oInstance = CreateObject(OBJECT_TYPE_PLACEABLE, sEntry, GetLocation(oSelf), FALSE, "plc_random_inst");

        if(GetIsObjectValid(oInstance)) SetPlotFlag(oInstance, GetLocalInt(oSelf, LV_IS_PLOT));
    }

    // Always destroy the caller, since this is a heartbeat script and we don't
    // want more than one execution.
    SetPlotFlag(oSelf, FALSE);
    DestroyObject(oSelf);
}
