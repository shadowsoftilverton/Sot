//Skill Roll Placeables by Hardcore UFO
//OnUsed script
//Required variables for this script to work (to be placed on the placeable that calls it):
//  NAME            TYPE    VALUE
//  SkillType       Int     See skills.2da in the first column
//  SkillDC         Int     The DC to beat for that roll
//  RollSuccess     String  Message for a successful roll on the DC
//  RollFailure     String  Message for an unsuccessful roll on the DC
//  RollSuccessXP   Int     Amount of XP to give characters that pass the roll
//  RollDone        String  Message for characters that have already clicked

//  SPECIAL
//  The placeable must have a unique tag to toggle the effects off for characters that already clicked
//
//The script will get the current value of a skill and add it to the result of a d20 roll to compare it to the DC, and send a message accordingly

#include "engine"

void main()
{
    object oUser = GetLastUsedBy();
    int nSkill = GetLocalInt(OBJECT_SELF, "SkillType"); //On the placeable, there should be a variable called SkillType that is an Integer and goes by the values of the first column in skills.2da
    int nDC = GetLocalInt(OBJECT_SELF, "SkillDC"); //On the placeable, there should be a variable called SkillDC that is an Integer equal to the DC to beat
    string sSuccess = GetLocalString(OBJECT_SELF, "RollSuccess"); //On the placeable, there should be a variable called RollSuccess that is a string and has the success message as its value
    string sFailure = GetLocalString(OBJECT_SELF, "RollFailure"); //On the placeable, there should be a variable called RollFailure that is a string and has the failure message as its value
    string sAlready = GetLocalString(OBJECT_SELF, "RollDone");
    int bBroadCast = GetLocalInt(OBJECT_SELF, "BroadCast");

    string sTag = GetTag(OBJECT_SELF);
    int nUsed = GetLocalInt(oUser, sTag);

    int nRank = GetSkillRank(nSkill, oUser, FALSE);
    int nRoll = d20();
    int nXP = GetLocalInt(OBJECT_SELF, "RollSuccess");

    if(nUsed < 1)
    {
        if(nRank + nRoll >= nDC)
        {
            if(bBroadCast==0) SendMessageToPC(oUser, sSuccess);
            else SpeakString(sSuccess);
            SetLocalInt(oUser, sTag, 1);

            if(nXP > 0)
            {
                GiveXPToCreature(oUser, nXP);
            }
        }

        else if(nRank + nRoll < nDC)
        {
            if(bBroadCast==0) SendMessageToPC(oUser, sFailure);
            else SpeakString(sFailure);
            SetLocalInt(oUser, sTag, 1);
        }
    }

    if(nUsed == 1)
    {
        SendMessageToPC(oUser, sAlready);
    }
}
