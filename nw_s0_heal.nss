#include "engine"

//::///////////////////////////////////////////////
//:: Heal
//:: [NW_S0_Heal.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Heals the target to full unless they are undead.
//:: If undead they reduced to 1d4 HP.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 12, 2001
//:://////////////////////////////////////////////
//:: Update Pass By: Preston W, On: Aug 1, 2001

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
  effect eKill, eHeal;
  int nMetaMagic=GetMetaMagicFeat();
  int nDamage, nHeal, nTouch;
  int nCasterLevel = GetCasterLevel(oCaster);
  effect eSun = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
  effect eHealVis = EffectVisualEffect(VFX_IMP_HEALING_X);
  int nDC=GetSpellSaveDC();

  if(!GetHasFeat(1582,oCaster)&&nCasterLevel > 15){//Check for Energy Channeler
    nCasterLevel = 15;
  }
  //Figure out how much to heal
  if(nMetaMagic==METAMAGIC_EMPOWER) nDamage=d4(nCasterLevel*6);
  else if(nMetaMagic==METAMAGIC_MAXIMIZE) nDamage=nCasterLevel*16;
  else nDamage=d4(nCasterLevel*4);

    //Check to see if the target is an undead
    if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
    {
        if(!GetIsReactionTypeFriendly(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_HEAL));
            //Make a touch attack
            int nTouch=TouchAttackMelee(oTarget);
            if (nTouch>0)
            {
                if(nTouch==2) nDamage=nDamage*2;
                nDamage=nDamage+getSneakDamage(oCaster,oTarget);
                //Make SR check
                if (!MyResistSpell(oCaster, oTarget))
                {

                    if(WillSave(oTarget, nDC))
                    nDamage /= 2;

                    if(nDamage >= GetCurrentHitPoints(oTarget))
                    nDamage = GetCurrentHitPoints(oTarget) - 1;

                    //Set damage
                    eKill = EffectDamage(nDamage, DAMAGE_TYPE_POSITIVE);
                    //Apply damage effect and VFX impact
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eKill, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eSun, oTarget);
                }
            }
        }
    }
    else
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HEAL, FALSE));

        //Set the heal effect
        eHeal = EffectHeal(nDamage);
        //Apply the heal effect and the VFX impact
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHealVis, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
    }
}
