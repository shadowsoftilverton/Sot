#include "engine"
#include "ave_inc_skills"

void DoBoost(int iAmount, object oDM, object oTarget)
{
    int iFixNum=GetLocalInt(oTarget,"ave_cl_fixnum");
    iFixNum=iFixNum+iAmount;
    if(iFixNum<1) iFixNum=1;//Some spells produce problematic exploits and bugs if caster level is less than one
    SendMessageToPC(oDM,"Target now always uses caster level "+IntToString(GetLocalInt(oTarget,"ave_cl_fixnum"))+" when casting spells or using spellcasting items.");
}

void DoCasterLevelReport(object oDM, object oTarget)
{
    if(GetLocalInt(oTarget,"ave_cl_boolfix")==1)
    SendMessageToPC(oDM,"Target always uses caster level "+IntToString(GetLocalInt(oTarget,"ave_CL_fixnum"))+" when casting spells or using spellcasting items.");
    else SendMessageToPC(oDM,"Target is not in fixed-caster level mode.");
    if(bGetIsWildMagic(oTarget)) SendMessageToPC(oDM,"Target is in Wild Magic mode.");
    else SendMessageToPC(oDM,"Target is not in Wild Magic mode.");
}

//Toggles fixed-caster level mode on the target. Sends a report of the action
//to oDM on success. Defaults to caster level 10 if no other value is specified
void FixCL(object oDM, object oTarget)
{
    if(GetLocalInt(oTarget,"ave_cl_boolfix")==1)
    {
        SetLocalInt(oTarget,"ave_cl_boolfix",0);
        SendMessageToPC(oDM,"Fixed-caster level mode turned off");
    }
    else
    {
        SetLocalInt(oTarget,"ave_cl_boolfix",1);
        if(GetLocalInt(oTarget,"ave_cl_fixnum")==0) SetLocalInt(oTarget,"ave_cl_fixnum",10);
        SendMessageToPC(oDM,"Target now always uses caster level "+IntToString(GetLocalInt(oTarget,"ave_cl_fixnum"))+" when casting spells or using spellcasting items.");
    }
}

//returns wild magic and fixed caster levels to default state
void DoCLRevert(object oDM, object oTarget)
{
    SetLocalInt(oTarget,"ave_cl_boolfix",0);
    SendMessageToPC(oDM,"Fixed-caster level mode is off");
    SetLocalInt(oTarget,"ave_cl_wild",0);
    SendMessageToPC(oDM,"Wild magic mode is off");
}

void DoToggleWildMode(object oDM, object oTarget)
{
    if(bGetIsWildMagic(oTarget)==1)
    {
        SetLocalInt(oTarget,"ave_cl_wild",0);
        SendMessageToPC(oDM,"Wild magic mode has been turned off");
    }
    else
    {
        SetLocalInt(oTarget,"ave_cl_wild",1);
        SendMessageToPC(oDM,"Wild magic mode has been turned on");
    }
}
