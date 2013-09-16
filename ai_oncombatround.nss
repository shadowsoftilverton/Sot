//OnCombatRoundEnd
//Default AI script for Shadows of Tilverton
//Written by Harcore UFO
//April 25, 2012

#include "engine"
#include "x0_i0_anims"
#include "nw_i0_generic"
#include "ai_wrapper"

void main()
{
    object oAttackee = GetAttackTarget();
    if(!GetIsObjectValid(oAttackee)) {oAttackee = GetAttemptedAttackTarget();}
    else if(!GetIsObjectValid(oAttackee)) {oAttackee = GetAttemptedSpellTarget();}

    if(!GetObjectSeen(oAttackee, OBJECT_SELF))
    {
        //If the current attack target is concealed and the caller does not have the appropriate effects to detect them, stop attacking.
        if(!GetHasEffect(EFFECT_TYPE_TRUESEEING, OBJECT_SELF) || GetHasFeat(FEAT_BLINDSIGHT_60_FEET, OBJECT_SELF))
        {
            if(!GetHasEffect(EFFECT_TYPE_SEEINVISIBLE, OBJECT_SELF))
            {
                if(GetHasEffect(EFFECT_TYPE_INVISIBILITY, oAttackee)
                || GetHasEffect(EFFECT_TYPE_IMPROVEDINVISIBILITY, oAttackee))
                {
                    //If the target has become invisible right in front, take a swing. If they are too far, then stop.
                    if(GetDistanceToObject(oAttackee) > 2.0)
                    {
                        ActionAttack(oAttackee, TRUE);
                        DetermineCombatRound();
                    }

                    else
                    {
                        ClearAllActions();
                        DetermineCombatRound();
                    }
                }
            }

            if(GetHasEffect(EFFECT_TYPE_SANCTUARY, oAttackee))
            {
                ClearAllActions();
                DetermineCombatRound();
            }
        }
    }

    else
    {
        //Different combat tactics.
        int nAI = GetLocalInt(OBJECT_SELF, "CombatRoundTactic");

        object oDef;
        int nDefAC;
        object oDed;
        int nDedAC;
        int nBaseAttack;

        object oFactionCycle;
        int nSrc;
        int nWiz;
        int nClr;
        int nDru;
        int nBrd;
        int nTotal;

        switch(nAI)
        {
            //Low tactical awareness:
            //Attack nearest.
            case 0:
                if(GetDistanceToObject(oAttackee) > 8.0f)
                {
                    oAttackee = GetNearestSeenEnemy(OBJECT_SELF);
                }

                DetermineCombatRound(oAttackee);

                break;

            //Determined tactical awareness:
            //Stays locked on the first target.
            //If the target is too far, switch to a ranged weapon.
            case 1:
                if(GetDistanceToObject(oAttackee) > 8.0f)
                {
                    ActionEquipMostDamagingRanged();
                }

                DetermineCombatRound(oAttackee);

                break;


            //Ranged tactical awareness:
            //If the target is too far, switch to a ranged weapon or switch to a closer target.
            case 2:
                if(GetDistanceToObject(oAttackee) > 8.0f)
                {
                    oAttackee = GetNearestSeenEnemy(OBJECT_SELF);

                    if(GetDistanceToObject(oAttackee) > 8.0f)
                    {
                        ActionEquipMostDamagingRanged();
                    }

                    else
                    {
                        ActionEquipMostDamagingMelee();
                    }
                }

                DetermineCombatRound(oAttackee);

                break;

            //Opportunistic tactical awareness:
            //Attack the most vulnerable enemy.
            case 3:
                oDef = GetFactionWorstAC(oAttackee, TRUE);
                nDefAC = GetAC(oDef);
                oDed = GetFactionMostDamagedMember(oAttackee, TRUE);
                nDedAC = GetAC(oDed);
                nBaseAttack = GetBaseAttackBonus(OBJECT_SELF);

                //If the most damaged is down to 20% of its total HP or lower, see if it can be hit.
                //If none are below 20% then attack the lowest AC.
                if(GetCurrentHitPoints(oDed) < (GetMaxHitPoints(oAttackee) / 5))
                {
                    if(nDedAC <= (nBaseAttack + 15))
                    {
                        oAttackee = oDed;
                    }

                    else
                    {
                        oAttackee = oDef;
                    }
                }

                else
                {
                    oAttackee = oDef;
                }

                DetermineCombatRound(oAttackee);

                break;

            //Mage hunter tactical awareness:
            //Will locate spell casters in the enemy party and attack them.
            //The caller will use Hide in Plain Sight if it is available.
            case 4:
                oFactionCycle = GetFirstFactionMember(oAttackee, TRUE);
                nSrc = GetLevelByClass(CLASS_TYPE_SORCERER, oFactionCycle);
                nWiz = GetLevelByClass(CLASS_TYPE_WIZARD, oFactionCycle);
                nClr = GetLevelByClass(CLASS_TYPE_CLERIC, oFactionCycle);
                nDru = GetLevelByClass(CLASS_TYPE_DRUID, oFactionCycle);
                nBrd = GetLevelByClass(CLASS_TYPE_BARD, oFactionCycle);
                nTotal = GetHitDice(oFactionCycle) / 3;

                while(GetIsObjectValid(oFactionCycle))
                {
                    if(nSrc > nTotal || nWiz > nTotal || nClr > nTotal || nDru > nTotal || nBrd > nTotal)
                    {
                        oAttackee = oFactionCycle;
                        break;
                    }

                    oFactionCycle = GetNextFactionMember(oFactionCycle, TRUE);
                }

                if(GetHasFeat(FEAT_HIDE_IN_PLAIN_SIGHT))
                {
                    if(GetDistanceToObject(oAttackee) < 1.5)
                    {
                        RunHideAndStrike(OBJECT_SELF, oAttackee);
                    }

                    else
                    {
                        SetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH, TRUE);
                        UseStealthMode();
                    }
                }

                DetermineCombatRound(oAttackee);

                break;

            //Dismantler combat awareness.
            //Will attempt to take down the strongest member of a party.
            //If they have too much AC, attack the party member with least HP%.
            case 5:
                oDed = GetFactionStrongestMember(oAttackee, TRUE);
                oDef = GetFactionBestAC(oAttackee, TRUE);
                nDefAC = GetAC(oDef);
                nBaseAttack = GetBaseAttackBonus(OBJECT_SELF);

                if(oDed == oDef)
                {
                    if(nDefAC > (nBaseAttack + 15))
                    {
                        oAttackee = GetFactionMostDamagedMember(oAttackee, TRUE);
                    }

                    else
                    {
                        oAttackee = oDed;
                    }
                }

                else
                {
                    oAttackee = oDed;
                }

                DetermineCombatRound(oAttackee);

                break;
        }
    }

    DetermineCombatRound(oAttackee);

    if(GetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1003));
    }
}




