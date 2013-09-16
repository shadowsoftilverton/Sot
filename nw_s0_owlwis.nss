//::///////////////////////////////////////////////
//:: Owl's Wisdom
//:: NW_S0_OwlWis
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Raises targets Wis by 1d4+1
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Aug 15, 2001
//:: Normalized Effects: 2011-09-17 - Invictus
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
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
    effect eRaise;
    effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);


    int nMetaMagic = GetMetaMagicFeat();
    int nRaise = 4;
    int nDuration = GetCasterLevel(OBJECT_SELF);

    //Enter Metamagic conditions
    /*if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nRaise = 5;//Damage is at max
    }
    else if (nMetaMagic == METAMAGIC_EMPOWER)
    {
        nRaise = nRaise + (nRaise/2); //Damage/Healing is +50%
    }
    else*/ if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }
    //Set Adjust Ability Score effect
    eRaise = EffectAbilityIncrease(ABILITY_WISDOM, nRaise);
    effect eLink = EffectLinkEffects(eRaise, eDur);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_OWLS_WISDOM, FALSE));

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}