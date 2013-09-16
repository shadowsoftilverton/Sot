#include "engine"

//::///////////////////////////////////////////////
//:: INC_MOD.NSS
//:: Silver Marches Script
//:://////////////////////////////////////////////
/*
    Handles module-specific data, largely that of
    reconfiguring player feats, skills, etc.
*/
//:://////////////////////////////////////////////
//:: Created By: Ashton Shapcott
//:: Created On: Nov. 2, 2010
//:://////////////////////////////////////////////

#include "x2_inc_itemprop"
#include "nwnx_funcs"
#include "nwnx_defenses"

// ** DOCUMENTATION ** //

// Reconfigures a character's feat selection automatically based on the basic
// module presets.
// * nSave: If TRUE, save the character when the changes are made.
void ReconfigureFeats(object oPC, int nSave = TRUE);

// Reconfigures a character's skill selection automatically based on the module
// presets.
// * nSave: If TRUE, save the character when the changes are made.
void ReconfigureSkills(object oPC, int nSave = TRUE);

// Enables the prestige class switches for custom prestige classes requiring
// additional support.
void EnablePrestigeClasses(object oPC);

void ApplyDivineGraceFeatProperties(object oPC);
void ClearDivineGraceFeatProperties(object oPC);

void ApplyPerfectSelfFeatProperties(object oPC);
void ClearPerfectSelfFeatProperties(object oPC);

void ApplyPermanentFeatProperties(object oPC);
void ClearPermanentFeatProperties(object oPC);

// ** IMPLEMENTATION ** //

void ReconfigureFeats(object oPC, int nSave = TRUE){
    int nRace = GetRacialType(oPC);

    SendMessageToPC(oPC, "Configuring feats.");

    // Feats to Add
    if(!GetHasFeat(FEAT_UTILITY_WAND, oPC))      AddKnownFeat(oPC, FEAT_UTILITY_WAND);
    if(!GetHasFeat(FEAT_UTILITY_WAND_SELF, oPC)) AddKnownFeat(oPC, FEAT_UTILITY_WAND_SELF);

    switch(nRace){
        case RACIAL_TYPE_DWARF:
            if(!GetHasFeat(FEAT_WEAPON_PROFICIENCY_DWARF, oPC))     AddKnownFeat(oPC, FEAT_WEAPON_PROFICIENCY_DWARF);
        break;
    }

    if(GetHasFeat(FEAT_POWER_ATTACK, oPC)){
        RemoveKnownFeat(oPC, FEAT_POWER_ATTACK);
        AddKnownFeat(oPC, FEAT_SOT_POWER_ATTACK);
    }

    if(GetHasFeat(FEAT_IMPROVED_POWER_ATTACK, oPC)){
        RemoveKnownFeat(oPC, FEAT_IMPROVED_POWER_ATTACK);
        AddKnownFeat(oPC, FEAT_SOT_IMPROVED_POWER_ATTACK);
    }

    if(GetHasFeat(FEAT_EXPERTISE, oPC)){
        RemoveKnownFeat(oPC, FEAT_EXPERTISE);
        AddKnownFeat(oPC, FEAT_SOT_EXPERTISE);
    }

    if(GetHasFeat(FEAT_IMPROVED_EXPERTISE, oPC)){
        RemoveKnownFeat(oPC, FEAT_IMPROVED_EXPERTISE);
        AddKnownFeat(oPC, FEAT_SOT_IMPROVED_EXPERTISE);
    }

    if(GetLevelByClass(CLASS_TYPE_FIGHTER, oPC) > 0){
        if(!GetHasFeat(FEAT_TOWER_SHIELD_PROFICIENCY, oPC)) AddKnownFeat(oPC, FEAT_TOWER_SHIELD_PROFICIENCY, GetHitDice(oPC));
    }

    if(GetHasFeat(FEAT_DWARVEN_DEFENDER_DEFENSIVE_STANCE, oPC)) {
        RemoveKnownFeat(oPC, FEAT_DWARVEN_DEFENDER_DEFENSIVE_STANCE);
        AddKnownFeat(oPC, FEAT_SOT_DEFENSIVE_STANCE);
    }

    if(GetHasFeat(FEAT_PERFECT_SELF, oPC)) {
        RemoveKnownFeat(oPC, FEAT_PERFECT_SELF);
        AddKnownFeat(oPC, FEAT_SOT_PERFECT_SELF);
    }

    if(GetHasFeat(FEAT_DIVINE_GRACE, oPC)) {
        RemoveKnownFeat(oPC, FEAT_DIVINE_GRACE);
        AddKnownFeat(oPC, FEAT_SOT_DIVINE_GRACE);
    }

    ExportSingleCharacter(oPC);
}

void ReconfigureSkills(object oPC, int nSave = TRUE){
    int nRank, nPoints;

    /*

    :: To disable the acquisition of a skill, use the following template:

    if(GetHasSkill(SKILL_CONST_VALUE, oPC)){
        nRank = GetSkillRank(SKILL_CONST_VALUE, oPC, TRUE);
        nPoints = GetPCSkillPoints(oPC);

        SetSkillRank(oPC, SKILL_CONST_VALUE, 0);
        SetPCSkillPoints(oPC, nRank + nPoints);
    }

    */

    ExportSingleCharacter(oPC);
}

void EnablePrestigeClasses(object oPC){
    int nDivineSpellcasting = (GetLevelByClass(CLASS_TYPE_CLERIC, oPC) + 1)/2;

    int nPotential = (GetLevelByClass(CLASS_TYPE_DRUID, oPC) + 1)/2;
    if(nPotential > nDivineSpellcasting) nDivineSpellcasting = nPotential;

    nPotential = (GetLevelByClass(CLASS_TYPE_PALADIN, oPC) + 2)/4;
    if(nPotential > nDivineSpellcasting) nDivineSpellcasting = nPotential;

    nPotential = (GetLevelByClass(CLASS_TYPE_RANGER, oPC) + 2)/4;
    if(nPotential > nDivineSpellcasting) nDivineSpellcasting = nPotential;

    for(nDivineSpellcasting; nDivineSpellcasting > 0; nDivineSpellcasting--){
        SetLocalInt(oPC, "DIVSPELL" + IntToString(nDivineSpellcasting), TRUE);
    }
}

//----------------------------------------------------------------------------//

void ApplyPerfectSelfFeatProperties(object oPC) {
    if(GetHasFeat(FEAT_SOT_PERFECT_SELF, oPC)) {
        effect eMindImmunity = EffectImmunity(IMMUNITY_TYPE_MIND_SPELLS);
        effect eDamageResistanceSlashing = EffectDamageResistance(DAMAGE_TYPE_SLASHING, 5);
        effect eDamageResistancePiercing = EffectDamageResistance(DAMAGE_TYPE_PIERCING, 5);
        effect eDamageResistanceBludgeoning = EffectDamageResistance(DAMAGE_TYPE_BLUDGEONING, 5);
        effect eRegeneration = EffectRegenerate(3, 6.0);

        effect eLink = EffectLinkEffects(eMindImmunity, eDamageResistanceSlashing);
        eLink = EffectLinkEffects(eLink, eDamageResistancePiercing);
        eLink = EffectLinkEffects(eLink, eDamageResistanceBludgeoning);
        eLink = EffectLinkEffects(eLink, eRegeneration);

        eLink = SupernaturalEffect(eLink);

        SetEffectSpellId(eLink, PERFECT_SELF_SPELL_ID);

        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oPC);
    }
}

void ClearPerfectSelfFeatProperties(object oPC) {
    effect eLoop = GetFirstEffect(oPC);

    while(GetIsEffectValid(eLoop)) {
        int nSpellId = GetEffectSpellId(eLoop);

        if(nSpellId == PERFECT_SELF_SPELL_ID)
            RemoveEffect(oPC, eLoop);

        eLoop = GetNextEffect(oPC);
    }
}

//----------------------------------------------------------------------------//

void ApplyDivineGraceFeatProperties(object oPC) {
    if(GetHasFeat(FEAT_SOT_DIVINE_GRACE, oPC)) {
        int nBonus = (GetAbilityScore(oPC, ABILITY_CHARISMA) - 10) / 2;
        int nExemplarLevel = GetLevelByClass(CLASS_TYPE_PALADIN, oPC);
        if(nBonus > nExemplarLevel) nBonus = nExemplarLevel;

        SetSavingThrowBonus(oPC, SAVING_THROW_FORT, nBonus);
        SetSavingThrowBonus(oPC, SAVING_THROW_REFLEX, nBonus);
        SetSavingThrowBonus(oPC, SAVING_THROW_WILL, nBonus);
    }
}

void ClearDivineGraceFeatProperties(object oPC) {
    /*effect eLoop = GetFirstEffect(oPC);

    while(GetIsEffectValid(eLoop)) {
        int nSpellId = GetEffectSpellId(eLoop);

        if(nSpellId == DIVINE_GRACE_SPELL_ID) {
            SendMessageToPC("Found Divine Grace Effect.");
            RemoveEffect(oPC, eLoop);
            SetSavingThrowBonus(oPC, 0, 0);
            SetSavingThrowBonus(oPC, 1, 0);
            SetSavingThrowBonus(oPC, 2, 0);
        }

        eLoop = GetNextEffect(oPC);
    }*/

    SetSavingThrowBonus(oPC, SAVING_THROW_FORT, 0);
    SetSavingThrowBonus(oPC, SAVING_THROW_REFLEX, 0);
    SetSavingThrowBonus(oPC, SAVING_THROW_WILL, 0);
}

//----------------------------------------------------------------------------//

void ApplyPermanentFeatProperties(object oPC) {
    ApplyPerfectSelfFeatProperties(oPC);
    ApplyDivineGraceFeatProperties(oPC);
}

void ClearPermanentFeatProperties(object oPC) {
    ClearPerfectSelfFeatProperties(oPC);
    ClearDivineGraceFeatProperties(oPC);
}

//----------------------------------------------------------------------------//
