#include "engine"

//::///////////////////////////////////////////////
//:: Divine Shield
//:: x0_s2_divshield.nss
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Up to [turn undead] times per day the character may add his Charisma bonus to his armor
    class for a number of rounds equal to the Charisma bonus.
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: Sep 13, 2002
//:://////////////////////////////////////////////
#include "x0_i0_spells"

void main()
{

   if (!GetHasFeat(FEAT_TURN_UNDEAD, OBJECT_SELF))
   {
        SpeakStringByStrRef(40550);
   }
   else
   if(GetHasFeatEffect(414) == FALSE)
   {
   if(GetLocalInt(OBJECT_SELF,"ave_hier_cel")==0)
   {
        //Declare major variables
        object oTarget = GetSpellTargetObject();
        int nLevel = GetLevelByClass(CLASS_TYPE_CLERIC, oTarget)
                   + GetLevelByClass(CLASS_TYPE_PALADIN, oTarget);

        effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

        int nCharismaBonus = GetAbilityModifier(ABILITY_CHARISMA);

        if(nCharismaBonus > nLevel) nCharismaBonus = nLevel;

        effect eAC = EffectACIncrease(nCharismaBonus);
        effect eLink = EffectLinkEffects(eAC, eDur);
        eLink = SupernaturalEffect(eLink);

         // * Do not allow this to stack
        RemoveEffectsFromSpell(oTarget, GetSpellId());

        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 474, FALSE));

        //Apply Link and VFX effects to the target
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nCharismaBonus));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

        DecrementRemainingFeatUses(OBJECT_SELF, FEAT_TURN_UNDEAD);
    }
    else SendMessageToPC(OBJECT_SELF,"This ability does not work in conjunction with the celebrant feat!");
    }
}



