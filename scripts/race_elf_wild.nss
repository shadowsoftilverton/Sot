#include "engine"

#include "nwnx_funcs"
#include "race_inc"

void main()
{
    object oPC = GetPCSpeaker();

    ModifyAbilityScore(oPC, ABILITY_CONSTITUTION, 2);
    ModifyAbilityScore(oPC, ABILITY_INTELLIGENCE, -2);
    ModifyPCSkillPoints(oPC, -4);

    SetSubRace(oPC, "Wild Elf");

    AddKnownFeat(oPC, FEAT_LANGUAGE_ELVEN);

    DoStandardCharacterSetup(oPC);
}

