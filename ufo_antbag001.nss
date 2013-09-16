#include "engine"

void main()
{
    object oPC = GetEnteringObject();
    effect eAOE = EffectAreaOfEffect(AOE_PER_FOGSTINK);
    location lTarget = GetLocation(oPC);
    effect eImpact = EffectVisualEffect(257);
    string sMess = "The white mass sprays out a noxious cloud!";
    effect eDamage=EffectDamage(10, DAMAGE_TYPE_ACID);

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lTarget);
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(4));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
    FloatingTextStringOnCreature(sMess, oPC, FALSE);
}
