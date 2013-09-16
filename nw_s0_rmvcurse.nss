//::///////////////////////////////////////////////
//:: Remove Curse
//:: NW_S0_RmvCurse.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Goes through the effects on a character and removes
    all curse effects.
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
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nType;
    effect eRemove = GetFirstEffect(oTarget);
    effect eVis = EffectVisualEffect(VFX_IMP_REMOVE_CONDITION);
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_REMOVE_CURSE, FALSE));
    //Get the first effect on the target
    while(GetIsEffectValid(eRemove))
    {
        //Check if the current effect is of correct type
        if (GetEffectType(eRemove) == EFFECT_TYPE_CURSE)
        {
            //Remove the effect and apply VFX impact
            RemoveEffect(oTarget, eRemove);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
        //Get the next effect on the target
        GetNextEffect(oTarget);
    }
}
