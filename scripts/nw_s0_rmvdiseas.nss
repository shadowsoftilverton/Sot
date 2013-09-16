//::///////////////////////////////////////////////
//:: Remove Disease
//:: NW_S0_RmvDiseas.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Removes all disease effects on the character.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Aug 7, 2001
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 22, 2001

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
    object oTarget = GetSpellTargetObject();
    int nType;
    int bValid = FALSE;
    effect eParal = GetFirstEffect(oTarget);
    effect eVis = EffectVisualEffect(VFX_IMP_REMOVE_CONDITION);
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_REMOVE_DISEASE, FALSE));
    //Get the first effect on the target
    while(GetIsEffectValid(eParal))
    {
        //Check if the current effect is of correct type
        if (GetEffectType(eParal) == EFFECT_TYPE_DISEASE)
        {
            //Remove the effect
            RemoveEffect(oTarget, eParal);
            bValid = TRUE;
        }
        //Get the next effect on the target
        GetNextEffect(oTarget);
    }
    if (bValid)
    {
        //Apply VFX Impact
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    }
}

