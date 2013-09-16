void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC)){
        FloatingTextStringOnCreature("Entering a safe resting area.", oPC);

        SetLocalInt(oPC, "REST_ENABLED", TRUE);
    }
}
