#include "engine"

#include "nw_i0_plot"

#include "inc_death"
#include "inc_multiserver"

void main()
{
    object oPC = OBJECT_SELF;
    int nDeathServer = GetPersistentDeathServer(oPC);
    int nThisServer = GetLocalInt(GetModule(), "SYS_INSTANCE_TYPE");

    if(GetIsPersistentDead(oPC) && GetTag(GetArea(oPC)) != AREA_FUGUE){
        if(nDeathServer == nThisServer) {
            // This happens if we've been revived and were in-game.
            FloatingTextStringOnCreature("You are still clinging to life.", oPC, FALSE);

            AssignCommand(oPC, JumpToLocation(GetPersistentDeathLocation(oPC)));

            DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oPC));
        } else if(nThisServer == INSTANCE_TYPE_HUB) {
            // Port PC to Fugue
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oPC)), oPC);
            RemoveEffects(oPC);

            AssignCommand(oPC, JumpToLocation(GetLocation(GetObjectByTag("wp_fox_fugue_spawn"))));
        } else if(nThisServer == INSTANCE_TYPE_DUNGEON) {
            // Port PC to Dungeon Fugue
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oPC)), oPC);
            RemoveEffects(oPC);

            AssignCommand(oPC, JumpToLocation(GetLocation(GetObjectByTag("wp_fugue_spawn_dungeon"))));
        }
    } else if(GetIsPersistentDead(oPC) == -1){
        if(nDeathServer == nThisServer) {
            // This happens if we've been revived when we weren't present in-game.
            FloatingTextStringOnCreature("Someone has returned you to life.", oPC, FALSE);

            AssignCommand(oPC, JumpToLocation(GetPersistentDeathLocation(oPC)));

            SetIsPersistentDead(oPC, 0);
        } else {
            FloatingTextStringOnCreature("Someone has returned you to life.", oPC, FALSE);
            SetIsPersistentDead(oPC, 0);
        }
    }
}
