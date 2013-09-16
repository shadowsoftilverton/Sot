#include "aps_include"
#include "nwnx_funcs"
void main()
{
     object oPC=GetPCSpeaker();
     int PreviousRage=GetPersistentInt(oPC,"NUM_BONUS_RAGEFEATS");
     SetPersistentInt(oPC,"NUM_BONUS_RAGEFEATS",PreviousRage+1);
     AddKnownFeat(oPC, 1341);
}
