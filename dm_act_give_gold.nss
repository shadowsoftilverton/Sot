#include "engine"

#include "nwnx_dmactions"

#include "inc_iss"
#include "inc_logs"

#include "dm_inc"

void main()
{
    object oDM = OBJECT_SELF;

    if(DoISSToolLimiting(oDM)) return;

    object oTarget = GetDMActionTarget();

    int nGold = GetDMActionIntParam();

    FloatingTextStringOnCreature(GetName(oTarget) + " was awarded " + IntToString(nGold) + " GP.", oDM, FALSE);

    WriteLog("Dungeon Master " + GetPCInfoString(oDM) + " awarded " + IntToString(nGold) + " GP to " + GetPCInfoString(oTarget) + ".", LOG_TYPE_DM, "TOOLS");
}
