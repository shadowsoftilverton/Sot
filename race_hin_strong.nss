#include "engine"

#include "race_inc"
#include "nwnx_funcs"

void main()
{
    object oPC = GetPCSpeaker();

    SetSubRace(oPC, "Strongheart Halfling");

    AddKnownFeat(oPC, FEAT_LANGUAGE_HALFLING);
    AddKnownFeat(oPC, FEAT_QUICK_TO_MASTER);
    RemoveKnownFeat(oPC, FEAT_LUCKY);

    DoStandardCharacterSetup(oPC);
}

