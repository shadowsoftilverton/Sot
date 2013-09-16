#include "engine"

void OutlawReturnToSpawnPoint(object oThug4Life);

void OutlawJumpToSpawnPoint(object oThug4Life, object oSpawnPoint);

void OutlawReturnToSpawnPoint(object oThug4Life)
{
    object oSpawn = GetLocalObject(oThug4Life, "OutlawSpawnPoint");

    ClearPersonalReputation(GetAttemptedAttackTarget(), oThug4Life);
    ClearPersonalReputation(oThug4Life, GetAttemptedAttackTarget());
    AssignCommand(oThug4Life, ActionMoveToObject(oSpawn, FALSE, 1.0f));
    DelayCommand(20.0f, OutlawJumpToSpawnPoint(oThug4Life, oSpawn));
}

//If not thee in 20 seconds, the creature is jumped (circumvent path issues).
void OutlawJumpToSpawnPoint(object oThug4Life, object oSpawnPoint)
{
    if(GetDistanceBetween(oThug4Life, oSpawnPoint) > 7.0f)
    {
        AssignCommand(oThug4Life, ActionJumpToObject(oSpawnPoint, FALSE));
    }
}
