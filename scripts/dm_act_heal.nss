#include "engine"

#include "nwnx_dmactions"

#include "inc_death"
#include "inc_strings"

#include "dm_inc"

void main()
{
    object oDM = OBJECT_SELF;

    if(DoISSToolLimiting(oDM)) return;

    object oTarget = GetDMActionTarget();

    PreventDMAction();

    if(GetIsDead(oTarget)) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oTarget);

    effect eBad = GetFirstEffect(oTarget);
    //Search for negative effects
    while(GetIsEffectValid(eBad)){
        if (GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_AC_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_ATTACK_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
            GetEffectType(eBad) == EFFECT_TYPE_DEAF ||
            GetEffectType(eBad) == EFFECT_TYPE_CURSE ||
            GetEffectType(eBad) == EFFECT_TYPE_DISEASE ||
            GetEffectType(eBad) == EFFECT_TYPE_POISON ||
            GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_CHARMED ||
            GetEffectType(eBad) == EFFECT_TYPE_DOMINATED ||
            GetEffectType(eBad) == EFFECT_TYPE_DAZED ||
            GetEffectType(eBad) == EFFECT_TYPE_CONFUSED ||
            GetEffectType(eBad) == EFFECT_TYPE_FRIGHTENED ||
            GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL ||
            GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_SLOW ||
            GetEffectType(eBad) == EFFECT_TYPE_STUNNED)
        {
                RemoveEffect(oTarget, eBad);
        }
        eBad = GetNextEffect(oTarget);
    }

    effect eHeal = EffectHeal(GetMaxHitPoints(oTarget) - GetCurrentHitPoints(oTarget));

    if(GetIsPC(oTarget)) SetIsPersistentDead(oTarget, 0);

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
}
