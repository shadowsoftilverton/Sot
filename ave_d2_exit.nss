void main()
{
    object oPC=GetEnteringObject();
    string sName=GetName(oPC)+GetPCPlayerName(oPC);
    SetLocalInt(GetModule(),"ave_d2_timerbool"+sName,0);
}
