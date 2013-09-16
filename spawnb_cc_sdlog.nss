#include "engine"

//
// Spawn Banner
// Conversation Check
// Spawn Delay Debugging on
//
int StartingConditional()
{
    object oSpawn = GetLocalObject(OBJECT_SELF, "ParentSpawn");
    object oArea = GetArea(oSpawn);
    if (GetLocalInt(oArea, "SpawnDelayDebug") == FALSE)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
