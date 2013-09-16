#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Dimensional Anchor                                                   //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 7, 2011                                  //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    object oTarget = GetSpellTargetObject();
    float fDuration = GetCasterLevel(OBJECT_SELF) * 60.0; //1 minute per level
    int nTouch = TouchAttackRanged(oTarget);

    if(!nTouch)
        return;

    if(!MyResistSpell(OBJECT_SELF, oTarget)) {
        SetLocalInt(oTarget, "wg_s0_dimanchor", 1);    // Variable checked for in Teleport, Plane Shift, Word of Recall, etc...
        DelayCommand(fDuration, SetLocalInt(oTarget, "wg_s0_dimanchor", 0));
    }
}
