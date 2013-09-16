#include "engine"

#include "inc_areas"
#include "inc_arrays"
#include "inc_encounter"
#include "inc_logs"

void main()
{
    object oPC = GetEnteringObject();

    if(GetIsDM(oPC) || !GetIsPC(oPC)) return;

    int i = 0;

    int nVFX;
    float fDur;

    int nSpawnChance = 0;

    float fTimer;

    object oSelf = OBJECT_SELF;
    object oArea = GetArea(oSelf);
    object oWaypoint = GetObjectByTag(GetWaypointTag(oSelf), i++);

    SendMessageToDevelopers("Assessing area as instance area.");

    int nIsInstance = GetIsDungeonInstance(oArea);
    int nIsRandomized = GetIsRandomizedInstance(oArea);

    string sCreatureArray;

    if(nIsInstance && nIsRandomized){
        sCreatureArray = GetAreaCreatureArray(oArea);

        SendMessageToDevelopers("Fetching instance creature array: <" + sCreatureArray + ">.");
    }

    location lLoc;
    object oSpawn;
    effect eVFX;
    while(GetIsObjectValid(oWaypoint)){
        if(!GetSpawnDisabled(oWaypoint) && GetIsSpawnHour(oWaypoint)){

            nSpawnChance = GetSpawnChance(oWaypoint);

            if(nSpawnChance == 0 && nIsInstance && nIsRandomized) nSpawnChance = 80;

            if(nSpawnChance >= d100() || nSpawnChance == 0){

                int nCount = 0;
                string sBlueprint = (nIsInstance && nIsRandomized)? GetRandomArrayElement(sCreatureArray) : GetSpawnBlueprint(oWaypoint, nCount);

                SendMessageToDevelopers("Spawning: <" + sBlueprint + ">.");

                lLoc = GetLocation(oWaypoint);

                if(!nIsInstance){
                    while(sBlueprint != ""){

                        nCount += 1;

                        sBlueprint = GetSpawnBlueprint(oWaypoint, nCount);
                    }
                }

                int nRandom = Random(nCount);

                sBlueprint = GetSpawnBlueprint(oWaypoint, nRandom);

                if(GetStringLeft(sBlueprint,4)=="ave_")//I don't want my creature tags overwritten by the spawn system - Ave
                {
                    oSpawn=CreateObject(OBJECT_TYPE_CREATURE, sBlueprint, lLoc, FALSE);
                    DestroyObject(oSpawn,GetLocalFloat(oWaypoint,RESET_TIME));
                }
                else
                CreateObject(OBJECT_TYPE_CREATURE, sBlueprint, lLoc, FALSE, SPAWN_TAG);

                if(GetIsSpawnVFXEnabled(oWaypoint)){
                    nVFX = GetSpawnVFXNumber(oWaypoint);
                    fDur = GetSpawnVFXDuration(oWaypoint);

                    effect eVFX = EffectVisualEffect(nVFX);

                    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVFX, lLoc, fDur);
                }
            }

            fTimer = GetLocalFloat(oWaypoint, RESET_TIME);

            SetSpawnDisabled(oWaypoint, TRUE);

            if(!nIsInstance) DelayCommand(fTimer, SetSpawnDisabled(oWaypoint, FALSE));
        }

        oWaypoint = GetObjectByTag(GetWaypointTag(oSelf), i++);
    }
}
