void main()
{
    object oWP1 = GetObjectByTag("GLD_TRG004");
    object oWP2 = GetObjectByTag("GLD_TRG004");
    object oWP3 = GetObjectByTag("GLD_TRG004");
    object oWP4 = GetObjectByTag("GLD_TRG004");

    SetLocalInt(oWP1, "IsFired", 0);
    SetLocalInt(oWP2, "IsFired", 0);
    SetLocalInt(oWP3, "IsFired", 0);
    SetLocalInt(oWP4, "IsFired", 0);
}
