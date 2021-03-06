#include "engine"

#include "nwnx_funcs"
#include "race_inc"

void main()
{
    object oPC = GetPCSpeaker();

    ModifyAbilityScore(oPC, ABILITY_STRENGTH, 2);
    ModifyAbilityScore(oPC, ABILITY_INTELLIGENCE, -2);
    ModifyAbilityScore(oPC, ABILITY_CHARISMA, -2);
    ModifyPCSkillPoints(oPC, -4);

    SetSubRace(oPC, "Wood Elf");

    AddKnownFeat(oPC, FEAT_LANGUAGE_ELVEN);

    DoStandardCharacterSetup(oPC);
}

