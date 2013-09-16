#include "inc_world"

void main()
{
  object oPC = GetPCSpeaker();
  if(GetIsAreaInterior(GetArea(oPC)))
  SendMessageToPC(oPC,"This area is an interior! You can't predict the weather inside.");
  else if(GetLocalInt(oPC,"ave_hasforecast")==1)
  {
    SendMessageToPC(oPC,"You must wait before forecasting the weather. You can only forecast the weather every 1 hour.");
  }
  else
  {
    SetLocalInt(oPC,"ave_hasforecast",1);
    DelayCommand(HoursToSeconds(1),SetLocalInt(oPC,"ave_hasforecast",0));
    int iNature=GetSkillRank(41,oPC);
    int iSurvival=GetSkillRank(41,oPC);
    int iSkill=iNature+iSurvival;
    int iMyRoll=d20(2)+iSkill;
    int iPredict;
    if(iMyRoll>40)
    {
        //SendMessageToPC(oPC,"Debug: You get correct weather information with a roll of "+IntToString(iMyRoll));
        iPredict=GetLocalInt(GetModule(), "ave_forecaster");
    }
    else if(iMyRoll>30)
    {
        //SendMessageToPC(oPC,"Debug: You get slightly wrong weather information with a roll of "+IntToString(iMyRoll));
        iPredict=GetLocalInt(GetModule(),"ave_forecaster");
        iPredict=iPredict-Random(3);
        iPredict=iPredict+Random(3);
        if(iPredict<1) iPredict=1;
        else if(iPredict>10) iPredict=Random(10)+1;
    }
    else
    {
        //SendMessageToPC(oPC,"Debug: You get completly random weather information with a roll of "+IntToString(iMyRoll));
        iPredict=Random(10)+1;
        int iClearBias=Random(10)+1;
        if(iClearBias<iPredict) iPredict=iClearBias;
    }
    string sFeed;
    switch(iPredict)
    {
    case 1: sFeed="Clear";
    break;
    case 2: sFeed="Cloudy";
    break;
    case 3: sFeed="Overcast";
    break;
    case 4: sFeed="Light Rain";
    break;
    case 5: sFeed="Heavy Rain";
    break;
    case 6: sFeed="A Minor Storm";
    break;
    case 7: sFeed="A Major Storm";
    break;
    case 8: sFeed="A Natural Disaster";
    break;
    case 9: sFeed="Snowy";
    break;
    case 10: sFeed="A Blizzard";
    }
    SendMessageToPC(oPC,"Using your knowledge of Nature and Survival skill, you estimate that in a few hours the weather will be " + sFeed);
  }
}
