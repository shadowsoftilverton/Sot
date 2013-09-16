#include "engine"

void main()
{
    object oPC = GetLastUsedBy();
    object oWP = GetObjectByTag("UFO_MOV_ANTGEY");
    location lWP = GetLocation(oWP);
    effect eSplash = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_MIND);

    int nDamage = d10(2);
    effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
    string sMess = "You get carried up in the next rush of boiling water.";

    FloatingTextStringOnCreature(sMess, oPC, FALSE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eSplash, oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
    PlaySound("as_na_surf2");
    AssignCommand(oPC, ActionJumpToLocation(lWP));
}
