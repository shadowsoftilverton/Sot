#include "ave_d2_inc"

void main()
{
    object oPC=GetEnteringObject();
    string sName=GetName(oPC)+GetPCPlayerName(oPC);
    SetLocalInt(GetModule(),"ave_d2_timerstart"+sName,GetTimeByMinute());
    SetLocalInt(GetModule(),"ave_d2_timerbool"+sName,1);
    DelayCommand((MAX_AVE_D2_HOURS*60.0*15.0)+1.0,AveD2Leave(oPC));//60 seconds to a minute, 15 minutes to an hour
}
