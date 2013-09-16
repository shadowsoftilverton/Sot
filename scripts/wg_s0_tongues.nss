#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Tongues                                                              //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 7, 2011                                  //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    float fDuration = TurnsToSeconds(GetCasterLevel(OBJECT_SELF) * 2);

    SetLocalInt(OBJECT_SELF, "wg_s0_tongues", 1);
    DelayCommand(fDuration, SetLocalInt(OBJECT_SELF, "wg_s0_tongues", 0));
}
