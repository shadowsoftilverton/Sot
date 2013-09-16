#include "engine"

#include "uw_inc"

int StartingConditional()
{
    object oPC      = GetPCSpeaker();
    object oTarget  = GetUtilityTarget(oPC);
    string sTag = GetTag(GetArea(oPC));
    int nType   = GetObjectType(oTarget);

    return (oPC == oTarget || (GetIsDM(oPC) && GetIsPC(oTarget))) && sTag != "ooc_afk";
}
