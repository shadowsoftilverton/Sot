#include "engine"

const int STABILIZE_SAVE_DC = 15;

void CalculateHitPointLoss(object oPC) {
    int nDeathThreshold;

    nDeathThreshold = -1 * (10 + GetHitDice(oPC));

    if(GetCurrentHitPoints(oPC) > 0 || GetCurrentHitPoints(oPC) < nDeathThreshold)
        return;

    if(FortitudeSave(oPC, 15)) {
        effect eHeal = EffectHeal(1);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
    } else {
        effect eDamage = EffectDamage(1, DAMAGE_TYPE_NEGATIVE, DAMAGE_POWER_ENERGY);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
    }

    DelayCommand(6.0, CalculateHitPointLoss(oPC));
}

void main()
{
    // Our core dying script is very simple and follows standard Dungeons and
    // Dragons.
    object oPC = GetLastPlayerDying();

    // Now we get to the recursive check.
    DelayCommand(6.0, CalculateHitPointLoss(oPC));
}
