/*
    OnPerception for outlaws.
    By Hardcore UFO
    They have a 10% chance of disliking any PC on seeing them.
    They will threaten the PC, walk to them, and if the PC does not leave then attack.
*/

#include "engine"
#include "inc_outlaws"
#include "nw_i0_generic"
#include "x0_i0_partywide"
/*
void GetDirty(object oThug4Life, object oTarget);

void main()
{
    object oPercy = GetLastPerceived();

    if(!GetIsPC(oPercy))
    {
        ExecuteScript("ai_onperception", OBJECT_SELF);
    }

    else
    {
        int nRandom = d100();
        string sThreat;
        int nThreat = d4();

        switch(nThreat)
        {
            case 1:
                sThreat = "Hey... I don't like your face. Why don't you get out of here and we'll forget about cuttin' you.";
                break;

            case 2:
                sThreat = "You ain't welcome here. Get out before I throw you out.";
                break;

            case 3:
                sThreat = "Wanna die, buddy? Get gone or else.";
                break;

            case 4:
                sThreat = "Hey, where's the coin you owe me? Better pay up, and now...";
                break;

            default:
                sThreat = "Hey, where's the coin you owe me? Better pay up, and now...";
                break;
        }

        //10% Chance of hostility to the new perception.
        if(nRandom > 90)
        {
            SetIsTemporaryEnemy(oPercy, OBJECT_SELF, FALSE);
            SpeakString(sThreat);
            ActionMoveToLocation(GetLocation(oPercy), FALSE);

            DelayCommand(12.0f, GetDirty(OBJECT_SELF, oPercy));
        }

        else if(nRandom <= 90)
        {
            ExecuteScript("ai_onperception", OBJECT_SELF);
        }
    }
}

void GetDirty(object oThug4Life, object oTarget)
{
    if(GetDistanceBetween(oThug4Life, oTarget) > 4.0f)
    {
        ClearAllActions();
        ActionMoveToLocation(GetLocation(oTarget), FALSE);
        DelayCommand(12.0f, GetDirty(oThug4Life, oTarget));
    }

    else
    {
        int nTimid = Std_GetSkillRank(SKILL_INTIMIDATE, oTarget, FALSE) + d10();
        int nStepOffBro = GetAbilityScore(oThug4Life, ABILITY_CHARISMA, FALSE) + d10();

        SendMessageToPC(oTarget, "Intimidate: " + IntToString(nTimid) + " vs. DC " + IntToString(nStepOffBro));

        //If the PC's Intimidate beats the outlaw'S Charisma they back down.
        if(nStepOffBro <= nTimid)
        {
            ClearPersonalReputation(oTarget, oThug4Life);
            ClearAllActions();
            AssignCommand(oThug4Life, SpeakString("Hrf... You ain't worth the trouble."));
            OutlawReturnToSpawnPoint(oThug4Life);
        }

        else if(nStepOffBro > nTimid)
        {
            DetermineCombatRound(oTarget);
        }
    }
}

*/

void GetDirty(object oThug4Life, object oTarget);

void main()
{
    object oPercy = GetLastPerceived();

    if(!GetIsPC(oPercy))
    {
        ExecuteScript("ai_onperception", OBJECT_SELF);
    }

    else
    {
        int nRandom = d100();
        string sThreat;
        int nThreat = d4();

        switch(nThreat)
        {
            case 1:
                sThreat = "Hey... I don't like your face. Why don't you get out of here and we'll forget about cuttin' you.";
                break;

            case 2:
                sThreat = "You ain't welcome here. Get out before I throw you out.";
                break;

            case 3:
                sThreat = "Wanna die, buddy? Get gone or else.";
                break;

            case 4:
                sThreat = "Hey, where's the coin you owe me? Better pay up, and now...";
                break;

            default:
                sThreat = "Hey, where's the coin you owe me? Better pay up, and now...";
                break;
        }

        //5% Chance of hostility to the new perception.
        if(nRandom > 95)
        {
            SetPCDislike(oPercy, OBJECT_SELF);

            //SetIsTemporaryEnemy(oPercy, OBJECT_SELF, FALSE);
            //SetIsTemporaryEnemy(OBJECT_SELF, oPercy, FALSE);
            SetFacingPoint(GetPosition(oPercy));
            SpeakString(sThreat);

            DelayCommand(12.0f, GetDirty(OBJECT_SELF, oPercy));
        }

        else if(nRandom <= 95)
        {
            ExecuteScript("ai_onperception", OBJECT_SELF);
        }
    }
}

void GetDirty(object oThug4Life, object oTarget)
{
    float fDist = GetDistanceBetween(oThug4Life, oTarget);

    if(fDist < 15.0f)
    {
        AssignCommand(oThug4Life, SpeakString("I warned you!"));
        AssignCommand(oThug4Life, DetermineCombatRound(oTarget));
    }

    else
    {
        ClearPersonalReputation(oTarget, oThug4Life);
        ClearPersonalReputation(oThug4Life, oTarget);
        AssignCommand(oThug4Life, ClearAllActions());
    }
}
