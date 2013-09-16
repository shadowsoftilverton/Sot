#include "engine"
#include "inc_outlaws"

void main()
{
    object oExit = GetEnteringObject();
    string sResRef = GetStringLeft(GetResRef(oExit), 8);

    if(sResRef == "tsl_ban_")
    {
        AssignCommand(oExit, ClearAllActions());
        OutlawReturnToSpawnPoint(oExit);
    }
}
