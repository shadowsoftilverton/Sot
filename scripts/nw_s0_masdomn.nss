//::///////////////////////////////////////////////
//:: [Mass Dominate]
//:: [NW_S0_MsDomn.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
/*
The caster attempts to dominate a group of individuals
who's HD can be no more than his level combined.
The spell starts checking the area and those that
fail a will save are dominated.  The affected persons
are dominated for 1 round per 2 caster levels.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Feb 4, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 10, 2001

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

    //Declare major varialbes
    object oTarget;
    effect eDom = EffectDominated();
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
    effect eLink = EffectLinkEffects(eMind, eDom);
    effect eVis = EffectVisualEffect(VFX_IMP_DOMINATE_S);
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDuration = nCasterLevel/2;
    int nHD = nCasterLevel;
    int nCnt = 0;
    int nRacial = GetRacialType(oTarget);
    //Check for metamagic extension
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nCasterLevel;
    }
    //Get first target in spell area
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation());
    while (GetIsObjectValid(oTarget) && nCnt < nHD)
    {
        //Make sure the target is not in the caster's faction
        if(GetIsEnemy(oTarget))
        {
            //Make sure the target is a humanoid
            if (GetIsPlayableRacialType(oTarget) ||
                (nRacial == RACIAL_TYPE_HUMANOID_MONSTROUS) ||
                (nRacial == RACIAL_TYPE_HUMANOID_ORC) ||
                (nRacial == RACIAL_TYPE_HUMANOID_REPTILIAN) ||
                (nRacial == RACIAL_TYPE_ANIMAL) ||
                ((nHD-nCnt) > GetHitDice(oTarget)))
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 112));//SPELL_MASS_DOMINATION
                //Make an SR check
                if (!ResistSpell(OBJECT_SELF, oTarget))
                {
                    //Make a Will save to negate
                    if (!WillSave(oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_MIND_SPELLS))
                    {
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    }
                }
                //Add targets HD to the total
                nCnt = nCnt + GetHitDice(oTarget);
            }
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation());
    }
}
