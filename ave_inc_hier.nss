#include "engine"
#include "nwnx_funcs"
#include "nw_i0_spells"
#include "ave_inc_align"
#include "ave_inc_combat"

//struct MemSlot
//    {
///        int domain;
///        int id;
//        int meta;
//        int ready;
//    };

int Hier_GetClass(object oPC)
{
    int nClass=CLASS_TYPE_CLERIC;
    //SendMessageToPC(oPC,"Debug: Checking Class");
    if(GetLevelByClass(CLASS_TYPE_DRUID,oPC)>GetLevelByClass(nClass,oPC))
    {
        nClass=CLASS_TYPE_DRUID;
        //SendMessageToPC(oPC,"Debug: Druid");
    }
    if(GetLevelByClass(CLASS_TYPE_PALADIN,oPC)>GetLevelByClass(nClass,oPC))
    {
        nClass=CLASS_TYPE_PALADIN;
        //SendMessageToPC(oPC,"Debug: Paladin");
    }
    if(GetLevelByClass(CLASS_TYPE_RANGER,oPC)>GetLevelByClass(nClass,oPC))
    {
        nClass=CLASS_TYPE_RANGER;
        //SendMessageToPC(oPC,"Debug: Ranger");
    }
    return nClass;
}

int HierFeat_GetCasterLevel(object oPC)
{
    int iMyClass=Hier_GetClass(oPC);
    SetLocalInt(oPC,"ave_hierset",TRUE);
    SetLocalInt(oPC,"ave_hiercls",iMyClass);
    int iMyLevel=GetLevelByClass(iMyClass,oPC);
    SetLocalInt(oPC,"ave_hierlev",iMyLevel);
    int iCL=GetCasterLevel(oPC);
    SetLocalInt(oPC,"ave_hiercls",0);
    SetLocalInt(oPC,"ave_hierlev",0);
    SetLocalInt(oPC,"ave_hierset",FALSE);
    return iCL;
}

int DoCheckForKnownSpell(int nSpellID,object oPC,int nClass,int nLevel)
{
    //SendMessageToPC(oPC,"Debug: you just cast the "+IntToString(nLevel)+"th level spell as classID "+IntToString(nClass)+" and drew on spellID "+IntToString(nSpellID));
    int nMax;
    int nIndex;
    struct MemorizedSpellSlot MemSlot;
    //SendMessageToPC(oPC,"Checking For Known Spell");
    while(nLevel<10)
    {
        nIndex=0;
        nMax=GetMaxSpellSlots(oPC,nClass,nLevel);
        //SendMessageToPC(oPC,"Debug: you have "+IntToString(nMax)+" spell slots at level "+IntToString(nLevel));
        while(nIndex<nMax)
        {
            MemSlot=GetMemorizedSpell(oPC,nClass,nLevel,nIndex);
            //SendMessageToPC(oPC,"Debug: this memorized spell is "+IntToString(MemSlot.id)+" and its ready state is "+IntToString(MemSlot.ready));
            if(MemSlot.id==nSpellID&&MemSlot.ready==TRUE)
            {
                MemSlot.ready=FALSE;
                SetMemorizedSpell(oPC,nClass,nLevel,nIndex,MemSlot);
                SendMessageToPC(oPC,"Debug: you are using metamagic "+IntToString(MemSlot.meta));
                return MemSlot.meta;
            }
            nIndex++;
        }
    nLevel++;
    }
    return -5;
}

void DoRangedCure(int nDC, int nMetaMagic, int nDamage, int nMaxExtraDamage, int nMaximized, int vfx_impactHurt, int vfx_impactHeal, int nSpellID)
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nHeal;
    effect eHeal, eDam;
    object oCaster=OBJECT_SELF;

    int nExtraDamage = HierFeat_GetCasterLevel(oCaster); // * figure out the bonus damage
    if (nExtraDamage > nMaxExtraDamage)
    {
        nExtraDamage = nMaxExtraDamage;
    }

    //else
    {
        nDamage = nDamage + nExtraDamage;
    }

    if(GetIsOpposedAlignment(oTarget,oCaster)&&GetRacialType(oTarget)==RACIAL_TYPE_UNDEAD&&GetHasFeat(1557,oCaster))
    nDamage=nMaximized+nExtraDamage;
    else if(!GetIsOpposedAlignment(oTarget,oCaster)&&GetRacialType(oTarget)!=RACIAL_TYPE_UNDEAD&&GetHasFeat(1556,oCaster))
    nDamage=nMaximized+nExtraDamage;

    //Make metamagic checks
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        // 04/06/2005 CraigW - We should be using the maximized value here instead of 8.
        nDamage = nMaximized + nExtraDamage;
    }
    if (nMetaMagic == METAMAGIC_EMPOWER || GetHasFeat(FEAT_HEALING_DOMAIN_POWER))
    {
        nDamage = nDamage + (nDamage/2);
    }


    if (GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
    {
        //Figure out the amount of damage to heal
        eHeal = EffectHeal(nDamage);
        //Apply heal effect and VFX impact
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
        effect eVis2 = EffectVisualEffect(vfx_impactHeal);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellID, FALSE));


    }
    //Check that the target is undead
    else
    {
        int nTouch = TouchAttackRanged(oTarget);
        if (nTouch > 0)
        {
            if(nTouch==2) nDamage=nDamage*2;
            nDamage=nDamage+getSneakDamage(oCaster,oTarget);
            if(!GetIsReactionTypeFriendly(oTarget))
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellID));
                //if (!MyResistSpell(OBJECT_SELF, oTarget))
                //{
                    eDam = EffectDamage(nDamage,DAMAGE_TYPE_POSITIVE);
                    //Apply the VFX impact and effects
                    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    effect eVis = EffectVisualEffect(vfx_impactHurt);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                //}
            }
        }
    }
}

void DoRangedInflict(int nDC,int nMetaMagic,int nDamage, int nMaxExtraDamage, int nMaximized, int vfx_impactHurt, int vfx_impactHeal, int nSpellID)
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nTouch = TouchAttackRanged(oTarget);
    object oCaster=OBJECT_SELF;
    int nExtraDamage = HierFeat_GetCasterLevel(OBJECT_SELF); // * figure out the bonus damage
    if (nExtraDamage > nMaxExtraDamage)
    {
        nExtraDamage = nMaxExtraDamage;
    }

    if(GetIsOpposedAlignment(oTarget,oCaster)&&GetRacialType(oTarget)!=RACIAL_TYPE_UNDEAD&&GetHasFeat(1557,oCaster))
    nDamage=nMaximized;
    else if(!GetIsOpposedAlignment(oTarget,oCaster)&&GetRacialType(oTarget)==RACIAL_TYPE_UNDEAD&&GetHasFeat(1556,oCaster))
    nDamage=nMaximized;

        //Check for metamagic
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nDamage = nMaximized;
    }
    else
    if (nMetaMagic == METAMAGIC_EMPOWER)
    {
        nDamage = nDamage + (nDamage / 2);
    }


    //Check that the target is undead
    if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
    {
        effect eVis2 = EffectVisualEffect(vfx_impactHeal);
        //Figure out the amount of damage to heal
        //nHeal = nDamage;
        //Set the heal effect
        effect eHeal = EffectHeal(nDamage + nExtraDamage);
        //Apply heal effect and VFX impact
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellID, FALSE));
    }
    else if (nTouch >0 )
    {
        if(nTouch==2) nDamage=nDamage*2;
        nDamage=nDamage+getSneakDamage(oCaster,oTarget);
        if(!GetIsReactionTypeFriendly(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellID));
            //if (!MyResistSpell(OBJECT_SELF, oTarget))
            //{
                int nDamageTotal = nDamage + nExtraDamage;
                // A succesful will save halves the damage
                if(MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_ALL,OBJECT_SELF))
                {
                    nDamageTotal = nDamageTotal / 2;
                }
                effect eVis = EffectVisualEffect(vfx_impactHurt);
                effect eDam = EffectDamage(nDamageTotal,DAMAGE_TYPE_NEGATIVE);
                //Apply the VFX impact and effects
                DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

            //}
        }
    }
}

int HierFeat_GetSpellSaveDC(object oPC,int nLevel)
{
    int nDC=10+GetAbilityModifier(ABILITY_WISDOM,oPC)+nLevel;
    if(GetHasFeat(FEAT_EPIC_SPELL_FOCUS_NECROMANCY, oPC)) nDC += 3;
    else if(GetHasFeat(FEAT_GREATER_SPELL_FOCUS_NECROMANCY, oPC)) nDC += 2;
    else if(GetHasFeat(FEAT_SPELL_FOCUS_NECROMANCY, oPC)) nDC += 1;
    return nDC;
}

int GetNthFavoredEnemy(object oPC, int nFavored)
{
     int nCheck=0;
     int iHas;
     while(nFavored>0&&nCheck<26)
     {
         iHas=FECheck(oPC,nCheck);
         if(iHas==1)
         {
            nFavored=nFavored-1;
            if(nFavored==0) return nCheck;
         }
         nCheck++;
     }
     return -1;
}
