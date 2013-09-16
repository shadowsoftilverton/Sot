#include "engine"

void main()
{
    object oPC=GetEnteringObject();
    object oTrigger=OBJECT_SELF;
    if(GetLocalInt(oTrigger,"ave_d2_sprung")==0)
    {
        SetLocalInt(oTrigger,"ave_d2_sprung",1);
        if(GetIsSkillSuccessful(oPC,SKILL_SEARCH,24))
        {
            SendMessageToPC(oPC,"You spot a pit trap up ahead!");
        }
        else if(ReflexSave(oPC,25))
        {
            SendMessageToPC(oPC,"You deftly evade the pit trap!");
        }
        else
        {
            string sDistress="You stumble into a pit trap, and fall down a tunnel into an underground river with a loud splash, and quickly get swept downstream by the intense current, becoming separated from your party...";
            SpeakString(sDistress);
            //ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCutsceneParalyze(),oPC,0.2);
            location lLoc=GetLocation(GetObjectByTag("ave_d2_fallpoint"));
            AssignCommand(oPC,JumpToLocation(lLoc));
        }
        CreateObject(OBJECT_TYPE_PLACEABLE,"ave_d2_plcpit",GetLocation(oTrigger));
    }
}
