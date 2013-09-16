#include "engine"
#include "nw_i0_generic"
#include "ai_wrapper"

void main()
{
    if (GetAILevel() == AI_LEVEL_VERY_LOW) return;

    object oPercy = GetLastPerceived();
    int nSeen = GetLastPerceptionSeen();
    int nHeard = GetLastPerceptionHeard();
    int nLostSight = GetLastPerceptionVanished();
    int nLostTrack = GetLastPerceptionInaudible();
    int n20;

    if(GetIsInCombat(OBJECT_SELF))
    {
        //If the caller is busy fighting, ignore new detected creatures.
    }

    if(GetLocalInt(OBJECT_SELF, "CombatDefensiveCasting") == 1)
    {
        SetActionMode(OBJECT_SELF, ACTION_MODE_DEFENSIVE_CAST, TRUE);
    }

    else if(nLostSight && nLostTrack)
    {
        if(GetDistanceToObject(oPercy) <= 7.0)
        {
            AttemptMagicalDetection(OBJECT_SELF);
        }

        else if(GetDistanceToObject(oPercy) > 7.0)
        {
            if(LineOfSightObject(OBJECT_SELF, oPercy))
            {
                ActionAttack(oPercy);
            }

            else
            {
                ActionMoveToLocation(GetLocation(oPercy), TRUE);
                DetermineCombatRound();
            }
        }

        else if(GetArea(OBJECT_SELF) != GetArea(oPercy))
        {
            ClearAllActions();
            DetermineCombatRound();
        }
    }

    else if(GetIsEnemy(oPercy))
    {
        //If the enemy has been spotted.
        if(nSeen && !GetHasEffect(EFFECT_TYPE_SLEEP))
        {
            if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
            {
                DetermineSpecialBehavior();
            }

            else
            {
                SetFacingPoint(GetPosition(oPercy));
                SpeakString("NW_I_WAS_ATTACKED", TALKVOLUME_SILENT_TALK);
                DetermineCombatRound(oPercy);
            }
        }

        //If the enemy has been heard.
        else if(nHeard && !GetHasEffect(EFFECT_TYPE_SLEEP))
        {
            AttemptMagicalDetection(OBJECT_SELF);

            //If something is heard outside melee range, move toward it.
            if(GetDistanceToObject(oPercy) > 1.5)
            {
                ActionMoveToLocation(GetLocation(oPercy), TRUE);
                ActionUseSkill(SKILL_SPOT, oPercy);
                ActionUseSkill(SKILL_LISTEN, oPercy);

                //If the heard enemy fails an added Move Silently check once detected, attack them.
                n20 = d20();

                if(Std_GetSkillRank(SKILL_LISTEN, OBJECT_SELF) + n20 > Std_GetSkillRank(SKILL_MOVE_SILENTLY, oPercy))
                {
                    SetFacingPoint(GetPosition(oPercy));
                    SpeakString("NW_I_WAS_ATTACKED", TALKVOLUME_SILENT_TALK);
                    ActionAttack(oPercy, TRUE);
                }

                else
                {
                    ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 0.5);
                    ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT, 0.5);
                }
            }

            //If something is heard closeby, take a swing at it.
            if(GetDistanceToObject(oPercy) <= 1.5)
            {
                ActionUseSkill(SKILL_SPOT, oPercy);
                ActionUseSkill(SKILL_LISTEN, oPercy);

                SetFacingPoint(GetPosition(oPercy));
                SpeakString("NW_I_WAS_ATTACKED", TALKVOLUME_SILENT_TALK);
                ActionAttack(oPercy, TRUE);
            }
        }

        //If the enemy can no longer be seen.
        else if(nLostSight)
        {
            if(GetDistanceToObject(oPercy) <= 7.0)
            {
                AttemptMagicalDetection(OBJECT_SELF);
                ActionUseSkill(SKILL_SPOT, oPercy);
                ActionUseSkill(SKILL_LISTEN, oPercy);

                //If the enemy has become invisible and is not audible, try another target if any.
                if(!nHeard && GetHasEffect(EFFECT_TYPE_INVISIBILITY, oPercy))
                {
                    ClearAllActions();
                    DetermineCombatRound();
                }

                ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 0.5);
                ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT, 0.5);
            }
        }

        //If the enemy can no longer be heard.
        else if(nLostTrack)
        {
            if(!nLostSight)
            {
                //If the enemy is still in sight, continue on.
                DetermineCombatRound();
            }

            else
            {
                AttemptMagicalDetection(OBJECT_SELF);
            }
        }

        if(!IsInConversation(OBJECT_SELF))
        {
            if (GetIsPostOrWalking())
            {
                WalkWayPoints();
            }
        }
    }

    if(GetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_PERCEIVE));
    }
}




