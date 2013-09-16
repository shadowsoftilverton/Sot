#include "engine"
#include "x0_i0_anims"
#include "nw_i0_generic"
#include "ai_wrapper"

void main()
{
//============================================================================//
//============================= ON PERCEIVE ==================================//
//============================================================================//

    if(GetUserDefinedEventNumber() == 1002) //==================================: OnPerception
    {
        string sOnPerceive = GetLocalString(OBJECT_SELF, "OnPerceive");
        object oPercy = GetLastPerceived();

        //Leap to the enemy just perceived and attack.
        if(sOnPerceive == "PerceiveLeapAttack")
        {
            if(GetIsInCombat(OBJECT_SELF))
            {
                return;
            }

            if(GetIsEnemy(oPercy, OBJECT_SELF))
            {
                effect eLand = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION);
                float fDistance = GetDistanceToObject(oPercy);
                float fFlight = fDistance / 20;
                effect eFadeIn = EffectEthereal();

                JumpToDistantEnemy(OBJECT_SELF, oPercy);
                DelayCommand(fFlight, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eLand, GetLocation(oPercy)));
                DelayCommand(fFlight + 0.2, RemoveEffect(OBJECT_SELF, eFadeIn));
                DelayCommand(fFlight + 0.4, ActionAttack(oPercy));
            }
        }
    }

//============================================================================//
//============================== ON DAMAGED ==================================//
//============================================================================//

    else if(GetUserDefinedEventNumber() == 1006) //=============================: OnDamaged
    {
        string sOnDamaged = GetLocalString(OBJECT_SELF, "OnDamaged");
        object oDamer = GetLastDamager();

        //Run away from the damager.
        if(sOnDamaged == "DamagedRetreat")
        {
            ActionMoveAwayFromObject(oDamer, TRUE, 40.0f);
        }

        //Retreat to hide and attack again. Requires Hide in Plain Sight to make sense.
        if(sOnDamaged == "DamagedStealth")
        {
            RunHideAndStrike(OBJECT_SELF, oDamer);
        }

        else
        {
            DetermineCombatRound(oDamer);
        }
    }

//============================================================================//
//========================== ON COMBAT ROUND END =============================//
//============================================================================//

    else if(GetUserDefinedEventNumber() == 1003) //=============================: OnCombatRound
    {
        string sOnCombatRoundEnd = GetLocalString(OBJECT_SELF, "OnCombatRoundEnd");

        if(sOnCombatRoundEnd == "DimensionDoor")
        {
            JumpToWeakestEnemy(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY));
        }
    }
}

