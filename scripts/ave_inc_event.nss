#include "engine"

//This file includes things that are used by mod_levelup and mod_enter

const int SPELL_HIEROPHANT_PASSIVES=1039;
const int SPELL_ROGUE_PASSIVES=1097;

#include "ave_inc_duration"
#include "nw_i0_spells"
#include "x3_inc_horse"
#include "x2_inc_itemprop"
#include "inc_arrays"
#include "inc_classes"
#include "inc_death"
#include "inc_save"
#include "inc_mod"
#include "inc_map_pins"
#include "inc_spellbook"
#include "inc_iss"
#include "inc_xp"
#include "inc_ilr"
#include "inc_barbarian"
#include "inc_camp"
#include "ave_inc_rogue"
#include "inc_system"
#include "x3_inc_skin"
#include "ave_inc_hier"
#include "nwnx_funcs"
#include "inc_equipment"

//Gets ability scores with racial ability mods
int GetPreRaceAbility(object oPC, int nAbility)
{
    int nScore=GetAbilityScore(oPC,nAbility,TRUE);
    int iRace=GetRacialType(oPC);
    if(nAbility==ABILITY_STRENGTH&&iRace==RACIAL_TYPE_HALFLING) return nScore+2;
    if(nAbility==ABILITY_STRENGTH&&iRace==RACIAL_TYPE_GNOME) return nScore+2;
    if(nAbility==ABILITY_STRENGTH&&iRace==RACIAL_TYPE_HALFORC) return nScore-2;

    if(nAbility==ABILITY_DEXTERITY&&iRace==RACIAL_TYPE_ELF) return nScore-2;
    if(nAbility==ABILITY_DEXTERITY&&iRace==RACIAL_TYPE_HALFLING) return nScore-2;

    if(nAbility==ABILITY_CONSTITUTION&&iRace==RACIAL_TYPE_ELF) return nScore+2;
    if(nAbility==ABILITY_CONSTITUTION&&iRace==RACIAL_TYPE_DWARF) return nScore-2;

    if(nAbility==ABILITY_INTELLIGENCE&&iRace==RACIAL_TYPE_HALFORC) return nScore+2;

    if(nAbility==ABILITY_CHARISMA&&iRace==RACIAL_TYPE_HALFORC) return nScore+2;
    if(nAbility==ABILITY_CHARISMA&&iRace==RACIAL_TYPE_DWARF) return nScore+2;

    return nScore;
}

string GetDDType(object oPC)
{
    int nCheck=1600;
    while(nCheck<1610)
    {
        if(GetHasFeat(nCheck,oPC)) return "rdd_drag";
        nCheck++;
    }
    nCheck=1613;
    while(nCheck<1615)
    {
        if(GetHasFeat(nCheck,oPC)) return "rdd_elemfast";
        nCheck++;
    }
    nCheck=1615;
    while(nCheck<1617)
    {
        if(GetHasFeat(nCheck,oPC)) return "rdd_elemcon";
        nCheck++;
    }
    nCheck=1617;
    while(nCheck<1619)
    {
        if(GetHasFeat(nCheck,oPC)) return "rdd_fiend";
        nCheck++;
    }
    nCheck=1619;
    while(nCheck<1621)
    {
        if(GetHasFeat(nCheck,oPC)) return "rdd_celes";
        nCheck++;
    }
    nCheck=1621;
    while(nCheck<1623)
    {
        if(GetHasFeat(nCheck,oPC)) return "rdd_fey";
        nCheck++;
    }
    if(GetHasFeat(962,oPC)) return "rdd_drag";  //Old RDD
    return "";
}

void DoBloodlineDisciple(object oPC)//This function should only be called on bloodline disciple PCs.
{
    string sMyType=GetDDType(oPC);
    if(sMyType=="")
    {
        SendMessageToPC(oPC,"ERROR! DRAGON DISCIPLE TYPE NOT FOUND! This probably means you picked an epic bonus feat instead of a dragon color. Please ask an admin for help.");
        return;
    }
    int iLevel=GetLevelByClass(37,oPC);
    int iType=0;
    int iBase=0;
    string sStat;
    int iNew=0;//Entry in the new 2da table
    int iAdj=0;//Amount of total adjustment they should have
    int iChange=0;//Amount by which we change it right now
    int iAlreadyDone=0;//Amount by which we have changed it before
    while(iType<6)
    {
        int iPre=GetPreRaceAbility(oPC,iType);
        //int iPre=GetAbilityScore(oPC,iType,TRUE);
        switch(iType)
        {
            case ABILITY_STRENGTH:      sStat="Str"; break;
            case ABILITY_DEXTERITY:     sStat="Dex"; break;
            case ABILITY_CONSTITUTION:  sStat="Con"; break;
            case ABILITY_INTELLIGENCE:  sStat="Int"; break;
            case ABILITY_WISDOM:        sStat="Wis"; break;
            case ABILITY_CHARISMA:      sStat="Cha"; break;
        }
        if(GetHasFeat(962,oPC))//Bioware dragon abilities
        iBase=StringToInt(Get2DAString("rdd_base",sStat,iLevel));
        else iBase=0;
        iNew=StringToInt(Get2DAString(sMyType,sStat,iLevel));
        iAlreadyDone=GetPersistentInt(oPC,"RDD_"+sStat);
        iAdj=iNew-(iBase+iAlreadyDone);
        if(iAdj!=0)
        {
            //iChange=iAdj-GetPersistentInt(oPC,"RDD_"+sStat);
            //if(iChange!=0)
            //{
                SetAbilityScore(oPC,iType,iAdj+iPre);
                SetPersistentInt(oPC,"RDD_"+sStat,iAlreadyDone+(iAdj+iBase));
            //}
        }
        iType++;
    }
    if(GetHasFeat(1612,oPC))//Immunities
    {
        effect eDragImmune;
        if(sMyType=="rdd_drag")
        {
            if(GetHasFeat(962,oPC)||GetHasFeat(1600,oPC)||GetHasFeat(1607,oPC)||GetHasFeat(1605,oPC))//Fire Dragons
            {
                eDragImmune=SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE,100));
            }
            else if(GetHasFeat(1601,oPC)||GetHasFeat(1609,oPC))//Lightning Dragons
            {
                eDragImmune=SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL,100));
            }
            else if(GetHasFeat(1602,oPC)||GetHasFeat(1604,oPC)||GetHasFeat(1608,oPC))//Acid dragons
            {
                eDragImmune=SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_ACID,100));
            }
            else if(GetHasFeat(1606,oPC)||GetHasFeat(1603,oPC))//Cold Dragons
            {
                eDragImmune=SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD,100));
            }
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,eDragImmune,oPC);
            if(!GetHasFeat(228,oPC)) AddKnownFeat(oPC,228,GetHitDice(oPC));//Darkvision
            if(!GetHasFeat(235,oPC)) AddKnownFeat(oPC,235,GetHitDice(oPC));//Sleep immunity
            if(!GetHasFeat(963,oPC)) AddKnownFeat(oPC,963,GetHitDice(oPC));//Paralysis immunity
        }
        else if(sMyType=="rdd_elemfast")
        {
            if(GetHasFeat(1613,oPC))//Air Elemental
            {
                eDragImmune=SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL,100));
            }
            else if(GetHasFeat(1614,oPC))//Fire Elemental
            {
                eDragImmune=SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE,100));
            }
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,eDragImmune,oPC);
            if(!GetHasFeat(228,oPC)) AddKnownFeat(oPC,228,GetHitDice(oPC));//Darkvision
            if(!GetHasFeat(235,oPC)) AddKnownFeat(oPC,235,GetHitDice(oPC));//Sleep immunity
            if(!GetHasFeat(963,oPC)) AddKnownFeat(oPC,963,GetHitDice(oPC));//Paralysis immunity
        }
        else if(sMyType=="rdd_elemcon")
        {
            if(GetHasFeat(1616,oPC))//Earth Elemental
            {
                eDragImmune=SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_ACID,100));
            }
            else if(GetHasFeat(1615,oPC))//Water Elemental
            {
                eDragImmune=SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD,100));
            }
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,eDragImmune,oPC);
            if(!GetHasFeat(228,oPC)) AddKnownFeat(oPC,228,GetHitDice(oPC));//Darkvision
            if(!GetHasFeat(235,oPC)) AddKnownFeat(oPC,235,GetHitDice(oPC));//Sleep immunity
            if(!GetHasFeat(963,oPC)) AddKnownFeat(oPC,963,GetHitDice(oPC));//Paralysis immunity
        }
        else if(sMyType=="rdd_fiend")
        {
            if(GetHasFeat(1617,oPC))//Demon
            {
                eDragImmune=EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL,100);
                eDragImmune=EffectLinkEffects(eDragImmune,EffectDamageResistance(DAMAGE_TYPE_FIRE,5));
                eDragImmune=EffectLinkEffects(eDragImmune,EffectDamageResistance(DAMAGE_TYPE_ACID,5));
                eDragImmune=EffectLinkEffects(eDragImmune,EffectDamageResistance(DAMAGE_TYPE_COLD,5));
                eDragImmune=EffectLinkEffects(eDragImmune,EffectImmunity(IMMUNITY_TYPE_POISON));
                eDragImmune=SupernaturalEffect(eDragImmune);
            }
            else if(GetHasFeat(1618,oPC))//Devil
            {
                eDragImmune=EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE,100);
                eDragImmune=EffectLinkEffects(eDragImmune,EffectDamageResistance(DAMAGE_TYPE_COLD,5));
                eDragImmune=EffectLinkEffects(eDragImmune,EffectDamageResistance(DAMAGE_TYPE_ACID,5));
                eDragImmune=EffectLinkEffects(eDragImmune,EffectImmunity(IMMUNITY_TYPE_POISON));
                eDragImmune=SupernaturalEffect(eDragImmune);
            }
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,eDragImmune,oPC);
            if(!GetHasFeat(228,oPC)) AddKnownFeat(oPC,228,GetHitDice(oPC));//Darkvision
        }
        else if(sMyType=="rdd_celes")
        {
            if(GetHasFeat(1619,oPC))//Archon
            {
                eDragImmune=SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL,100));
            }
            else if(GetHasFeat(1620,oPC))//Eladrin
            {
                eDragImmune=SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL,100));
            }
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,eDragImmune,oPC);
            if(!GetHasFeat(963,oPC)) AddKnownFeat(oPC,963,GetHitDice(oPC));//Paralysis immunity
            if(!GetHasFeat(228,oPC)) AddKnownFeat(oPC,228,GetHitDice(oPC));//Darkvision
        }
        else if(sMyType=="rdd_fey")
        {
            eDragImmune=SupernaturalEffect(EffectSpellResistanceIncrease((iLevel/2)+25));
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,eDragImmune,oPC);
            //Fey don't get any special level 10 immunities, instead they get an upgrade of their level 3 power.
        }
    }
}

void DoCheckForDeadlyGift(object oPC,int iGiftNum)
{
    object oItem=GetFirstItemInInventory(oPC);
    while(GetIsObjectValid(oItem))
    {
        if(GetLocalInt(oItem,"ave_gift_num")==iGiftNum)
        {DoDeadlyGiftExplode(oItem,iGiftNum);}
        oItem=GetNextItemInInventory(oPC);
    }
}

void DoRogueStuff(object oPC)
{
   //Smallest Vulnerability
   int PMDelay=GetPersistentInt(oPC,"ave_vuln_pm");
   if(PMDelay>0)
   {
      DelayCommand(IntToFloat(PMDelay),NoLongerVulnPM(oPC));
   }
   //Deadly Gift
   object oModule=GetModule();
   int iGifts=GetLocalInt(oModule,"ave_gift_num");
   while(iGifts>0)
   {
      if(GetLocalInt(oModule,"ave_gift_logout_"+IntToString(iGifts))==1)
      {
        DoCheckForDeadlyGift(oPC,iGifts);
      }
      iGifts=iGifts-1;
   }

    //Skill Boosting feats
    effect eStrip=GetFirstEffect(oPC);
    while(GetIsEffectValid(eStrip))
    {
        if(GetEffectSpellId(eStrip)==SPELL_ROGUE_PASSIVES)
        RemoveEffect(oPC,eStrip);
        eStrip=GetNextEffect(oPC);
    }
        int nLevel=GetLevelByClass(CLASS_TYPE_ROGUE,oPC);
        effect eSkill;

        if(GetHasFeat(HONEYED_WORDS,oPC))
        {
            eSkill=EffectSkillIncrease(SKILL_BLUFF,nLevel);
            SetEffectSpellId(eSkill,SPELL_ROGUE_PASSIVES);
            eSkill=SupernaturalEffect(eSkill);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSkill,oPC);
        }

        if(GetHasFeat(MASTER_OF_DISGUISE,oPC))
        {
            eSkill=EffectSkillIncrease(SKILL_DISGUISE,nLevel);
            SetEffectSpellId(eSkill,SPELL_ROGUE_PASSIVES);
            eSkill=SupernaturalEffect(eSkill);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSkill,oPC);
        }

        if(GetHasFeat(CUNNING_CAUTION,oPC))
        {
            eSkill=EffectSkillIncrease(SKILL_SEARCH,nLevel/3);
            eSkill=EffectLinkEffects(eSkill,EffectSkillIncrease(SKILL_SPOT,nLevel/3));
            eSkill=EffectLinkEffects(eSkill,EffectSkillIncrease(SKILL_LISTEN,nLevel/3));
            SetEffectSpellId(eSkill,SPELL_ROGUE_PASSIVES);
            eSkill=SupernaturalEffect(eSkill);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSkill,oPC);
        }

    if(GetLevelByClass(CLASS_TYPE_ROGUE,oPC)>1)
    {
        if(GetHasFeat(CHEAP_SHOT,oPC))
        {
            DecrementRemainingFeatUses(oPC,CHEAP_SHOT);
            GeneralCoolDown(CHEAP_SHOT,oPC,180.0);
        }

        if(GetHasFeat(ANOTHER_DAY,oPC))
        {
            DecrementRemainingFeatUses(oPC,ANOTHER_DAY);
            GeneralCoolDown(ANOTHER_DAY,oPC,600.0);
        }

        if(GetHasFeat(RIGGED_DECOY,oPC))
        {
            GeneralCoolDown(RIGGED_DECOY,oPC,900.0);
            DecrementRemainingFeatUses(oPC,RIGGED_DECOY);
        }

        if(GetHasFeat(SLY_SPELLDODGER,oPC))
        {
            GeneralCoolDown(SLY_SPELLDODGER,oPC,180.0);
            DecrementRemainingFeatUses(oPC,SLY_SPELLDODGER);
        }

        if(GetHasFeat(FALSE_FRIEND,oPC))
        {
            GeneralCoolDown(FALSE_FRIEND,oPC,180.0);
            DecrementRemainingFeatUses(oPC,FALSE_FRIEND);
        }

        if(GetHasFeat(DEADLY_GIFT,oPC))
        {
            GeneralCoolDown(DEADLY_GIFT,oPC,900.0);
            DecrementRemainingFeatUses(oPC,DEADLY_GIFT);
        }

        if(GetHasFeat(GARROTE_GRAB,oPC))
        {
            GeneralCoolDown(GARROTE_GRAB,oPC,240.0);
            DecrementRemainingFeatUses(oPC,GARROTE_GRAB);
        }

        if(GetHasFeat(MIASMIC_FLASK,oPC))
        {
            GeneralCoolDown(MIASMIC_FLASK,oPC,180.0);
            DecrementRemainingFeatUses(oPC,MIASMIC_FLASK);
        }
        if(GetHasFeat(LINGERING_SHROUD,oPC))
        {
            GeneralCoolDown(LINGERING_SHROUD,oPC,300.0);
            DecrementRemainingFeatUses(oPC,LINGERING_SHROUD);
        }

        if(GetHasFeat(SNIPERS_EYE,oPC))
        {
            if(GetHasFeat(SNIPERS_EYE_2,oPC)) GeneralCoolDown(SNIPERS_EYE,oPC,60.0);
            else GeneralCoolDown(SNIPERS_EYE,oPC,180.0);
            DecrementRemainingFeatUses(oPC,SNIPERS_EYE);
        }

        if(GetHasFeat(SLY_SPELLTHIEF,oPC))
        {
            GeneralCoolDown(SLY_SPELLTHIEF,oPC,180.0);
            DecrementRemainingFeatUses(oPC,SLY_SPELLTHIEF);
        }

        if(GetHasFeat(VENDETTA,oPC))
        {
            GeneralCoolDown(VENDETTA,oPC,60.0);
            DecrementRemainingFeatUses(oPC,VENDETTA);
        }

        if(GetHasFeat(SMALLEST_VULNERABILITY,oPC))
        {
            if(GetHasFeat(SMALLEST_VULNERABILITY_2,oPC)) GeneralCoolDown(SMALLEST_VULNERABILITY,oPC,6.0);
            else GeneralCoolDown(SMALLEST_VULNERABILITY,oPC,120.0);
            DecrementRemainingFeatUses(oPC,SMALLEST_VULNERABILITY);
        }

    }

}

void DoEpicSelfConceal(object oPC)
{
    RemoveEffectsFromSpell(oPC,1076);
    int nAmount=10;
    if(GetLevelByClass(CLASS_TYPE_ROGUE,oPC)==GetHitDice(oPC))
    {
        nAmount=10+(GetAbilityScore(oPC,ABILITY_INTELLIGENCE,TRUE)*2);
    }
    else if(GetLevelByClass(CLASS_TYPE_MONK,oPC)==GetHitDice(oPC))
    {
        nAmount=10+(GetAbilityScore(oPC,ABILITY_INTELLIGENCE,TRUE)*2);
    }
    if(nAmount>80) nAmount=80;//No PC will ever get enough intelligence to get anywhere near 80% conceal. But, this is a failsafe for NPCs.
    effect eConceal=EffectConcealment(nAmount);
    SetEffectSpellId(eConceal,1076);
    SupernaturalEffect(eConceal);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,eConceal,oPC);
}

void DoBardWeaponProf(object oPC)
{
    AddKnownFeat(oPC,1387,2);
}

void DoHierophantPassives(object oPC)
{
    effect eStrip=GetFirstEffect(oPC);
    while(GetIsEffectValid(eStrip))
    {
        if(GetEffectSpellId(eStrip)==SPELL_HIEROPHANT_PASSIVES)
        RemoveEffect(oPC,eStrip);
        eStrip=GetNextEffect(oPC);
    }

    if(GetHasFeat(1567,oPC))//Inquisitor
    {
        int nValue=GetLevelByClass(50,oPC)/4;
        effect eInq=EffectSkillIncrease(SKILL_SENSE_MOTIVE,nValue);
        eInq=EffectLinkEffects(eInq,EffectSkillIncrease(SKILL_INTIMIDATE,nValue));
        eInq=EffectLinkEffects(eInq,EffectSkillIncrease(41,nValue));//Knowledge religion
        eInq=EffectLinkEffects(eInq,EffectSavingThrowIncrease(SAVING_THROW_TYPE_ALL,nValue));
        SetEffectSpellId(eInq,SPELL_HIEROPHANT_PASSIVES);
        eInq=SupernaturalEffect(eInq);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,eInq,oPC);
    }

    if(GetHasFeat(1566,oPC))//Blessed Hunter
    {
        int iCount=0;
        int iEnemy=0;
        int nBuffSize=GetLevelByClass(50,oPC)+1;
        effect eHuntBuff;
        while(iEnemy>-1)
        {
            iCount++;
            iEnemy=GetNthFavoredEnemy(oPC,iCount);
            if(iEnemy>-1)
            {
                eHuntBuff=VersusRacialTypeEffect(EffectDamageIncrease(nBuffSize),iEnemy);//Note! If there is ever a chance of this going above +5 use damage_type_* constants!
                eHuntBuff=EffectLinkEffects(eHuntBuff,VersusRacialTypeEffect(EffectSkillIncrease(SKILL_TAUNT,nBuffSize),iEnemy));
                eHuntBuff=EffectLinkEffects(eHuntBuff,VersusRacialTypeEffect(EffectSkillIncrease(SKILL_LISTEN,nBuffSize),iEnemy));
                eHuntBuff=EffectLinkEffects(eHuntBuff,VersusRacialTypeEffect(EffectSkillIncrease(SKILL_HIDE,nBuffSize),iEnemy));
                SetEffectSpellId(eHuntBuff,SPELL_HIEROPHANT_PASSIVES);
                eHuntBuff=SupernaturalEffect(eHuntBuff);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT,eHuntBuff,oPC);
            }
        }
    }

    if(GetHasFeat(1574,oPC))//Epic Blessed Hunter
    {
        int iCount=0;
        int iEnemy=0;
        int nBuffSize=6;
        effect eEpicHuntBuff;
        while(iEnemy>-1)
        {
            iCount++;
            iEnemy=GetNthFavoredEnemy(oPC,iCount);
            if(iEnemy>-1)
            {
                eEpicHuntBuff=VersusRacialTypeEffect(EffectDamageIncrease(nBuffSize),iEnemy);//Note! If there is ever a chance of this going above +5 use damage_type_* constants!
                eEpicHuntBuff=EffectLinkEffects(eEpicHuntBuff,VersusRacialTypeEffect(EffectSkillIncrease(SKILL_TAUNT,nBuffSize),iEnemy));
                eEpicHuntBuff=EffectLinkEffects(eEpicHuntBuff,VersusRacialTypeEffect(EffectSkillIncrease(SKILL_LISTEN,nBuffSize),iEnemy));
                eEpicHuntBuff=EffectLinkEffects(eEpicHuntBuff,VersusRacialTypeEffect(EffectSkillIncrease(SKILL_HIDE,nBuffSize),iEnemy));
                eEpicHuntBuff=EffectLinkEffects(eEpicHuntBuff,VersusRacialTypeEffect(EffectACIncrease(nBuffSize/2),iEnemy));
                eEpicHuntBuff=EffectLinkEffects(eEpicHuntBuff,VersusRacialTypeEffect(EffectSavingThrowIncrease(SAVING_THROW_ALL,nBuffSize/2),iEnemy));
                SetEffectSpellId(eEpicHuntBuff,SPELL_HIEROPHANT_PASSIVES);
                eEpicHuntBuff=SupernaturalEffect(eEpicHuntBuff);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT,eEpicHuntBuff,oPC);
            }
        }
    }

    if(GetHasFeat(1586,oPC))//Divine Panoply
    {
        if(!GetKnowsFeat(1380,oPC)) AddKnownFeat(oPC,1380,GetHitDice(oPC));
        if(!GetKnowsFeat(1381,oPC)) AddKnownFeat(oPC,1381,GetHitDice(oPC));
    }

    object oSkin=SKIN_SupportGetSkin(oPC);
    int nClass=Hier_GetClass(oPC);
    int nLevel;
    itemproperty ipMyProp;

    SetPersistentInt(oPC,"ave_dbping",1);
    if(GetPersistentInt(oPC,"ave_dbping")!=1) SendMessageToPC(oPC,"Warning! Database Error");
    else
    {
        DeletePersistentVariable(oPC,"ave_dbping");
        if(GetHasFeat(1572,oPC)&&GetPersistentInt(oPC,"willgod4")==0)//Will of the Gods 4
        {
            nLevel=0;
            while(nLevel<10)
            {
                ipMyProp=ItemPropertyBonusLevelSpell(nClass,nLevel);
                IPSafeAddItemProperty(oSkin,ipMyProp,0.0f,X2_IP_ADDPROP_POLICY_IGNORE_EXISTING);
                nLevel++;
            }
            SetPersistentInt(oPC,"willgod4",1);
        }
        if(GetHasFeat(1571,oPC)&&GetPersistentInt(oPC,"willgod3")==0)//Will of the Gods 3
        {
            nLevel=7;
            while(nLevel<10)
            {
                ipMyProp=ItemPropertyBonusLevelSpell(nClass,nLevel);
                IPSafeAddItemProperty(oSkin,ipMyProp,0.0f,X2_IP_ADDPROP_POLICY_IGNORE_EXISTING);
                nLevel++;
        }
            SetPersistentInt(oPC,"willgod3",1);
        }
        if(GetHasFeat(1570,oPC)&&GetPersistentInt(oPC,"willgod2")==0)//Will of the Gods 2
        {
            nLevel=4;
            while(nLevel<7)
            {
                ipMyProp=ItemPropertyBonusLevelSpell(nClass,nLevel);
                IPSafeAddItemProperty(oSkin,ipMyProp,0.0f,X2_IP_ADDPROP_POLICY_IGNORE_EXISTING);
                nLevel++;
            }
            SetPersistentInt(oPC,"willgod2",1);
        }
        if(GetHasFeat(1569,oPC)&&GetPersistentInt(oPC,"willgod1")==0)//Will of the Gods 1
        {
            nLevel=1;
            while(nLevel<4)
            {
                ipMyProp=ItemPropertyBonusLevelSpell(nClass,nLevel);
                IPSafeAddItemProperty(oSkin,ipMyProp,0.0f,X2_IP_ADDPROP_POLICY_IGNORE_EXISTING);
                nLevel++;
            }
            SetPersistentInt(oPC,"willgod1",1);
        }
    }
}

void DoFeatHPBonus(object oPC)
{
    int nTough=0;
    if(GetHasFeat(FEAT_EPIC_TOUGHNESS_10,oPC))
    nTough=10;
    else if(GetHasFeat(FEAT_EPIC_TOUGHNESS_9,oPC))
    nTough=9;
    else if(GetHasFeat(FEAT_EPIC_TOUGHNESS_8,oPC))
    nTough=8;
    else if(GetHasFeat(FEAT_EPIC_TOUGHNESS_7,oPC))
    nTough=7;
    else if(GetHasFeat(FEAT_EPIC_TOUGHNESS_6,oPC))
    nTough=6;
    else if(GetHasFeat(FEAT_EPIC_TOUGHNESS_5,oPC))
    nTough=5;
    else if(GetHasFeat(FEAT_EPIC_TOUGHNESS_4,oPC))
    nTough=4;
    else if(GetHasFeat(FEAT_EPIC_TOUGHNESS_3,oPC))
    nTough=3;
    else if(GetHasFeat(FEAT_EPIC_TOUGHNESS_2,oPC))
    nTough=2;
    else if(GetHasFeat(FEAT_EPIC_TOUGHNESS_1,oPC))
    nTough=1;
    int iPreTough=GetPersistentInt(oPC,"ave_hpboost");
    if(iPreTough==0)
    {
        SetPersistentInt(oPC,"ave_hpboost",1);
        if(GetPersistentInt(oPC,"ave_hpboost")==0)
        {
            SendMessageToPC(oPC,"Warning! Database not found.");
            return;
        }
    }
    int iSum=0;
    if(nTough>0)
    {
        //Single classed monks, rangers, barbarians, fighters, paladins
        //and people with no more than 10 levels in non-DWD classes
        //get more benefit from epic toughness
        if(GetIsDedicatedDefender(oPC)||GetLevelByClass(CLASS_TYPE_FIGHTER,oPC)==GetHitDice(oPC)||GetLevelByClass(CLASS_TYPE_MONK,oPC)==GetHitDice(oPC)||GetLevelByClass(CLASS_TYPE_BARBARIAN,oPC)==GetHitDice(oPC)||GetLevelByClass(CLASS_TYPE_RANGER,oPC)==GetHitDice(oPC)||GetLevelByClass(CLASS_TYPE_PALADIN,oPC)==GetHitDice(oPC))
        iSum=iSum+(40*nTough);
        else
        iSum=iSum+(20*nTough);
    }
    if(GetHasFeat(FEAT_EPIC_PERFECT_HEALTH,oPC)) iSum=iSum+40;
    if(GetHasFeat(FEAT_RESIST_POISON,oPC)) iSum=iSum+5;
    if(GetHasFeat(FEAT_RESIST_DISEASE,oPC)) iSum=iSum+5;
    SetPersistentInt(oPC,"ave_hpboost",iSum);
    int iBoost=iSum-iPreTough;//Here we figure out how many maximum hit points should be added - the number they should have, minus the number they previously gained
    if(iBoost!=0)
    {
        int iBase=GetMaxHitPointsByLevel(oPC,GetHitDice(oPC));
        SetMaxHitPointsByLevel(oPC,GetHitDice(oPC),iBase+iBoost);
    }
}

void DoMiscFeatBonuses(object oPC)
{
    effect eBoost;
    if(GetHasFeat(753,oPC))//Superior initiative
    {
        RemoveSpecificEffect(EFFECT_TYPE_MOVEMENT_SPEED_INCREASE,oPC);
        eBoost=SupernaturalEffect(EffectMovementSpeedIncrease(10));
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,eBoost,oPC);
    }
    else if(GetHasFeat(377,oPC))//Improved initiative
    {
        RemoveSpecificEffect(EFFECT_TYPE_MOVEMENT_SPEED_INCREASE,oPC);
        eBoost=SupernaturalEffect(EffectMovementSpeedIncrease(5));
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,eBoost,oPC);
    }
}
