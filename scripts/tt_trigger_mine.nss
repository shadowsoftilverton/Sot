void main()
{
    // Get the creature who triggered this event.
    object oPC = GetEnteringObject();

    // Only fire for (real) PCs.
    if ( !GetIsPC(oPC)  ||  GetIsDMPossessed(oPC) )
        return;

    // Only fire once per PC.
    if ( GetLocalInt(oPC, "DO_ONCE__" + GetTag(OBJECT_SELF)) )
        return;
    SetLocalInt(oPC, "DO_ONCE__" + GetTag(OBJECT_SELF), TRUE);

    // Have text appear over the PC's head.
    FloatingTextStringOnCreature("The tunnel before you is dark and narrow. Old mining tools litter the ground. ", oPC, FALSE);
}

