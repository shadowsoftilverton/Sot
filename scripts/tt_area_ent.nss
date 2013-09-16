





void main()
{
    // Get the 2 objects
    object oPC = GetEnteringObject();
    object oSource = GetObjectByTag("BEAM1");
    object oTarget = GetObjectByTag("BEAM2");

    // Declare the fire beam effect
    effect eBeam = EffectBeam(VFX_BEAM_CHAIN,oSource,BODY_NODE_CHEST, FALSE);

    // Apply it permamently
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam, oTarget);
}

