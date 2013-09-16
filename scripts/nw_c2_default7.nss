//:://////////////////////////////////////////////////
//:: NW_C2_DEFAULT7
/*
  Default OnDeath event handler for NPCs.

  Adjusts killer's alignment if appropriate and
  alerts allies to our death.
 */
//:://////////////////////////////////////////////////
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 12/22/2002
//:://////////////////////////////////////////////////
//:://////////////////////////////////////////////////
//:: Modified By: Deva Winblood
//:: Modified On: April 1st, 2008
//:: Added Support for Dying Wile Mounted
//:://///////////////////////////////////////////////

#include "x2_inc_compon"
#include "x0_i0_spawncond"
#include "x3_inc_horse"
#include "inc_xp"
#include "inc_undead"

void main()
{
    int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
    object oKiller = GetLastKiller();

    //If killer is a kamakazi kobold, give xp to caster
    if(GetLocalInt(oKiller,"ave_koblevel")>0) {oKiller=GetLocalObject(oKiller,"ave_kobcast");}

    if (GetLocalInt(GetModule(),"X3_ENABLE_MOUNT_DB")&&GetIsObjectValid(GetMaster(OBJECT_SELF))) SetLocalInt(GetMaster(OBJECT_SELF),"bX3_STORE_MOUNT_INFO",TRUE);

    // Call to allies to let them know we're dead
    SpeakString("NW_I_AM_DEAD", TALKVOLUME_SILENT_TALK);

    //Shout Attack my target, only works with the On Spawn In setup
    SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);

    // Undead destruction retribution - Invictus 2012-06-03
    if(GetLocalInt(OBJECT_SELF, "UndeadSys_DestructionRetribution"))
        DestructionRetributionAction(OBJECT_SELF);

    // NOTE: the OnDeath user-defined event does not
    // trigger reliably and should probably be removed
    if(GetSpawnInCondition(NW_FLAG_DEATH_EVENT))
    {
         SignalEvent(OBJECT_SELF, EventUserDefined(1007));
    }

    GiveKillXP(oKiller, OBJECT_SELF);
}
