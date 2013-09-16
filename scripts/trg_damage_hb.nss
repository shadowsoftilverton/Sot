//Generic Trigger Damage script: Heartbeat.
/*
    Variables on the trigger:
    DamageType      Int     Damage type as arbitrarily defined here.
    DamageDice      Int     Number of d6 to roll.
    DamageIgnore    String  First 8 characters of a tag. Creatures whose tag starts with these 8 characters will not be damaged.
*/

#include "engine"

void main()
{
    object oContain = GetFirstInPersistentObject();
    int nDamageType = GetLocalInt(OBJECT_SELF, "DamageType");
    int nDamageDice = GetLocalInt(OBJECT_SELF, "DamageDice");
    string sIgnore = GetLocalString(OBJECT_SELF, "DamageIgnore");
    string sMatch = GetStringRight(GetTag(oContain), 8);
    effect eDamage;
    int nDamage;

    if(nDamageDice < 1) nDamageDice = 1;

    switch(nDamageType)
    {
        case 1: nDamageType = DAMAGE_TYPE_FIRE;         break;
        case 2: nDamageType = DAMAGE_TYPE_COLD;         break;
        case 3: nDamageType = DAMAGE_TYPE_ELECTRICAL;   break;
        case 4: nDamageType = DAMAGE_TYPE_ACID;         break;
        case 5: nDamageType = DAMAGE_TYPE_NEGATIVE;     break;
        case 6: nDamageType = DAMAGE_TYPE_POSITIVE;     break;
        case 7: nDamageType = DAMAGE_TYPE_MAGICAL;      break;
        case 8: nDamageType = DAMAGE_TYPE_DIVINE;       break;
        case 9: nDamageType = DAMAGE_TYPE_SLASHING;     break;
        case 10: nDamageType = DAMAGE_TYPE_PIERCING;    break;
        case 11: nDamageType = DAMAGE_TYPE_BLUDGEONING; break;
    }

    while(GetIsObjectValid(oContain))
    {
        if(sIgnore != sMatch)
        {
            nDamage = d6(nDamageDice);
            eDamage = EffectDamage(nDamage, nDamageType);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oContain);
        }

        oContain = GetNextInPersistentObject();
    }
}
