int StartingConditional()
{
    object oPC=GetPCSpeaker();
    return GetLocalInt(GetModule(),"ave_d2_bluffuse"+GetName(oPC)+GetPCPlayerName(oPC))==0;
}
