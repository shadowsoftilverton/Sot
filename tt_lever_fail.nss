#include "nw_i0_2q4luskan"

void main()
{
    object oTarget;
    object oSpawn;
    effect eVFX;

    eVFX = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_FIRE);
    oTarget = GetWaypointByTag("tt_wp_iron_lava");
    oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "sm_fluid008", GetLocation(oTarget));
    DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oSpawn));

    object oPC = GetLastUsedBy();
    FloatingTextStringOnCreature("A fluid of hot Lava starts to fill the room!", oPC);

   //eVFX = EffectVisualEffect(VFX_FNF_FIRESTORM);
    //oTarget = GetWaypointByTag("tt_wp_iron_lavafloor");
    //DelayCommand(4.0, CreateObjectVoid(OBJECT_TYPE_PLACEABLE, "tt_plc_lava", GetLocation(oTarget)));
    //DelayCommand(4.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, GetLocation(oTarget)));


}
