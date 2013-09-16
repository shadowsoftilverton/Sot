#include "engine"

#include "race_inc"

void main()
{
    object oPC = GetPCSpeaker();

    SetSubRace(oPC, "Lightfoot Halfling");

    AddKnownFeat(oPC, FEAT_LANGUAGE_HALFLING);

    DoStandardCharacterSetup(oPC);
}

