void main()
{
    object oPC=GetPCSpeaker();
    SetLocalInt(GetModule(),"ave_d2_stealuse"+GetName(oPC)+GetPCPlayerName(oPC),1);
}
