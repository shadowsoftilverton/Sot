#include "engine"

//::///////////////////////////////////////////////
//:: Breath Weapon for Dragon Disciple Class
//:: x2_s2_discbreath
//:: Copyright (c) 2003Bioware Corp.
//:://////////////////////////////////////////////
/*

  Damage Type is Fire
  Save is Reflex
  Shape is cone, 30' == 10m

  Level      Damage      Save
  ---------------------------
  3          2d10         19
  7          4d10         19
  10          6d10        19

  after 10:
   damage: 6d10  + 1d10 per 3 levels after 10
   savedc: increasing by 1 every 4 levels after 10



*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: June, 17, 2003
//:://////////////////////////////////////////////
//Modified by Ave for multiple dragon disciple types
//DC increased to 20 (Ave, 4/24/2012)

const int HGVFX_CONE_DRAGON_BREATH_COLD=1553;
const int HGVFX_CONE_DRAGON_BREATH_ACID=1556;
const int HGVFX_CONE_DRAGON_BREATH_FIRE=1559;
const int HGVFX_CONE_DRAGON_BREATH_ELEC=1558;
const int HGVFX_CONE_DRAGON_BREATH_MIND=1561;
const int HGVFX_CONE_GAZE_HOLY=1594;

#include "NW_I0_SPELLS"
#include "ave_inc_event"
#include "nwnx_structs"
#include "ave_inc_rogue"

void DragonBreath(object oPC)
{
    int nType = GetSpellId();
    int nDamageDice;
    int nLevel = GetLevelByClass(37,OBJECT_SELF);// 37 = red dragon disciple
    int nSaveDC = 20+nLevel;
    nDamageDice=5+nLevel/2;
    if(nLevel>15) nDamageDice=nDamageDice+2;
    if(nLevel>18) nDamageDice=nDamageDice+2;
    int nDamage = d12(nDamageDice);
    //Declare major variables
    float fDelay;
    object oTarget;
    effect eVis, eBreath;
    effect eSecond;
    int iSecondSaveType;
    int iSecondDurDice;
    int iDamageType;
    int iSaveType;
    int iHitVFX;
    int nPersonalDamage;
    if(GetHasFeat(1606,oPC)||GetHasFeat(1603,oPC))//Cold Dragons
    {
        if(nLevel>16)
        {
            if(GetHasFeat(1603,oPC)) nDamageDice=nDamageDice+2;
            else
            {
                eSecond=EffectParalyze();
                iSecondSaveType=SAVING_THROW_FORT;
                iSecondDurDice=1;
            }
        }
        eVis=EffectVisualEffect(1546);
        iSaveType=SAVING_THROW_TYPE_COLD;
        iDamageType=DAMAGE_TYPE_COLD;
        iHitVFX=VFX_IMP_FROST_S;
    }
    else if(GetHasFeat(1602,oPC)||GetHasFeat(1604,oPC)||GetHasFeat(1608,oPC))//Acid dragons
    {
        if(nLevel>16)
        {
            if(GetHasFeat(1602,oPC)|GetHasFeat(1604,oPC)) nDamageDice=nDamageDice+2;
            else
            {
                eSecond=EffectSlow();
                iSecondSaveType=SAVING_THROW_FORT;
                iSecondDurDice=3;
            }
        }
        eVis=EffectVisualEffect(1554);
        iSaveType=SAVING_THROW_TYPE_ACID;
        iDamageType=DAMAGE_TYPE_ACID;
        iHitVFX=VFX_IMP_ACID_S;
    }
    else if(GetHasFeat(962,oPC)||GetHasFeat(1600,oPC)||GetHasFeat(1607,oPC)||GetHasFeat(1605,oPC))//Fire Dragons
    {
        if(nLevel>16)
        {
            if(GetHasFeat(962,oPC)|GetHasFeat(1600,oPC)) nDamageDice=nDamageDice+2;
            else if(GetHasFeat(1605,oPC))
            {
                eSecond=EffectAbilityDecrease(ABILITY_STRENGTH,6);
                iSecondSaveType=SAVING_THROW_FORT;
                iSecondDurDice=100;
            }
            else if(GetHasFeat(1607,oPC))
            {
                eSecond=EffectSleep();
                iSecondSaveType=SAVING_THROW_WILL;
                iSecondDurDice=2;
            }
        }
        eVis=EffectVisualEffect(1548);
        iSaveType=SAVING_THROW_TYPE_FIRE;
        iDamageType=DAMAGE_TYPE_FIRE;
        iHitVFX=VFX_IMP_FLAME_M;
    }
    else if(GetHasFeat(1601,oPC)||GetHasFeat(1609,oPC))//Lightning Dragons
    {
        if(nLevel>16)
        {
            if(GetHasFeat(1601,oPC)) nDamageDice=nDamageDice+2;
            else
            {
                eSecond=EffectFrightened();
                iSecondSaveType=SAVING_THROW_WILL;
                iSecondDurDice=1;
            }
        }
        eVis=EffectVisualEffect(1552);
        iSaveType=SAVING_THROW_TYPE_ELECTRICITY;
        iDamageType=DAMAGE_TYPE_ELECTRICAL;
        iHitVFX=VFX_IMP_LIGHTNING_S;
    }
    else
    {
        SendMessageToPC(oPC,"Warning! Dragon Type not found!");
        return;
    }

    //eVis = EffectVisualEffect(494);

    //Get first target in spell area
    location lFinalTarget = GetSpellTargetLocation();
    if ( lFinalTarget == GetLocation(OBJECT_SELF) )
    {
        // Since the target and origin are the same, we have to determine the
        // direction of the spell from the facing of OBJECT_SELF (which is more
        // intuitive than defaulting to East everytime).

        // In order to use the direction that OBJECT_SELF is facing, we have to
        // instead we pick a point slightly in front of OBJECT_SELF as the target.
        vector lTargetPosition = GetPositionFromLocation(lFinalTarget);
        vector vFinalPosition;
        vFinalPosition.x = lTargetPosition.x +  cos(GetFacing(OBJECT_SELF));
        vFinalPosition.y = lTargetPosition.y +  sin(GetFacing(OBJECT_SELF));
        lFinalTarget = Location(GetAreaFromLocation(lFinalTarget),vFinalPosition,GetFacingFromLocation(lFinalTarget));
    }
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis,OBJECT_SELF,0.2f);
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 15.0, lFinalTarget, TRUE,  OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR  | OBJECT_TYPE_PLACEABLE);
    while(GetIsObjectValid(oTarget))
    {
        nPersonalDamage = nDamage;
        if(oTarget != OBJECT_SELF && !GetIsReactionTypeFriendly(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
            //Determine effect delay
            fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
            if(MySavingThrow(SAVING_THROW_REFLEX, oTarget, nSaveDC, iSaveType))
            {
                nPersonalDamage  = nPersonalDamage/2;
                if(GetHasFeat(FEAT_EVASION, oTarget) || GetHasFeat(FEAT_IMPROVED_EVASION, oTarget))
                {
                    nPersonalDamage = 0;
                }
            }
            else if(GetHasFeat(FEAT_IMPROVED_EVASION, oTarget))
            {
                nPersonalDamage = nPersonalDamage/2;
            }
            if (nPersonalDamage > 0)
            {
                //Set Damage and VFX
                eBreath = EffectDamage(nPersonalDamage, iDamageType);
                eVis = EffectVisualEffect(iHitVFX);
                //Apply the VFX impact and effects
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBreath, oTarget));
             }
             if(iSecondDurDice>0)
             {
                if(!MySavingThrow(iSecondSaveType,oTarget,nSaveDC))
                {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSecond,oTarget,6.0*IntToFloat(d3(iSecondDurDice)));
                }
             }
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 15.0, lFinalTarget, TRUE,  OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR  | OBJECT_TYPE_PLACEABLE);
    }
}

void AirPushLoop(vector vPush, object oPushee, int nTimes)
{
    //RemoveSpellEffects(1138,oPushee,oPushee);
    object oMyArea=GetArea(oPushee);
    float fFacing=GetFacing(oPushee);
    vector vPosition=GetPosition(oPushee)+vPush;
    location lLoc=Location(oMyArea,vPosition,fFacing);
    //AssignCommand(oPushee,ClearAllActions());
    AssignCommand(oPushee,ActionJumpToLocation(lLoc));
    nTimes=nTimes-1;
    if(nTimes>0) AirPushLoop(vPush,oPushee,nTimes);
}

void ElemFastBreath(object oPC)
{
    object oTarget=GetSpellTargetObject();
    int nLevel = GetLevelByClass(37,oPC);// 37 = red dragon disciple
    int nSaveDC = 20+nLevel;
    if(GetHasFeat(1613,oPC))//Air Disciple
    {
        vector vPush;
        vPush.x = cos(GetFacing(oPC))*2.0;
        vPush.y = sin(GetFacing(oPC))*2.0;
        int nTimes=1;
        float fDur=RoundsToSeconds(nLevel)/4.0;
        effect eVis=EffectVisualEffect(VFX_FNF_LOS_NORMAL_20);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVis,GetLocation(oTarget));
        //effect eStop=EffectCutsceneParalyze();
        //SetEffectSpellId(eStop,1138);
        if(nLevel>15) nSaveDC=nSaveDC+2;
        if(nLevel>18) nSaveDC=nSaveDC+2;
        if(nLevel>16)
        {
            if(!GetIsReactionTypeHostile(oPC,oTarget))
            {
                RemoveSpecificEffect(EFFECT_TYPE_ENTANGLE,oTarget);
                RemoveSpecificEffect(EFFECT_TYPE_SLOW,oTarget);
                RemoveSpecificEffect(EFFECT_TYPE_PARALYZE,oTarget);
                //RemoveSpecificEffect(EFFECT_TYPE_KNOCKDOWN,oTarget);
                AirPushLoop(vPush,oTarget,nTimes);
                //AssignCommand(oTarget,ActionDoCommand(SetCommandable(FALSE,oTarget)));
                //DelayCommand(6.0,AssignCommand(oTarget,SetCommandable(TRUE,oTarget)));
                //DelayCommand(0.2,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eStop,oTarget,fDur));
                //AirPushLoop(vPush,oTarget,nLevel*10);
            }
            else if(!ReflexSave(oTarget,nSaveDC,SAVING_THROW_TYPE_SONIC,oPC))
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectKnockdown(),oTarget,fDur);
                AirPushLoop(vPush,oTarget,nTimes);
                //AssignCommand(oTarget,ActionDoCommand(SetCommandable(FALSE,oTarget)));
                //DelayCommand(6.0,AssignCommand(oTarget,SetCommandable(TRUE,oTarget)));
                //DelayCommand(0.2,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eStop,oTarget,fDur));
                //AirPushLoop(vPush,oTarget,nLevel*10);
            }
        }
    }
    else if(GetHasFeat(1614,oPC))//Fire Disciple
    {
        int nDamageDice=8+nLevel/2;
        if(nLevel>16) nDamageDice=nDamageDice+2;
        int nDamage = d12(nDamageDice);
        int iSaveType=SAVING_THROW_TYPE_FIRE;
        int iDamageType=DAMAGE_TYPE_FIRE;
        int iHitVFX=VFX_IMP_FLAME_M;
        SignalEvent(oTarget, EventSpellCastAt(oPC, GetSpellId()));
        nDamage=GetReflexAdjustedDamage(nDamage,oTarget,nSaveDC,iSaveType,oPC);
        effect eDamage=EffectDamage(nDamage,iDamageType);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget);
    }
    else
    {
        SendMessageToPC(oPC,"Warning! Quick elemental Type not found!");
        return;
    }
}

void ElemConBreath(object oPC)
{
    int nLevel=GetLevelByClass(37,oPC);//Red Dragon Disciple
    int nSaveDC=20+nLevel;
    object oTarget;
    if(GetHasFeat(1615,oPC))//Water Disciple
    {
        float fDur=TurnsToSeconds(10);
        effect eWaterBuff=ExtraordinaryEffect(EffectTemporaryHitpoints(10+nLevel));
        if(nLevel>15) eWaterBuff=EffectLinkEffects(eWaterBuff,EffectSavingThrowIncrease(SAVING_THROW_TYPE_ALL,2));
        if(nLevel>16) eWaterBuff=EffectLinkEffects(eWaterBuff,EffectACIncrease(2));
        if(nLevel>18)
        {
            effect eSlow=EffectSlow();
            oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetLocation(OBJECT_SELF), TRUE,  OBJECT_TYPE_CREATURE);
            while(GetIsObjectValid(oTarget))
            {
                if(GetIsReactionTypeHostile(oPC,oTarget))
                {
                    if(0==MySavingThrow(SAVING_THROW_REFLEX,oTarget,nSaveDC))
                    {
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSlow,oTarget,RoundsToSeconds(d3(2)));
                        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_SLOW),oTarget);
                    }
                }
                oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetLocation(OBJECT_SELF), TRUE,  OBJECT_TYPE_CREATURE);
            }
        }
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eWaterBuff,oPC,fDur);
        effect eVis=EffectVisualEffect(VFX_COM_HIT_FROST);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oPC);
    }
    else if(GetHasFeat(1616,oPC))//Earth Disciple
    {
        float fDur=RoundsToSeconds(5);
        effect eEarthBuff=ExtraordinaryEffect(EffectDamageShield(DAMAGE_BONUS_10,0,DAMAGE_TYPE_BLUDGEONING));
        if(nLevel>16) eEarthBuff=EffectLinkEffects(eEarthBuff,EffectDamageReduction(10,DAMAGE_POWER_PLUS_TWENTY));
        if(nLevel>18)
        {
            eEarthBuff=EffectLinkEffects(eEarthBuff,EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING,20));
            eEarthBuff=EffectLinkEffects(eEarthBuff,EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING,20));
            eEarthBuff=EffectLinkEffects(eEarthBuff,EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING,20));
        }
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eEarthBuff,oPC,fDur);
        effect eVis=EffectVisualEffect(VFX_COM_BLOOD_REG_YELLOW);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oPC);
        if(nLevel>15)
        {
            effect eVuln;
            oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetLocation(OBJECT_SELF), TRUE,  OBJECT_TYPE_CREATURE);
            while(GetIsObjectValid(oTarget))
            {
                if(GetIsReactionTypeHostile(oPC,oTarget))
                {
                    if(0==MySavingThrow(SAVING_THROW_REFLEX,oTarget,nSaveDC))
                    {
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectDamageImmunityDecrease(DAMAGE_TYPE_BLUDGEONING,20),oTarget,fDur);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_DUST_EXPLOSION),oTarget);
                    }
                    else
                    {
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectDamageImmunityDecrease(DAMAGE_TYPE_BLUDGEONING,10),oTarget,fDur);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_DUST_EXPLOSION),oTarget);
                    }
                }
                oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetLocation(OBJECT_SELF), TRUE,  OBJECT_TYPE_CREATURE);
            }
        }
    }
}

void FiendBreath(object oPC)
{
    int nLevel=GetLevelByClass(37,oPC);//Red Dragon Disciple
    int nSaveDC = 20+nLevel;
    object oTarget=GetSpellTargetObject();
    effect eImp=EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
    object oVictim=GetSpellTargetObject();
    if(GetHasFeat(1617,oPC))//Demon Disciple
    {
        int nConDamage=2+nLevel/4;
        float fDur=RoundsToSeconds(100);
        effect eDam;
        if(FortitudeSave(oVictim,nSaveDC,SAVING_THROW_TYPE_EVIL,oPC))
        {
            if(nLevel>18) nConDamage=nConDamage*2;
            else return;
        }
        if(nConDamage>GetAbilityScore(oTarget,ABILITY_CONSTITUTION)&nLevel>15)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(TRUE,TRUE),oVictim);
        }
        if(nLevel>16)
        {
            if(nConDamage>20) nConDamage=20;//Failsafe. NWN engine doesn't support damage or attack bonus greater than +20
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAttackIncrease(nConDamage),OBJECT_SELF,18.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectDamageIncrease(GetDamageConstFromDamageAmount(nConDamage)),OBJECT_SELF,18.0);
        }
        eDam=ExtraordinaryEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION,nConDamage));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDam,oVictim,fDur);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eImp,oVictim);
    }
    else if(GetHasFeat(1618,oPC))//Devil Disciple
    {
        float fDur=RoundsToSeconds(nLevel/4);
        if(nLevel>16)
        fDur=fDur*2;
        if(nLevel>18)
        nSaveDC=nSaveDC+2;
        int nDebuffAmount=2;
        effect eFear=EffectLinkEffects(EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR),EffectFrightened());
        eFear=EffectLinkEffects(eFear,EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR));
        eFear=ExtraordinaryEffect(eFear);
        effect eDebuff=EffectAttackDecrease(nDebuffAmount);
        eDebuff=EffectLinkEffects(eDebuff,EffectSavingThrowDecrease(SAVING_THROW_ALL,nDebuffAmount));
        eDebuff=EffectLinkEffects(eDebuff,EffectDamageDecrease(nDebuffAmount));
        eDebuff=EffectLinkEffects(eDebuff,EffectACDecrease(nDebuffAmount));
        eDebuff=EffectLinkEffects(eDebuff,EffectSkillDecrease(SKILL_ALL_SKILLS,nDebuffAmount));
        eDebuff=ExtraordinaryEffect(eDebuff);
        if(!WillSave(oVictim,nSaveDC,SAVING_THROW_TYPE_EVIL,oPC))
        {
            if(nLevel<10) ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDebuff,oVictim,fDur);
            else ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eFear,oVictim,fDur);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eImp,oVictim);
        }
        else if(nLevel>15)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDebuff,oVictim,fDur);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eImp,oVictim);
        }
    }
}

void CelestialBreath(object oPC)
{
    int nLevel=GetLevelByClass(37,oPC);//Red Dragon Disciple
    int nSaveDC = 20+nLevel;
    effect eVis=EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    float fDur;
    if(GetHasFeat(1619,oPC))//Archon Disciple
    {
        effect eAOE=EffectVisualEffect(VFX_IMP_PULSE_HOLY);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eAOE,oPC,0.2f);
        int nBuff=nLevel/2;
        fDur=RoundsToSeconds(3);
        effect eBuff=EffectAttackIncrease(nBuff);
        eBuff=EffectLinkEffects(eBuff,EffectACIncrease(nBuff));
        if(nLevel>16) eBuff=EffectLinkEffects(eBuff,EffectDamageIncrease(nBuff));
        if(nLevel>15) eBuff=EffectLinkEffects(eBuff,EffectSavingThrowIncrease(SAVING_THROW_ALL,nBuff));
        if(nLevel>18) eBuff=EffectLinkEffects(eBuff,EffectDamageShield(nBuff,0,DAMAGE_TYPE_DIVINE));
        eBuff=ExtraordinaryEffect(eBuff);
        object oTarget=GetFirstObjectInShape(SHAPE_SPHERE, 15.0, GetSpellTargetLocation(), TRUE);
        while(GetIsObjectValid(oTarget))
        {
            if(!GetIsReactionTypeHostile(oTarget))
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBuff,oTarget,fDur);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget);
            }
            oTarget=GetNextObjectInShape(SHAPE_SPHERE, 15.0, GetSpellTargetLocation(), TRUE);
        }
    }
    else if(GetHasFeat(1620,oPC))//Eladrin disciple
    {
        effect eAOE=EffectVisualEffect(HGVFX_CONE_GAZE_HOLY);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eAOE,oPC,0.2f);
        fDur=RoundsToSeconds(2);
        effect eTurn=EffectTurned();
        eTurn=EffectLinkEffects(eTurn,EffectVisualEffect(VFX_DUR_AURA_PULSE_YELLOW_WHITE));
        effect eStun=EffectParalyze();
        eStun=EffectLinkEffects(eStun,EffectVisualEffect(VFX_DUR_PARALYZE_HOLD));
        if(nLevel>15)
        {
            effect eEye=EffectSeeInvisible();
            if(!GetHasSpellEffect(SPELL_TRUE_SEEING,oPC))
            {
                eEye=EffectLinkEffects(eEye,EffectSkillIncrease(SKILL_SPOT,nLevel));
            }
            eEye=SupernaturalEffect(eEye);
            SetEffectSpellId(eEye,1059);//Eladrin sight: make sure the spot bonus doesn't stack with true sight.
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eEye,oPC,fDur);
        }
        object oTarget=GetFirstObjectInShape(SHAPE_SPELLCONE, 15.0, GetSpellTargetLocation(), TRUE);
        while(GetIsObjectValid(oTarget))
        {
            if(GetIsReactionTypeHostile(oTarget))
            {
                if(0==MySavingThrow(SAVING_THROW_WILL,oTarget,nSaveDC))
                {
                    fDur=RoundsToSeconds(d8(1));
                    if(GetRacialType(oTarget)==RACIAL_TYPE_UNDEAD&nLevel>18)
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,eTurn,oTarget,fDur);
                    else
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,eStun,oTarget,fDur);
                }
                if(nLevel>16) ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d12(4),DAMAGE_TYPE_DIVINE),oTarget);
            }
            oTarget=GetNextObjectInShape(SHAPE_SPELLCONE, 15.0, GetSpellTargetLocation(), TRUE);
        }
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oPC);
    }
}

void FeyBreath(object oPC)
{
    int nLevel=GetLevelByClass(37,oPC);//Red Dragon Disciple
    int nDC = 20+nLevel;
    int nDamageDice;
    effect eVis=EffectVisualEffect(VFX_IMP_WILL_SAVING_THROW_USE);
    if(GetHasFeat(1621,oPC))//Seelie
    {
        if(nLevel>15) nDC=nDC+2;
        if(nLevel>16) nDC=nDC+2;
        if(nLevel>18) nDC=nDC+2;
        effect eCone=EffectVisualEffect(1551);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eCone,OBJECT_SELF,0.2f);
        effect eSleep=EffectLinkEffects(EffectVisualEffect(VFX_IMP_SLEEP),EffectSleep());
        eSleep=ExtraordinaryEffect(eSleep);
        object oTarget=GetFirstObjectInShape(SHAPE_SPELLCONE, 15.0, GetSpellTargetLocation(), TRUE);
        while(GetIsObjectValid(oTarget))
        {
            if(GetIsReactionTypeHostile(oTarget)&&(oTarget!=oPC))
            {
                if(!WillSave(oTarget,nDC,SAVING_THROW_TYPE_MIND_SPELLS,oPC))
                {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSleep,oTarget,RoundsToSeconds(d6(2)));
                }
            }
            oTarget=GetNextObjectInShape(SHAPE_SPELLCONE, 15.0, GetSpellTargetLocation(), TRUE);
        }
    }
    else if(GetHasFeat(1622,oPC))//Unseelie
    {
        effect eInvis;
        if(nLevel<16) eInvis=EffectInvisibility(INVISIBILITY_TYPE_NORMAL);
        else eInvis=EffectInvisibility(INVISIBILITY_TYPE_IMPROVED);
        float fInvisDur=RoundsToSeconds(nLevel);
        if(nLevel>18) fInvisDur=fInvisDur*2;
        object oInvisTarget=GetFirstObjectInShape(SHAPE_SPHERE, IntToFloat(nLevel), GetLocation(oPC), TRUE);
        while(GetIsObjectValid(oInvisTarget))
        {
            if(!GetIsReactionTypeHostile(oInvisTarget))
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eInvis,oInvisTarget,RoundsToSeconds(nLevel));
                if(nLevel>16) ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectEthereal(),oInvisTarget,6.0);
            }
            else if(nLevel>18&(!MySavingThrow(SAVING_THROW_WILL,oInvisTarget,nDC,SAVING_THROW_TYPE_MIND_SPELLS)))
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE),EffectConfused()),oInvisTarget,RoundsToSeconds(d4(1)));
            }
            oInvisTarget=GetNextObjectInShape(SHAPE_SPHERE, IntToFloat(nLevel), GetLocation(oPC), TRUE);
        }
    }
}

void main()
{
    object oPC=OBJECT_SELF;
    string sDDType=GetDDType(oPC);

    if(sDDType=="rdd_drag")
    {
        DragonBreath(oPC);
    }
    if(sDDType=="rdd_elemfast")
    {
        ElemFastBreath(oPC);
    }
    if(sDDType=="rdd_elemcon")
    {
        ElemConBreath(oPC);
    }
    if(sDDType=="rdd_fiend")
    {
        FiendBreath(oPC);
    }
    if(sDDType=="rdd_celes")
    {
        CelestialBreath(oPC);
    }
    if(sDDType=="rdd_fey")
    {
        FeyBreath(oPC);
    }
    if(GetLevelByClass(37,oPC)>12) GeneralCoolDown(1611,oPC,18.0);
}
