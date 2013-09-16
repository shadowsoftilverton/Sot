#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Control Weather                                                      //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 10 2011                                  //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    int nSpell = GetSpellId();
    object oTarget = GetArea(OBJECT_SELF);
    effect eVis = EffectVisualEffect(VFX_IMP_DOOM);
    int nWeather;
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = d12() + d12() + d12() + d12();
    int nDruidLevels = GetLevelByClass(CLASS_TYPE_DRUID);

    if(nMetaMagic == METAMAGIC_EXTEND)
        nDuration *= 2;

    if(nDruidLevels > 0)
        nDuration *= 2;

    if(nSpell == SPELL_CONTROL_WEATHER_CLEAR)
        nWeather = WEATHER_CLEAR;
    else if(nSpell == SPELL_CONTROL_WEATHER_RAIN)
        nWeather = WEATHER_RAIN;
    else if(nSpell == SPELL_CONTROL_WEATHER_SNOW)
        nWeather = WEATHER_SNOW;
    else if(nSpell == SPELL_CONTROL_WEATHER_RESTORE)
        nWeather = WEATHER_USE_AREA_SETTINGS;

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    SetWeather(oTarget, nWeather);
}
