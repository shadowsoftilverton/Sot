#include "engine"
#include "x0_i0_anims"
#include "nw_i0_generic"
#include "ai_wrapper"

void main()
{
    //Standard OnSpawn functions.
    SetListeningPatterns();
    WalkWayPoints();

//============================================================================//
//=================================GENERAL====================================//
//============================================================================//

    if(GetLocalString(OBJECT_SELF, "OnPerceive") != "")
    {
        SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT);            //Fire User Defined Event 1002
    }

    if(GetLocalString(OBJECT_SELF, "OnPhysicalAttacked") != "")
    {
        SetSpawnInCondition(NW_FLAG_ATTACK_EVENT);              //Fire User Defined Event 1005
    }

    if(GetLocalString(OBJECT_SELF, "OnSpellCastAt") != "")
    {
        SetSpawnInCondition(NW_FLAG_SPELL_CAST_AT_EVENT);       //Fire User Defined Event 1011
    }

    if(GetLocalString(OBJECT_SELF, "OnDamaged") != "")
    {
        SetSpawnInCondition(NW_FLAG_DAMAGED_EVENT);             //Fire User Defined Event 1006
    }

    if(GetLocalString(OBJECT_SELF, "OnCombatRoundEnd") != "")
    {
        SetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT);    //Fire User Defined Event 1003
    }

    if(GetLocalString(OBJECT_SELF, "OnDeath") != "")
    {
        SetSpawnInCondition(NW_FLAG_DEATH_EVENT);               //Fire User Defined Event 1007
    }

    //Frequently recurring variables.
    object oTarget;

//============================================================================//
//=================================EFFECTS====================================//
//============================================================================//

    //Various effects that can be applied to the creature.
    effect eEffect0;
    effect eEffect1;
    effect eEffect2;
    effect eEffect3;
    effect eEffect4;
    effect eEffect5;
    effect eEffect6;
    effect eEffect7;
    effect eEffect8;
    effect eEffect9;

    int nAmount0;
    int nAmount1;
    int nAmount2;
    int nAmount3;
    int nAmount4;
    int nAmount5;
    int nAmount6;
    int nAmount7;
    int nAmount8;
    int nAmount9;

    //Creatures that get incorporeal properties.
    if(GetLocalInt(OBJECT_SELF, "SpawnIncorporeal") > 0)
    {
        eEffect0 = EffectConcealment(50, MISS_CHANCE_TYPE_NORMAL);
        eEffect0 = ExtraordinaryEffect(eEffect0);
        eEffect1 = EffectCutsceneGhost();
        eEffect1 = ExtraordinaryEffect(eEffect1);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect0, OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect1, OBJECT_SELF);
    }

    //Creatures that get concealment.
    if(GetLocalInt(OBJECT_SELF, "SpawnConcealment") > 0)
    {
        nAmount0 = GetLocalInt(OBJECT_SELF, "SpawnConcealment");
        eEffect0 = EffectConcealment(nAmount0, MISS_CHANCE_TYPE_NORMAL);
        eEffect0 = ExtraordinaryEffect(eEffect0);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect0, OBJECT_SELF);
    }

    //Creatures that get See Invisibility.
    if(GetLocalInt(OBJECT_SELF, "SpawnSeeInvisible") > 0)
    {
        eEffect0 = EffectSeeInvisible();
        eEffect0 = ExtraordinaryEffect(eEffect0);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect0, OBJECT_SELF);
    }

//============================================================================//
//=================================VISUALS====================================//
//============================================================================//

    int nVisual = GetLocalInt(OBJECT_SELF, "SpawnVisual");

    if(nVisual != 0)
    {
        effect eVisual = EffectVisualEffect(nVisual, FALSE);
        SupernaturalEffect(eVisual);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVisual, OBJECT_SELF);
    }

//============================================================================//
//===============================BEHAVIOR=====================================//
//============================================================================//

    //Stealth.
    //The creature will enter stealth mode as soon as it spawns.
    if(GetLocalInt(OBJECT_SELF, "SpawnStealth") == TRUE)
    {
        SetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH, TRUE);
        UseStealthMode();
    }

    //Detect.
    //The creature will enter detect mode as soon as it spawns.
    if(GetLocalInt(OBJECT_SELF, "SpawnDetect") == TRUE)
    {
        SetActionMode(OBJECT_SELF, ACTION_MODE_DETECT, TRUE);
        UseDetectMode();
    }

    //Feats.
    //The value of the variable should be the ID number of the feat to use.
    //This will activate the feat on the creature, so valid feat categories
    //are combat modes, rages, etc.
    int nFeat = GetLocalInt(OBJECT_SELF, "SpawnActivateFeat");
    if(nFeat == TRUE)
    {
        if(GetHasFeat(nFeat, OBJECT_SELF) == TRUE)
        {
            ActionUseFeat(nFeat, OBJECT_SELF);
        }
    }
}
