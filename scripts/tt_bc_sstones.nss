/*
 *  Script generated by LS Script Generator, v.TK.0
 *
 *  For download info, please visit:
 *  http://nwvault.ign.com/View.php?view=Other.Detail&id=1502
 */
// Put this script OnEnter.


void main()
{
    effect eEffect;
    effect eVFX;

    // Get the creature who triggered this event.
    object oPC = GetEnteringObject();

    // Only fire for (real) PCs.
    if ( !GetIsPC(oPC)  ||  GetIsDMPossessed(oPC) )
        return;

    // Apply a visual effect.
    eVFX = EffectVisualEffect(VFX_COM_CHUNK_STONE_MEDIUM);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oPC);

    // Apply an effect.
    eEffect = EffectKnockdown();
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, 2.0);
}

