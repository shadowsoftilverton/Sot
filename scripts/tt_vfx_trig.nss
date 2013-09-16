void main()
{
    effect eVFX;

    // Get the creature who triggered this event.
    object oPC = GetEnteringObject();

    // Only fire for (real) PCs.
    if ( !GetIsPC(oPC)  ||  GetIsDMPossessed(oPC) )
        return;

    // Apply a visual effect.
    eVFX = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oPC);
}


