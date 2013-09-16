#include "engine"

#include "race_inc"

void main()
{
    object oPC = GetPCSpeaker();

    SetSubRace(oPC, "Shield Dwarf");

    AddKnownFeat(oPC, FEAT_LANGUAGE_DWARVEN);

    DoStandardCharacterSetup(oPC);
}

