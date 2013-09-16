#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Comprehend Languages                                                 //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 16, 2011                                 //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    object oTarget = GetSpellTargetObject();
    object oPC = OBJECT_SELF;
    float fDuration = 10.0 * 60.0 * GetCasterLevel(oPC);

    if(oTarget == oPC) return;

    if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE) {
        SetLocalInt(oPC, "wg_s0_complng_enabled", 1);
        SetLocalObject(oPC, "wg_s0_complng_speaker", oTarget);

        DelayCommand(fDuration, SetLocalInt(oPC, "wg_s0_complng_enabled", 0));

        //Note that the actual translation logic is handled in inc_language
    }
}
