#include "engine"

void FallDown(object oFaller)
{
    AssignCommand(oFaller, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0f, 12.0f));
}

void main()
{
    object oPC = GetEnteringObject();
    object oBall = GetNearestObjectByTag("spn_guld_ball", oPC, 1);
    object oBott = GetObjectByTag("WP_MOV_CHASM001");
    float fDist = GetDistanceBetween(oPC, oBall);
    effect eBurst = EffectVisualEffect(459);
    string sName = GetName(oPC);
    string sMess = sName + " is swept into the chasm by the surge!";

    if(fDist <= 5.0f)
    {
        int nDamage = d6(2);
        int nHP = GetCurrentHitPoints(oPC);

        if(nDamage >= nHP)
        {
            nDamage = nHP;
        }

        effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eBurst, oBall);
        FloatingTextStringOnCreature(sMess, oPC, FALSE);
        AssignCommand(oPC, ActionJumpToObject(oBott, FALSE));
        DelayCommand(5.0f, FallDown(oPC));
        DelayCommand(3.0f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC));
    }
}
