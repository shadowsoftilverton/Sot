#include "engine"

#include "nwnx_funcs"
#include "race_inc"

void main()
{
    object oPC = GetPCSpeaker();

    ModifyAbilityScore(oPC, ABILITY_DEXTERITY, -2);
    ModifyAbilityScore(oPC, ABILITY_CHARISMA, 2);

    SetSubRace(oPC, "Gold Dwarf");

    AddKnownFeat(oPC, FEAT_LANGUAGE_DWARVEN);

    DoStandardCharacterSetup(oPC);
}

