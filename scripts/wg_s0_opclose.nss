#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Open/Close                                                           //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 17, 2011                                 //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    object oTarget = GetSpellTargetObject();

    if(GetObjectType(oTarget) == OBJECT_TYPE_DOOR)
        AssignCommand(oTarget, ActionOpenDoor(oTarget));
}
