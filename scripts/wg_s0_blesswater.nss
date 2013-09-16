#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Bless Water                                                          //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 7, 2011                                  //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    if(GetGold() >= 25) {
        TakeGoldFromCreature(25, OBJECT_SELF);
        CreateItemOnObject("wmgrenade006");
        FloatingTextStringOnCreature("*You have successfully created holy water!*", OBJECT_SELF);
    } else
        FloatingTextStringOnCreature("*You must have 25gp (roleplay: 5 pounds of silver) to create holy water!*", OBJECT_SELF);
}
