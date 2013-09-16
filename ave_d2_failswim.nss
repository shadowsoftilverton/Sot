#include "engine"

void SwimFall(object oPC)
{
    location lLoc=GetLocation(GetObjectByTag("ave_d2_fallpoint"));
    AssignCommand(oPC,JumpToLocation(lLoc));
}

void main()
{
    object oPC=GetLastUsedBy();
    string sDistress="You attempt to swim across the underground river, but quickly get swept downstream by the intense current, becoming separated from your party...";
    SpeakString(sDistress);
    //ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCutsceneParalyze(),oPC,0.2);
    SwimFall(oPC);
}
