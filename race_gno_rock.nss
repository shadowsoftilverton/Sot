#include "engine"

#include "race_inc"

void main()
{
    object oPC = GetPCSpeaker();

    SetSubRace(oPC, "Rock Gnome");

    AddKnownFeat(oPC, FEAT_LANGUAGE_GNOMISH);

    DoStandardCharacterSetup(oPC);
}

