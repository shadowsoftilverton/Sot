#include "engine"
#include "aps_include"

void DoEndBarbarianRage(object oPC) {
    int iRacialStrMod = 0;
    int iRacialConMod = 0;

    switch(GetRacialType(oPC)) {
        case RACIAL_TYPE_ELF:
            iRacialConMod = -2;
            break;
        case RACIAL_TYPE_DWARF:
            iRacialConMod =  2;
            break;
        case RACIAL_TYPE_HALFLING:
            iRacialStrMod = -2;
            break;
        case RACIAL_TYPE_GNOME:
            iRacialStrMod = -2;
            iRacialConMod =  2;
            break;
        case RACIAL_TYPE_HALFORC:
            iRacialStrMod =  2;
            break;
        case RACIAL_TYPE_HUMAN:
        case RACIAL_TYPE_HALFELF:
        default: break;
    }

    SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod - GetPersistentInt(oPC, "BARBARIAN_STR_INC"));
    SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod - GetPersistentInt(oPC, "BARBARIAN_CON_INC"));
    SetPersistentInt(oPC, "BARBARIAN_RAGING", 0);
    SetPersistentInt(oPC, "BARBARIAN_STR_INC", 0);
    SetPersistentInt(oPC, "BARBARIAN_CON_INC", 0);

    effect eLoop = GetFirstEffect(oPC);

    while(GetIsEffectValid(eLoop)) {
        if(GetEffectSpellId(eLoop) == SPELLABILITY_BARBARIAN_RAGE || GetEffectSpellId(eLoop) == SPELLABILITY_EPIC_MIGHTY_RAGE) {
            Std_RemoveEffect(oPC, eLoop);
        }

        eLoop = GetNextEffect(oPC);
    }
}

void DoCheckBarbarianRage(object oPC) {
    if(GetPersistentInt(oPC, "BARBARIAN_RAGING") == 1) DoEndBarbarianRage(oPC);
}

void DoCheckAndRemindBonusRageFeats(object oPC)
{
    int EligibleFor=GetLevelByClass(CLASS_TYPE_BARBARIAN,oPC)/6;
    if(EligibleFor>GetPersistentInt(oPC,"NUM_BONUS_RAGEFEATS"))
    {
        SendMessageToPC(oPC,"You are eligible for a bonus RAGEPOWER! Select the RAGEPOWER from your utility wand!");
    }
}
