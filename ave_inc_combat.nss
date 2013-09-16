#include "engine"
#include "nwnx_structs"
#include "nwnx_defenses"
#include "ave_inc_tables"
#include "nwnx_weapons"
#include "nwnx_funcs"
#include "inc_equipment"

//Checks to see if oVictim is facing away from oPC
int GetIsBehind(object oPC,object oVictim)
{
    vector vDist=GetPosition(oVictim)-GetPosition(oPC);
    float fDiff=VectorToAngle(vDist)-GetFacing(oVictim);
    if(fDiff>-30.0&&fDiff<30.0)
    {
        //SendMessageToPC(oPC,"Debug: Behind target with fDiff of "+FloatToString(fDiff,5,1)+" degrees");
        return 1;
    }
    if(fDiff<(-330.0)||fDiff>330.0)
    {
        //SendMessageToPC(oPC,"Debug: Behind target with fDiff of "+FloatToString(fDiff,5,1)+" degrees");
        return 1;
    }
    //SendMessageToPC(oPC,"Debug: Not behind target with fDiff of "+FloatToString(fDiff,5,1)+" degrees");
    return 0;
}

//Checks to see if oShooter has a longbow or shortbow in their main hand.
int IsUsingBow(object oShooter)
{
    object oOnHand=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oShooter);
    int iType=GetBaseItemType(oOnHand);
    if(iType==BASE_ITEM_SHORTBOW||iType==BASE_ITEM_LONGBOW) return TRUE;
    return FALSE;
}

int DamTypeWrapper(object oWeapon)
{
    int iDamType;
    if(oWeapon==OBJECT_INVALID) iDamType=DAMAGE_TYPE_BLUDGEONING;
    else iDamType=GetWeaponDamageType(oWeapon);
    return iDamType;
}

//Handles the rear attack feats (dirty fighting, improved precise shot, precise shot)
void DoRearAttackFeats(object oAtt, object oHit)
{
    if(GetIsBehind(oAtt,oHit))
    {
        int nDam=0;
        if(GetHasFeat(1541,oAtt))//Dirty Fighting
        {
            nDam=nDam+d4(1);
        }
        if(GetHasFeat(1539,oAtt)&&IPGetIsRangedWeapon(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oAtt)))//Improved Precise Shot
        {
            nDam=nDam+d6(2);
        }
        else if(GetHasFeat(1538,oAtt)&&IPGetIsRangedWeapon(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oAtt)))//Precise Shot
        {
            nDam=nDam+d6(1);
        }
        int iDamType=DamTypeWrapper(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oAtt));
        effect eDam=EffectDamage(nDam,iDamType,DAMAGE_POWER_PLUS_TWENTY);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oHit);
    }
}

//Handles the shot on the run feat - don't send them here unless they have it
void DoShotOnRun(object oAtt, object oHit)
{
    if(IPGetIsRangedWeapon(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oAtt)))
    {
        if(!GetHasSpellEffect(1136,oAtt))//Shot on the run spell ID
        {
            effect eSpeed=EffectMovementSpeedIncrease(30);
            SetEffectSpellId(eSpeed,1136);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSpeed,oAtt,12.0);
        }
    }
}

//Returns the sum of Attack bonus boosts oAtt has vs. oHit when using oWep
//including race, alignment
int GetABvsBoosts(object oAtt, object oHit, object oWep)
{
    int HitRace=GetRacialType(oHit);
    int iIsFavored=FECheck(oAtt,HitRace);
    int iAB=0;
    if(iIsFavored)
    {
        if(GetHasFeat(FEAT_EPIC_BANE_OF_ENEMIES,oAtt)) iAB=iAB+2;
    }
    return iAB;
}


//Gets the enhancement of weapon oWep for purposes of bypassing DR.
int GetWeaponEnhance(object oWep)
{
    int nEnc=0;
    int iCompare=0;
    itemproperty ipCheck=GetFirstItemProperty(oWep);
    while(GetIsItemPropertyValid(ipCheck))
    {
        if(GetItemPropertyType(ipCheck)==ITEM_PROPERTY_ATTACK_BONUS)
        {
            iCompare=GetItemPropertyInteger(ipCheck,3);
            if(iCompare>nEnc) nEnc=iCompare;
        }
        else if(GetItemPropertyType(ipCheck)==ITEM_PROPERTY_ENHANCEMENT_BONUS)
        {
            iCompare=GetItemPropertyInteger(ipCheck,3);
            if(iCompare>nEnc) nEnc=iCompare;
        }
        ipCheck=GetNextItemProperty(oWep);
    }
    return nEnc;
}

void DoWhirlDamage(object oException,object oCaster)
{
    int nDamageDice=1;
    if(GetHasFeat(645,oCaster))
    {
        nDamageDice=2;
    }
    object oWep=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oCaster);
    if(!GetIsObjectValid(oWep)) oWep=GetItemInSlot(INVENTORY_SLOT_ARMS,oCaster);
    effect eDam;
    object oTarget=GetFirstObjectInShape(SHAPE_SPHERE,2.5,GetLocation(oCaster));
    while(GetIsObjectValid(oTarget))
    {
        eDam=EffectDamage(d12(nDamageDice),GetWeaponEnhance(oWep));
        if((oTarget!=oCaster)&(oTarget!=oException)&GetIsReactionTypeHostile(oTarget,oCaster)) ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oTarget);
        oTarget=GetNextObjectInShape(SHAPE_SPHERE,2.5,GetLocation(oCaster));
    }
}

//Gets a damage bonus or penalty of oWeapon against oHit
int DoWeaponDamBonus(object oWep, object oHit)
{
    int iDamAdd=0;
    int iDamPow=GetWeaponEnhance(oWep);
    int iDamDo=0;
    int iDamType=0;
    int nMighty=0;
    effect eDamDo;
    int iType;
    itemproperty ipCheck=GetFirstItemProperty(oWep);
    while(GetIsItemPropertyValid(ipCheck))
    {
        iType=GetItemPropertyType(ipCheck);
        if(iType==ITEM_PROPERTY_DAMAGE_BONUS)
        {
            iDamDo=GetDamageFromDamageBonusConst(GetItemPropertyInteger(ipCheck,1));
            iDamType=GetItemPropertyInteger(ipCheck,0);
            if(iDamType==DamTypeWrapper(oWep))
            {
                iDamAdd=iDamAdd+iDamDo;
            }
            else
            {
                eDamDo=EffectDamage(iDamDo,iDamType,iDamPow);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamDo,oHit);
            }
        }
        if(iType==ITEM_PROPERTY_ENHANCEMENT_BONUS)
        {
            iDamAdd=iDamAdd+GetDamageFromDamageBonusConst(GetItemPropertyInteger(ipCheck,0));
        }
        if(iType==ITEM_PROPERTY_DECREASED_DAMAGE)
        {
            iDamAdd=iDamAdd-GetDamageFromDamageBonusConst(GetItemPropertyInteger(ipCheck,0));
        }
        if(iType==ITEM_PROPERTY_DECREASED_ENHANCEMENT_MODIFIER)
        {
            iDamAdd=iDamAdd-GetDamageFromDamageBonusConst(GetItemPropertyInteger(ipCheck,0));
        }
        if(iType==ITEM_PROPERTY_MIGHTY)
        {
            nMighty=GetItemPropertyInteger(ipCheck,0);
            if(nMighty>GetAbilityModifier(ABILITY_STRENGTH,OBJECT_SELF))
            nMighty=GetAbilityModifier(ABILITY_STRENGTH,OBJECT_SELF);
            iDamAdd=iDamAdd+nMighty;
        }
        ipCheck=GetNextItemProperty(oWep);
    }
    return iDamAdd;
}

//Inflicts all bonus damage types oAtt can do to oHit. Returns damage bonus/penalty, if any.
//Currently includes damage penalty effects, favored enemies, and weapon specialization
//Also calls DoWeaponDamBonus
int DoDamBoosts(object oAtt, object oHit,object oWep)
{
    int HitRace=GetRacialType(oHit);
    int iIsFavored=FECheck(oAtt,HitRace);
    int iDamBonus=0;
    if(iIsFavored)
    {
        iDamBonus=iDamBonus+(GetLevelByClass(CLASS_TYPE_RANGER,oAtt)/5)+1;
        if(GetHasFeat(FEAT_EPIC_BANE_OF_ENEMIES,oAtt)) iDamBonus=iDamBonus+d6(2);
    }
    effect eDam;
    effect eCheck=GetFirstEffect(oAtt);
    while(GetIsEffectValid(eCheck))
    {
        //For now damage bonuses don't apply, until we figure out a way to make them sort by racial type
        //if(GetEffectType(eCheck)==EFFECT_TYPE_DAMAGE_INCREASE)
        //{
            //eDam=EffectDamage(GetEffectInteger(eCheck,0),GetEffectInteger(eCheck,1));
            //ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oHit);
        //}
        //else
        if(GetEffectType(eCheck)==EFFECT_TYPE_DAMAGE_DECREASE)
        {
            iDamBonus=iDamBonus-GetEffectInteger(eCheck,1);
        }
        eCheck=GetNextEffect(oAtt);
    }
    int iWepType=GetBaseItemType(oWep);
    string sSpec=Get2DAString("baseitem_feats","WepSpec",iWepType);
    string sEpicSpec=Get2DAString("baseitem_feats","EpWepSpec",iWepType);
    if(GetHasFeat(StringToInt(sEpicSpec),oAtt))
    {
        iDamBonus=iDamBonus+6;
    }
    else if(GetHasFeat(StringToInt(sSpec),oAtt))
    {
        iDamBonus=iDamBonus+2;
    }
    int iWeaponBonus=DoWeaponDamBonus(oWep,oHit);
    iDamBonus=iDamBonus+iWeaponBonus;
    return iDamBonus;
}

//Gets the ammo type that goes with iType of ranged weapon. Return value on error -1
int GetAmmoSlotFromRangedWeaponType(int iType)
{
    string sAmmoType=Get2DAString("baseitems","AmmunitionType",iType);
    int iAmmoType=StringToInt(sAmmoType);
    return GetItemSlotFromAmmoBaseType(iAmmoType);
}

//Gets the strength bonus from a weapon - .5, 1, or 1.5
int GetStrBoost(object oAtt, object oWep, int iOffHand)
{
    if(iOffHand==1)
    {
        return GetAbilityModifier(ABILITY_STRENGTH,oAtt)/2;
    }
    else if(GetIsOptionalTwoHandable(oWep,oAtt) && !GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oAtt)) && IPGetIsMeleeWeapon(oWep))
    return GetAbilityModifier(ABILITY_STRENGTH,oAtt)+GetAbilityModifier(ABILITY_STRENGTH,oAtt)/2;
    else if(GetWeaponSize(oWep)==GetCreatureSize(oAtt)+1)
    return GetAbilityModifier(ABILITY_STRENGTH,oAtt)+GetAbilityModifier(ABILITY_STRENGTH,oAtt)/2;
    else return GetAbilityModifier(ABILITY_STRENGTH,oAtt);
}

//Gets unarmed damage. A monk should get more.
int GetUnarmedBaseDamage(object oAtt)
{
    if(GetLevelByClass(CLASS_TYPE_MONK,oAtt)==0) return GetNonMonkUnarmedBaseDamage(oAtt);
    return GetMonkUnarmedBaseDamage(oAtt);
}

//Gets the base damage thw weapon does
int GetWeaponBaseDamage(object oWep)
{
    int iType=GetBaseItemType(oWep);
    string sDiceType=Get2DAString("baseitems","DieToRoll",iType);
    string sDiceNum=Get2DAString("baseitems","NumDice",iType);
    //SendMessageToPC(GetItemPossessor(oWep),"Debug: Your weapon does "+sDiceNum+"d"+sDiceType+" base damage");
    int iMyRoll=GetGeneralDiceRoll(StringToInt(sDiceNum),StringToInt(sDiceType));
    return iMyRoll;
}

//Gets base weapon damage (damage plus strength) for oAtt using oWep
int GetStrengthAndAmmoDamage(object oAtt,object oWep,int iOffHand,object oHit)
{
    int nDamage=0;
    int iType=GetBaseItemType(oWep);
    string sBase=CraftingBaseItemTo2daColumn(iType);
    if(sBase=="1_Ranged")
    {
        int nSlot=GetAmmoSlotFromRangedWeaponType(iType);
        object oAmmo=GetItemInSlot(nSlot,oAtt);
        nDamage=nDamage+GetStrengthAndAmmoDamage(oAtt,oAmmo,FALSE,oHit);
    }
    else if(sBase=="2_Thrown")  //Strength based bonuses for thrown
    {
        nDamage=nDamage+GetStrBoost(oAtt,oWep,iOffHand);
    }
    else if(sBase=="5_Ammo")
    { //Ammo provides no stat-based bonuses, but here is where we call the damage bonuses from it
        nDamage=nDamage+DoWeaponDamBonus(oWep,oHit);
    }
    else //Anything else is a melee weapon - strength based bonuses for melee
    {
        nDamage=nDamage+GetStrBoost(oAtt,oWep,iOffHand);
    }
    //Here I will add item base damage (ex 1d8 for longbow) to nDamage
    return nDamage;
}

//Does damage to oHit as if oAtt had just hit with his currently equipped weapon
//if nCrit is 2, damages as if it were a critical hit
void DoScriptedDamage(object oAtt, object oHit, int nCrit, int iOffHand)
{
    int iSlot=INVENTORY_SLOT_RIGHTHAND;
    if(iOffHand==1) iSlot=INVENTORY_SLOT_LEFTHAND;
    object oWep=GetItemInSlot(iSlot,oAtt);
    int Unarmed=0;
    if(!GetIsObjectValid(oWep))
    {
        oWep=GetItemInSlot(INVENTORY_SLOT_ARMS,oAtt);//Gloves
        Unarmed=1;
    }
    int DamBoosts=DoDamBoosts(oAtt,oHit,oWep);//nDam is the damage boosts/penalties from weapon spec, ranger favored, and weapon bonuses
    int nDam=DamBoosts;
    int nPow=GetWeaponEnhance(oWep);
    int nStrAmmo=GetStrengthAndAmmoDamage(oAtt,oWep,iOffHand,oHit);//Gets the str damage. Also does ammo damage of missile weapons
    nDam=nDam+nStrAmmo;
    int nBase;
    if(Unarmed==1) nBase=GetUnarmedBaseDamage(oAtt);
    else nBase=GetWeaponBaseDamage(oWep);//Gets the base weapon damage (example, 1d8 for longbow)
    nDam=nDam+nBase;
    //SendMessageToPC(oAtt,"Debug: You do "+IntToString(nDam)+" damage, including "+IntToString(nBase)+" from base weapon, "+IntToString(nStrAmmo)+" from strength and ammo, and "+IntToString(DamBoosts)+" from other sources.");
    int nMult=1;
    if(nCrit==2)
    {
        nMult=GetCriticalHitMultiplier(oAtt,iOffHand);
    }
    nDam=nDam*nMult;
    int iDamType=DamTypeWrapper(GetItemInSlot(iSlot,oAtt));
    effect eDam=EffectDamage(nDam,iDamType,nPow);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oHit);
}

//Gets the concealment of oHit. If nRanged=1 checks concealment vs ranged.
int GetConcealment(object oHit,int nRanged)
{
    int iConceal=0;
    int iType=0;
    effect eCheck=GetFirstEffect(oHit);
    while(GetIsEffectValid(eCheck))
    {
        if(GetEffectType(eCheck)==EFFECT_TYPE_CONCEALMENT)
        {
            iType=GetEffectInteger(eCheck,1);
            if(iType==0||(iType==2&&nRanged==0)||(iType==1&&nRanged==1))
            {
                if(iConceal<GetEffectInteger(eCheck,0))
                {
                    iConceal=GetEffectInteger(eCheck,0);
                }
            }
        }
        eCheck=GetNextEffect(oHit);
    }
    return iConceal;
}

//Wrapper for concealment checking.
int iConcealMiss(object oAtt, object oHit, int nRanged, int iFeed)
{
    int iConceal=GetConcealment(oHit,nRanged);
    if(Random(100)<iConceal)
    {
        if(GetHasFeat(FEAT_BLIND_FIGHT,oAtt)&&Random(100)<iConceal)
        {
            if(iFeed==TRUE) SendMessageToPC(oAtt,"Concealment bypassed with Blind Fighting");
        }
        else
        {
            if(iFeed==TRUE) SendMessageToPC(oAtt,"Miss: "+IntToString(iConceal)+"% concealment.");
            return 1;
        }
    }
    return 0;
}

//Gets the magnitude of a character's power critical bonus with oWeapon
int GetPowerCriticalBonus(object oAtt,object oWeapon)
{
    int iType=GetBaseItemType(oWeapon);
    string sPowCrit=Get2DAString("baseitem_feats","PowCrit",iType);
    string sImpPowCrit=Get2DAString("baseitem_feats","ImpPowCrit",iType);
    int nPowCrit=StringToInt(sPowCrit);
    int nImpPowCrit=StringToInt(sImpPowCrit);
    return (GetHasFeat(nPowCrit)+GetHasFeat(nImpPowCrit))*2;
}

//Object oAtt attacks object oHit, taking a bonus/penalty of nBon to the roll
//if iNat is FALSE, a natural 20 is not an automatic hit. If iFeed is
//true, reports attack rolls to both parties. iRanged=1 for ranged, iRanged=0 for melee
//Returns 1 if a hit happened, 2 on critical hit, 0 on a miss
int DoScriptedAttack(object oAtt, object oHit, int nBon, int iNat, int iFeed,int iRanged,int iOffHand)
{
    if(iConcealMiss(oAtt,oHit,iRanged,iFeed)==1) return 0;//Check concealment
    int iAB=GetBaseAttackBonus(oAtt);
    int iSlot=INVENTORY_SLOT_RIGHTHAND;
    if(iOffHand==1) iSlot=INVENTORY_SLOT_LEFTHAND;
    if(GetItemInSlot(iSlot,oAtt)==OBJECT_INVALID) iSlot=INVENTORY_SLOT_ARMS;
    int iABBonus=GetAttackBonusAdjustment(oAtt,GetItemInSlot(iSlot,oAtt),iRanged);
    iABBonus=GetWeaponEnhance(GetItemInSlot(iSlot,oAtt))+iABBonus+GetABvsBoosts(oAtt,oHit,GetItemInSlot(iSlot,oAtt));
    iAB=iAB+iABBonus;
    iAB=iAB+nBon;
    int iAC=GetACVersus(oAtt,oHit);
    int iRoll=d20(1);
    int iThreat=GetCriticalHitRange(oAtt,iOffHand);
    if(iRoll+iAB<iAC)//Miss
    {
        if(iRoll==20&&iNat==TRUE)
        {
            if(iFeed) SendMessageToPC(oAtt,"Natural 20");
        }
        else
        {
            if(iFeed) SendMessageToPC(oAtt,"Attack Roll: "+IntToString(iRoll)+"+"+IntToString(iAB)+"="+IntToString(iRoll+iAB)+" miss");
            return 0;
        }
    }
    else if(iRoll==1)
    {//Automatic miss on natural 1.
        SendMessageToPC(oAtt,"Attack Roll: "+IntToString(iRoll)+"+"+IntToString(iAB)+"="+IntToString(iRoll+iAB)+" miss");
        return 0;
    }
    else if(iFeed) SendMessageToPC(oAtt,"Attack Roll: "+IntToString(iRoll)+"+"+IntToString(iAB)+"="+IntToString(iRoll+iAB)+" hit");

    if(22-iRoll>iThreat)
    {
        iRoll=d20(1);
        iAB=iAB+GetPowerCriticalBonus(oAtt,GetItemInSlot(iSlot,oAtt));
        if(iRoll+iAB<iAC)//Nonconfirmed crit
        {
            if(iFeed) SendMessageToPC(oAtt,"Critical Threat Roll: "+IntToString(iRoll)+"+"+IntToString(iAB)+"="+IntToString(iRoll+iAB)+" no critical");
        }
        else//Confirmed crit
        {
            if(iFeed) SendMessageToPC(oAtt,"Critical Threat Roll: "+IntToString(iRoll)+"+"+IntToString(iAB)+"="+IntToString(iRoll+iAB)+" CRITICAL HIT!");
            return 2;
        }
    }
    return 1;
}

//SoT's custom whirlwind attack implementation. Designed to work around the bug
//where the character freezes when attacking precisely 3 targets.
void SoT_DoWhirlwindAttack(int bDisplayFeedback=TRUE, int bImproved=FALSE)
{
    if(IPGetIsRangedWeapon(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF)))
    {

        SendMessageToPC(OBJECT_SELF,"This feat can only be used with melee weapons!");
        return;
    }
    location lCenter=GetLocation(OBJECT_SELF);
    int iHit;
    object oHit=GetFirstObjectInShape(SHAPE_SPHERE,4.0,lCenter,TRUE);
    while(GetIsObjectValid(oHit))
    {
        if(!GetIsFriend(oHit,OBJECT_SELF))
        {
            iHit=DoScriptedAttack(OBJECT_SELF,oHit,0,TRUE,TRUE,FALSE,FALSE);
            if(iHit>0) DoScriptedDamage(OBJECT_SELF,oHit,iHit,FALSE);
            if(GetHasFeat(868))//Greater Whirlwind Attack
            {
                iHit=DoScriptedAttack(OBJECT_SELF,oHit,-5,TRUE,TRUE,FALSE,FALSE);//Additional attack at -5
                if(iHit>0) DoScriptedDamage(OBJECT_SELF,oHit,iHit,FALSE);
            }
        }
        oHit=GetNextObjectInShape(SHAPE_SPHERE,4.0,lCenter,TRUE);
    }
}

//Gets the AB of the PC speaker with his currently equipped weapon
int GetSpeakerAB()
{
    object oMe=GetPCSpeaker();
    int iRanged=0;
    object oWep=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oMe);
    if(GetIsObjectValid(oWep))
    {
        if(GetWeaponRanged(oWep)) iRanged=1;
    }
    else oWep=GetItemInSlot(INVENTORY_SLOT_ARMS,oMe);
    int iAB=GetBaseAttackBonus(oMe)+GetAttackBonusAdjustment(oMe,oWep,iRanged);
    SendMessageToPC(oMe,"Debug: Script calculated weapon enchancement bonus is +"+IntToString(GetWeaponEnhance(oWep)));
    SendMessageToPC(oMe,"NWNX-Calculated Weapon Adjustment is +"+IntToString(GetAttackBonusAdjustment(oMe,oWep,iRanged)));
    SendMessageToPC(oMe,"BAB is +"+IntToString(GetBaseAttackBonus(oMe)));
    return iAB+GetWeaponEnhance(oWep);
}
