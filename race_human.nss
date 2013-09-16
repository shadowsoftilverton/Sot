#include "engine"

#include "race_inc"

void main()
{
    object oPC = GetPCSpeaker();

    SetSubRace(oPC, "Human");

    SetFreeRegionalLanguages(oPC, 1);

    DoStandardCharacterSetup(oPC);
}
