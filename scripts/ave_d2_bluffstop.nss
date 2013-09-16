void main()
{
    object oPC=GetPCSpeaker();
    SetLocalInt(GetModule(),"ave_d2_bluffuse"+GetName(oPC)+GetPCPlayerName(oPC),1);
}
