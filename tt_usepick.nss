#include "nw_i0_2q4luskan"
#include "engine"

void main()
{
    object oTarget;
    effect eVFX;
    effect eDamage;
    object oSpawn;
    location lLocation;


    // Get the PC who is in this conversation.
     object oPC = GetPCSpeaker();

oTarget = GetObjectByTag("tt_orc_tunnels");
if ( GetLocalInt(oTarget, "rock_check") == 0 )
  {

    if ( GetItemPossessedBy(oPC, "tt_eq_heavypick") != OBJECT_INVALID )
    {
        // If a skill check (heal) is successful.
        if ( GetIsSkillSuccessful(oPC, 37, 15) )
              {

//                DelayCommand(5.0f, DestroyObject(GetObjectByTag("tt_plc_rockconv")));
                DestroyObject(GetObjectByTag("tt_plc_remrock1"));
                DestroyObject(GetObjectByTag("tt_plc_remrock2"));

//               ExecuteScript("tt_usepick_resp", OBJECT_SELF);

               oTarget = GetWaypointByTag("tt_wp_tunnelrock");
               lLocation = GetLocation(oTarget);
               DelayCommand(1200.0f, CreateObjectVoid(OBJECT_TYPE_PLACEABLE, "tt_plc_remrock1", lLocation));

               oTarget = GetWaypointByTag("tt_wp_tunnelrock2");
               DelayCommand(1200.0f, CreateObjectVoid(OBJECT_TYPE_PLACEABLE, "tt_plc_remrock2", GetLocation(oTarget)));



               oTarget = GetObjectByTag("tt_orc_tunnels");
               SetLocalInt(oTarget, "rock_check", 1);
               DelayCommand (1200.0f, SetLocalInt(oTarget, "rock_check", 0));



               }
        else
        {
            // Cause damage.
            eDamage = EffectDamage(d10(), DAMAGE_TYPE_BLUDGEONING);
            eVFX = EffectVisualEffect(VFX_COM_CHUNK_STONE_MEDIUM);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX   , oPC);

            FloatingTextStringOnCreature("More rocks fall down from the roof!", oPC);

        }
    }
    else
    {
        // Send a message to the player's chat window.
        SendMessageToPC(oPC, "You don't have a Heavy Pick!");
    }
  }

    else
    {
                FloatingTextStringOnCreature("The path is clear", oPC);
    }
}






