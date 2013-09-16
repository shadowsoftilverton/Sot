#include "engine"
#include "nwnx_funcs"
#include "uw_inc"

const int FEAT_SKILLED_WILDERNESS_DWELLER=1536;
const int FEAT_SKILLED_CITY_DWELLER=1537;

int GetSkilledDwellerSkill(object oPC, int nSkill)
{
    if(GetHasFeat(FEAT_SKILLED_CITY_DWELLER,oPC))
    {
        int iLastClass=GetClassByLevel(oPC,GetHitDice(oPC));
        if(iLastClass==CLASS_TYPE_RANGER||iLastClass==CLASS_TYPE_DRUID||iLastClass==CLASS_TYPE_BARBARIAN)
        {
            switch(nSkill)
            {
            case SKILL_GATHER_INFORMATION:
            return (GetSkillRank(SKILL_ANIMAL_EMPATHY,oPC,TRUE)>0&&GetIsClassSkill(iLastClass,SKILL_ANIMAL_EMPATHY));

            case SKILL_SENSE_MOTIVE:
            return (GetSkillRank(SKILL_SURVIVAL,oPC,TRUE)>0&&GetIsClassSkill(iLastClass,SKILL_SURVIVAL));

            case SKILL_K_LOCAL:
            return (GetSkillRank(SKILL_K_NATURE,oPC,TRUE)>0&&GetIsClassSkill(iLastClass,SKILL_K_NATURE));

            case SKILL_TUMBLE:
            return(GetSkillRank(SKILL_RIDE,oPC,TRUE)>0&&GetIsClassSkill(iLastClass,SKILL_RIDE));

            case SKILL_BLUFF:
            return (GetSkillRank(SKILL_SET_TRAP,oPC,TRUE)>0&&GetIsClassSkill(iLastClass,SKILL_SET_TRAP));
            }
        }
    }
    if(GetHasFeat(FEAT_SKILLED_WILDERNESS_DWELLER,oPC))
    {
        int iLastClass=GetClassByLevel(oPC,GetHitDice(oPC));
        if(iLastClass==CLASS_TYPE_BARD||iLastClass==CLASS_TYPE_ROGUE)
        {
            switch(nSkill)
            {
            case SKILL_ANIMAL_EMPATHY:
            return (GetSkillRank(SKILL_GATHER_INFORMATION,oPC,TRUE)>0&&GetIsClassSkill(iLastClass,SKILL_GATHER_INFORMATION));

            case SKILL_SURVIVAL:
            return (GetSkillRank(SKILL_SENSE_MOTIVE,oPC,TRUE)>0&&GetIsClassSkill(iLastClass,SKILL_SENSE_MOTIVE));

            case SKILL_K_NATURE:
            return (GetSkillRank(SKILL_K_LOCAL,oPC,TRUE)>0&&GetIsClassSkill(iLastClass,SKILL_K_LOCAL));

            case SKILL_RIDE:
            return(GetSkillRank(SKILL_TUMBLE,oPC,TRUE)>0&&GetIsClassSkill(iLastClass,SKILL_TUMBLE));

            case SKILL_SET_TRAP:
            return (GetSkillRank(SKILL_BLUFF,oPC,TRUE)>0&&GetIsClassSkill(iLastClass,SKILL_BLUFF));
            }
        }
    }
    return 0;
}

//Checks to see if the character is eligible for nSkill as a virtual class skill. This is currently a rump
//function for GetSkilledCityDwellerSkill, but having it here lets us modularize to other sources of virtual
//class skills later using || gates for each case.
int GetIsEligibleForSkill(object oPC, int nSkill)
{
    //if(GetPCSkillPoints(oPC)==0) return 0;//Return false if the PC hasn't banked any skill points
    if(GetSkillRank(nSkill,oPC,TRUE)>GetHitDice(oPC)+2) return 0;//Return false if the PC is maxed out in the skill
    switch(nSkill)
    {
        case SKILL_GATHER_INFORMATION: return GetSkilledDwellerSkill(oPC,nSkill);
        case SKILL_SENSE_MOTIVE: return GetSkilledDwellerSkill(oPC,nSkill);
        case SKILL_K_LOCAL: return GetSkilledDwellerSkill(oPC,nSkill);
        case SKILL_TUMBLE: return GetSkilledDwellerSkill(oPC,nSkill);
        case SKILL_BLUFF: return GetSkilledDwellerSkill(oPC,nSkill);
        case SKILL_SET_TRAP: return GetSkilledDwellerSkill(oPC,nSkill);
        case SKILL_ANIMAL_EMPATHY: return GetSkilledDwellerSkill(oPC,nSkill);
        case SKILL_K_NATURE: return GetSkilledDwellerSkill(oPC,nSkill);
        case SKILL_SURVIVAL: return GetSkilledDwellerSkill(oPC,nSkill);
        case SKILL_RIDE: return GetSkilledDwellerSkill(oPC,nSkill);
    }
    return 0;
}

int GetIsEligibleForAnySkill(object oPC)
{
    int iSkill=0;
    while(iSkill<48)
    {
        if(GetIsEligibleForSkill(oPC,iSkill)) return 1;
        iSkill++;
    }
    return 0;
}

void TakeSkillRank(object oPC, int nSkill)
{
    //int nPoints=GetPCSkillPoints(oPC);
    //SendMessageToPC(oPC,"Debug: You have "+IntToString(nPoints)+" skill points remaining.");
    //SetPCSkillPoints(oPC,nPoint+1);
    //SetSkillRank(oPC,GetHitDice(oPC),nSkill,GetSkillRank(nSkill,oPC,TRUE)-1);
    ModifySkillRankByLevel(oPC,GetHitDice(oPC),nSkill,-1);
}

//Increments oPC's rank in nSkill by a single rank, at the cost of one stored skill point
void GiveSkillRank(object oPC, int nSkill)
{
    //int nPoints=GetPCSkillPoints(oPC);
    //SendMessageToPC(oPC,"Debug: You have "+IntToString(nPoints)+" skill points remaining.");
    //SetPCSkillPoints(oPC,nPoints-1);
    //SetSkillRank(oPC,GetHitDice(oPC),nSkill,GetSkillRank(nSkill,oPC,TRUE)+1);
    ModifySkillRankByLevel(oPC,GetHitDice(oPC),nSkill,1);
}

// Invictus 3013-04-30
void AddHalfElfSkillPoints(object oPC) {
    if(GetHitDice(oPC) == 1) ModifyPCSkillPoints(oPC, 4);
    else ModifyPCSkillPoints(oPC, 1);
}

// Invictus 3013-04-30
void AddMechanicalSkillsForPerception(object oPC) {
    int nSpotRank;
    int nListenRank;
    int nPerceptionRank;

    nSpotRank = GetSkillRank(SKILL_SPOT, oPC, TRUE);
    nListenRank = GetSkillRank(SKILL_LISTEN, oPC, TRUE);
    nPerceptionRank = GetSkillRank(SKILL_PERCEPTION, oPC, TRUE);

    if(nSpotRank > nPerceptionRank) SetSkillRank(oPC, SKILL_SPOT, nPerceptionRank);
    if(nListenRank > nPerceptionRank) SetSkillRank(oPC, SKILL_LISTEN, nPerceptionRank);

    if(nSpotRank < nPerceptionRank) ModifySkillRankByLevel(oPC, GetHitDice(oPC), SKILL_SPOT, nPerceptionRank - nSpotRank);
    if(nListenRank < nPerceptionRank) ModifySkillRankByLevel(oPC, GetHitDice(oPC), SKILL_LISTEN, nPerceptionRank - nListenRank);
}

// Invictus 3013-04-30
void AddMechanicalSkillsForStealth(object oPC) {
    int nHideRank;
    int nMoveSilentRank;
    int nStealthRank;

    nHideRank = GetSkillRank(SKILL_HIDE, oPC, TRUE);
    nMoveSilentRank = GetSkillRank(SKILL_MOVE_SILENTLY, oPC, TRUE);
    nStealthRank = GetSkillRank(SKILL_STEALTH, oPC, TRUE);

    if(nHideRank > nStealthRank) SetSkillRank(oPC, SKILL_HIDE, nStealthRank);
    if(nMoveSilentRank > nStealthRank) SetSkillRank(oPC, SKILL_MOVE_SILENTLY, nStealthRank);

    if(nHideRank < nStealthRank) ModifySkillRankByLevel(oPC, GetHitDice(oPC), SKILL_HIDE, nStealthRank - nHideRank);
    if(nMoveSilentRank < nStealthRank) ModifySkillRankByLevel(oPC, GetHitDice(oPC), SKILL_MOVE_SILENTLY, nStealthRank - nMoveSilentRank);
}
