void main()
{
    object oPC = GetExitingObject();

    if(GetIsPC(oPC)){
        FloatingTextStringOnCreature("Leaving the safe resting area.", oPC);

        DeleteLocalInt(oPC, "REST_ENABLED");
    }
}
