#include "engine"

#include "race_inc"

void main()
{
    object oPC = GetPCSpeaker();

    SetSubRace(oPC, "Half-elf");

    LearnLanguage(oPC, LANGUAGE_ELVEN);

    SetFreeRegionalLanguages(oPC, 1);

    DoStandardCharacterSetup(oPC);
}


