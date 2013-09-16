#include "engine"
#include "x2_inc_spellhook"
#include "ave_inc_hier"
#include "ave_inc_duration"

void main()
{
/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }


// End of Spell Cast Hook

    object oPC=OBJECT_SELF;
    DoGeneralOnCast(oPC);
    int nSpellID = GetSpellId();

    int nLevel=9;
    int nClass=Hier_GetClass(oPC);

    int nCheckSpell=SPELL_MASS_HEAL;

    int nCL=HierFeat_GetCasterLevel(oPC);
    int nDC=HierFeat_GetSpellSaveDC(oPC,nLevel);
    int nMetaMagic=DoCheckForKnownSpell(nCheckSpell,oPC,nClass,nLevel);

    if(nMetaMagic==-5)
    {
        SendMessageToPC(oPC,"You do not have any uses or preparations for this spell!");
        return;
    }
    SendMessageToPC(oPC,"You have a use or preparation for this spell!");

    if(GetHasFeat(1581))
    {
        StoreLevel(oPC);
        int nDuration;
        if (nMetaMagic==METAMAGIC_EXTEND)
        nDuration=60;
        else
        nDuration=30;
        if(GetHasFeat(1386,oPC)) nDuration=nDuration+30;
        effect eDur=EffectVisualEffect(VFX_DUR_AURA_BLUE_LIGHT);
        SetLocalInt(oPC,"ave_dc",nDC);
        SetLocalInt(oPC,"ave_cl",nCL);
        SetLocalInt(oPC,"ave_duration",nSpellID);
        SetLocalInt(oPC,"ave_metamagic",nMetaMagic);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oPC,RoundsToSeconds(nDuration));
        IncrementRemainingFeatUses(oPC,ACTIVE_DURATION_FEAT);
        int iAveExpire=GetLocalInt(oPC,"ave_expire");
        SetLocalInt(oPC,"ave_expire",iAveExpire+1);
        DelayCommand(RoundsToSeconds(nDuration),DurationEnd(iAveExpire+1,oPC));
    }

    effect eKill;
  effect eVis = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
  effect eHeal;
  effect eVis2 = EffectVisualEffect(VFX_IMP_HEALING_G);
  effect eStrike = EffectVisualEffect(VFX_FNF_LOS_HOLY_10);
  int nTouch;
  int nModifier = d4(nCL*4);
  float fDelay;
  location lLoc =  GetSpellTargetLocation();

  // Caps the healing/damage at 250
  if(!GetHasFeat(1583,oPC)&&nModifier > 250){//Checks for supreme energy channeler
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
      if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD && !GetIsReactionTypeFriendly(oTarget))
      {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(oPC, SPELL_MASS_HEAL));
            //Make a touch attack
            nTouch = TouchAttackRanged(oTarget);
            if (nTouch > 0)
            {
                if(!GetIsReactionTypeFriendly(oTarget))
                {
                    //Make an SR check
                    if (!MyResistSpell(oPC, oTarget, fDelay))
                    {
                        if(WillSave(oTarget, nDC))
                        nModifier /= 2;

                        if(nModifier >= GetCurrentHitPoints(oTarget))
                        nModifier = GetCurrentHitPoints(oTarget) - 1;

                        //Set the damage effect
                        eKill = EffectDamage(nModifier, DAMAGE_TYPE_POSITIVE);
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
            if(GetIsFriend(oTarget) && GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(oPC, SPELL_MASS_HEAL, FALSE));
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
