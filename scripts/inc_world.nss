//::///////////////////////////////////////////////
//:: INC_WORLD.NSS
//:: Silver Marches Script
//:://////////////////////////////////////////////
/*
    Handles a lot of the worldwide ambiance funcs,
    such as weather and persistent time.
*/
//:://////////////////////////////////////////////
//:: Created By: Ashton Shapcott
//:: Created On: Oct. 31, 2010
//:://////////////////////////////////////////////
//:: Modified By: Invictus
//:: Modified On: March 23, 2012
//:://////////////////////////////////////////////
//:: Modified By: Ave
//:: Modified On: April 04, 2012
//:://////////////////////////////////////////////

#include "aps_include"
#include "nwnx_funcs"
#include "inc_areas"


const int WEATHER_TYPE_INVALID                  =  0;
const int WEATHER_TYPE_CLEAR                    =  1;
const int WEATHER_TYPE_CLOUDY                   =  2;
const int WEATHER_TYPE_OVERCAST                 =  3;
const int WEATHER_TYPE_LIGHT_PRECIPITATION      =  4;
const int WEATHER_TYPE_HEAVY_PRECIPITATION      =  5;
const int WEATHER_TYPE_MINOR_STORM              =  6;
const int WEATHER_TYPE_MAJOR_STORM              =  7;
const int WEATHER_TYPE_NATURAL_DISASTER         =  8;
const int WEATHER_TYPE_SNOW                     =  9;
const int WEATHER_TYPE_BLIZZARD                 = 10;
const int WEATHER_TYPE_HELLFIRE                 = 11;


//Weather chance consts no longer used.
const int WEATHER_CHANCE_CLEAR                  = 30;
const int WEATHER_CHANCE_CLOUDY                 = 20;
const int WEATHER_CHANCE_OVERCAST               = 12;
const int WEATHER_CHANCE_PRECIP_L               = 12;
const int WEATHER_CHANCE_PRECIP_H               = 10;
const int WEATHER_CHANCE_STORM_MIN              =  6;
const int WEATHER_CHANCE_STORM_MAJ              =  4;
const int WEATHER_CHANCE_DISASTER               =  2;
const int WEATHER_CHANCE_SNOW                   =  4;
const int WEATHER_CHANCE_BLIZZARD               =  2;

struct weather{
    //int nLightColor;
    int nFogAmountSun;
    int nFogAmountMoon;
    int nFogColorSun;
    int nFogColorMoon;
    int nSkybox;
    int nWeatherType;
    int nWeatherScheme;
};

// Gets if nType is a valid weather type with WEATHER_TYPE_* variables, NOT the
// standard WEATHER_* variables.
int GetIsWeatherValid(int nType);

// Gets a weather structure with preset values corresponding to the given nType.
struct weather GetWeatherFromType(int nType);

// Updates the weather for all global areas.
void UpdateWeather();

// Syncronizes the lighting and fog in an area to match the global weather
void SyncWeatherInArea(object oArea);

// Initializes the weather system.
int InitializeWeather();

// Initializes the time.
int InitializeTime();

int GetIsWeatherValid(int nType) {
    return nType != WEATHER_TYPE_INVALID;
}

struct weather GetWeatherFromType(int nType) {
    struct weather Weather;

    switch(nType){
        case WEATHER_TYPE_CLEAR:
            //Weather.nLightColor     = TILE_MAIN_LIGHT_COLOR_WHITE;
            Weather.nFogAmountSun   = 0;
            Weather.nFogAmountMoon  = 0;
            Weather.nFogColorSun    = FOG_COLOR_GREY;
            Weather.nFogColorMoon   = FOG_COLOR_GREY;
            Weather.nSkybox         = SKYBOX_DESERT_CLEAR;
            Weather.nWeatherType    = WEATHER_CLEAR;
            Weather.nWeatherScheme  = WEATHER_TYPE_CLEAR;
        break;

        case WEATHER_TYPE_CLOUDY:
            //Weather.nLightColor     = TILE_MAIN_LIGHT_COLOR_WHITE;
            Weather.nFogAmountSun   = 05;
            Weather.nFogAmountMoon  = 05;
            Weather.nFogColorSun    = 0x777777;
            Weather.nFogColorMoon   = 0x777777;
            Weather.nSkybox         = 65; //Doyle_clear1
            Weather.nWeatherType    = WEATHER_CLEAR;
            Weather.nWeatherScheme  = WEATHER_TYPE_CLOUDY;
        break;

        case WEATHER_TYPE_OVERCAST:
            //Weather.nLightColor     = TILE_MAIN_LIGHT_COLOR_DIM_WHITE;
            Weather.nFogAmountSun   = 10;
            Weather.nFogAmountMoon  = 10;
            Weather.nFogColorSun    = 0x666666;
            Weather.nFogColorMoon   = 0x666666;
            Weather.nSkybox         = 34; //TROD_VALE
            Weather.nWeatherType    = WEATHER_CLEAR;
            Weather.nWeatherScheme  = WEATHER_TYPE_OVERCAST;
        break;

        case WEATHER_TYPE_LIGHT_PRECIPITATION:
            //Weather.nLightColor     = TILE_MAIN_LIGHT_COLOR_DIM_WHITE;
            Weather.nFogAmountSun   = 10;
            Weather.nFogAmountMoon  = 10;
            Weather.nFogColorSun    = 0x666666;
            Weather.nFogColorMoon   = 0x666666;
            Weather.nSkybox         = 78;//Dem_coudy
            Weather.nWeatherType    = WEATHER_RAIN;
            Weather.nWeatherScheme  = WEATHER_TYPE_LIGHT_PRECIPITATION;
        break;

        case WEATHER_TYPE_HEAVY_PRECIPITATION:
            //Weather.nLightColor     = TILE_MAIN_LIGHT_COLOR_DIM_WHITE;
            Weather.nFogAmountSun   = 30;
            Weather.nFogAmountMoon  = 30;
            Weather.nFogColorSun    = 0x666666;
            Weather.nFogColorMoon   = 0x666666;
            Weather.nSkybox         = 77; //Dem_stormy
            Weather.nWeatherType    = WEATHER_RAIN;
            Weather.nWeatherScheme  = WEATHER_TYPE_HEAVY_PRECIPITATION;
        break;

        case WEATHER_TYPE_MINOR_STORM:
            //Weather.nLightColor     = TILE_MAIN_LIGHT_COLOR_DIM_WHITE;
            Weather.nFogAmountSun   = 50;
            Weather.nFogAmountMoon  = 50;
            Weather.nFogColorSun    = 0x555555;
            Weather.nFogColorMoon   = 0x555555;
            Weather.nSkybox         = SKYBOX_GRASS_STORM;
            Weather.nWeatherType    = WEATHER_RAIN;
            Weather.nWeatherScheme  = WEATHER_TYPE_MINOR_STORM;
        break;

        case WEATHER_TYPE_MAJOR_STORM:
            //Weather.nLightColor     = TILE_MAIN_LIGHT_COLOR_BLACK;
            Weather.nFogAmountSun   = 60;
            Weather.nFogAmountMoon  = 60;
            Weather.nFogColorSun    = 0x444444;
            Weather.nFogColorMoon   = 0x444444;
            Weather.nSkybox         = 67;//Doyle cloudy
            Weather.nWeatherType    = WEATHER_RAIN;
            Weather.nWeatherScheme  = WEATHER_TYPE_MAJOR_STORM;
        break;

        case WEATHER_TYPE_NATURAL_DISASTER:
            //Weather.nLightColor     = TILE_MAIN_LIGHT_COLOR_BLACK;
            Weather.nFogAmountSun   = 80;
            Weather.nFogAmountMoon  = 80;
            Weather.nFogColorSun    = 0x222222;
            Weather.nFogColorMoon   = 0x222222;
            Weather.nSkybox         = 68;//Doyle Stormy
            Weather.nWeatherType    = WEATHER_RAIN;
            Weather.nWeatherScheme  = WEATHER_TYPE_NATURAL_DISASTER;
        break;

        case WEATHER_TYPE_SNOW:
            //Weather.nLightColor    = TILE_MAIN_LIGHT_COLOR_DIM_WHITE;
            Weather.nFogAmountSun  = 30;
            Weather.nFogAmountMoon = 30;
            Weather.nFogColorSun   = 0x777777;
            Weather.nFogColorMoon  = 0x777777;
            Weather.nSkybox        = SKYBOX_WINTER_CLEAR;
            Weather.nWeatherType   = WEATHER_SNOW;
            Weather.nWeatherScheme = WEATHER_TYPE_SNOW;
        break;

        case WEATHER_TYPE_BLIZZARD:
            //Weather.nLightColor    = TILE_MAIN_LIGHT_COLOR_BLACK;
            Weather.nFogAmountSun  = 60;
            Weather.nFogAmountMoon = 60;
            Weather.nFogColorSun   = 0x888888;
            Weather.nFogColorMoon  = 0x888888;
            Weather.nSkybox        = SKYBOX_ICY;
            Weather.nWeatherType   = WEATHER_SNOW;
            Weather.nWeatherScheme = WEATHER_TYPE_BLIZZARD;
        break;

        case WEATHER_TYPE_HELLFIRE:
            //Weather.nLightColor    = TILE_MAIN_LIGHT_COLOR_BLACK;
            Weather.nFogAmountSun  = 40;
            Weather.nFogAmountMoon = 40;
            Weather.nFogColorSun   = 0x882222;
            Weather.nFogColorMoon  = 0x882222;
            Weather.nSkybox        = 35;
            Weather.nWeatherType   = WEATHER_CLEAR;
            Weather.nWeatherScheme = WEATHER_TYPE_HELLFIRE;
        break;
    }

    return Weather;
}

void GlobalSynchWeather()
{
   object oPC=GetFirstPC();
   while (GetIsObjectValid(oPC))
   {
      SyncWeatherInArea(GetArea(oPC));
      oPC=GetNextPC();
   }
}

void DM_SetWeather(int iWeatherType)
{
    struct weather w=GetWeatherFromType(iWeatherType);
    SetPersistentInt(GetModule(), "MOD_WEATHER_COLOR_SUN", w.nFogColorSun);
    SetPersistentInt(GetModule(), "MOD_WEATHER_COLOR_MOON", w.nFogColorMoon);
    SetPersistentInt(GetModule(), "MOD_WEATHER_AMOUNT_SUN", w.nFogAmountSun);
    SetPersistentInt(GetModule(), "MOD_WEATHER_AMOUNT_MOON", w.nFogAmountMoon);
    SetPersistentInt(GetModule(), "MOD_WEATHER_SKYBOX", w.nSkybox);
    SetPersistentInt(GetModule(), "MOD_WEATHER_TYPE", w.nWeatherType);
    SetPersistentInt(GetModule(), "MOD_WEATHER_SCHEME", w.nWeatherScheme);
    SetWeather(GetModule(), WEATHER_CLEAR); // Here to prevent the bug where lightning continues to occur when going from rain->snow
    SetWeather(GetModule(), w.nWeatherType);
    GlobalSynchWeather();
}

void UpdateWeather() {

int ClearChance;
int CloudyChance;
int OvercastChance;
int PrecipLChance;
int PrecipHChance;
int StormMinChance;
int StormMajChance;
int DisasterChance;
int SnowChance;
int BlizzardChance;

if(GetLocalInt(GetModule(),"ave_forecaster")<2)//clear
{
    ClearChance=80;
    CloudyChance=12;
    OvercastChance=5;
    PrecipLChance=3;
    PrecipHChance=0;
    StormMinChance=0;
    StormMajChance=0;
    DisasterChance=0;
    SnowChance=0;
    BlizzardChance=0;
}
else if(GetLocalInt(GetModule(),"ave_forecaster")<4)//clouds
{
    ClearChance=25;
    CloudyChance=10;
    OvercastChance=10;
    PrecipLChance=32;
    PrecipHChance=10;
    StormMinChance=5;
    StormMajChance=2;
    DisasterChance=1;
    SnowChance=0;//Was 5
    BlizzardChance=0;
}
else if(GetLocalInt(GetModule(),"ave_forecaster")<9)//rain
{
    ClearChance=35;
    CloudyChance=6;
    OvercastChance=5;
    PrecipLChance=10;
    PrecipHChance=20;
    StormMinChance=12;
    StormMajChance=8;
    DisasterChance=3;
    SnowChance=0;//Was 1
    BlizzardChance=0;
}
else//snow
{
    ClearChance=5;
    CloudyChance=5;
    OvercastChance=1;
    PrecipLChance=4;
    PrecipHChance=0;
    StormMinChance=0;
    StormMajChance=0;
    DisasterChance=0;
    SnowChance=65;
    BlizzardChance=20;
}
    float fTimeOffset = HoursToSeconds(1 + d4());
    int nWeatherRange = ClearChance     +
                        CloudyChance    +
                        OvercastChance  +
                        PrecipLChance   +
                        PrecipHChance   +
                        StormMinChance  +
                        StormMajChance  +
                        DisasterChance  +
                        SnowChance      +
                        BlizzardChance;

    int nWeatherSelection = Random(nWeatherRange);


    struct weather w;
    int bFlag = FALSE;

    nWeatherRange -= BlizzardChance;
    if(nWeatherSelection >= nWeatherRange && !bFlag) {
        w = GetWeatherFromType(WEATHER_TYPE_BLIZZARD);
        SetLocalInt(GetModule(), "ave_forecaster", WEATHER_TYPE_BLIZZARD);
        bFlag = TRUE;
    }

    nWeatherRange -= SnowChance;
    if(nWeatherSelection >= nWeatherRange && !bFlag) {
        w = GetWeatherFromType(WEATHER_TYPE_SNOW);
        SetLocalInt(GetModule(), "ave_forecaster", WEATHER_TYPE_SNOW);
        bFlag = TRUE;
    }

    nWeatherRange -= DisasterChance;
    if(nWeatherSelection >= nWeatherRange && !bFlag) {
        w = GetWeatherFromType(WEATHER_TYPE_NATURAL_DISASTER);
        SetLocalInt(GetModule(), "ave_forecaster", WEATHER_TYPE_NATURAL_DISASTER);
        bFlag = TRUE;
    }

    nWeatherRange -= StormMajChance;
    if(nWeatherSelection >= nWeatherRange && !bFlag) {
        w = GetWeatherFromType(WEATHER_TYPE_MAJOR_STORM);
        SetLocalInt(GetModule(), "ave_forecaster", WEATHER_TYPE_MAJOR_STORM);
        bFlag = TRUE;
    }

    nWeatherRange -= StormMinChance;
    if(nWeatherSelection >= nWeatherRange && !bFlag) {
        w = GetWeatherFromType(WEATHER_TYPE_MINOR_STORM);
        SetLocalInt(GetModule(), "ave_forecaster", WEATHER_TYPE_MINOR_STORM);
        bFlag = TRUE;
    }

    nWeatherRange -= PrecipHChance;
    if(nWeatherSelection >= nWeatherRange && !bFlag) {
        w = GetWeatherFromType(WEATHER_TYPE_HEAVY_PRECIPITATION);
        SetLocalInt(GetModule(), "ave_forecaster", WEATHER_TYPE_HEAVY_PRECIPITATION);
        bFlag = TRUE;
    }

    nWeatherRange -= PrecipLChance;
    if(nWeatherSelection >= nWeatherRange && !bFlag) {
        w = GetWeatherFromType(WEATHER_TYPE_LIGHT_PRECIPITATION);
        SetLocalInt(GetModule(), "ave_forecaster", WEATHER_TYPE_LIGHT_PRECIPITATION);
        bFlag = TRUE;
    }

    nWeatherRange -= OvercastChance;
    if(nWeatherSelection >= nWeatherRange && !bFlag) {
        w = GetWeatherFromType(WEATHER_TYPE_OVERCAST);
        SetLocalInt(GetModule(), "ave_forecaster", WEATHER_TYPE_OVERCAST);
        bFlag = TRUE;
    }

    nWeatherRange -= CloudyChance;
    if(nWeatherSelection >= nWeatherRange && !bFlag) {
        w = GetWeatherFromType(WEATHER_TYPE_CLOUDY);
        SetLocalInt(GetModule(), "ave_forecaster", WEATHER_TYPE_CLOUDY);
        bFlag = TRUE;
    }

    nWeatherRange -= ClearChance;
    if(nWeatherSelection >= nWeatherRange && !bFlag) {
        w = GetWeatherFromType(WEATHER_TYPE_CLEAR);
        SetLocalInt(GetModule(), "ave_forecaster", WEATHER_TYPE_CLEAR);
        bFlag = TRUE;
    }

    //The delay is so the module 'knows' what the weather is going to be for the benefit of weather forecasting PCs.

    DelayCommand(fTimeOffset-0.5,SetWeather(GetModule(), WEATHER_CLEAR)); // Here to prevent the bug where lightning continues to occur when going from rain->snow
    DelayCommand(fTimeOffset-0.4,SetWeather(GetModule(), w.nWeatherType));

    DelayCommand(fTimeOffset-0.3,SetPersistentInt(GetModule(), "MOD_WEATHER_COLOR_SUN", w.nFogColorSun));
    DelayCommand(fTimeOffset-0.3,SetPersistentInt(GetModule(), "MOD_WEATHER_COLOR_MOON", w.nFogColorMoon));
    DelayCommand(fTimeOffset-0.3,SetPersistentInt(GetModule(), "MOD_WEATHER_AMOUNT_SUN", w.nFogAmountSun));
    DelayCommand(fTimeOffset-0.3,SetPersistentInt(GetModule(), "MOD_WEATHER_AMOUNT_MOON", w.nFogAmountMoon));
    DelayCommand(fTimeOffset-0.3,SetPersistentInt(GetModule(), "MOD_WEATHER_SKYBOX", w.nSkybox));
    DelayCommand(fTimeOffset-0.3,SetPersistentInt(GetModule(), "MOD_WEATHER_TYPE", w.nWeatherType));
    DelayCommand(fTimeOffset-0.3,SetPersistentInt(GetModule(), "MOD_WEATHER_SCHEME", w.nWeatherScheme));
    DelayCommand(fTimeOffset-0.2,GlobalSynchWeather());
    DelayCommand(fTimeOffset-0.1, UpdateWeather());
}



void SyncWeatherInArea(object oArea) {
    if(!GetLocalInt(GetModule(), "MOD_WEATHER_SYSTEM_INITIALIZED")) return; // Necessary to prevent NWNX!INIT shitfit.

    if(GetIsAreaInterior(oArea)) return;

    int nFogColorSun   = GetPersistentInt(GetModule(), "MOD_WEATHER_COLOR_SUN");
    int nFogColorMoon  = GetPersistentInt(GetModule(), "MOD_WEATHER_COLOR_MOON");
    int nFogAmountSun  = GetPersistentInt(GetModule(), "MOD_WEATHER_AMOUNT_SUN");
    int nFogAmountMoon = GetPersistentInt(GetModule(), "MOD_WEATHER_AMOUNT_MOON");
    int nSkybox = GetPersistentInt(GetModule(), "MOD_WEATHER_SKYBOX");
    int nWeatherType   = GetPersistentInt(GetModule(), "MOD_WEATHER_TYPE");
    int nWeatherScheme = GetPersistentInt(GetModule(), "MOD_WEATHER_SCHEME");

    if(GetLocalInt(oArea, "AREA_WEATHER_SCHEME") == nWeatherScheme) return;

    SetFogColor(FOG_TYPE_SUN, nFogColorSun, oArea);
    SetFogColor(FOG_TYPE_MOON, nFogColorMoon, oArea);
    SetFogAmount(FOG_TYPE_SUN, nFogAmountSun, oArea);
    SetFogAmount(FOG_TYPE_MOON, nFogAmountMoon, oArea);
    SetSkyBox(nSkybox, oArea);
    SetWeather(oArea, nWeatherType);
    SetLocalInt(oArea, "AREA_WEATHER_SCHEME", nWeatherScheme);
}

int InitializeWeather() {
    // If we've already initialized, break off.
    if(GetLocalInt(GetModule(), "MOD_WEATHER_SYSTEM_INTIAILIZED")) return FALSE;

    SetLocalInt(GetModule(), "MOD_WEATHER_SYSTEM_INITALIZED", TRUE);

    //int nType = GetPersistentInt(GetModule(), "MOD_WEATHER");

    // Initializes our weather variable for the first time, and in case anyone
    // happens to dump an invalid variable in it.
    //if(!GetIsWeatherValid(nType)){
    //    nType = WEATHER_TYPE_CLEAR;
    //    WriteTimestampedLogEntry("MODULE :: WORLD :: Module weather was reset.");
    //}

    UpdateWeather();

    return TRUE;
}

int InitializeTime() {
    int nSecond = (GetTimeOfDay().sec - 1000000000) * 4;

    SetTime(0, 0, nSecond, 0);

    return TRUE;
}
