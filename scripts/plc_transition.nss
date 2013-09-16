#include "engine"

#include "inc_debug"
#include "inc_areas"

//::////////////////////////////////////////////////////////////////////////
//:: This script should be placed in the OnUsed event of a placeable, which
//:: will then allow you to specify a waypoint for it to teleport creatures
//:: to when used.
//::
//:: The following is an explanation of the local variables and how to use
//:: them properly:
//::
//:://////////////////////////////////////////////////////////////////////
//:: BASIC VARIABLES
//:://////////////////////////////////////////////////////////////////////
//::
//:: PLC_TRANSITION_TAG (string) - The tag of the object or waypoint to
//:: jump to.
//::
//:: PLC_TRANSITION_MESSAGE (string) - A message to play if the character
//:: has successfully managed to activate the
//:: transition. Will play immediately.
//::
//:: PLC_TRANSITION_TIMER_DELAY (float) - A delay between when the player
//:: uses the object and when the player is
//:: actually transitioned. Good if you want
//:: the player to see a message before they
//:: transition.
//::
//:://////////////////////////////////////////////////////////////////////
//:: KEY RELATED VARIABLES
//:://////////////////////////////////////////////////////////////////////
//::
//:: PLC_TRANSITION_KEY_TAG (string) - The tag of the key a character must
//:: have in their inventory in order to make the transition.
//::  May be left blank for no key.
//::
//:: PLC_TRANSITION_NO_KEY (string) - A message to play if the character
//:: has no key. Only use if a key is required.
//::
//:://////////////////////////////////////////////////////////////////////
//:: SKILL CHECK VARIABLES
//:://////////////////////////////////////////////////////////////////////
//::
//:: PLC_TRANSITION_DO_SKILL_CHECK (boolean) - If TRUE (1), a skill check
//:: is required to pass the transition.
//::
//:: PLC_TRANSITION_SKILL (integer) - The skill that needs to be rolled.
//::
//:: PLC_TRANSITION_SKILL_DC (integer) - The DC of the skill check.
//::
//:: PLC_TRANSITION_SKILL_FAILURE_MESSAGE (string) - A message to play if
//:: the skill check fails.
//::
//:: PLC_TRANSITION_SKILL_FAILURE_SCRIPT (string) - A script to run if the
//:: skill check fails. Runs off of the object in
//:: use, not the player. Use GetLastUsedBy to
//:: reference the PC.
//::
//:://////////////////////////////////////////////////////////////////////
//:: VFX SCRIPTS
//:://////////////////////////////////////////////////////////////////////
//::
//:: PLC_TRANSITION_DO_VFX (boolean) - If TRUE (1), the transition will
//:: play a VFX directly on the player.
//::
//:: PLC_TRANSITION_DELAY_VFX (float) - The delay for the VFX. Make the
//:: delay lower for entering the portal if
//:: desired.
//::
//:: PLC_TRANSITION_VFX (integer) - The VFX to play.
//::
//:://////////////////////////////////////////////////////////////////////

void main()
{
    // Declare variables.
    object oPlaceable = OBJECT_SELF;

    //No transition if the plc is cooling down from a failed skill roll
    if(GetLocalInt(oPlaceable,"ave_plc_failed_cooling_down")==1) return;

    object oPC = GetLastUsedBy();
    object oArea = GetArea(oPlaceable);

    // Fetch local variables.
    string sTransitionTag = GetLocalString(oPlaceable, "transition_tag");
    string sTransitionMessage = GetLocalString(oPlaceable, "transition_message");
    float fDelay = GetLocalFloat(oPlaceable, "transition_timer_delay");

    SendMessageToDevelopers("Sending " + GetName(oPC) + " to " + sTransitionTag + ".");

    // Specifies a key, if necessary.
    string sKeyTag = GetLocalString(oPlaceable, "transition_key_tag");
    string sNoKey = GetLocalString(oPlaceable, "transition_no_key");

    // Specifies a skill check, if necessary.
    int iDoSkillCheck = GetLocalInt(oPlaceable, "transition_do_skill_check");
    int iSkill = GetLocalInt(oPlaceable, "transition_skill");
    int iSkillDC = GetLocalInt(oPlaceable, "transition_skill_dc");
    string sSkillFailureMessage = GetLocalString(oPlaceable, "transition_skill_failure_message");
    string sSkillFailureScript = GetLocalString(oPlaceable, "transition_skill_failure_script");
    float fSkillFailureDelay = GetLocalFloat(oPlaceable,"transition_skill_failure_delay");

    // Specifies a VFX, if necessary.
    int iDoEffect = GetLocalInt(oPlaceable, "transition_do_vfx");
    float fDelayEffect = GetLocalFloat(oPlaceable, "transition_delay_vfx");
    int iVFX = GetLocalInt(oPlaceable, "transition_vfx");

    // If there is a specified key tag, test that the item exists in the PC's
    // inventory.
    if(sKeyTag != ""){
        object oKey = GetItemPossessedBy(oPC, sKeyTag);

        // If we don't have the key, send a message and escape.
        if(!GetIsObjectValid(oKey)){
            // Sends a message if the builer has specified one.
            if(sNoKey != ""){
                FloatingTextStringOnCreature(sNoKey, oPC, FALSE);
            }

            return;
        }
    }

    // Do we require a skill check?
    if(iDoSkillCheck){
        // Do we fail our skill check?
        if(!GetIsSkillSuccessful(oPC, iSkill, iSkillDC)){
            // Send a message if the builder specified one, then escape.
            if(sSkillFailureMessage != ""){
                FloatingTextStringOnCreature(sSkillFailureMessage, oPC, FALSE);
            }

            if(sSkillFailureScript != ""){
                ExecuteScript(sSkillFailureScript, oPlaceable);
            }

            //Implemented skill failure cooldown - Ave
            if(fSkillFailureDelay>0.0)
            {
                SetLocalInt(oPlaceable,"ave_plc_failed_cooling_down",1);
                DelayCommand(fSkillFailureDelay,SetLocalInt(oPlaceable,"ave_plc_failed_cooling_down",0));
            }

            return;
        }
    }

    // Do we do a visual effect?
    if(iDoEffect){
        effect eEffect = EffectVisualEffect(iVFX);
        DelayCommand(fDelayEffect, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oPC));
    }

    // Fetch the waypoint to jump to
    object oWaypoint;

    if(GetIsDungeonInstance(oArea)) {
        // If we are in an instance, just examine placeables with the desired tag in the current area. This constrains plc_transition to the current instance.
        oWaypoint = GetFirstObjectInArea(oArea);
        while(GetTag(oWaypoint) != sTransitionTag) {
            oWaypoint = GetNextObjectInArea(oArea);
        }
    } else
        oWaypoint = GetObjectByTag(sTransitionTag);

    SendMessageToDevelopers("Testing validity of object.");

    // If it's a valid object, jump to it.
    if(GetIsObjectValid(oWaypoint)){
        // Send a message immediately, if there is one.
        if(sTransitionMessage != ""){
            FloatingTextStringOnCreature(sTransitionMessage, oPC, FALSE);
        }

        SendMessageToDevelopers("Jumping to object.");

        DelayCommand(fDelay, AssignCommand(oPC, JumpToObject(oWaypoint)));
    }
}
