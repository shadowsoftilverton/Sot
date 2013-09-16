#include "engine"

//----------------------------------------------------------------------------//

#include "NW_I0_SPELLS"
#include "x2_i0_spells"
#include "x2_inc_spellhook"

//----------------------------------------------------------------------------//

void main() {
    if(!X2PreSpellCastCode()) return;

    effect eAOE = EffectAreaOfEffect(AOE_MOB_CIRCGOOD, "pc_rallypres_en", "", "pc_rallypres_ex");

    int nDuration = GetLevelByClass(CLASS_TYPE_BATTLECAPTAIN);
    if(GetAbilityModifier(ABILITY_CHARISMA) > 0) nDuration += GetAbilityModifier(ABILITY_CHARISMA);

    if(nDuration < 1) nDuration = 1;

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, OBJECT_SELF, RoundsToSeconds(nDuration));
}
