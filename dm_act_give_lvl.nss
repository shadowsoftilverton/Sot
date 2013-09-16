#include "engine"

#include "nwnx_dmactions"

#include "inc_iss"
#include "inc_logs"

#include "dm_inc"


void main()
{
    object oDM = OBJECT_SELF;

    PreventDMAction();

    ErrorMessage(oDM, "The give/take levels feature is disabled to prevent mishaps.");

    /*

    if(DoISSToolLimiting(oDM)) return;

    object oTarget = GetDMActionTarget();

    int nLevels = GetDMActionIntParam();

    WriteLog("Dungeon Master " + GetPCInfoString(oDM) + " awarded " + IntToString(nLevels) + " Character Levels to " + GetPCInfoString(oTarget) + ".", LOG_TYPE_DM, "TOOLS");
    */
}
