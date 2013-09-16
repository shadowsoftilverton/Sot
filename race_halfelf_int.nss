#include "engine"

#include "race_inc"
#include "nwnx_funcs"

void main()
{
    object oPC = GetPCSpeaker();

    SetSubRace(oPC, "Half-elf");

    LearnLanguage(oPC, LANGUAGE_ELVEN);

    SetFreeRegionalLanguages(oPC, 1);

    ModifyAbilityScore(oPC, ABILITY_INTELLIGENCE, 1);

    DoStandardCharacterSetup(oPC);
}
