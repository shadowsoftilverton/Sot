void main()
{
    object oTarget;

    // Set a local integer.
    oTarget = GetObjectByTag("tt_trap_lava");
    SetLocalInt(oTarget, "ContinuousDmg", 1);
    DelayCommand(2.0f, ExecuteScript("cs_oe_trapcep2", oTarget));

}





