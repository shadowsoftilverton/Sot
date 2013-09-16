#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Water Breathing                                                      //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 7, 2011                                  //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    object oTarget = GetSpellTargetObject();
    float fDuration = HoursToSeconds(GetCasterLevel(OBJECT_SELF) * 2);

    SetLocalInt(oTarget, "wg_s0_waterbrth", 1);
    DelayCommand(fDuration, SetLocalInt(oTarget, "wg_s0_waterbrth", 0));
}
