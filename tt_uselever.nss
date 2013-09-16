#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    object oTarget;
    effect eVFX;
    effect eDamage;
    object oSpawn;
    int nValue;

    // Get the creature who triggered this event.
    object oPC = GetLastUsedBy();




        if ( GetIsSkillSuccessful(oPC, 37, 15) )
              {
                // Unlock and open "tt_dwarf_castledoor1".

                ActionPlayAnimation (ANIMATION_PLACEABLE_ACTIVATE);
                oTarget = GetObjectByTag("tt_dwarf_castledoor1");
                SetLocked(oTarget, FALSE);
                AssignCommand(oTarget, ActionOpenDoor(oTarget));
                oTarget = GetObjectByTag("tt_sw_lever01");
                SoundObjectPlay(oTarget);
                FloatingTextStringOnCreature("Several mechanisms activate and you can hear the sound of a door unlocking...", oPC);

                oTarget = GetObjectByTag("LargeNewGearUprightTiny");
                ActionPlayAnimation (ANIMATION_PLACEABLE_DEACTIVATE);




              }

        else
        {

            oTarget = GetObjectByTag("tt_dwarf_ironworks_core");
            if ( GetLocalInt(oTarget, "lava_flow") == 0 )
               {
                // Cause damage.
                eDamage = EffectDamage(d10(), DAMAGE_TYPE_ELECTRICAL);

                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_LIGHTNING, OBJECT_SELF, BODY_NODE_CHEST), oPC, 2.0);

                FloatingTextStringOnCreature("You can't figure out the mechanism, and a fluid stream of lava starts to pour from a pipe!", oPC);

                eVFX = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_FIRE);
                oTarget = GetWaypointByTag("tt_wp_iron_lava");
                oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "sm_fluid008", GetLocation(oTarget));
                DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oSpawn));

//                nValue = GetLocalInt(OBJECT_SELF, "lava_flow") + 1;
//                SetLocalInt(OBJECT_SELF, "lava_flow", nValue);

                oTarget = GetObjectByTag("tt_dwarf_ironworks_core");
                SetLocalInt(oTarget, "lava_flow", 1);

                oTarget = GetObjectByTag("tt_sw_lever01");
                SoundObjectPlay(oTarget);

                }



           else if ( GetLocalInt(oTarget, "lava_flow") == 1 )
                {

                // Cause damage.
                eDamage = EffectDamage(d10(), DAMAGE_TYPE_ELECTRICAL);

                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_LIGHTNING, OBJECT_SELF, BODY_NODE_CHEST), oPC, 2.0);

                FloatingTextStringOnCreature("The floor is flooded by lava!", oPC);

                eVFX = EffectVisualEffect(VFX_FNF_FIRESTORM);
                oTarget = GetWaypointByTag("tt_wp_iron_lavafloor");
                oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "tt_plc_lava", GetLocation(oTarget));
                DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oSpawn));

//               nValue = GetLocalInt(OBJECT_SELF, "lava_flow") + 1;
//               SetLocalInt(OBJECT_SELF, "lava_flow", nValue);
                oTarget = GetObjectByTag("tt_dwarf_ironworks_core");
                SetLocalInt(oTarget, "lava_flow", 2);

                oTarget = GetObjectByTag("tt_trap_lava");
                SetLocalInt(oTarget, "ContinuousDmg", 1);
                DelayCommand(2.0f, ExecuteScript("cs_oe_trapcep2", oTarget));

                oTarget = GetObjectByTag("tt_sw_lever01");
                SoundObjectPlay(oTarget);


                }

            else if ( GetLocalInt(oTarget, "lava_flow") == 2 )
                {
                // Cause damage.
                eDamage = EffectDamage(d10(), DAMAGE_TYPE_ELECTRICAL);

                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_LIGHTNING, OBJECT_SELF, BODY_NODE_CHEST), oPC, 2.0);

                FloatingTextStringOnCreature("More lava pours out from the pipe!", oPC);


//                nValue = GetLocalInt(OBJECT_SELF, "lava_flow") + 1;
//               SetLocalInt(OBJECT_SELF, "lava_flow", nValue);

                oTarget = GetObjectByTag("tt_dwarf_ironworks_core");
                SetLocalInt(oTarget, "lava_flow", 3);

                oTarget = GetNearestObjectByTag("tt_wp_iron_lavafloor2", OBJECT_SELF);
                ActionCastSpellAtObject(SPELL_INCENDIARY_CLOUD, oTarget, METAMAGIC_ANY, TRUE, 5);

                oTarget = GetObjectByTag("tt_sw_lever01");
                SoundObjectPlay(oTarget);

                }



            else
                {
                FloatingTextStringOnCreature("The lever is now stuck, you must wait for the lava to drain into the sewers!", oPC);
                }
           }
   }










