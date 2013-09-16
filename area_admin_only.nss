void main()
{
    object oPC = GetEnteringObject();

    AssignCommand(oPC, JumpToObject(GetObjectByTag("WP_AFK_ENTRY")));

    FloatingTextStringOnCreature("The area you attempted to enter is admin access only.", oPC, FALSE);
}
