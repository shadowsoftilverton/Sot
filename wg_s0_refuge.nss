#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Refuge                                                               //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 10, 2011                                 //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    int nSpell = GetSpellId();
    object oPC = OBJECT_SELF;

    if(nSpell == SPELL_REFUGE_TOHOME) {
        location lPC = GetLocation(oPC);
        int iTeleportable = GetLocalInt(GetArea(oPC), "wg_teleportable");

        if(!iTeleportable) {
            SendMessageToPC(oPC, "Invalid area to recall.");
            return;
        }

        if(GetGold() < 1500) {
            SendMessageToPC(oPC, "You must have 1500gp (roleplay: a collection of gems) as a material component.");
            return;
        }

        TakeGoldFromCreature(1500, oPC);
        object oRefugeStoneHome = CreateItemOnObject("wg_sp_refg_stnh");
        SetLocalLocation(oRefugeStoneHome, "wg_refuge_target", lPC);
    } else if(nSpell == SPELL_REFUGE_TOPERSON) {
        if(GetGold() < 1500) {
            SendMessageToPC(oPC, "You must have 1500gp (roleplay: a collection of gems) as a material component.");
            return;
        }

        TakeGoldFromCreature(1500, oPC);
        object oRefugeStonePerson = CreateItemOnObject("wg_sp_refg_stnp");
        SetLocalObject(oRefugeStonePerson, "wg_refuge_target", oPC);
    }
}
