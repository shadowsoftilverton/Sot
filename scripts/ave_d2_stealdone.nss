int StartingConditional()
{
    object oPC=GetPCSpeaker();
    return GetLocalInt(GetModule(),"ave_d2_stealuse"+GetName(oPC)+GetPCPlayerName(oPC))==0;
}
