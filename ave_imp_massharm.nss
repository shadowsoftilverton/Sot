#include "engine"

//::///////////////////////////////////////////////
//:: Mass Harm
//::
//::
//:://////////////////////////////////////////////
//:: Heals all friendly targets within 10ft to full
//:: unless if they are undead.
//:: If not undead they are reduced to 1d4 HP.
//:://////////////////////////////////////////////
//:: Created By: Dan Pages
//:: Created On: April 18, 2012
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
//#include "ave_inc_duration"

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
  //DoGeneralOnCast(oCaster);
  effect eKill;
  effect eVis = EffectVisualEffect(246);
  effect eHeal;
  effect eVis2 = EffectVisualEffect(VFX_IMP_HEALING_G);
  effect eStrike = EffectVisualEffect(VFX_FNF_LOS_EVIL_10);
  int nTouch;
  int nModifier = d4(GetCasterLevel(oCaster)*4);
  float fDelay;
  location lLoc =  GetSpellTargetLocation();
  int nDC=GetSpellSaveDC();

  // Caps the healing/damage at 250
  if(!GetHasFeat(1583,oCaster)&&nModifier > 250){//Checks for supreme energy channeler
    nModifier = 250;
  }

  //Apply VFX area impact
  ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStrike, lLoc);
  //Get first target in spell area
  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLoc);
  while(GetIsObjectValid(oTarget))
  {
      fDelay = GetRandomDelay();
      //Check to see if the target is an undead
      if (GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD && GetIsReactionTypeHostile(oTarget))
      {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_MASS_HEAL));
            //Make a touch attack
            nTouch = TouchAttackRanged(oTarget);
            if (nTouch > 0)
            {
                if(!GetIsReactionTypeFriendly(oTarget))
                {
                    //Make an SR check
                    if (!MyResistSpell(oCaster, oTarget, fDelay))
                    {
                        if(WillSave(oTarget, nDC))
                        nModifier /= 2;

                        if(nModifier >= GetCurrentHitPoints(oTarget))
                        nModifier = GetCurrentHitPoints(oTarget) - 1;

                        //Set the damage effect
                        eKill = EffectDamage(nModifier, DAMAGE_TYPE_NEGATIVE);
                        //Apply the VFX impact and damage effect
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eKill, oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    }
                 }
            }
      }
      else
      {
            //Make a faction check
            if(GetIsFriend(oTarget) && GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_MASS_HEAL, FALSE));
                //Set the damage effect
                eHeal = EffectHeal(nModifier);
                //Apply the VFX impact and heal effect
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
            }
      }
      //Get next target in the spell area
      oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLoc);
   }
}
