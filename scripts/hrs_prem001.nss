/*/
    Horse Pre-Mount script
    by Hardcore UFO
    Caller is the rider as per x3_inc_horse
    Applies boni
/*/

#include "engine"
#include "x2_inc_switches"
#include "inc_henchmen"
#include "x3_inc_horse"
#include "x3_inc_skin"
#include "aps_include"
#include "inc_horses"

void HorseAdjustSpeed(object oRider, object oHorse, int nRider, int nHorse);

void HorseAdjustAC(object oRider, int nRider, int nMount);

void HorseAdjustSkills(object oRider, object oHorse, int nRider, int nHorse);

void HorseAdjustHP(object oRider, object oHorse);

void HorseAdjustEffects(object oRider, object oHorse, int nRider, int nHorse);

void main()
{
    SetSkinInt(OBJECT_SELF, "bX3_IS_MOUNTED", TRUE);

    object oHorse = HorseGetMyHorse(OBJECT_SELF);
    //GetLocalObject(OBJECT_SELF, "oX3_TempHorse");
    int nSkillH = Std_GetSkillRank(SKILL_RIDE, oHorse, TRUE);
    int nSkillR = Std_GetSkillRank(SKILL_RIDE, OBJECT_SELF, FALSE);

    HorseMountedWeaponSwitchIn(OBJECT_SELF);
    HorseAdjustSpeed(OBJECT_SELF, oHorse, nSkillR, nSkillH);
    HorseAdjustAC(OBJECT_SELF, nSkillR, nSkillH);
    HorseAdjustHP(OBJECT_SELF, oHorse);
    HorseAdjustSkills(OBJECT_SELF, oHorse, nSkillR, nSkillH);
    HorseAdjustEffects(OBJECT_SELF, oHorse, nSkillR, nSkillH);

    SetLocalString(OBJECT_SELF, "X3_HORSE_PREMOUNT_SCRIPT", "hrs_prem001");
    SetLocalString(OBJECT_SELF, "X3_HORSE_POSTDISMOUNT_SCRIPT", "hrs_pstd001");
    SetLocalObject(OBJECT_SELF, "HorseWidget", GetLocalObject(oHorse, "HorseWidget"));
    SetLocalObject(OBJECT_SELF, "HorseOwner", GetLocalObject(oHorse, "HorseOwner"));
}

void HorseAdjustSpeed(object oRider, object oHorse, int nRider, int nHorse)
{
    if(GetLocalInt(GetModule(),"X3_HORSE_DISABLE_SPEED"))   return;

    int nSpeed = GetLocalInt(oHorse,"X3_HORSE_MOUNT_SPEED");
    effect eMovement;
    float fSpeed;
    int nMonkSpeed;
    int nMonk = GetLevelByClass(CLASS_TYPE_MONK, oRider);

    if(nSpeed == 0)         nSpeed = HORSE_DEFAULT_SPEED_INCREASE;
    if(nSpeed > 70)         nSpeed = 70;
    if(nSpeed < -100)       nSpeed =- 100;
    if(nMonk > 2)
    {
        nMonkSpeed -= 10 * nMonk / 3;
        if(nMonkSpeed >= nSpeed) nSpeed = -(nMonkSpeed - nSpeed);
    }
    if(GetLevelByClass(CLASS_TYPE_BARBARIAN,oRider) > 0)
    {
        nSpeed -= 10;
    }
    if(nSpeed <- 150) nSpeed =- 150;

    //Skill-based speed adjustment.
    if(nRider < nHorse)
    {
        fSpeed = IntToFloat(nSpeed);
        fSpeed = (fSpeed * 1.8f) - fSpeed;
        nSpeed = FloatToInt(fSpeed);
    }

    SetLocalInt(oRider, "nX3_SpeedIncrease", nSpeed);
    eMovement = SupernaturalEffect(EffectMovementSpeedIncrease(nSpeed));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eMovement, oRider);
}

void HorseAdjustAC(object oRider, int nRider, int nMount)
{
    int nAC;
    int nTier;
    effect eAC;

    //Determine AC cap for the mount.
    //This is to prevent purposefully using low grade horses for AC.
    if(nMount > 0 && nMount <= 4)           nTier = 1;
    else if(nMount >= 5 && nMount <= 8)     nTier = 2;
    else if(nMount >= 9 && nMount <= 12)    nTier = 3;
    else if(nMount >= 13 && nMount <= 16)   nTier = 4;
    //else if(nMount >= 17)                   nTier = 6;

    //Determining the AC bonus based on relative skill.
    if(nRider >= nMount)
    {
        nAC = (nRider - nMount) / 5;
        if(nAC > nTier) nAC = nTier;
        eAC = SupernaturalEffect(EffectACIncrease(nAC, AC_DODGE_BONUS, AC_VS_DAMAGE_TYPE_ALL));
    }

    else if(nRider <= nMount)
    {
        eAC = SupernaturalEffect(EffectACDecrease(nTier, AC_DODGE_BONUS, AC_VS_DAMAGE_TYPE_ALL));
    }

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAC, oRider);
}

//Sets the mounted character's Discipline to an average between his score and the mount.
//If Ride is higher than the mount, a bonus of 1/5 Ride is applied to Discipline.
//Plus other skill penalties.
void HorseAdjustSkills(object oRider, object oHorse, int nRider, int nHorse)
{
    int nDiscR = Std_GetSkillRank(SKILL_DISCIPLINE, oRider, FALSE);
    int nDiscH = Std_GetSkillRank(SKILL_DISCIPLINE, oHorse, FALSE);
    int nDiscB = Std_GetSkillRank(SKILL_DISCIPLINE, oRider, TRUE);
    int nBonus;

    SetPersistentInt(oRider, "RiderBaseDiscipline", nDiscB);

    effect eDisarmTrap = SupernaturalEffect(EffectSkillDecrease(SKILL_DISABLE_TRAP , 30));
    effect eHide       = SupernaturalEffect(EffectSkillDecrease(SKILL_HIDE         , 50));
    effect eMove       = SupernaturalEffect(EffectSkillDecrease(SKILL_MOVE_SILENTLY, 50));
    effect eSetTrap    = SupernaturalEffect(EffectSkillDecrease(SKILL_SET_TRAP     , 50));
    effect eTumble     = SupernaturalEffect(EffectSkillDecrease(SKILL_TUMBLE       , 50));
    effect eDiscipline;

    nBonus = (nDiscR + nDiscH) / 2;
    if(nRider > nHorse) nBonus = nBonus + (nRider / 5);

    SetSkillRank(oRider, SKILL_DISCIPLINE, nBonus);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDisarmTrap, oRider);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eHide, oRider);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eMove, oRider);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSetTrap, oRider);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eTumble, oRider);
}

void HorseAdjustHP(object oRider, object oHorse)
{
    int nLife = GetCurrentHitPoints(oHorse);
    effect eTemp = EffectTemporaryHitpoints(nLife / 2);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eTemp, oRider);
}

void HorseAdjustEffects(object oRider, object oHorse, int nRider, int nHorse)
{
    int nBonus;

    if(GetHasFeat(1087, oRider) && nRider > nHorse)
    {
        nBonus = nRider / 5;
        if(nBonus < 1)  nBonus = 1;
    }

    //Damage Immunities
    int nDRSlash = GetLocalInt(oHorse, "MountReductionSlashing");
    int nDRPierc = GetLocalInt(oHorse, "MountReductionPiercing");
    int nDRBludg = GetLocalInt(oHorse, "MountReductionBludgeoning");
    int nDRFire = GetLocalInt(oHorse, "MountReductionFire");
    int nDRCold = GetLocalInt(oHorse, "MountReductionCold");
    int nDRElec = GetLocalInt(oHorse, "MountReductionElec");
    int nDRAcid = GetLocalInt(oHorse, "MountReductionAcid");
    int nDRSonic = GetLocalInt(oHorse, "MountReductionSonic");
    int nDRPosit = GetLocalInt(oHorse, "MountReductionPositive");
    int nDRNegat = GetLocalInt(oHorse, "MountReductionNegative");
    int nDRMagic = GetLocalInt(oHorse, "MountReductionMagical");
    int nDRDivin = GetLocalInt(oHorse, "MountReductionDivine");

    effect eDRSlash;
    effect eDRPierc;
    effect eDRBludg;
    effect eDRFire;
    effect eDRCold;
    effect eDRElec;
    effect eDRAcid;
    effect eDRSonic;
    effect eDRPosit;
    effect eDRNegat;
    effect eDRMagic;
    effect eDRDivin;

    if(nDRSlash > 0){   eDRSlash = EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING, nDRSlash + nBonus);
                        eDRSlash = SupernaturalEffect(eDRSlash);
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDRSlash, oRider);}

    if(nDRPierc > 0){   eDRPierc = EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING, nDRPierc + nBonus);
                        eDRPierc = SupernaturalEffect(eDRPierc);
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDRPierc, oRider);}

    if(nDRBludg > 0){   eDRBludg = EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING, nDRBludg + nBonus);
                        eDRBludg = SupernaturalEffect(eDRBludg);
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDRBludg, oRider);}

    if(nDRFire > 0){    eDRFire = EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE, nDRFire + nBonus);
                        eDRFire = SupernaturalEffect(eDRFire);
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDRFire, oRider);}

    if(nDRCold > 0){    eDRCold = EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD, nDRCold + nBonus);
                        eDRCold = SupernaturalEffect(eDRCold);
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDRCold, oRider);}

    if(nDRElec > 0){    eDRElec = EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL, nDRElec + nBonus);
                        eDRElec = SupernaturalEffect(eDRElec);
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDRElec, oRider);}

    if(nDRAcid > 0){    eDRAcid = EffectDamageImmunityIncrease(DAMAGE_TYPE_ACID, nDRAcid + nBonus);
                        eDRAcid = SupernaturalEffect(eDRAcid);
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDRAcid, oRider);}

    if(nDRSonic > 0){   eDRSonic = EffectDamageImmunityIncrease(DAMAGE_TYPE_SONIC, nDRSonic + nBonus);
                        eDRSonic = SupernaturalEffect(eDRSonic);
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDRSonic, oRider);}

    if(nDRPosit > 0){   eDRPosit = EffectDamageImmunityIncrease(DAMAGE_TYPE_POSITIVE, nDRPosit + nBonus);
                        eDRPosit = SupernaturalEffect(eDRPosit);
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDRPosit, oRider);}

    if(nDRNegat > 0){   eDRNegat = EffectDamageImmunityIncrease(DAMAGE_TYPE_NEGATIVE, nDRNegat + nBonus);
                        eDRNegat = SupernaturalEffect(eDRNegat);
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDRNegat, oRider);}

    if(nDRMagic > 0){   eDRMagic = EffectDamageImmunityIncrease(DAMAGE_TYPE_MAGICAL, nDRMagic + nBonus);
                        eDRMagic = SupernaturalEffect(eDRMagic);
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDRMagic, oRider);}

    if(nDRDivin > 0){   eDRDivin = EffectDamageImmunityIncrease(DAMAGE_TYPE_DIVINE, nDRDivin + nBonus);
                        eDRDivin = SupernaturalEffect(eDRDivin);
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDRDivin, oRider);}
}


