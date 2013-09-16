#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Word of Recall                                                       //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 10, 2011                                  //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    object oPC = OBJECT_SELF;
    location lPC = GetLocation(oPC);
    int iTeleportable = GetLocalInt(GetArea(oPC), "wg_teleportable");

    if(!iTeleportable) {
        SendMessageToPC(oPC, "Invalid area to recall.");
        return;
    }

    SendMessageToPC(oPC, "Recall to " + GetName(GetArea(oPC)) + " by saying !RETURN!");

    SetLocalInt(oPC, "wg_wordofrecall_returnready", 1);
    SetLocalLocation(oPC, "wg_wordofrecall_target", lPC);

    effect eVFX = EffectVisualEffect(VFX_IMP_PULSE_HOLY);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oPC);
}
