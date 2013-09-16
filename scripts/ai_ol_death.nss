/*
    OnDeath for outlaws.
    By Hardcore UFO
    Removes spawn waypoints
*/

#include "engine"

void main()
{
    DeleteLocalInt(GetLocalObject(OBJECT_SELF, "OutlawSpawnPoint"), "OutlawActive");
}


