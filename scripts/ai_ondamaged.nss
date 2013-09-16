#include "engine"
#include "nw_i0_generic"
#include "ai_wrapper"

int DetermineAttackedBy();

void main()
{
    object oDamager = GetLastDamager();

    if (!GetIsObjectValid(oDamager))
    {
            //If damager is not valid, do nothing.
    }

    //If the caller is not in combat.
    else if(!GetIsFighting(OBJECT_SELF))
    {
        if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
        {
            DetermineSpecialBehavior(oDamager);
        }

        else
        {
            //If the damager is not seen, move to their location and decide what can be done from there.
            if(!GetObjectSeen(oDamager)
            && GetArea(OBJECT_SELF) == GetArea(oDamager))
            {
                ActionMoveToLocation(GetLocation(oDamager), TRUE);
                ActionDoCommand(DetermineCombatRound());
            }

            else
            {
                //If the attack is probably physical, and therefore direct, exit stealth to charge or fire.
                //If the damager is farther than 8 meters, switch to a ranged weapon.
                if(DetermineAttackedBy() == 1)
                {
                    if(GetDistanceToObject(oDamager) > 8.0f)
                    {
                        ActionEquipMostDamagingRanged();
                    }

                    else
                    {
                        SetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH, FALSE);
                        ActionEquipMostDamagingMelee();
                    }

                    DetermineCombatRound(oDamager);
                }

                else if(DetermineAttackedBy() == 2)
                {
                    if(GetDistanceToObject(oDamager) > 8.0f)
                    {
                        ActionEquipMostDamagingRanged();
                    }

                    else
                    {
                        SetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH, FALSE);
                        ActionEquipMostDamagingMelee();
                    }

                    DetermineCombatRound(oDamager);
                }
            }
        }
    }

    else
    {
        object oTarget = GetAttackTarget();

        if (!GetIsObjectValid(oTarget))
            oTarget = GetAttemptedAttackTarget();
        if (!GetIsObjectValid(oTarget))
            oTarget = GetAttemptedSpellTarget();

        //If the current combat target is not valid;
        //If the last damager has done 20% of the caller's HP in damage;
        //If the last damager has less AC than the caller's current target;
        //Attack the last damager.
        if (!GetIsObjectValid(oTarget)
        || (oTarget != oDamager && (GetTotalDamageDealt() > (GetMaxHitPoints(OBJECT_SELF) / 5)))
        || (GetAC(oDamager) < GetAC(oTarget)))
        {
            DetermineCombatRound(oDamager);
        }
    }

    if(GetSpawnInCondition(NW_FLAG_DAMAGED_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_DAMAGED));
    }
}

//Approximates if the last attack was from a weapon or a spell.
int DetermineAttackedBy()
{
    if(GetDamageDealtByType(DAMAGE_TYPE_PIERCING | DAMAGE_TYPE_SLASHING | DAMAGE_TYPE_BLUDGEONING) > 0)
    {
        return 1;
    }

    else
    {
        return 2;
    }
}
