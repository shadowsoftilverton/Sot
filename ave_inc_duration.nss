#include "engine"
#include "nw_i0_spells"
#include "inc_spells"
#include "inc_system"
#include "x2_i0_spells"
#include "ave_inc_hier"
#include "nwnx_structs"
#include "spell_sneak_inc"

const int ACTIVE_DURATION_FEAT=1383;
const int SPELL_PSHOCK=857;
const int SPELL_RESOL=858;
const int SPELL_MANT=859;
const int SPELL_ECHO=860;
const int SPELL_FWAVE=861;
const int SPELL_ACCE=862;
const int SPELL_MADGOD=863;
const int SPELL_BURN=864;
const int SPELL_TRUEC=865;
const int SPELL_DBOLT=866;
const int SPELL_LITAN=867;
const int SPELL_CONFP=868;
const int SPELL_INSPIRE=869;
const int SPELL_NEEDLE=870;
const int SPELL_ACTIVE_SHIELD=871;
const int SPELL_ARMORY=872;
const int SPELL_GRIP=873;
const int SPELL_KOBOLD=874;
const int SPELL_BREAK=875;
const int SPELL_EYESTORM=876;
const int SPELL_AIRFLAME=877;
const int SPELL_FLASH=878;
const int SPELL_DESIRE=879;
const int SPELL_SUCCUBUS=880;

const int HIER_REACH_MASSHEAL=980;
const int HIER_REACH_HEAL=981;
const int HIER_REACH_MASSHARM=983;
const int HIER_REACH_HARM=984;

const int NUM_KOBOLD_TYPES=3;

//Clears the inventory of the target object.
void ClearInventory(object oDecoy)
{
    TakeGold(GetGold(oDecoy),oDecoy,TRUE);
    object oClear=GetFirstItemInInventory(oDecoy);
    while(GetIsObjectValid(oClear))
    {
        //if(!GetIsItemEquipped(oClear,oDecoy)) DestroyObject(oClear);
        //else SetDroppableFlag(oClear,FALSE);

        DestroyObject(oClear);//Just destroy it instead of screwing around with checks.
        oClear=GetNextItemInInventory(oDecoy);
    }
}

//stores the spell level of a cast onHit spell. Also stores school.
void StoreLevel(object oPC)
{
    int nID=GetSpellId();
    string sClass=GetSpellTableFromClassConstant(GetLastSpellCastClass());
    string sLevel=Get2DAString("spells",sClass,nID);
    int iLevel=StringToInt(sLevel);
    SetLocalString(oPC,"ave_activespell_class",sClass);
    SetLocalInt(oPC,"ave_activespell_level",iLevel);
    string sSchool=Get2DAString("spells","School",nID);
    //SendMessageToPC(oPC,"Debug: You are casting an "+sLevel+"th level spell of the "+sSchool+" school, as a "+sClass);
    SetLocalInt(oPC,"ave_activespell_school",GetSpellSchoolIntFromAbbreviation(sSchool));
}

//This strips invis
void DoGeneralOnCast(object oPC)
{
    effect eInvis=GetFirstEffect(oPC);
    while(GetIsEffectValid(eInvis))
    {
        if(GetEffectType(eInvis)==EFFECT_TYPE_INVISIBILITY)
        RemoveEffect(oPC,eInvis);
        eInvis=GetNextEffect(oPC);
    }
}

//Returns the number of bonus spell levels oCaster has for purposes of penetrating SR
int GetPenetrations(object oCaster)
{
    if(GetHasFeat(FEAT_EPIC_SPELL_PENETRATION,oCaster)) return 6;
    else if(GetHasFeat(FEAT_GREATER_SPELL_PENETRATION,oCaster)) return 4;
    else if(GetHasFeat(FEAT_SPELL_PENETRATION)) return 2;
    return 0;
}

//Returns false if iSpellLevel is greater than iImmunityLevel
//Returns true if iSpellLevel is not greater than iImmunityLevel AND iImmunitySchool is iCastSchool
//Returns false if iImmunitySchool is not iCastSchool
//iImmunitySchool=SPELL_SCHOOL_GENERAL and iImmunityLevel=-1 are considered 'free passes' that work for anything
int GetDoesApply(int iCastSchool,int iImmunitySchool,int iSpellLevel,int iImmunityLevel)
{
    if(iSpellLevel>iImmunityLevel&&(iImmunityLevel!=-1)) return FALSE;
    if(iImmunitySchool==SPELL_SCHOOL_GENERAL) return TRUE;
    if(iImmunitySchool==iCastSchool) return TRUE;
    return FALSE;
}

int GetRedoubleSR(object oCaster,object oTarget)
{
    int nCasterLvl=GetLocalInt(oCaster,"ave_cl");
    int nSR=GetSpellResistance(oTarget);
    nCasterLvl=nCasterLvl+GetPenetrations(oCaster);
    int iRoll=d20(1);
    //SendMessageToPC(oCaster,"Debug: "+IntToString(iRoll)+"+"+IntToString(nCasterLvl)+" vs SR "+IntToString(nSR));
    if(iRoll+nCasterLvl<nSR)
    {
        SendMessageToPC(oCaster,IntToString(iRoll)+"+"+IntToString(nCasterLvl)+" vs SR "+IntToString(nSR)+" Spell Resisted!");
        if(oTarget!=oCaster) SendMessageToPC(oTarget,IntToString(iRoll)+"+"+IntToString(nCasterLvl)+" vs SR "+IntToString(nSR)+" Spell Resisted!");
        return TRUE;
    }
    int iSpellLevel=GetLocalInt(oCaster,"ave_activespell_level");
    int iSchool=GetLocalInt(oCaster,"ave_activespell_school");
    int iMax;
    int iTot;
    int iDefendedSchool;
    effect eVis=EffectVisualEffect(VFX_IMP_SPELL_MANTLE_USE);
    effect eMantle=GetFirstEffect(oTarget);
    while(GetIsEffectValid(eMantle))
    {
        if(GetEffectType(eMantle)==EFFECT_TYPE_SPELLLEVELABSORPTION)
        {
            iMax=GetEffectInteger(eMantle,0);//Highest spell level absorbed
            iTot=GetEffectInteger(eMantle,1);//Total spell levels aborbed
            iDefendedSchool=GetEffectInteger(eMantle,2);
            //SendMessageToPC(oCaster,"Debug: they have a mantle against school "+IntToString(iDefendedSchool)+" and you are attacking with "+IntToString(iSchool));
            if(GetDoesApply(iSchool,iDefendedSchool,iSpellLevel,iMax))
            {
                //SendMessageToPC(oCaster,"Debug: they have a mantle against "+IntToString(iTot)+" spell levels, and you are using spell level "+IntToString(iSpellLevel));
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget);
                if(iTot>iSpellLevel)
                {
                    SetEffectInteger(eMantle,1,iTot-iSpellLevel);
                    return TRUE;
                }
                else
                {
                    RemoveEffect(oTarget,eMantle);
                    return TRUE;
                }
            }
        }
        eMantle=GetNextEffect(oTarget);
    }
    return FALSE;
}

//This removes a single buff, as the spell breach spell
void DoSingleBuffRemove(object oTarget)
{
    int iCheck=1;
    int iBreachProt=0;
    while(iCheck<33)
    {
        iBreachProt=GetSpellBreachProtection(iCheck);
        if(GetHasSpellEffect(iBreachProt,oTarget))
        {
            effect eCheck=GetFirstEffect(oTarget);
            while(GetIsEffectValid(eCheck))
            {
                if(GetEffectSpellId(eCheck)==iBreachProt)
                {
                    RemoveEffect(oTarget, eCheck);
                    return;
                }
                eCheck=GetNextEffect(oTarget);
            }
        }
        iCheck++;
    }
}

//This performs an asf check
int TestASF(object oPC)
{
    if(GetLocalString(oPC,"ave_activespell_class")=="Wiz_Sorc"||GetLocalString(oPC,"ave_activespell_class")=="Bard")
    {
        int nASF=GetArcaneSpellFailure(oPC);//Gets ASF that comes from inventory items
        effect eLoop=GetFirstEffect(oPC);
        while(GetIsEffectValid(eLoop))
        {
            if(GetEffectType(eLoop)==EFFECT_TYPE_ARCANE_SPELL_FAILURE)
            {
                nASF=nASF+GetEffectInteger(eLoop,1);
            }
            eLoop=GetNextEffect(oPC);
        }
        if(nASF>Random(100))
        {
            IncrementRemainingFeatUses(oPC,ACTIVE_DURATION_FEAT);
            return 1;//Arcane spell failed.
        }
        else return 0;//Arcane spell passed check.
    }
    return 0;//Not an arcane spell, no arcane spell failure
}

//This function tests for the KO effect of air to flame
void DoChokeCheck(object oVictim,int nDC,int nMetaMagic)
{
    if(!FortitudeSave(oVictim,nDC,SAVING_THROW_TYPE_FIRE))
    {
        effect eStun=EffectStunned();
        eStun=EffectLinkEffects(eStun,EffectKnockdown());
        eStun=EffectLinkEffects(EffectVisualEffect(VFX_DUR_PARALYZE_HOLD),eStun);
        float fDur=24.0f;
        if(nMetaMagic==METAMAGIC_EXTEND) fDur=fDur*2;
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eStun,oVictim,fDur);
    }
}

//Note: because this script uses delaycommand, it will not function if called from a dead creature.
//Instead, use ExecuteScript and then call it from that script.
//
//lCenter is the center of the vfx
//eVFX is the effect, should be created with EffectVisualEffect
//nIteration is the number of times the vfx should fire
//iRadius is the size of the spread over which the vfx fire
//iDelay is the maximum delay (in tenths of seconds) between each firing of the vfx
//
//Be wary of setting nIteration too high because it may cause client-side slowdowns for
//older machines.
void SpamVFX(location lCenter,effect eVFXTYPE,int nIteration, int iRadius, int iDelay)
{
    if(nIteration>1)
    {
        nIteration=nIteration-1;
        DelayCommand(IntToFloat(Random(iDelay)/10),SpamVFX(lCenter,eVFXTYPE,nIteration,iRadius,iDelay));
    }
    vector vLoc=GetPositionFromLocation(lCenter);
    vector vAdd=Vector(IntToFloat(Random((iRadius*2)+1)-iRadius),IntToFloat(Random((iRadius*2)+1)-iRadius),IntToFloat(Random((iRadius*2)+1)-iRadius));
    vLoc=vLoc+vAdd;
    location lNewLoc=Location(GetAreaFromLocation(lCenter),vLoc,IntToFloat(Random(360)));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVFXTYPE,lNewLoc);
}

//Checks to see if the active duration spell you are trying to end is the most recently cast one
void DurationEnd(int nExpire, object oCaster)
{
   if(nExpire==GetLocalInt(oCaster,"ave_expire"))
   {
    DecrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
    SetLocalInt(oCaster,"ave_duration",-1);
    SetLocalInt(oCaster,"ave_metamagic",-1);
   }
}

//Creates the weapon that the creature will be using.
void CreateArmoryItem(object oCaster, float fDuration)
{
    //Declare major variables
    int nStat = GetIsMagicStatBonus(oCaster) / 2;
    // GZ: Just in case...
    if (nStat >20)
    {
        nStat =20;
    }
    else if (nStat <1)
    {
        nStat = 1;
    }
    object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED);
    object oWeapon;
    if (GetIsObjectValid(oSummon))
    {
        //Create item on the creature, epuip it and add properties.
        oWeapon = CreateItemOnObject("NW_WSWDG001", oSummon);
        // GZ: Fix for weapon being dropped when killed
        SetDroppableFlag(oWeapon,FALSE);
        AssignCommand(oSummon, ActionEquipItem(oWeapon, INVENTORY_SLOT_RIGHTHAND));
        // GZ: Check to prevent invalid item properties from being applies
        if (nStat>0)
        {
            AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyAttackBonus(nStat), oWeapon,fDuration);
        }
        AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_1,5),oWeapon,fDuration);
    }
}

void pshock_redouble(int nMetaMagic)
{

    object oCaster = OBJECT_SELF;
    int nCasterLvl = GetLocalInt(oCaster,"ave_cl");
    int nDC=GetLocalInt(oCaster,"ave_dc");
    int nDamage;
    if(nMetaMagic == METAMAGIC_MAXIMIZE)
    nDamage=12;
    else if(nMetaMagic == METAMAGIC_EMPOWER)
    nDamage=FloatToInt(d4(3)*1.5);
    else nDamage=d4(3);
    object oTarget = GetSpellTargetObject();
    IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
    effect eVFX=EffectVisualEffect(VFX_IMP_LIGHTNING_S);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eVFX,oTarget);
    if(GetRedoubleSR(oCaster, oTarget)==0)
    {
        if(!GetIsReactionTypeFriendly(oTarget))
        {
            nDamage=GetReflexAdjustedDamage(nDamage,oTarget,nDC,SAVING_THROW_TYPE_ELECTRICITY,oCaster);
            effect eMyDamage=EffectDamage(nDamage,DAMAGE_TYPE_ELECTRICAL);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eMyDamage,oTarget);
        }
    }
}

void resol_redouble(int nMetaMagic)
{

    object oCaster = OBJECT_SELF;
    int nCasterLvl = GetLocalInt(oCaster,"ave_cl");
    object oTarget = GetSpellTargetObject();
    IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
    effect eVFX=EffectVisualEffect(VFX_IMP_GLOBE_USE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eVFX,oTarget);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eVFX,oCaster);
    float fDur=6.0;
    if(nMetaMagic==METAMAGIC_EXTEND) fDur=fDur*2;
            effect eMyDR=EffectDamageReduction(10,DAMAGE_POWER_PLUS_THREE);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eMyDR,oTarget,fDur);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eMyDR,oCaster,fDur);
}

void mant_redouble(int nMetaMagic)
{
    object oCaster = OBJECT_SELF;

    int nCasterLvl = GetLocalInt(oCaster,"ave_cl");
    int nDC=GetLocalInt(oCaster,"ave_dc");
    int nDamage;
    if (nMetaMagic==METAMAGIC_MAXIMIZE)
    nDamage=8;
    else if(nMetaMagic==METAMAGIC_EMPOWER)
    nDamage=FloatToInt(d8(1)*1.5);
    else nDamage=d8(1);
    object oTarget=GetSpellTargetObject();
    IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
    int iTouchHit=TouchAttackRanged(oTarget,TRUE);
    float nDuration=RoundsToSeconds(5);
    if(nMetaMagic==METAMAGIC_EXTEND) nDuration=nDuration*2;
    if(iTouchHit>0)
    {
        if(iTouchHit==2) nDamage=nDamage*2;
        nDamage=nDamage+getSneakDamage(oCaster,oTarget);
        if(!GetIsReactionTypeFriendly(oTarget))
        {
            if(GetRedoubleSR(oCaster, oTarget)==0)
            {
                effect eVFX=EffectVisualEffect(VFX_IMP_POISON_S);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eVFX,oTarget);
                effect eMyDamage=EffectDamage(nDamage,DAMAGE_TYPE_PIERCING);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eMyDamage,oTarget);
                if((0==FortitudeSave(oTarget,nDC,SAVING_THROW_TYPE_POISON)))
                {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityDecrease(ABILITY_CONSTITUTION,2),oTarget,nDuration);
                }
            }
        }
    }

}

void echo_redouble(int nMetaMagic)
{
    object oCaster=OBJECT_SELF;
    int nCasterLvl = GetLocalInt(oCaster,"ave_cl");
    int nDC=GetLocalInt(oCaster,"ave_dc");
    int nDamage;
    if (nMetaMagic==METAMAGIC_MAXIMIZE)
    nDamage=12;
    else if(nMetaMagic==METAMAGIC_EMPOWER)
    nDamage=FloatToInt(d6(2)*1.5);
    else nDamage=d6(2);
    location lLoc = GetSpellTargetLocation();
    effect eFNF = EffectVisualEffect(VFX_FNF_SOUND_BURST);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eFNF, lLoc);
    effect eVis = EffectVisualEffect(VFX_IMP_SONIC);
    IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLoc);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis,oTarget);
    effect eDamage;
    float fDur=RoundsToSeconds(1);
    if(nMetaMagic==METAMAGIC_EXTEND) fDur=fDur*2;
    while (GetIsObjectValid(oTarget))
    {
        if(GetRedoubleSR(oCaster, oTarget)==0)
        {
            if(!GetIsReactionTypeFriendly(oTarget))
            {
                if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_SONIC))
                {
                    eDamage=EffectDamage(nDamage,DAMAGE_TYPE_SONIC);
                    effect eDaze=EffectDazed();
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDamage,oTarget,fDur);
                }
                else eDamage=EffectDamage(nDamage/2,DAMAGE_TYPE_SONIC);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget);
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLoc);
    }
}

void fwave_redouble(int nMetaMagic)
{
    object oCaster=OBJECT_SELF;
    int nCasterLvl = GetLocalInt(oCaster,"ave_cl");
    int nDC=GetLocalInt(oCaster,"ave_dc");

        int nDamage;
        if (nMetaMagic==METAMAGIC_MAXIMIZE)
        nDamage=3*nCasterLvl;
        else if(nMetaMagic==METAMAGIC_EMPOWER)
        nDamage=FloatToInt(d3(nCasterLvl)*1.5);
        else nDamage=d3(nCasterLvl);
        location lLoc = GetSpellTargetLocation();
        effect eExplode = EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION);
        effect eVis = EffectVisualEffect(VFX_IMP_FROST_L);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eExplode, lLoc);
        IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lLoc);
        effect eDamage;
        while (GetIsObjectValid(oTarget))
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis,oTarget);
            if(GetRedoubleSR(oCaster, oTarget)==0)
            {
                if(!GetIsReactionTypeFriendly(oTarget))
                {
                    if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_COLD))
                    {
                        eDamage=EffectDamage(nDamage,DAMAGE_TYPE_COLD);
                    }
                    else eDamage=EffectDamage(nDamage/2,DAMAGE_TYPE_COLD);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget);
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lLoc);
        }
}

void acce_redouble(int nMetaMagic)
{
        object oCaster=OBJECT_SELF;
        int nCasterLvl = GetLocalInt(oCaster,"ave_cl");
        int nDC=GetLocalInt(oCaster,"ave_dc");
        object oTarget = GetSpellTargetObject();
        int nDamage;
        if (nMetaMagic==METAMAGIC_MAXIMIZE)
        nDamage=3*nCasterLvl;
        else if(nMetaMagic==METAMAGIC_EMPOWER)
        nDamage=FloatToInt(d3(nCasterLvl)*1.5);
        else nDamage=d3(nCasterLvl);
        IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
        effect eVis = EffectVisualEffect(VFX_IMP_HOLY_AID );
        effect eDamage;
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis,oTarget);
            if(GetRedoubleSR(oCaster, oTarget)==0)
            {
                if(!GetIsReactionTypeFriendly(oTarget))
                {
                    if(GetRacialType(oTarget)==RACIAL_TYPE_UNDEAD)
                    {
                        nDamage=GetReflexAdjustedDamage(nDamage,oTarget,nDC,SAVING_THROW_TYPE_POSITIVE,oCaster);
                        eDamage=EffectDamage(nDamage,DAMAGE_TYPE_POSITIVE);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget);
                    }
                }
            }
}

void madgod_redouble(int nMetaMagic)
{
    object oCaster=OBJECT_SELF;
    int nCasterLvl = GetLocalInt(oCaster,"ave_cl");
    int nDC=GetLocalInt(oCaster,"ave_dc");
        object oTarget = GetSpellTargetObject();
        int nDamage;
        IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
        if (nMetaMagic==METAMAGIC_MAXIMIZE)
        nDamage=4*nCasterLvl;
        else if(nMetaMagic==METAMAGIC_EMPOWER)
        nDamage=FloatToInt(d4(nCasterLvl)*1.5);
        else nDamage=d4(nCasterLvl);
        effect eVis = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
        effect eDamage;
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis,oTarget);
            if(GetRedoubleSR(oCaster, oTarget)==0)
            {
                if(!GetIsReactionTypeFriendly(oTarget))
                {
                        int nNewDamage=GetReflexAdjustedDamage(nDamage,oTarget,nDC,SAVING_THROW_TYPE_ELECTRICITY,oCaster);
                        if(nNewDamage==nDamage)
                        {
                            if(0==(MySavingThrow(SAVING_THROW_WILL,oTarget,nDC,SAVING_THROW_TYPE_ELECTRICITY)))
                            {
                                effect eConfuse=EffectConfused();
                                effect eConfuseVis=EffectVisualEffect(VFX_IMP_CONFUSION_S);
                                ApplyEffectToObject(DURATION_TYPE_INSTANT,eConfuseVis,oTarget);
                                float fConfuseDuration=RoundsToSeconds(1);
                                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eConfuse,oTarget,fConfuseDuration);
                            }
                        }
                        eDamage=EffectDamage(nDamage,DAMAGE_TYPE_ELECTRICAL);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget);
                }
            }
}

void burn_redouble(int nMetaMagic)
{
        object oCaster=OBJECT_SELF;
        int nCasterLvl = GetLocalInt(oCaster,"ave_cl");
        int nDC=GetLocalInt(oCaster,"ave_dc");
        object oTarget=GetSpellTargetObject();
        IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
        int nDamage;
        if (nMetaMagic==METAMAGIC_MAXIMIZE)
        nDamage=2*nCasterLvl;
        else if(nMetaMagic==METAMAGIC_EMPOWER)
        nDamage=FloatToInt(d2(nCasterLvl)*1.5);
        else nDamage=d2(nCasterLvl);
        effect eExplode = EffectVisualEffect(VFX_IMP_PULSE_FIRE);
        effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
        effect eVisAura=EffectVisualEffect(VFX_DUR_ELEMENTAL_SHIELD);
        effect eVuln=EffectDamageImmunityDecrease(DAMAGE_TYPE_FIRE,50);
        effect eShield=EffectDamageShield(nCasterLvl-1,DAMAGE_BONUS_1,DAMAGE_TYPE_FIRE);
        float ShortDur=RoundsToSeconds(1);
        if(nMetaMagic==METAMAGIC_EXTEND) ShortDur=ShortDur*2;
        eShield=EffectLinkEffects(eShield,eVisAura);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVuln,oCaster,ShortDur);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eShield,oCaster,ShortDur);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVuln,oTarget,ShortDur);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eShield,oTarget,ShortDur);
        effect eDamage;
        location lLoc;
        if(GetHitDice(oTarget)>0)//If the target is a creature
        {
            lLoc = GetSpellTargetLocation();
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eExplode, lLoc);
            object oVictim = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lLoc);
            while (GetIsObjectValid(oVictim))
            {
                if(!(oVictim==oTarget))
                {
                if(GetRedoubleSR(oCaster, oTarget)==0)
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis,oVictim);
                    if(!GetIsReactionTypeFriendly(oTarget))
                    {
                        nDamage=GetReflexAdjustedDamage(nDamage,oVictim,nDC,SAVING_THROW_TYPE_FIRE,oCaster);
                        eDamage=EffectDamage(nDamage,DAMAGE_TYPE_FIRE);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oVictim);
                    }
                }
                }
                oVictim = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lLoc);
            }
        }
        lLoc=GetLocation(oCaster);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eExplode, lLoc);
            object oVictim = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lLoc);
            while (GetIsObjectValid(oVictim))
            {
                if(!(oVictim==oCaster))
                {
                if(GetRedoubleSR(oCaster, oTarget)==0)
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis,oVictim);
                    if(!GetIsReactionTypeFriendly(oTarget))
                    {
                        nDamage=GetReflexAdjustedDamage(nDamage,oVictim,nDC,SAVING_THROW_TYPE_FIRE,oCaster);
                        eDamage=EffectDamage(nDamage,DAMAGE_TYPE_FIRE);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oVictim);
                    }
                }
                }
                oVictim = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lLoc);
            }
}

int CheckTrueCastingPhase(object oTarget)
{
    effect eLoop=GetFirstEffect(oTarget);
    int MyType=0;
    while(GetIsEffectValid(eLoop))
    {
        if((GetEffectSpellId(eLoop)==SPELL_TRUEC))
        {   //returns too soon, should store a variable and return variable at end
            if((GetEffectType(eLoop)==EFFECT_TYPE_FRIGHTENED))
                MyType=2;
            else if((GetEffectType(eLoop)==EFFECT_TYPE_SLOW)&&MyType==0)
                MyType=1;
        }
        eLoop=GetNextEffect(oTarget);
    }
    return MyType;
}

void truec_redouble(int nMetaMagic)
{
        object oCaster = OBJECT_SELF;
        int nCasterLvl = GetLocalInt(oCaster,"ave_cl");
        int nDC=GetLocalInt(oCaster,"ave_dc");
        object oTarget = GetSpellTargetObject();
        IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
        location lLoc = GetSpellTargetLocation();
        effect eExplode = EffectVisualEffect(VFX_IMP_PULSE_NEGATIVE);
        effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
        effect eSlowVis=EffectVisualEffect(VFX_IMP_SLOW);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eExplode, lLoc);
        oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLoc);
        while (GetIsObjectValid(oTarget))
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis,oTarget);
            if(GetRedoubleSR(oCaster, oTarget)==0)
            {
                if(!GetIsReactionTypeFriendly(oTarget))
                {
                    effect eEffect;
                    int iPhase=CheckTrueCastingPhase(oTarget);
                    int iSaveType;
                    float feDur=RoundsToSeconds(6);
                    if (nMetaMagic==METAMAGIC_EXTEND) feDur=feDur*2;
                    effect eSaveDebuff=EffectSavingThrowDecrease(SAVING_THROW_ALL,1);
                    switch(iPhase)
                    {
                    case 2:
                        iSaveType=SAVING_THROW_FORT;
                        eEffect=EffectDeath();
                        if(0==(MySavingThrow(iSaveType,oTarget,nDC,SAVING_THROW_TYPE_SPELL,oCaster)))
                        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,oTarget);
                        else ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSaveDebuff,oTarget,feDur);
                        break;
                    case 1:
                        iSaveType=SAVING_THROW_WILL;
                        eEffect=EffectFrightened();
                        SetEffectSpellId(eEffect,SPELL_TRUEC);
                        if(0==(MySavingThrow(iSaveType,oTarget,nDC,SAVING_THROW_TYPE_SPELL,oCaster)))
                        {
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eEffect,oTarget,feDur);
                        eEffect=EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eEffect,oTarget,feDur);
                        }
                        else ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSaveDebuff,oTarget,feDur);
                        break;
                    case 0:
                        iSaveType=SAVING_THROW_REFLEX;
                        eEffect=EffectSlow();
                        SetEffectSpellId(eEffect,SPELL_TRUEC);
                        if(0==(MySavingThrow(iSaveType,oTarget,nDC,SAVING_THROW_TYPE_SPELL,oCaster)))
                        {ApplyEffectToObject(DURATION_TYPE_INSTANT,eSlowVis,oTarget);
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eEffect,oTarget,feDur);}
                        else ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSaveDebuff,oTarget,feDur);
                        break;
                    }
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLoc);
        }
}

void dbolt_redouble(int nMetaMagic)
{
        object oCaster=OBJECT_SELF;
        int nCasterLvl = GetLocalInt(oCaster,"ave_cl");
        int nDC=GetLocalInt(oCaster,"ave_dc");
        object oTarget=GetSpellTargetObject();
        IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
        if(nCasterLvl>15) nCasterLvl=15;
        int nDamage;
        if (nMetaMagic==METAMAGIC_MAXIMIZE)
        nDamage=3*nCasterLvl;
        else if(nMetaMagic==METAMAGIC_EMPOWER)
        nDamage=FloatToInt(d3(nCasterLvl)*1.5);
        else nDamage=d3(nCasterLvl);
        effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
        int iTouchHit=TouchAttackRanged(oTarget,TRUE);
        effect eDamage;
        if(iTouchHit>0)
        {
            if(iTouchHit==2) nDamage=nDamage*2;
            nDamage=nDamage+getSneakDamage(oCaster,oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis,oTarget);
            if(GetRedoubleSR(oCaster, oTarget)==0)
            {
                if(!GetIsReactionTypeFriendly(oTarget))
                {
                    if(!(GetRacialType(oTarget)==RACIAL_TYPE_UNDEAD))
                    {
                        eDamage=EffectDamage(nDamage,DAMAGE_TYPE_NEGATIVE);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget);
                    }
                }
            }
        }
}

void litan_redouble(int nMetaMagic)
{
    object oCaster=OBJECT_SELF;
    int nDC=GetLocalInt(oCaster,"ave_dc");
    object oTarget=GetSpellTargetObject();
        IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
        int nDuration;
        if (nMetaMagic==METAMAGIC_EXTEND)
        nDuration=60;
        else
        nDuration=30;
        effect eDur=EffectVisualEffect(VFX_DUR_AURA_BLUE_LIGHT);
        SetLocalInt(oCaster,"ave_duration",SPELL_LITAN);
        SetLocalInt(oCaster,"ave_metamagic",nMetaMagic);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oCaster,RoundsToSeconds(nDuration));
        IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
        DelayCommand(RoundsToSeconds(nDuration),DecrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT));
        DelayCommand(RoundsToSeconds(nDuration),SetLocalInt(oCaster,"ave_duration",-1));
        DelayCommand(RoundsToSeconds(nDuration),SetLocalInt(oCaster,"ave_metamagic",-1));
        float fShortDur=RoundsToSeconds(2);
        if (nMetaMagic==METAMAGIC_EXTEND) fShortDur=fShortDur*2;
        int nDamage;
        effect eVis = EffectVisualEffect(VFX_IMP_GOOD_HELP);
        if(GetRedoubleSR(oCaster, oTarget)==0)
            {
                if(!GetIsReactionTypeFriendly(oTarget))
                {
                    if(nMetaMagic==METAMAGIC_EMPOWER)
                    nDamage=FloatToInt(d8(1)*1.5);
                    else if(nMetaMagic==METAMAGIC_MAXIMIZE)
                    nDamage=8;
                    else nDamage=d8(1);
                    effect MyACDebuff=EffectACDecrease(nDamage);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,MyACDebuff,oTarget,fShortDur);
                }
            }
}

void confp_redouble(int nMetaMagic)
{
        object oCaster=OBJECT_SELF;
        int nCasterLvl = GetLocalInt(oCaster,"ave_cl");
        object oTarget=GetSpellTargetObject();
        IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
        location lLoc = GetSpellTargetLocation();
        effect eExplode = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eExplode, lLoc);
        float fDur=RoundsToSeconds(1);
        if(nMetaMagic==METAMAGIC_EXTEND) fDur=fDur*2;
        oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lLoc);
        while (GetIsObjectValid(oTarget))
        {
            if(!GetIsReactionTypeHostile(oTarget,oCaster))
            {
                effect eInvis=EffectInvisibility(INVISIBILITY_TYPE_NORMAL);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eInvis,oTarget,fDur);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lLoc);
        }
}

void airflame_redouble(int nMetaMagic)
{
        object oCaster=OBJECT_SELF;
        int nCasterLvl = GetLocalInt(oCaster,"ave_cl");
        int nDC=GetLocalInt(oCaster,"ave_dc");
        object oTarget=GetSpellTargetObject();
        location lLoc=GetSpellTargetLocation();
        IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);


        int nDamage;
        effect eDamage;
        if (nMetaMagic==METAMAGIC_MAXIMIZE)
        nDamage=3*nCasterLvl;
        else if(nMetaMagic==METAMAGIC_EMPOWER)
        nDamage=FloatToInt(d3(nCasterLvl)*1.5);
        else nDamage=d3(nCasterLvl);
        SpamVFX(lLoc,EffectVisualEffect(VFX_IMP_PULSE_FIRE),16,4,7);
        effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
        effect eFire = EffectVisualEffect(VFX_DUR_INFERNO_CHEST);
        float fDur=10.0;
        if(nMetaMagic==METAMAGIC_EXTEND) fDur=fDur*2;
        float fDelay;
        object oVictim = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lLoc);
        while(GetIsObjectValid(oVictim))
        {
            if(MyResistSpell(oCaster, oTarget)==0)
            {
                fDelay=Random(5)*0.1;
                if(!GetIsReactionTypeFriendly(oTarget))
                {
                    int nAdjustedDamage=GetReflexAdjustedDamage(nDamage,oVictim,nDC,SAVING_THROW_TYPE_FIRE,oCaster);
                    if(nAdjustedDamage==nDamage)
                    {
                        if(GetHasSpellEffect(1137,oVictim))
                        DoChokeCheck(oVictim,nDC,nMetaMagic);
                        SetEffectSpellId(eFire,1137);//Air to Flame
                        DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eFire,oVictim,fDur));
                    }
                    eDamage=EffectDamage(nAdjustedDamage,DAMAGE_TYPE_FIRE);
                    DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oVictim));
                }
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis,oVictim);
            }
            oVictim=GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lLoc);
        }
}

void inspire_redouble(int nMetaMagic)
{
        object oCaster=OBJECT_SELF;
        int nCasterLvl = GetLocalInt(oCaster,"ave_cl");
        int nDC=GetLocalInt(oCaster,"ave_dc");
        object oTarget=GetSpellTargetObject();
        location lLoc=GetSpellTargetLocation();
        IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);

        float fDur=12.0;
        if (nMetaMagic==METAMAGIC_EXTEND) fDur=fDur*2;
        object oAlly = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lLoc);
        effect eBuff=EffectVisualEffect(VFX_DUR_AURA_CYAN);
        eBuff=EffectLinkEffects(eBuff,EffectAttackIncrease(2));
        eBuff=EffectLinkEffects(eBuff,EffectSkillIncrease(SKILL_ALL_SKILLS,2));
        eBuff=EffectLinkEffects(eBuff,EffectSavingThrowIncrease(SAVING_THROW_ALL,2));
        if (nMetaMagic==METAMAGIC_EXTEND) fDur=fDur*2;
        while (GetIsObjectValid(oAlly))
        {
            if(!GetIsReactionTypeHostile(oAlly,oCaster))
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBuff,oAlly,fDur);
            }
            oAlly=GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lLoc);
        }
}

void shield_redouble(int nMetaMagic)
{
        object oCaster=OBJECT_SELF;
        int nCasterLvl = GetLocalInt(oCaster,"ave_cl");
        int nDC=GetLocalInt(oCaster,"ave_dc");
        object oTarget=GetSpellTargetObject();
        location lLoc=GetSpellTargetLocation();
        IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);

        effect eHit = EffectVisualEffect(VFX_IMP_SPELL_MANTLE_USE);
        effect eVFX = EffectVisualEffect(VFX_DUR_SPELLTURNING);
        float fDur=6.0;
        if (nMetaMagic==METAMAGIC_EXTEND) fDur=fDur*2;
        effect eLink=EffectLinkEffects(eVFX,EffectSpellLevelAbsorption(9,1));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oCaster,fDur);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eHit,oCaster);
        if(oCaster!=oTarget)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oTarget,fDur);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eHit,oTarget);
        }
}

void armory_redouble(int nMetaMagic)
{
        object oCaster=OBJECT_SELF;
        int nCasterLvl = GetLocalInt(oCaster,"ave_cl");
        int nDC=GetLocalInt(oCaster,"ave_dc");
        object oTarget=GetSpellTargetObject();
        location lLoc=GetSpellTargetLocation();
        IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);

        object oSummon=GetAssociate(ASSOCIATE_TYPE_SUMMONED,oCaster);
        if(GetIsObjectValid(oSummon))
        {
            location lLoc=GetLocation(oSummon);
            effect eFrost=EffectVisualEffect(VFX_IMP_FROST_L);
            object oVictim=GetFirstObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_MEDIUM,lLoc);
            int nDamage;
            effect eDam;
            while(GetIsObjectValid(oVictim))
            {
                nDamage=d3(3);
                if(nMetaMagic==METAMAGIC_MAXIMIZE) nDamage=9;
                if(nMetaMagic==METAMAGIC_EMPOWER) nDamage=FloatToInt(d3(3)*1.5);
                nDamage=GetReflexAdjustedDamage(nDamage,oTarget,nDC,SAVING_THROW_TYPE_COLD,oCaster);
                eDam=EffectDamage(nDamage,DAMAGE_TYPE_COLD);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oVictim);
                oVictim=GetNextObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_MEDIUM,lLoc);
            }
        }
        else
        {
            float fDur=18.0;
            if (nMetaMagic==METAMAGIC_EXTEND) fDur=fDur*2;
            effect eSummon = EffectSummonCreature("X2_S_FAERIE001");
            effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, GetSpellTargetLocation());
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), fDur);
            object oSelf = OBJECT_SELF;
            DelayCommand(1.0, CreateArmoryItem(oSelf,fDur));
        }
}

int CheckNeedlePhase(object oTarget)
{
    effect eLoop=GetFirstEffect(oTarget);
    int MyType=0;
    while(GetIsEffectValid(eLoop))
    {
        if((GetEffectSpellId(eLoop)==SPELL_NEEDLE))
        {   //returns too soon, should store a variable and return variable at end
            if((GetEffectType(eLoop)==EFFECT_TYPE_SAVING_THROW_DECREASE))
                MyType=2;
            else if((GetEffectType(eLoop)==EFFECT_TYPE_ABILITY_DECREASE)&&MyType==0)
                MyType=1;
        }
        eLoop=GetNextEffect(oTarget);
    }
    return MyType;
}

void needle_redouble(int nMetaMagic)
{
    object oCaster=OBJECT_SELF;
    int nCasterLvl = GetLocalInt(oCaster,"ave_cl");
    int nDC=GetLocalInt(oCaster,"ave_dc");
    object oTarget=GetSpellTargetObject();
    location lLoc=GetSpellTargetLocation();
    IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);

    int nPhase=CheckNeedlePhase(oTarget);
    effect eDam;
    effect eDeBuff;
    float fDur=18.0;
    if(nMetaMagic==METAMAGIC_EXTEND) fDur=fDur*2;
    switch (nPhase)
    {
    case 0:
    if(nMetaMagic==METAMAGIC_MAXIMIZE) eDam=EffectDamage(6,DAMAGE_TYPE_NEGATIVE);
    else if(nMetaMagic==METAMAGIC_EMPOWER) eDam=EffectDamage(FloatToInt(d6(1)*1.5),DAMAGE_TYPE_NEGATIVE);
    else eDam=EffectDamage(d6(1),DAMAGE_TYPE_NEGATIVE);
    eDeBuff=EffectAbilityDecrease(ABILITY_STRENGTH,1);
    SetEffectSpellId(eDeBuff,SPELL_NEEDLE);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDeBuff,oTarget,fDur);
    break;
    case 1:
    if(nMetaMagic==METAMAGIC_MAXIMIZE) eDam=EffectDamage(6,DAMAGE_TYPE_NEGATIVE);
    else if(nMetaMagic==METAMAGIC_EMPOWER) eDam=EffectDamage(FloatToInt(d6(1)*1.5),DAMAGE_TYPE_NEGATIVE);
    else eDam=EffectDamage(d6(1),DAMAGE_TYPE_NEGATIVE);
    eDeBuff=EffectSavingThrowDecrease(SAVING_THROW_ALL,1);
    SetEffectSpellId(eDeBuff,SPELL_NEEDLE);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDeBuff,oTarget,fDur);
    break;
    case 2:
    if(nMetaMagic==METAMAGIC_MAXIMIZE) eDam=EffectDamage(10,DAMAGE_TYPE_NEGATIVE);
    else if(nMetaMagic==METAMAGIC_EMPOWER) eDam=EffectDamage(FloatToInt(d10(1)*1.5),DAMAGE_TYPE_NEGATIVE);
    else eDam=EffectDamage(d10(1),DAMAGE_TYPE_NEGATIVE);
    break;
    }
    effect eLink=EffectLinkEffects(eDam,EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE));
    if(GetRedoubleSR(oCaster,oTarget)==0)
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eLink,oTarget);
}

void grip_redouble(int nMetaMagic)
{
    object oCaster=OBJECT_SELF;
    int nCasterLvl = GetLocalInt(oCaster,"ave_cl");
    int nDC=GetLocalInt(oCaster,"ave_dc");
    object oTarget=GetSpellTargetObject();
    location lLoc=GetSpellTargetLocation();
    IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);

        effect eExplode=EffectVisualEffect(VFX_FNF_HOWL_ODD);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eExplode, lLoc);
        oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lLoc);
        float fDur=6.0;
        if(nMetaMagic==METAMAGIC_EXTEND) fDur=fDur*2;
        effect eFear;
        while (GetIsObjectValid(oTarget))
        {
            if(GetRedoubleSR(oCaster, oTarget)==0)
            {
                if(!GetIsReactionTypeFriendly(oTarget))
                {
                    if(!MySavingThrow(SAVING_THROW_WILL,oTarget,nDC,SAVING_THROW_TYPE_FEAR))
                    {
                        eFear=EffectFrightened();
                        eFear=EffectLinkEffects(eFear,EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR));
                    }
                    else
                    {
                        eFear=EffectAttackDecrease(4);
                        eFear=EffectLinkEffects(eFear,EffectSavingThrowDecrease(SAVING_THROW_ALL,4));
                        eFear=EffectLinkEffects(eFear,EffectDamageDecrease(4));
                        eFear=EffectLinkEffects(eFear,EffectSkillDecrease(SKILL_ALL_SKILLS,4));
                    }
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eFear,oTarget,fDur);
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lLoc);
        }
}

void kobold_redouble(int nMetaMagic)
{
    object oCaster=OBJECT_SELF;
    int nCasterLvl = GetLocalInt(oCaster,"ave_cl");
    int nDC=GetLocalInt(oCaster,"ave_dc");
    object oTarget=GetSpellTargetObject();
    location lLoc=GetSpellTargetLocation();
    IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);

        string sBluePrint="ave_kobold_"+IntToString(Random(NUM_KOBOLD_TYPES));
        object oKobold=CreateObject(OBJECT_TYPE_CREATURE,sBluePrint,lLoc,TRUE,"ave_kobold");
        DelayCommand(0.0,ClearInventory(oKobold));
        SetLocalInt(oKobold,"ave_koblevel",nCasterLvl);
        SetLocalInt(oKobold,"ave_kobdc",nDC);
        SetLocalObject(oKobold,"ave_kobcast",oCaster);
        SetLocalInt(oKobold,"ave_kobmeta",nMetaMagic);
        float fKobDie=30.0;
        if(nMetaMagic==METAMAGIC_EXTEND) fKobDie=fKobDie*2;
        DelayCommand(fKobDie,ExecuteScript("ave_kob_die",oKobold));
}


void break_redouble(int nMetaMagic)
{
    object oCaster=OBJECT_SELF;
    int nCasterLvl = GetLocalInt(oCaster,"ave_cl");
    int nDC=GetLocalInt(oCaster,"ave_dc");
    object oTarget=GetSpellTargetObject();
    location lLoc=GetSpellTargetLocation();
    IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);

        float fDur=36.0;
        if(nMetaMagic==METAMAGIC_EXTEND) fDur=fDur*2;
        effect eSavePen;
        effect eVis;
        if(GetHitDice(oTarget)>0)//If Target is a creature
        {
            if(!WillSave(oTarget,nDC,SAVING_THROW_TYPE_MIND_SPELLS,oCaster))
            {
                eSavePen=EffectSavingThrowDecrease(SAVING_THROW_ALL,3);
                eSavePen=EffectLinkEffects(eSavePen,EffectSpellResistanceDecrease(2));
                eVis=EffectVisualEffect(VFX_DUR_SANCTUARY);
                eSavePen=EffectLinkEffects(eSavePen,eVis);
                DoSingleBuffRemove(oTarget);
            }
            else
            {
                eSavePen=EffectSavingThrowDecrease(SAVING_THROW_ALL,1);
                eSavePen=EffectLinkEffects(eSavePen,EffectSpellResistanceDecrease(1));
                eVis=EffectVisualEffect(VFX_DUR_SANCTUARY);
                eSavePen=EffectLinkEffects(eVis,eSavePen);
            }
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSavePen,oTarget,fDur);
        }
}

void eyestorm_redouble(int nMetaMagic)
{
    object oCaster=OBJECT_SELF;
    int nCasterLvl = GetLocalInt(oCaster,"ave_cl");
    int nDC=GetLocalInt(oCaster,"ave_dc");
    IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);

        float fDur=6.0;
        float fDeafDur=12.0;
        if(nMetaMagic==METAMAGIC_EXTEND)
        {
            fDur=fDur*2;
            fDeafDur=fDeafDur*2;
        }
        location lLoc=GetLocation(oCaster);
        effect eAOE=EffectVisualEffect(VFX_FNF_SOUND_BURST);
        object oVictim=GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lLoc);
        while(GetIsObjectValid(oVictim))
        {
            if(GetIsReactionTypeHostile(oVictim,oCaster))
            {
                if(GetRedoubleSR(oCaster, oVictim)==0)
                {
                    if(!ReflexSave(oVictim,nDC,SAVING_THROW_TYPE_SONIC,oCaster))
                    {
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectKnockdown(),oVictim,fDur);
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectDeaf(),oVictim,fDeafDur);
                    }
                    else
                    {
                        effect eDebuff=EffectSpellFailure(20);
                        eDebuff=EffectLinkEffects(eDebuff,EffectAttackDecrease(4));
                        ApplyEffectToObject(DURATION_TYPE_INSTANT,eDebuff,oVictim,fDur);
                    }
                }
            }
            oVictim = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lLoc);
        }
}

void flash_redouble(int nMetaMagic)
{
    object oCaster=OBJECT_SELF;
    int nCasterLvl = GetLocalInt(oCaster,"ave_cl");
    int nDC=GetLocalInt(oCaster,"ave_dc");
    object oTarget=GetSpellTargetObject();
    location lLoc=GetSpellTargetLocation();
    IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);

    effect eAOE=EffectVisualEffect(VFX_FNF_NATURES_BALANCE);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eAOE,lLoc);
        float fDur=6.0;
        if(nMetaMagic==METAMAGIC_EXTEND) fDur=fDur*2;
        effect eShield=EffectDamageResistance(DAMAGE_TYPE_COLD,10,10);
        eShield=EffectLinkEffects(eShield,EffectDamageResistance(DAMAGE_TYPE_FIRE,10,10));
        eShield=EffectLinkEffects(eShield,EffectDamageResistance(DAMAGE_TYPE_ACID,10,10));
        eShield=EffectLinkEffects(eShield,EffectDamageResistance(DAMAGE_TYPE_ELECTRICAL,10,10));
        eShield=EffectLinkEffects(eShield,EffectDamageResistance(DAMAGE_TYPE_SONIC,10,10));
        object oAlly=GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lLoc);
        while(GetIsObjectValid(oAlly))
        {
            if(!GetIsReactionTypeHostile(oAlly,oCaster))
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eShield,oAlly,fDur);
            }
            oAlly=GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lLoc);
        }
}

void desire_redouble(int nMetaMagic)
{
    object oCaster=OBJECT_SELF;
    int nCasterLvl = GetLocalInt(oCaster,"ave_cl");
    int nDC=GetLocalInt(oCaster,"ave_dc");
    object oTarget=GetSpellTargetObject();
    location lLoc=GetSpellTargetLocation();
    IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);

        float fDur=6.0;
        if(nMetaMagic==METAMAGIC_EXTEND) fDur=12.0;
        if(GetHitDice(oTarget)>0&&GetHitDice(oTarget)<11)
        {
            if(!GetIsReactionTypeFriendly(oTarget))
               {
                    if(GetRedoubleSR(oCaster, oTarget)==0)
                    {
                        if(!WillSave(oTarget,nDC,SAVING_THROW_TYPE_SPELL,oCaster))
                        {
                            effect eDaze=EffectLinkEffects(EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED),EffectDazed());
                            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDaze,oTarget,fDur);
                        }
                    }
               }
        }
}

effect GetPriorSuccubusEffect(object oTarget)
{
    effect eLoop=GetFirstEffect(oTarget);
    while(GetIsEffectValid(eLoop))
    {
       if(GetEffectSpellId(eLoop)==SPELL_SUCCUBUS&&(GetEffectType(eLoop)!=EFFECT_TYPE_VISUALEFFECT))
       {
            return eLoop;
       }
       eLoop=GetNextEffect(oTarget);
    }
    return eLoop;
}

void succubus_redouble(int nMetaMagic)
{
    object oCaster=OBJECT_SELF;
    int nCasterLvl = GetLocalInt(oCaster,"ave_cl");
    int nDC=GetLocalInt(oCaster,"ave_dc");
    object oTarget=GetSpellTargetObject();
    location lLoc=GetSpellTargetLocation();
    IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);

        float fDur=9.0;
        if(nMetaMagic==METAMAGIC_EXTEND) fDur=fDur*2;
        effect eVFX;
        if(GetHitDice(oTarget)>0&&GetHitDice(oTarget)<16)
        {
           if(!GetIsReactionTypeFriendly(oTarget))
             {
                  if(GetRedoubleSR(oCaster, oTarget)==0)
                  {
                       effect ePrior=GetPriorSuccubusEffect(oTarget);
                       if(GetIsEffectValid(ePrior)) nDC=nDC+2;
                       if(!WillSave(oTarget,nDC,SAVING_THROW_TYPE_SPELL,oCaster))
                       {
                           if(!GetIsEffectValid(ePrior))
                           {
                               int nRand=Random(4);
                               switch(nRand)
                               {
                               case 0: ePrior=EffectStunned();
                               eVFX=EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);
                               break;
                               case 1: ePrior=EffectCurse(4,4,4,4,4,4);
                               eVFX=EffectVisualEffect(VFX_DUR_AURA_BLUE_DARK);
                               break;
                               case 2: ePrior=EffectConfused();
                               eVFX=EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
                               break;
                               case 3: ePrior=EffectDazed();
                               eVFX=EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
                               break;
                               }
                               effect eNew=EffectLinkEffects(ePrior,eVFX);
                               SetEffectSpellId(eNew,SPELL_SUCCUBUS);
                               ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eNew,oTarget,fDur);
                           }
                           else
                           {
                               effect eAdd;
                               switch(GetEffectType(ePrior))
                               {
                                    case EFFECT_TYPE_CONFUSED:
                                    eVFX=EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
                                    eAdd=EffectLinkEffects(eVFX,EffectConfused());
                                    break;
                                    case EFFECT_TYPE_DAZED:
                                    eVFX=EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
                                    eAdd=EffectLinkEffects(eVFX,EffectDazed());
                                    break;
                                    case EFFECT_TYPE_CURSE:
                                    eVFX=EffectVisualEffect(VFX_DUR_AURA_BLUE_DARK);
                                    eAdd=EffectLinkEffects(eVFX,EffectCurse(4,4,4,4,4,4));
                                    break;
                                    case EFFECT_TYPE_STUNNED:
                                    eVFX=EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);
                                    eAdd=EffectLinkEffects(eVFX,EffectStunned());
                                    break;
                               }
                               fDur=fDur+GetEffectDurationRemaining(ePrior);
                               RemoveEffect(oTarget,ePrior);
                               SetEffectSpellId(eAdd,SPELL_SUCCUBUS);
                               ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eAdd,oTarget,fDur);
                           }
                       }
                  }
              }
        }
}

void cure_redouble(int nMetaMagic,int iActiveSpell)
{
    int nSpellID=iActiveSpell;
    object oCaster=OBJECT_SELF;
    int nCasterLvl = GetLocalInt(oCaster,"ave_cl");
    int nDC=GetLocalInt(oCaster,"ave_dc");
    object oTarget=GetSpellTargetObject();
    location lLoc=GetSpellTargetLocation();
    IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);

    switch (iActiveSpell)
    {
/*Minor*/     case 996: DoRangedCure(nDC,nMetaMagic,4, 0, 4, VFX_IMP_SUNSTRIKE, VFX_IMP_HEAD_HEAL, nSpellID); break;
/*Light*/     case 995: DoRangedCure(nDC,nMetaMagic,d8(), 5, 8, VFX_IMP_SUNSTRIKE, VFX_IMP_HEAD_HEAL, nSpellID); break;
/*Moderate*/  case 994: DoRangedCure(nDC,nMetaMagic,d8(2), 10, 16, VFX_IMP_SUNSTRIKE, VFX_IMP_HEAD_HEAL, nSpellID); break;
/*Serious*/   case 993: DoRangedCure(nDC,nMetaMagic,d8(3), 15, 24,VFX_IMP_SUNSTRIKE, VFX_IMP_HEAD_HEAL, nSpellID); break;
/*Critical*/  case 992: DoRangedCure(nDC,nMetaMagic,d8(4), 20, 32, VFX_IMP_SUNSTRIKE, VFX_IMP_HEAD_HEAL, nSpellID); break;

    }
}

void inflict_redouble(int nMetaMagic,int iActiveSpell)
{
    int nSpellID=iActiveSpell;
    object oCaster=OBJECT_SELF;
    int nCasterLvl = GetLocalInt(oCaster,"ave_cl");
    int nDC=GetLocalInt(oCaster,"ave_dc");
    object oTarget=GetSpellTargetObject();
    location lLoc=GetSpellTargetLocation();
    IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);

    switch (iActiveSpell)
    {
/*Minor*/     case 990: DoRangedInflict(nDC,nMetaMagic,4, 0, 4, VFX_IMP_SUNSTRIKE, VFX_IMP_HEAD_HEAL, nSpellID); break;
/*Light*/     case 989: DoRangedInflict(nDC,nMetaMagic,d8(), 5, 8, VFX_IMP_SUNSTRIKE, VFX_IMP_HEAD_HEAL, nSpellID); break;
/*Moderate*/  case 988: DoRangedInflict(nDC,nMetaMagic,d8(2), 10, 16, VFX_IMP_SUNSTRIKE, VFX_IMP_HEAD_HEAL, nSpellID); break;
/*Serious*/   case 987: DoRangedInflict(nDC,nMetaMagic,d8(3), 15, 24,VFX_IMP_SUNSTRIKE, VFX_IMP_HEAD_HEAL, nSpellID); break;
/*Critical*/  case 986: DoRangedInflict(nDC,nMetaMagic,d8(4), 20, 32, VFX_IMP_SUNSTRIKE, VFX_IMP_HEAD_HEAL, nSpellID); break;

    }
}

void massheal_redouble(int nMetaMagic)
{
    object oCaster=OBJECT_SELF;
    int nCL = GetLocalInt(oCaster,"ave_cl");
    int nDC=GetLocalInt(oCaster,"ave_dc");
    IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);

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
      if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD && !GetIsReactionTypeFriendly(oTarget))
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
                    if (!GetRedoubleSR(oCaster, oTarget))
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

void heal_redouble(int nMetaMagic)
{
    object oCaster=OBJECT_SELF;
    int nCL = GetLocalInt(oCaster,"ave_cl");
    int nDC=GetLocalInt(oCaster,"ave_dc");
    object oTarget=GetSpellTargetObject();
    IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);

  effect eKill, eHeal;
  int nDamage, nHeal, nTouch;
  effect eSun = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
  effect eHealVis = EffectVisualEffect(VFX_IMP_HEALING_X);

  if(!GetHasFeat(1582,oCaster)&&nCL > 15){//Check for Energy Channeler
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
            SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_HEAL));
            //Make a touch attack
            int iTouchHit=TouchAttackRanged(oTarget);
            if (iTouchHit>0)
            {
                if(iTouchHit==2) nDamage=nDamage*2;
                nDamage=nDamage+getSneakDamage(oCaster,oTarget);
                //Make SR check
                if (!GetRedoubleSR(oCaster, oTarget))
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
        SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_HEAL, FALSE));

        //Set the heal effect
        eHeal = EffectHeal(nDamage);
        //Apply the heal effect and the VFX impact
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHealVis, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
    }
}

void massharm_redouble(int nMetaMagic)
{
    object oCaster=OBJECT_SELF;
    int nCL = GetLocalInt(oCaster,"ave_cl");
    int nDC=GetLocalInt(oCaster,"ave_dc");
    IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);

    effect eKill;
  effect eVis = EffectVisualEffect(246);
  effect eHeal;
  effect eVis2 = EffectVisualEffect(VFX_IMP_HEALING_G);
  effect eStrike = EffectVisualEffect(VFX_FNF_LOS_EVIL_10);
  int nTouch;
  int nModifier = d4(nCL*4);
  float fDelay;
  location lLoc =  GetSpellTargetLocation();

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
                    if (!GetRedoubleSR(oCaster, oTarget))
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

void harm_redouble(int nMetaMagic)
{
    object oCaster=OBJECT_SELF;
    int nCL = GetLocalInt(oCaster,"ave_cl");
    int nDC=GetLocalInt(oCaster,"ave_dc");
    object oTarget=GetSpellTargetObject();
    IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);

    int nDamage, nHeal;
    effect eVis = EffectVisualEffect(246);
    effect eVis2 = EffectVisualEffect(VFX_IMP_HEALING_G);
    effect eHeal, eDam;
    if(!GetHasFeat(1582,oCaster)&&nCL > 15){//Check for Energy Channeler
        nCL = 15;
    }

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
        SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_HARM, FALSE));
    }
    else
    {
    int nTouch = TouchAttackRanged(oTarget);
    if (nTouch != FALSE)  //GZ: Fixed boolean check to work in NWScript. 1 or 2 are valid return numbers from TouchAttackMelee
    {
        if(nTouch==2) nDamage=nDamage*2;
        nDamage=nDamage+getSneakDamage(oCaster,oTarget);
        if(!GetIsReactionTypeFriendly(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_HARM));
            if (!GetRedoubleSR(oCaster, oTarget))
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
