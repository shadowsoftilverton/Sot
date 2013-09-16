#include "engine"

void main()
{
    object oDevice=OBJECT_SELF;
    object oPC=GetLastUsedBy();
    if(GetLocalInt(oDevice,"ave_d2_mechactive")==0)
    {
        if(GetLocalInt(GetModule(),"ave_d2_mechuse"+GetName(oPC))==0)
        {
            SetLocalInt(GetModule(),"ave_d2_mechuse"+GetName(oPC),1);
            if(GetIsSkillSuccessful(oPC,SKILL_DECIPHER_SCRIPT,18))
            {
                SetLocalInt(oDevice,"ave_d2_mechactive",1);
                DelayCommand(1800.0,SetLocalInt(oDevice,"ave_d2_mechactive",0));
                SendMessageToPC(oPC,"You are able to learn just enough about the strange, illuminated runes to disable the strange device.");
            }
            else SendMessageToPC(oPC,"The device contains strange, illuminated runes that you unfortunately can't make sense of. You push a few buttons at random, but nothing seems to happen.");
        }
        else SendMessageToPC(oPC,"You've already done all you can with this.");
    }
    else SendMessageToPC(oPC,"This device appears to be dormant");
}
