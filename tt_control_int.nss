void main()
{

object oTarget;

    oTarget = GetObjectByTag("tt_dwarf_ironworks_core");
    int a = GetLocalInt(oTarget,"lava_flow");
    SendMessageToPC(GetFirstPC(), IntToString(a));
}
