#include "engine"

// Spawns nEncounter at lTarget.
void EncounterWandSpawn(location lTarget, int nEncounter);

// Wrapper to allow delayed command.
void EncounterWandCopy(object oSource, location locLocation){
    CopyObject(oSource, locLocation);
}

void EncounterWandSpawn(location lTarget, int nEncounter){
    location lWaypoint = GetLocation(GetObjectByTag("zdm_encounter" + IntToString(nEncounter)));

    object oSpawn = GetFirstObjectInShape(SHAPE_CUBE, 10.0, lWaypoint);

    while(GetIsObjectValid(oSpawn)){
        DelayCommand(1.0, EncounterWandCopy(oSpawn, lTarget));
        oSpawn = GetNextObjectInShape(SHAPE_CUBE, 10.0, lWaypoint);
    }
}
