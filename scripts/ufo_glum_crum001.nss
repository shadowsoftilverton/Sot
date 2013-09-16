#include "engine"

void main()
{
    object oCenter = GetNearestObjectByTag("WP_EVE_CRUMB");
    location lCenter = GetLocation(oCenter);
    effect eCrumb = EffectVisualEffect(354);
    effect eTremb = EffectVisualEffect(286);
    int nDamage = d6();
    effect eDamage;

    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eTremb, lCenter, 3.0f);

    object oPC = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lCenter, TRUE, OBJECT_TYPE_CREATURE);

    while(GetIsObjectValid(oPC))
    {
        nDamage = GetReflexAdjustedDamage(nDamage, oPC, 16, SAVING_THROW_TYPE_NONE);
        eDamage = EffectDamage(nDamage, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL);

        if(nDamage > 0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eCrumb, oPC);
        }

        oPC = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lCenter, TRUE, OBJECT_TYPE_CREATURE);
    }
}
