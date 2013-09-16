#include "engine"

#include "race_inc"

void main()
{
    object oPC = GetPCSpeaker();

    SetSubRace(oPC, "Moon Elf");

    LearnLanguage(oPC, LANGUAGE_ELVEN);

    AddKnownFeat(oPC, FEAT_LANGUAGE_ELVEN);

    DoStandardCharacterSetup(oPC);
}

