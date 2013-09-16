#include "engine"

#include "race_inc"
#include "nwnx_funcs"

void main()
{
    object oPC = GetPCSpeaker();

    SetSubRace(oPC, "Half-Orc");

    AddKnownFeat(oPC, FEAT_LANGUAGE_ORCISH);

    ModifyAbilityScore(oPC, ABILITY_INTELLIGENCE, 2);

    DoStandardCharacterSetup(oPC);
}

