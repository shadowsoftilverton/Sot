#include "engine"

//::///////////////////////////////////////////////
//:: Generic On Pressed Respawn Button
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
// * June 1: moved RestoreEffects into plot include
*/
//:://////////////////////////////////////////////
//:: Created By:   Brent
//:: Created On:   November
//:://////////////////////////////////////////////
#include "nw_i0_plot"

#include "inc_death"
#include "inc_multiserver"

string FUGUE_WAYPOINT_TAG = "wp_fox_fugue_spawn";
string FUGUE_WAYPOINT_DUNGEON_TAG = "wp_fugue_spawn_dungeon";

void main()
{
    object oPC = GetLastRespawnButtonPresser();

    object oWaypoint;
    switch(GetLocalInt(GetModule(), "SYS_INSTANCE_TYPE")) {
        case INSTANCE_TYPE_HUB:
            oWaypoint = GetWaypointByTag(FUGUE_WAYPOINT_TAG);
            break;
        case INSTANCE_TYPE_DUNGEON:
            oWaypoint = GetWaypointByTag(FUGUE_WAYPOINT_DUNGEON_TAG);
            break;
    }

    CreatePlayerBodyPlaceable(oPC, GetLocation(oPC));

    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oPC)), oPC);

    RemoveEffects(oPC);

    effect eGhost = SupernaturalEffect(EffectCutsceneGhost());

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPC);

    AssignCommand(oPC, JumpToObject(oWaypoint));
 }
