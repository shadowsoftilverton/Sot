//OnSpawn script of the pathblocking placeables.

#include "engine"

void main()
{
    effect ePrc = EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING, 50);
    effect eAcd = EffectDamageImmunityIncrease(DAMAGE_TYPE_ACID, 90);
    effect eElc = EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL, 50);
    effect eSon = EffectDamageImmunityIncrease(DAMAGE_TYPE_SONIC, 50);

    effect eLink = EffectLinkEffects(eAcd, ePrc);
    eLink = EffectLinkEffects(eElc, eLink);
    eLink = EffectLinkEffects(eSon, eLink);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, OBJECT_SELF);
}
