#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Dimension Door                                                       //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 17, 2011                                 //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    effect eVis = EffectVisualEffect(VFX_IMP_UNSUMMON);
    location lTarget = GetSpellTargetLocation();
    location lStart = GetLocation(OBJECT_SELF);
    int iTeleportable = GetLocalInt(GetArea(OBJECT_SELF), "wg_teleportable");

    if(GetLocalInt(OBJECT_SELF, "wg_s0_dimanchor")) {
        FloatingTextStringOnCreature("An anchoring spell is stopping you from teleporting.", OBJECT_SELF, FALSE);
        return;
    }

    if(!iTeleportable) {
        SendMessageToPC(OBJECT_SELF, "Invalid area to dimension door.");
        return;
    }

    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lStart, TRUE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oTarget)) {
        if(GetIsFriend(oTarget, OBJECT_SELF)) {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
            DelayCommand(0.5, AssignCommand(oTarget, JumpToLocation(lTarget)));
        }

        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lStart, TRUE, OBJECT_TYPE_CREATURE);
    }

    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    DelayCommand(0.5, JumpToLocation(lTarget));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lTarget);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lStart);
}


