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

    int nCheckSpell=SPELL_HARM;

    int nCL=HierFeat_GetCasterLevel(oPC);
    int nDC=HierFeat_GetSpellSaveDC(oPC,nLevel);
    int nMetaMagic=DoCheckForKnownSpell(nCheckSpell,oPC,nClass,nLevel);

    if(nMetaMagic==-5)
    {
        SendMessageToPC(oPC,"You do not have any uses or preparations for this spell!");
        return;
    }
    SendMessageToPC(oPC,"You have a use or preparation for this spell!");

    if(GetHasFeat(1577))
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

    int nDamage, nHeal;
    effect eVis = EffectVisualEffect(246);
    effect eVis2 = EffectVisualEffect(VFX_IMP_HEALING_G);
    effect eHeal, eDam;
    if(!GetHasFeat(1582,oPC)&&nCL > 15){//Check for Energy Channeler
        nCL = 15;
    }
    object oTarget=GetSpellTargetObject();
    if(nMetaMagic==METAMAGIC_EMPOWER) nDamage=d4(nCL*6);
    else if(nMetaMagic==METAMAGIC_MAXIMIZE) nDamage=nCL*16;
    else nDamage=d4(nCL*4);
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
        SignalEvent(oTarget, EventSpellCastAt(oPC, SPELL_HARM, FALSE));
    }
    else
    {
        int nTouch = TouchAttackRanged(oTarget);
        if (nTouch != FALSE)  //GZ: Fixed boolean check to work in NWScript. 1 or 2 are valid return numbers from TouchAttackMelee
        {
            if(nTouch==2) nDamage=nDamage*2;
            nDamage=nDamage+getSneakDamage(oPC,oTarget);

            if(!GetIsReactionTypeFriendly(oTarget))
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(oPC, SPELL_HARM));
                if (!MyResistSpell(oPC, oTarget))
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
}
