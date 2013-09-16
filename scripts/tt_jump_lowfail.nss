void main()
{
    effect eVFX;
    effect eDamage;

    // Get the creature who triggered this event.
    object oPC = GetLastUsedBy();

    // Cause damage.
    eDamage = EffectDamage(d10(3), DAMAGE_TYPE_FIRE);
    eVFX = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_FIRE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX   , oPC);
}
