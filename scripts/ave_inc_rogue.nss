#include "engine"
#include "x2_inc_itemprop"
#include "aps_include"
#include "nwnx_funcs"
#include "aps_include"

//feat consts

const int SMALLEST_VULNERABILITY=1478;
const int SMALLEST_VULNERABILITY_2=1479;
const int VENDETTA=1480;
const int FALSE_FRIEND=1481;
const int BUCKLER_TRICKSTER=1482;
const int LIGHT_ARMOR_TRICKSTER=1483;
const int ANOTHER_DAY=1484;
const int FEIGNED_RETREAT=1485;
const int CANNY_CUTTER=1486;
const int SNIPERS_EYE=1487;
const int SNIPERS_EYE_2=1488;
const int SNIPERS_EYE_3=1489;
const int DEADLY_GIFT=1490;
const int RIGGED_DECOY=1491;
const int HIDDEN_WEAPONS=1492;
const int HIDDEN_WEAPONS_2=1493;
const int CHEAP_SHOT=1494;
const int CUNNING_CAUTION=1495;
const int TREASURE_SCENT=1496;
const int MASTER_OF_DISGUISE=1497;
const int MIASMIC_FLASK=1498;
const int CAUSTIC_FLASK=1499;
const int HONEYED_WORDS=1500;
const int LINGERING_SHROUD=1501;
const int SLY_SPELLDODGER=1502;
const int SLY_SPELLTHIEF=1503;
const int GARROTE_GRAB=1504;

//spell consts

const int SPELL_SMALLEST_VULNERABILITY=1077;
const int SPELL_SMALLEST_VULNERABILITY_2=1078;
const int SPELL_VENDETTA=1079;
const int SPELL_FALSE_FRIEND=1080;
const int SPELL_BUCKLER_TRICKSTER=1081;
const int SPELL_LIGHT_ARMOR_TRICKSTER=1082;
const int SPELL_ANOTHER_DAY=1083;
const int SPELL_FEIGNED_RETREAT=1084;
const int SPELL_CANNY_CUTTER=1085;
const int SPELL_SNIPERS_EYE=1086;
const int SPELL_DEADLY_GIFT=1089;
const int SPELL_HIDDEN_WEAPONS=1090;
const int SPELL_HIDDEN_WEAPONS_2=1091;
const int SPELL_CHEAP_SHOT=1092;
const int SPELL_CUNNING_CAUTION=1093;
const int SPELL_LINGERING_SHROUD=1094;
const int SPELL_MIASMIC_FLASK=1095;
const int SPELL_SLY_SPELLDODGER=1098;
const int SPELL_SLY_SPELLTHIEF=1099;
const int SPELL_GARROTE_GRAB=1105;

void DoDeadlyGiftExplode(object oItem, int iItemID);

int GetIsStackableItem(object oItem);

void DecoyBlast(object oDead);

void SnipeHit(object oSpellTarget, object oSpellOrigin);

void NoLongerVulnItem(object oVictim, object oItem, int ImmunityType);

void NoLongerVulnPM(object oVictim);

void SmallestVulnerability(object oPC,object oVictim,float fDur);

void DoDeadlyGiftImpact(float fDelay);

void DoDeadlyGiftExplode(object oItem, int iItemID);

//This is intended to be a general-purpose solution to cooldown feats with a cooldown longer than the rest timer
//would be exploitable by using the feat and immediately resting if we simply did DelayCommand(fCooldown,nFeat).
//Works in conjunction with mod_enter and mod_rest.
void GeneralCoolDown(int nFeat, object oPC, float fCoolDown);

void CoolDownCheck(int nFeat, object oPC, int iCheck);

void CoolDownCheck(int nFeat, object oPC, int iCheck)
{
    if(GetIsObjectValid(oPC))
    {
        string sFeatName=Get2DAString("feat","LABEL",nFeat);
        if(GetPersistentInt(oPC,"ave_r_cd_"+IntToString(nFeat))==iCheck)
        {
            SendMessageToPC(oPC,"Iteration "+IntToString(iCheck)+" of feat "+sFeatName+" is the most recent one, so feat is cooling down. Most recent iteration is: "+IntToString(GetLocalInt(oPC,"ave_r_cd_"+IntToString(nFeat))));
            IncrementRemainingFeatUses(oPC,nFeat);
            //DeleteLocalInt(oPC,"ave_r_cd_"+IntToString(nFeat));
        }
        else SendMessageToPC(oPC,"Iteration "+IntToString(iCheck)+" of feat "+sFeatName+" is not the most recent one, so feat is not cooling down. Most recent iteration is: "+IntToString(GetLocalInt(oPC,"ave_r_cd_"+IntToString(nFeat))));
        }
}

void GeneralCoolDown(int nFeat, object oPC, float fCoolDown)
{
    int iMyID=1;
    int iOldID=GetPersistentInt(oPC,"ave_r_cd_"+IntToString(nFeat));
    iMyID=iOldID+iMyID;
    SetPersistentInt(oPC,"ave_r_cd_"+IntToString(nFeat),iMyID);
    DelayCommand(fCoolDown,CoolDownCheck(nFeat,oPC,iMyID));
    string sFeatName=Get2DAString("feat","LABEL",nFeat);
    SendMessageToPC(oPC,"Doing cooldown for feat "+sFeatName+" and setting most recent iteration to "+IntToString(iMyID));
}

int GetIsStackableItem(object oItem)
{
    //Must have a chest tagged checkchest

    object oCopy=CopyItem(oItem, GetObjectByTag("checkchest"));

    //Set the stacksize to two
    SetItemStackSize(oCopy, 2);

    //Check if it really is two - otherwise, not stackable!
    int bStack=GetItemStackSize(oCopy)==2;

    //Destroy the test copy
    DestroyObject(oCopy);

    //Return bStack which is TRUE if item is stackable
    return bStack;
}

void MakeEquippedUndroppable(object oDead)
{
    int nSlot=0;
    while(nSlot<17)
    {
        SetDroppableFlag(GetItemInSlot(nSlot,oDead),FALSE);
        nSlot++;
    }
}

void DecoyBlast(object oDead)
{
    location lLoc=GetLocation(oDead);
    effect eLink;
    effect eVis=EffectVisualEffect(VFX_IMP_FLAME_M);
    effect eAOE=EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_FIRE);
    int nDC=GetLocalInt(oDead,"ave_decoydc");
    int nLevel=GetLocalInt(oDead,"ave_decoyn");
    effect eDam;
    int nDam;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eAOE,lLoc);
    object oVictim=GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lLoc,FALSE,OBJECT_TYPE_CREATURE||OBJECT_TYPE_PLACEABLE||OBJECT_TYPE_DOOR);
    while(GetIsObjectValid(oVictim))
    {
        nDam=GetReflexAdjustedDamage(d12(nLevel),oVictim,nDC,SAVING_THROW_TYPE_FIRE,oDead);
        eDam=EffectLinkEffects(EffectDamage(nDam,DAMAGE_TYPE_FIRE),eVis);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oVictim);
        oVictim=GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lLoc,FALSE,OBJECT_TYPE_CREATURE||OBJECT_TYPE_PLACEABLE||OBJECT_TYPE_DOOR);
    }
    MakeEquippedUndroppable(oDead);
    DestroyObject(oDead,0.1);
}

void SnipeHit(object oSpellTarget, object oSpellOrigin)
{
    int nDC=14+(GetLevelByClass(CLASS_TYPE_ROGUE,oSpellOrigin)/2);
    if(GetHasFeat(FEAT_ZEN_ARCHERY,oSpellOrigin))
    {
        nDC=nDC+GetAbilityModifier(ABILITY_WISDOM,oSpellOrigin);
    }
    else
    {
        nDC=nDC+GetAbilityModifier(ABILITY_WISDOM,oSpellOrigin);
    }
    float fDur=6.0;
    if(GetHasFeat(SNIPERS_EYE_2,oSpellOrigin)) nDC=nDC+4;
    if(GetHasFeat(SNIPERS_EYE_3,oSpellOrigin)) {nDC=nDC+4;
    fDur=12.0;}

    if(ReflexSave(oSpellTarget,nDC,SAVING_THROW_TYPE_NONE,oSpellOrigin)==0)
    {
        effect eBlind=EffectBlindness();
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBlind,oSpellTarget,fDur);
    }

    if(GetHasFeat(SNIPERS_EYE_2,oSpellOrigin))
    {
        if(WillSave(oSpellTarget,nDC,SAVING_THROW_TYPE_NONE,oSpellOrigin)==0)
        {
            effect eDaze=EffectDazed();
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDaze,oSpellTarget,fDur);
        }
    }

    if(GetHasFeat(SNIPERS_EYE_3,oSpellOrigin))
    {
        if(FortitudeSave(oSpellTarget,nDC,SAVING_THROW_TYPE_NONE,oSpellOrigin)==0)
        {
            effect eKD=EffectKnockdown();
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eKD,oSpellTarget,fDur);
        }
    }
}

void NoLongerVulnItem(object oVictim, object oItem, int ImmunityType)
{
    itemproperty ipImmune=ItemPropertyImmunityMisc(ImmunityType);
    IPSafeAddItemProperty(oItem,ipImmune);
}

void NoLongerVulnPM(object oVictim)
{
    AddKnownFeat(oVictim,FEAT_DEATHLESS_MASTERY,GetHitDice(oVictim));
    DeletePersistentVariable(oVictim,"ave_vuln_pm");
}

void SmallestVulnerability(object oPC,object oVictim,float fDur)
{
    if(GetIsImmune(oVictim,IMMUNITY_TYPE_CRITICAL_HIT,oPC)||GetIsImmune(oVictim,IMMUNITY_TYPE_SNEAK_ATTACK,oPC))
    {
        int iSlot=0;
        itemproperty ipLoop;
        object oItem;
        while(iSlot<18)
        {
            oItem=GetItemInSlot(iSlot,oVictim);
            ipLoop=GetFirstItemProperty(oItem);
            while(GetIsItemPropertyValid(ipLoop))
            {
                if(GetItemPropertyType(ipLoop)==ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS)
                {
                    if(GetItemPropertySubType(ipLoop)==IP_CONST_IMMUNITYMISC_CRITICAL_HITS)
                    {
                        if(GetItemPropertyDurationType(ipLoop)==DURATION_TYPE_PERMANENT)
                        DelayCommand(fDur,NoLongerVulnItem(oVictim,oItem,IP_CONST_IMMUNITYMISC_CRITICAL_HITS));
                        RemoveItemProperty(oItem,ipLoop);
                    }
                    if(GetItemPropertySubType(ipLoop)==IP_CONST_IMMUNITYMISC_BACKSTAB)
                    {
                        if(GetItemPropertyDurationType(ipLoop)==DURATION_TYPE_PERMANENT)
                        DelayCommand(fDur,NoLongerVulnItem(oVictim,oItem,IP_CONST_IMMUNITYMISC_BACKSTAB));
                        RemoveItemProperty(oItem,ipLoop);
                    }
                }
                ipLoop=GetNextItemProperty(oItem);
            }
            iSlot++;
        }
        effect eLoop=GetFirstEffect(oVictim);
        while(GetIsEffectValid(eLoop))
        {
            if (GetEffectType(eLoop)==EFFECT_TYPE_IMMUNITY)
            {
                RemoveEffect(oVictim,eLoop);
            }
            eLoop=GetNextEffect(oVictim);
        }
        if(GetHasFeat(FEAT_DEATHLESS_MASTERY,oVictim))
        {
            RemoveKnownFeat(oVictim,FEAT_DEATHLESS_MASTERY);
            DelayCommand(fDur,NoLongerVulnPM(oVictim));
            if(GetIsPC(oVictim)) SetPersistentInt(oVictim,"ave_vuln_pm",FloatToInt(fDur));
        }
    }
    else SendMessageToPC(oPC,"This ability only works on creatures immune to critical hits or creatures immune to sneak attacks!");
}

void DoDeadlyGiftImpact(float fDelay)
{
     object oPC=OBJECT_SELF;
     object oItem=GetSpellTargetObject();
     if((!GetIsStackableItem(oItem))&&(!GetPlotFlag(oItem)))
     {
        int nDice=GetLevelByClass(CLASS_TYPE_ROGUE,oPC);
        int nDC=10+(nDice/2)+GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
        object oModule=GetModule();
        int nItemID=GetLocalInt(oModule,"ave_gift_num")+1;//This is the ID of the item. Used to distinguish it if PCs are simultaneously deadly gifting and their victims are all logging in and out at the same time.
        SetLocalInt(oItem,"ave_gift_id",nItemID);
        SetLocalInt(oModule,"ave_gift_num",nItemID);
        SetLocalInt(oItem,"ave_gift_ndice",nDice);
        SetLocalInt(oItem,"ave_gift_ndc",nDC);
        DelayCommand(fDelay,DoDeadlyGiftExplode(oItem,nItemID));
     }
     else SendMessageToPC(oPC,"This ability does not work on plot items or stackable items");
     GeneralCoolDown(DEADLY_GIFT,oPC,900.0);
}

void DoDeadlyGiftExplode(object oItem, int iItemID)
{
    if(GetIsObjectValid(oItem))
    {
        location lLoc;
        effect eDam;
        int nDice=GetLocalInt(oItem,"ave_gift_ndice");
        int nDC=GetLocalInt(oItem,"ave_gift_ndc");
        object oOwner=GetItemPossessor(oItem);
        effect eLink;
        effect eVis=EffectVisualEffect(VFX_IMP_FLAME_M);
        effect eAOE=EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_FIRE);
        if(GetIsObjectValid(oOwner))
        {
            string sName=GetName(oItem);
            lLoc=GetLocation(oOwner);
            SendMessageToPC(oOwner,"Your "+sName+" was rigged! It explodes in a painful blast!");
        }
        else lLoc=GetLocation(oItem);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eAOE,lLoc);
        int iDam;
        object oVictim=GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lLoc,FALSE,OBJECT_TYPE_CREATURE||OBJECT_TYPE_PLACEABLE||OBJECT_TYPE_DOOR);
        while(GetIsObjectValid(oVictim))
        {
            if(oVictim==oOwner)
            {
                iDam=d8(nDice);//No save for the owner of the item
            }
            else
            {
                iDam=GetReflexAdjustedDamage(d8(nDice),oVictim,nDC,SAVING_THROW_TYPE_FIRE);
            }
            eDam=EffectDamage(iDam,DAMAGE_TYPE_FIRE);
            eLink=EffectLinkEffects(eDam,eVis);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eLink,oVictim);
            oVictim=GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lLoc,FALSE,OBJECT_TYPE_CREATURE||OBJECT_TYPE_PLACEABLE||OBJECT_TYPE_DOOR);
        }
        DeleteLocalInt(GetModule(),"ave_gift_logout_"+IntToString(iItemID));
        DestroyObject(oItem);
    }
    else SetLocalInt(GetModule(),"ave_gift_logout_"+IntToString(iItemID),1);//This basically tells the module to start checking new PCs that log in for deadly gifts
}
