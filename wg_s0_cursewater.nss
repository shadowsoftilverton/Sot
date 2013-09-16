#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Curse Water                                                          //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 7, 2011                                  //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    if(GetGold() >= 25) {
        TakeGoldFromCreature(25, OBJECT_SELF);
        CreateItemOnObject("wg_grenl_uwater");
        FloatingTextStringOnCreature("*You have successfully created unholy water!*", OBJECT_SELF);
    } else
        FloatingTextStringOnCreature("*You must have 5 pounds of silver (25gp) to create unholy water!*", OBJECT_SELF);
}
