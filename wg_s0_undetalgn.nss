#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Undetectable Alignment                                               //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 7, 2011                                  //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    object oTarget = GetSpellTargetObject();
    effect eNull = EffectVisualEffect(VFX_COM_UNLOAD_MODEL);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eNull, oTarget, HoursToSeconds(24)); //Null visual effect, as our detect spells look for effects.
}
