#include "engine"

//::///////////////////////////////////////////////
//:: AREA_ENTER.NSS
//:: Silver Marches Script
//:://////////////////////////////////////////////
/*
    Generic area entry code.
*/
//:://////////////////////////////////////////////
//:: Created By: Ashton Shapcott
//:: Created On: Oct. 31, 2010
//:://////////////////////////////////////////////

#include "inc_areas"
#include "inc_ovl_spawn"
#include "inc_world"

// Performs the necessary area exploration checks.
void DoAreaExploration(object oPC, object oArea){
    int bExplore = FALSE;

    if(GetLocalInt(oArea, "area_reveal_automatic")){
        bExplore = TRUE;
    } else {
        // If we're not a global area, we don't get revealed.
        if(!GetIsGlobalArea(oArea)) return;

        int nDC = GetLocalInt(oArea, "area_reveal_dc");
        int nSkill = GetLocalInt(oArea, "area_reveal_skill");

        if(nDC == 0) nDC = 15;

        if(nSkill == 0){
            if(GetIsAreaNaturalExterior(oArea))    nSkill = SKILL_K_GEOGRAPHY;
            if(GetIsAreaDungeon(oArea))            nSkill = SKILL_K_DUNGEONEERING;
        }

        bExplore = GetIsSkillSuccessful(oPC, nSkill, nDC, TRUE);
    }

    if(bExplore) ExploreAreaForPlayer(oArea, oPC);
}

void DoDrownCount(object oPC, object oArea)
{
    if(GetArea(oPC) == oArea)
    {
        int nDuration = GetLocalInt(oPC, "DrownCount");

        if(GetLocalInt(oPC, "WaterBreathing") < 1) //Without Water Breathing
        {
            if(nDuration > 0)
            {
                SendMessageToPC(oPC, "You have air enough for " + IntToString(nDuration) + " rounds.");
                nDuration --;
                SetLocalInt(oPC, "DrownCount", nDuration);
                DelayCommand(6.0f, DoDrownCount(oPC, oArea));
            }

            else
            {
                effect eDrown = EffectDamage(GetMaxHitPoints(oPC) * 2, DAMAGE_TYPE_POSITIVE);

                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDrown, oPC);
                SendMessageToPC(oPC, "You have drowned!");
            }
        }

        else //With Water Breathing
        {
            DelayCommand(6.0f, DoDrownCount(oPC, oArea));
        }
    }
}

void DoUnderwaterAdjustments(object oPC, object oArea)
{
    int nFluid = GetLocalInt(oArea, "FluidDynamic");
    if(nFluid == 0) return;
    effect e01;
    effect e02;
    effect e03;
    effect e04;
    effect e05;
    effect e06;

    switch (nFluid)
    {
        case 0: break;
        case 1:     //Water, normal
            e01 = EffectMovementSpeedDecrease(10);
            e02 = EffectAttackDecrease(2);
            e03 = EffectDeaf();

            if(GetLocalInt(oPC, "WaterBreathing") < 1 && !GetHasFeat(2, oPC))
            {
                e04 = EffectSilence();
                e04 = SupernaturalEffect(e04);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, e04, oPC);
            }
            e01 = SupernaturalEffect(e01);
            e02 = SupernaturalEffect(e02);
            e03 = SupernaturalEffect(e03);


            ApplyEffectToObject(DURATION_TYPE_PERMANENT, e01, oPC);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, e02, oPC);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, e03, oPC);
    }

    int nCON = GetAbilityModifier(ABILITY_CONSTITUTION, oPC) + 10;

    //Temporary IF until Water Breathing feats exist.
    if(GetResRef(oPC) != "ufo_kuo_flip001"
    && GetResRef(oPC) != "ufo_kuo_hunt001"
    && GetResRef(oPC) != "ufo_kuo_ward001"
    && GetResRef(oPC) != "ufo_kuo_whip001"
    && GetResRef(oPC) != "ufo_kuo_tran001"
    && GetResRef(oPC) != "kuo_best001")
    //Real IF below.
    //if(!GetHasFeat(2, oPC))//If no Water Breathing feat. Checks for Water Breathing spell done each round,
    //inside the DoDrownCount function, to account for the duration.
    {
        SetLocalInt(oPC, "DrownCount", nCON);
        DoDrownCount(oPC, oArea);
    }
}

void DoArcaneSpellFailure(object oPC, object oArea){
    // Adds arcane spell failure if variables are set.
    int iSpellFailure = GetLocalInt(oArea, "area_spell_failure");
    if(iSpellFailure > 0){
        if(iSpellFailure > 100){
            iSpellFailure = 100;
        }
        effect eSpellFailure = SupernaturalEffect(EffectSpellFailure(iSpellFailure));
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSpellFailure, oPC);
    }
}

void DoAreaEnterMessage(object oPC, object oArea){
    string sMessage = GetLocalString(oArea, "area_enter_message");

    SendMessageToPC(oPC, sMessage);
}

void main()
{
    object oPC = GetEnteringObject();
    object oArea = GetArea(oPC);

    if(GetIsAreaPaused(oArea)){
        ApplyAreaPauseEffect(oPC);
    }

    SyncWeatherInArea(oArea);
    DoAreaExploration(oPC, oArea);
    DoArcaneSpellFailure(oPC, oArea);
    DoAreaEnterMessage(oPC, oArea);
    DoSpawnOverlandEncounters(oPC, oArea);
    DoUnderwaterAdjustments(oPC, oArea);

    SetInstanceNumber(oPC, GetInstanceNumber(oArea));
    DoInstanceLootAdjustments(oArea, oPC);
}
