#include "engine"

#include "nwnx_dmactions"

#include "inc_xp"
#include "inc_iss"
#include "inc_logs"

#include "dm_inc"


void main()
{
    object oDM = OBJECT_SELF;

    if(DoISSToolLimiting(oDM)) return;

    object oTarget = GetDMActionTarget();

    int nXP = GetDMActionIntParam();

    //PreventDMAction();

    //GiveAdjustedXP(oTarget, nXP);

    FloatingTextStringOnCreature(GetName(oTarget) + " was awarded " + IntToString(nXP) + " XP.", oDM, FALSE);

    WriteLog("Dungeon Master " + GetPCInfoString(oDM) + " awarded " + IntToString(nXP) + " XP (unadjusted) to " + GetPCInfoString(oTarget) + ".", LOG_TYPE_DM, "TOOLS");
}
