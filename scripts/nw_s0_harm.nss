#include "engine"

//::///////////////////////////////////////////////
//:: [Harm]
//:: [NW_S0_Harm.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Reduces target to 1d4 HP on successful touch
//:: attack.  If the target is undead it is healed.
//:://////////////////////////////////////////////
//:: Created By: Keith Soleski
//:: Created On: Jan 18, 2001
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 20, 2001
//:: Update Pass By: Preston W, On: Aug 1, 2001
//:: Last Update: Georg Zoeller On: Oct 10, 2004
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_sneak_inc"

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
    object oCaster = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    int nDamage, nHeal;
    int nCasterLevel = GetCasterLevel(oCaster);
    int nTouch = TouchAttackMelee(oTarget);
    effect eVis = EffectVisualEffect(246);
    effect eVis2 = EffectVisualEffect(VFX_IMP_HEALING_G);
    effect eHeal, eDam;
    int nDC=GetSpellSaveDC();
    int nMetaMagic=GetMetaMagicFeat();
    if(!GetHasFeat(1582,oCaster)&&nCasterLevel > 15){//Check for Energy Channeler
        nCasterLevel = 15;
    }

    if(nMetaMagic==METAMAGIC_EMPOWER) nDamage=d4(nCasterLevel*6);
    else if(nMetaMagic==METAMAGIC_MAXIMIZE) nDamage=nCasterLevel*16;
    else nDamage=d4(nCasterLevel*4);

    //Check that the target is undead
    if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
    {
        //Figure out the amount of damage to heal
        //Set the heal effect
        eHeal = EffectHeal(nDamage);
        //Apply heal effect and VFX impact
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_HARM, FALSE));
    }
    else if (nTouch != FALSE)  //GZ: Fixed boolean check to work in NWScript. 1 or 2 are valid return numbers from TouchAttackMelee
    {
        if(nTouch==2) nDamage=nDamage*2;
        nDamage=nDamage+getSneakDamage(oCaster,oTarget);
        if(!GetIsReactionTypeFriendly(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_HARM));
            if (!MyResistSpell(oCaster, oTarget))
            {

                if(WillSave(oTarget, nDC))
                    nDamage /= 2;

                if(nDamage >= GetCurrentHitPoints(oTarget))
                    nDamage = GetCurrentHitPoints(oTarget) - 1;

                eDam = EffectDamage(nDamage,DAMAGE_TYPE_NEGATIVE);

                //Apply the VFX impact and effects
                DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            }
        }
    }
}
