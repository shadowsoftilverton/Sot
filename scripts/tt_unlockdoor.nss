void main()
{
    object oTarget;

    // Get the creature who triggered this event.
    object oPC = GetLastUsedBy();

    // Open "tt_door".
    oTarget = GetObjectByTag("tt_dwarf_castledoor1");
    AssignCommand(oTarget, ActionOpenDoor(oTarget));
}
