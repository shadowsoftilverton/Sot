#include "inc_debug"

//============================================================================//
//                  Overland Encounter System Header File                     //
//============================================================================//


// Prototypes
int GetOverlandSpawnChance(object oArea);

int GetSpawnChanceInClear(object oArea);

int GetSpawnChanceInRain(object oArea);

int GetSpawnChanceInSnow(object oArea);

int GetMinSpawnHour(object oArea);

int GetMaxSpawnHour(object oArea);

int GetMinSpawnNumber(object oArea);

int GetMaxSpawnNumber(object oArea);

int GetMinSpawnSize(object oArea);

int GetMaxSpawnSize(object oArea);

string GetSpawnCreatureResref(object oArea, int nCreature);

int GetOverlandSpawnsEnabled(object oArea);

location GetRandomLocationInArea(object oArea);

int GetIsOverlandSpawn(object oCreature);

float GetOverlandSpawnInterval(object oArea);

void FlagAsOverlandSpawn(object oCreature);

void DoDisableOverlandSpawns(object oArea);

void DoEnableOverlandSpawns(object oArea);

// Checks to make sure that values are valid for the variables
// If they aren't, or if all variables are zero, no spawning
// occurs. Note: This implicitly short-circuits the logic
// for areas where overland spawns are undefined, which is
// desirable to save processing and pseudo-heartbeats.
int GetAreaHasValidOverlandSpawnValues(object oArea);

void DoSpawnOverlandEncounters(object oPC, object oArea);

void DoDespawnOverlandEncounters(object oPC, object oArea);

// Definitions
int GetOverlandSpawnChance(object oArea) {
    return GetLocalInt(oArea, "enc_ovl_chance");
}

int GetSpawnChanceInClear(object oArea) {
    return GetLocalInt(oArea, "enc_wthr_clr_chance");
}

int GetSpawnChanceInRain(object oArea) {
    return GetLocalInt(oArea, "enc_wthr_rn_chance");
}

int GetSpawnChanceInSnow(object oArea) {
    return GetLocalInt(oArea, "enc_wthr_snw_chance");
}

int GetMinSpawnHour(object oArea) {
    return GetLocalInt(oArea, "enc_min_hour");
}

int GetMaxSpawnHour(object oArea) {
    return GetLocalInt(oArea, "enc_max_hour");
}

int GetMinSpawnNumber(object oArea) {
    return GetLocalInt(oArea, "enc_min_number");
}

int GetMaxSpawnNumber(object oArea) {
    return GetLocalInt(oArea, "enc_max_number");
}

int GetMinSpawnSize(object oArea) {
    return GetLocalInt(oArea, "enc_min_size");
}

int GetMaxSpawnSize(object oArea) {
    return GetLocalInt(oArea, "enc_max_size");
}

string GetSpawnCreatureResref(object oArea, int nCreature) {
    return GetLocalString(oArea, "enc_cr_" + IntToString(nCreature));
}

int GetOverlandSpawnsEnabled(object oArea) {
    return GetLocalInt(oArea, "enc_ovl_enabled");
}

location GetRandomLocationInArea(object oArea) {
    float fAreaH = IntToFloat(GetAreaSize(AREA_HEIGHT, oArea));
    float fAreaW = IntToFloat(GetAreaSize(AREA_WIDTH, oArea));

    float fMaxAreaSizeH = 32.0;
    float fMaxAreaSizeW = 32.0;

    float fScaleAreaH = fMaxAreaSizeH / fAreaH;
    float fScaleAreaW = fMaxAreaSizeW / fAreaW;

    float fXLoc32 = IntToFloat(((d8() - 1) * 4 + (d4() - 1)) * 10 + d10());
    float fYLoc32 = IntToFloat(((d8() - 1) * 4 + (d4() - 1)) * 10 + d10());

    float fXLoc = fXLoc32 / fScaleAreaW;
    float fYLoc = fYLoc32 / fScaleAreaH;

    vector vPosition = Vector(fXLoc, fYLoc, 0.0f);

    float fOrientation = IntToFloat(((d6() - 1) * 6 +(d6() - 1)) * 10 + (d10() - 1));

    return Location(oArea, vPosition, fOrientation);
}

int GetIsOverlandSpawn(object oCreature) {
    return GetLocalInt(oCreature, "enc_ovl_spawn");
}

float GetOverlandSpawnInterval(object oArea) {
    return GetLocalFloat(oArea, "enc_ovl_interval");
}

void FlagAsOverlandSpawn(object oCreature) {
    SetLocalInt(oCreature, "enc_ovl_spawn", 1);
}

void DoDisableOverlandSpawns(object oArea) {
    SetLocalInt(oArea, "enc_ovl_enabled", 0);
}

void DoEnableOverlandSpawns(object oArea) {
    SetLocalInt(oArea, "enc_ovl_enabled", 1);
}

int GetAreaHasValidOverlandSpawnValues(object oArea) {
    return(
           GetOverlandSpawnChance(oArea)   >  0    &&
           GetOverlandSpawnChance(oArea)   <  101  &&
           GetSpawnChanceInClear(oArea)    >= 0    &&
           GetSpawnChanceInClear(oArea)    <  101  &&
           GetSpawnChanceInRain(oArea)     >= 0    &&
           GetSpawnChanceInRain(oArea)     <  101  &&
           GetSpawnChanceInSnow(oArea)     >= 0    &&
           GetSpawnChanceInSnow(oArea)     <  101  &&
           GetMinSpawnHour(oArea)          >= 0    &&
           GetMinSpawnHour(oArea)          <= 23   &&
           GetMaxSpawnHour(oArea)          >= 0    &&
           GetMaxSpawnHour(oArea)          <= 23   &&
           GetMinSpawnNumber(oArea)        >= 0    &&
           GetMinSpawnNumber(oArea)        <= 10   &&
           GetMaxSpawnNumber(oArea)        >  0    &&
           GetMaxSpawnNumber(oArea)        <= 10   &&
           GetMinSpawnSize(oArea)          >= 0    &&
           GetMinSpawnSize(oArea)          <= 10   &&
           GetMaxSpawnSize(oArea)          >  0    &&
           GetMaxSpawnSize(oArea)          <= 10   &&
           GetOverlandSpawnInterval(oArea) >  0.0
    );
}


void DoSpawnOverlandEncounters(object oPC, object oArea) {
    //SendMessageToAllDMs("area_enter: Entering DoSpawnOverlandEncounters for " + GetName(oArea) + ".");

    if(!GetAreaHasValidOverlandSpawnValues(oArea)) return;
    if(!GetOverlandSpawnsEnabled(oArea)) return;
    if(GetIsDM(oPC) || !GetIsPC(oPC)) return;

    int nMinSpawnHour = GetMinSpawnHour(oArea);
    int nMaxSpawnHour = GetMaxSpawnHour(oArea);

    if(GetTimeHour() > nMaxSpawnHour || GetTimeHour() < nMinSpawnHour) return;

    int nOverlandSpawnChance = GetOverlandSpawnChance(oArea);

    int nSpawnChanceInClear = GetSpawnChanceInClear(oArea);
    int nSpawnChanceInRain = GetSpawnChanceInRain(oArea);
    int nSpawnChanceInSnow = GetSpawnChanceInSnow(oArea);

    int nSpawnChance = nOverlandSpawnChance;

    switch(GetWeather(oArea)) {
        case WEATHER_CLEAR:
            nSpawnChance = FloatToInt(nSpawnChance * (nSpawnChanceInClear / 100.0));
            break;
        case WEATHER_RAIN:
            nSpawnChance = FloatToInt(nSpawnChance * (nSpawnChanceInRain / 100.0));
            break;
        case WEATHER_SNOW:
            nSpawnChance = FloatToInt(nSpawnChance * (nSpawnChanceInSnow / 100.0));
            break;
        default: break;
    }

    int nMinSpawnNumber = GetMinSpawnNumber(oArea);
    int nMaxSpawnNumber = GetMaxSpawnNumber(oArea);

    int nMinSpawnSize = GetMinSpawnSize(oArea);
    int nMaxSpawnSize = GetMaxSpawnSize(oArea);

    int nSpawnNumber = Random((nMaxSpawnNumber + 1) - nMinSpawnNumber) + nMinSpawnNumber;

    int k;
    location lSpawn;
    int nSpawnSize;
    string sBlueprint;
    int nRandom;
    object oCreature;

    //SendMessageToAllDMs("area_enter: Entering spawn number loop.");

    int i;
    int j;
    for(i = 0; i < nSpawnNumber; i++) {
        if(Random(nSpawnChance + 1) > nSpawnChance) continue;

        // Determine type of spawn
        // Voodoo to total up the number of blueprints listed on the area
        k = 0;
        sBlueprint = GetSpawnCreatureResref(oArea, k);

        //SendMessageToAllDMs("area_enter: Entering blueprint scanning loop.");
        while(sBlueprint != "") {
            k += 1;
            sBlueprint = GetSpawnCreatureResref(oArea, k);
        }
        //SendMessageToAllDMs("area_enter: Concluded blueprint scanning loop.");

        // Get the actual blueprint we want to spawn
        nRandom = Random(k);
        sBlueprint = GetSpawnCreatureResref(oArea, nRandom);

        // The following checks implicitly to see that the creature
        // is spawned in a walkable location.
        oCreature = OBJECT_INVALID;

        int nSafety = 0;

        //SendMessageToAllDMs("area_enter: Entering location scanning loop.");
        while(!GetIsObjectValid(oCreature)) {
            if(nSafety++ > 20){
                SendMessageToDevelopers("OVERLAND SPAWNS - Safety activated on location scanning loop. Spawn aborted.");
                return;
            }

            lSpawn = GetRandomLocationInArea(oArea);
            oCreature = CreateObject(OBJECT_TYPE_CREATURE, sBlueprint, lSpawn);
        }
        //SendMessageToAllDMs("area_enter: Concluded location scanning loop.");

        DestroyObject(oCreature); // Destroy our test object but use location

        // Spawn according to spawn size
        nSpawnSize = Random((nMaxSpawnSize + 1) - nMinSpawnSize) + nMinSpawnSize;

        //SendMessageToAllDMs("area_enter: Entering spawning loop.");
        for(j = 0; j < nSpawnSize; j++) {
            oCreature = CreateObject(OBJECT_TYPE_CREATURE, sBlueprint, lSpawn);
            FlagAsOverlandSpawn(oCreature);
        }
        //SendMessageToAllDMs("area_enter: Concluded spawning loop.");
    }

    //SendMessageToAllDMs("area_enter: Concluded spawn number loop.");

    DoDisableOverlandSpawns(oArea);
    DelayCommand(GetOverlandSpawnInterval(oArea), DoEnableOverlandSpawns(oArea));

    //SendMessageToAllDMs("area_enter: Concluding DoSpawnOverlandEncounters for " + GetName(oArea) + ".");
}

void DoDespawnOverlandEncounters(object oPC, object oArea) {
    if(!GetAreaHasValidOverlandSpawnValues(oArea)) return;
    if(!GetOverlandSpawnsEnabled(oArea)) return;

    object oObject = GetFirstObjectInArea(oArea);

    while(GetIsObjectValid(oObject)) {
        if(GetIsOverlandSpawn(oObject))
            DestroyObject(oObject);

        oObject = GetNextObjectInArea(oArea);
    }
}
