#include "engine"
#include "x2_inc_spellhook"
#include "ave_inc_hier"
#include "ave_inc_duration"
#include "spell_sneak_inc"

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
    int nClass=Hier_GetClass(oPC);
    DoGeneralOnCast(oPC);
    int nSpellID = GetSpellId();

    int nLevel;
    if (nClass==CLASS_TYPE_DRUID) nLevel=7;
    else nLevel=6;

    int nCheckSpell=SPELL_HEAL;
    int nCL=HierFeat_GetCasterLevel(oPC);
    int nDC=HierFeat_GetSpellSaveDC(oPC,nLevel);
    int nMetaMagic=DoCheckForKnownSpell(nCheckSpell,oPC,nClass,nLevel);

    if(nMetaMagic==-5)
    {
        SendMessageToPC(oPC,"You do not have any uses or preparations for this spell!");
        return;
    }
    SendMessageToPC(oPC,"You have a use or preparation for this spell!");

    if(GetHasFeat(1580))
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

    //Here we start firing the spell script

  object oTarget = GetSpellTargetObject();
  effect eKill, eHeal;
  int nDamage, nHeal, nTouch;
  effect eSun = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
  effect eHealVis = EffectVisualEffect(VFX_IMP_HEALING_X);

  if(!GetHasFeat(1582,oPC)&&nCL > 15){//Check for Energy Channeler
    nCL = 15;
  }
  //Figure out how much to heal
  if(nMetaMagic==METAMAGIC_EMPOWER) nDamage=d4(nCL*6);
  else if(nMetaMagic==METAMAGIC_MAXIMIZE) nDamage=nCL*16;
  else nDamage=d4(nCL*4);

    //Check to see if the target is an undead
    if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
    {
        if(!GetIsReactionTypeFriendly(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(oPC, SPELL_HEAL));
            //Make a touch attack
            int nTouch=TouchAttackRanged(oTarget);
            if (nTouch>0)
            {
                if(nTouch==2) nDamage=nDamage*2;
                nDamage=nDamage+getSneakDamage(oPC,oTarget);
                //Make SR check
                if (!MyResistSpell(oPC, oTarget))
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
        SignalEvent(oTarget, EventSpellCastAt(oPC, SPELL_HEAL, FALSE));

        //Set the heal effect
        eHeal = EffectHeal(nDamage);
        //Apply the heal effect and the VFX impact
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHealVis, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
    }
}
