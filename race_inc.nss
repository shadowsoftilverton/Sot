#include "engine"

#include "inc_language"
#include "inc_xp"

// Sets up the character with the XP and variables they need to get into the
// the module.
void DoStandardCharacterSetup(object oPC);

void DoStandardCharacterSetup(object oPC){
    AddKnownFeat(oPC, FEAT_LANGUAGE_COMMON);

    SetXPCap(oPC, STARTING_XP_CAP);

    SetXP(oPC, 10000);

    GiveGoldToCreature(oPC, 10000);

    SetFreeGeneralLanguages(oPC, GetAbilityModifier(ABILITY_INTELLIGENCE, oPC));
}
