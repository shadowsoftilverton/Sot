//::///////////////////////////////////////////////
//:: Remove Blindness / Deafness
//:: NW_S0_RmvBldDef.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    All allies within 10ft of the cast point have
    blindness and deafness removed.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: June 29, 2001
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 22, 2001
//:: Updated By: Preston W, On: June 29, 2001

#include "x2_inc_spellhook"

void main()
{
    /*
  Spellcast Hook Code
  Added 2012-11-06 by Ave (apparently this particular spell had missed the boat on spellhooking)
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook
    //Declare major variables
    object oTarget;
    int nType;
    effect eBlindDeaf;
    //Declare personal impact visual effect.
    effect eVis = EffectVisualEffect(VFX_IMP_REMOVE_CONDITION);
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetSpellTargetLocation());
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        //Make a faction check so that only friends are affected.
        if (GetIsFriend(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_REMOVE_BLINDNESS_AND_DEAFNESS, FALSE));
            //Get the first effect on the present target.
            eBlindDeaf = GetFirstEffect(oTarget);
            while(GetIsEffectValid(eBlindDeaf))
            {
                nType = GetEffectType(eBlindDeaf);
                if (nType == EFFECT_TYPE_DEAF || nType == EFFECT_TYPE_BLINDNESS)
                {
                    //Remove the effect if it matches the stated values
                    RemoveEffect(oTarget, eBlindDeaf);
                    //Apply the visual
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                }
                //Get the next effect
                GetNextEffect(oTarget);
            }
        }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetSpellTargetLocation());
    }
}

