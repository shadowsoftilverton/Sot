#include "engine"

void main()
{
    object oME = GetExitingObject();
    object oPC = GetLocalObject(oME, "TestObject");

    //Gradual fetch
    int nSTR = GetAbilityScore(oPC, ABILITY_CHARISMA);
    SendMessageToPC(oME, "FirstMethod: " + IntToString(nSTR));

    //Exort method
    SendMessageToPC(oME, "SecondMethod: " + IntToString(GetAbilityScore(oPC, ABILITY_CHARISMA)));

    oPC = GetFirstPC();
    nSTR = GetAbilityScore(oPC, ABILITY_CHARISMA);
    SendMessageToPC(oME, "Debug: " + IntToString(nSTR));

}
