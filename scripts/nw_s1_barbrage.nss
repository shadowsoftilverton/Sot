#include "engine"
#include "aps_include"
#include "inc_barbarian"
#include "x2_inc_itemprop"

//::///////////////////////////////////////////////
//:: Barbarian Rage
//:: NW_S1_BarbRage
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Str and Con of the Barbarian increases,
    Will Save are +2, AC -2.
    Greater Rage starts at level 15.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Aug 13, 2001
//:://////////////////////////////////////////////

#include "x2_i0_spells"

void main()
{
    if(!GetHasFeatEffect(FEAT_BARBARIAN_RAGE))
    {
        object oPC = OBJECT_SELF;

        int iRacialStrMod = 0;
        int iRacialDexMod = 0;
        int iRacialConMod = 0;

        switch(GetRacialType(oPC)) {
        case RACIAL_TYPE_ELF:
            iRacialDexMod =  2;
            iRacialConMod = -2;
            //if(GetSubRace(oPC)=="Wood Elf")
            //{
                //iRacialStrMod=2;
            //}
            //else if(GetSubRace(oPC)=="Sun Elf")
            //{
                //iRacialDexMod=0;
            //}
            //else if(GetSubRace(oPC)=="Wild Elf")
            //{
                //iRacialConMod=0;
            //}
            break;
        case RACIAL_TYPE_DWARF:
            iRacialConMod =  2;
            //if(GetSubRace(oPC)=="Gold Dwarf")
            //{
                //iRacialDexMod=-2;
            //}
            break;
        case RACIAL_TYPE_HALFLING:
            iRacialStrMod = -2;
            iRacialDexMod =  2;
            break;
        case RACIAL_TYPE_GNOME:
            iRacialStrMod = -2;
            iRacialConMod =  2;
            break;
        case RACIAL_TYPE_HALFORC:
            iRacialStrMod =  2;
            break;
        case RACIAL_TYPE_HUMAN:
        case RACIAL_TYPE_HALFELF:
        default: break;
        }

        //Declare major variables
        int nLevel = GetLevelByClass(CLASS_TYPE_BARBARIAN);
        int nIncrease;
        int nSave;
        if (nLevel < 15)
        {
            nIncrease = 4;
            nSave = 2;
        }
        else
        {
            nIncrease = 6;
            nSave = 3;
        }
        PlayVoiceChat(VOICE_CHAT_BATTLECRY1);
        //Determine the duration by getting the con modifier after being modified
        int nCon = 3 + GetAbilityModifier(ABILITY_CONSTITUTION) + nIncrease;
        //effect eStr = EffectAbilityIncrease(ABILITY_CONSTITUTION, nIncrease);
        //effect eCon = EffectAbilityIncrease(ABILITY_STRENGTH, nIncrease);

        // 2012-2-1, Invictus: NWNX-based rage modifiers
        SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + nIncrease);
        SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + nIncrease);
        SetPersistentInt(oPC, "BARBARIAN_RAGING", 1);
        SetPersistentInt(oPC, "BARBARIAN_STR_INC", nIncrease);
        SetPersistentInt(oPC, "BARBARIAN_CON_INC", nIncrease);
        DelayCommand(RoundsToSeconds(nCon), DoEndBarbarianRage(oPC));

        effect eSave = EffectSavingThrowIncrease(SAVING_THROW_WILL, nSave);
        effect eAC = EffectACDecrease(2, AC_DODGE_BONUS);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

        //effect eLink = EffectLinkEffects(eCon, eStr);
        //eLink = EffectLinkEffects(eLink, eSave);
        effect eLink = EffectLinkEffects(eSave, eAC);
        eLink = EffectLinkEffects(eLink, eDur);
        SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_BARBARIAN_RAGE, FALSE));
        //Make effect extraordinary
        eLink = ExtraordinaryEffect(eLink);
        effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE); //Change to the Rage VFX

        if (nCon > 0)
        {
            //Apply the VFX impact and effects
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(nCon));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF) ;

        // 2003-07-08, Georg: Rage Epic Feat Handling
        CheckAndApplyEpicRageFeats(nCon);
        }

        //Rage power stuff starts here
        object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
        object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
        if (!GetIsObjectValid(oWeapon))
        {
            oWeapon = GetItemInSlot(INVENTORY_SLOT_ARMS, oPC);
        }
        int bIdentified = GetIdentified(oArmor);
        SetIdentified(oArmor,FALSE);

        int nAC = -1;
        switch (GetGoldPieceValue(oArmor))
        {
            case    1: nAC = 0; break; // None
            case    5: nAC = 1; break; // Padded
            case   10: nAC = 2; break; // Leather
            case   15: nAC = 3; break; // Studded Leather / Hide
            case  100: nAC = 4; break; // Chain Shirt / Scale Mail
            case  150: nAC = 5; break; // Chainmail / Breastplate
            case  200: nAC = 6; break; // Splint Mail / Banded Mail
            case  600: nAC = 7; break; // Half-Plate
            case 1500: nAC = 8; break; // Full Plate
        }
        // Restore the identified flag, and return armor type.
        SetIdentified(oArmor,bIdentified);

        if(nAC < 6)//Rage powers only work if wearing medium armor or less

        {

            if(GetHasFeat(1319))//Lesser Spirit Totem
            {
                effect eConceal = SupernaturalEffect(EffectConcealment(10));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eConceal, oPC, RoundsToSeconds(nCon));
            }

            if(GetHasFeat(1320))//Spirit Totem
            {
                effect eShield = SupernaturalEffect(EffectDamageShield(nLevel/8, DAMAGE_BONUS_1d4, DAMAGE_TYPE_NEGATIVE));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eShield, oPC, RoundsToSeconds(nCon));
            }

            if(GetHasFeat(1321))//Greater Spirit Totem
            {
                itemproperty ipOnHit=ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER,1);
                IPSafeAddItemProperty(oArmor,ipOnHit, RoundsToSeconds(nCon));
            }

            if(GetHasFeat(1322))//Lesser World Serpent Totem
            {
                effect eMove=SupernaturalEffect(EffectMovementSpeedIncrease(20));
                effect eAC=SupernaturalEffect(EffectACIncrease(nLevel/7));
                effect eDam=SupernaturalEffect(EffectDamageIncrease(nLevel/7,DAMAGE_TYPE_MAGICAL));
                effect eACvsAb=SupernaturalEffect(VersusRacialTypeEffect(eAC,RACIAL_TYPE_ABERRATION));
                effect eACvsOut=SupernaturalEffect(VersusRacialTypeEffect(eAC,RACIAL_TYPE_OUTSIDER));
                effect eDamvsAb=SupernaturalEffect(VersusRacialTypeEffect(eDam,RACIAL_TYPE_ABERRATION));
                effect eDamvsOut=SupernaturalEffect(VersusRacialTypeEffect(eDam,RACIAL_TYPE_OUTSIDER));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eACvsAb, oPC, RoundsToSeconds(nCon));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eACvsOut, oPC, RoundsToSeconds(nCon));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDamvsAb, oPC, RoundsToSeconds(nCon));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDamvsOut, oPC, RoundsToSeconds(nCon));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eMove, oPC, RoundsToSeconds(nCon));
            }

            if(GetHasFeat(1323))//World Serpent Totem
            {
                effect eSav=SupernaturalEffect(EffectSavingThrowIncrease(SAVING_THROW_ALL,nLevel/7));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSav, oPC, RoundsToSeconds(nCon));
            }

            if(GetHasFeat(1324))//Greater World Sepent Totem
            {
                effect eKDImmune=SupernaturalEffect(EffectImmunity(IMMUNITY_TYPE_KNOCKDOWN));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKDImmune, oPC, RoundsToSeconds(nCon));
                effect eTSImmune=SupernaturalEffect(EffectSpellImmunity(SPELL_TIME_STOP));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eTSImmune, oPC, RoundsToSeconds(nCon));
            }

            if(GetHasFeat(1325))//Superstition
            {
                effect eSav=SupernaturalEffect(EffectSavingThrowIncrease(SAVING_THROW_TYPE_SPELL,nLevel/7));
                itemproperty pOnHit=ItemPropertyOnHitProps(IP_CONST_ONHIT_LESSERDISPEL,IP_CONST_ONHIT_SAVEDC_20);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSav, oPC, RoundsToSeconds(nCon));
                IPSafeAddItemProperty(oWeapon, pOnHit, RoundsToSeconds(nCon));
            }

            if(GetHasFeat(1326)|GetHasFeat(1327)|GetHasFeat(1328)|GetHasFeat(1329))//Elemental Totem series
            {
                int iDamageAmount;
                int iDamageType;
                if(GetHasFeat(1326))//Lesser Ice
                {
                    iDamageAmount=DAMAGE_BONUS_1d4;
                    iDamageType=DAMAGE_TYPE_COLD;
                }
                if(GetHasFeat(1327,oPC))//Lesser Fire
                {
                    iDamageAmount=DAMAGE_BONUS_1d4;
                    iDamageType=DAMAGE_TYPE_FIRE;
                }
                if(GetHasFeat(1328,oPC))//Lesser Acid
                {
                    iDamageAmount=DAMAGE_BONUS_1d4;
                    iDamageType=DAMAGE_TYPE_ACID;
                }
                if(GetHasFeat(1329,oPC))//Lesser Lightning
                {
                    iDamageAmount=DAMAGE_BONUS_1d4;
                    iDamageType=DAMAGE_TYPE_ELECTRICAL;
                }

                if(GetHasFeat(1330,oPC))//Ice
                {
                    iDamageAmount=DAMAGE_BONUS_1d8;
                    iDamageType=DAMAGE_TYPE_COLD;
                }
                if(GetHasFeat(1331,oPC))//Fire
                {
                    iDamageAmount=DAMAGE_BONUS_1d8;
                    iDamageType=DAMAGE_TYPE_FIRE;
                }
                if(GetHasFeat(1332,oPC))//Acid
                {
                    iDamageAmount=DAMAGE_BONUS_1d8;
                    iDamageType=DAMAGE_TYPE_ACID;
                }
                if(GetHasFeat(1333,oPC))//Lightning
                {
                    iDamageAmount=DAMAGE_BONUS_1d8;
                    iDamageType=DAMAGE_TYPE_ELECTRICAL;
                }

                if(GetHasFeat(1334,oPC))//Greater Cold
                {
                    iDamageAmount=DAMAGE_BONUS_1d12;
                    iDamageType=DAMAGE_TYPE_COLD;
                }
                if(GetHasFeat(1335,oPC))//Greater Fire
                {
                    iDamageAmount=DAMAGE_BONUS_1d12;
                    iDamageType=DAMAGE_TYPE_FIRE;
                }
                if(GetHasFeat(1336,oPC))//Greater Acid
                {
                    iDamageAmount=DAMAGE_BONUS_1d12;
                    iDamageType=DAMAGE_TYPE_ACID;
                }
                if(GetHasFeat(1337,oPC))//Greater Lightning
                {
                    iDamageAmount=DAMAGE_BONUS_1d12;
                    iDamageType=DAMAGE_TYPE_ELECTRICAL;
                }
                effect iDamage=SupernaturalEffect(EffectDamageIncrease(iDamageAmount,iDamageType));
                //itemproperty ipDamage=ItemPropertyDamageBonus(iDamageType,iDamageAmount);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,iDamage,oPC,RoundsToSeconds(nCon));
            }

           if(GetHasFeat(1338))//Fearless rage
           {
                effect eFearImmune=SupernaturalEffect(EffectImmunity(IMMUNITY_TYPE_FEAR));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFearImmune, oPC, RoundsToSeconds(nCon));
                effect eParImmune=SupernaturalEffect(EffectImmunity(IMMUNITY_TYPE_PARALYSIS));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eParImmune, oPC, RoundsToSeconds(nCon));
           }
           if(GetHasFeat(1339))//Lesser Celestial Totem
           {
                itemproperty ipDamage=ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d4);
                IPSafeAddItemProperty(oWeapon, ipDamage, RoundsToSeconds(nCon));
           }
           if(GetHasFeat(1340))//Celestial Totem
           {
                effect ePoiImmune=SupernaturalEffect(EffectImmunity(IMMUNITY_TYPE_POISON));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoiImmune, oPC, RoundsToSeconds(nCon));
                effect eDisImmune=SupernaturalEffect(EffectImmunity(IMMUNITY_TYPE_DISEASE));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDisImmune, oPC, RoundsToSeconds(nCon));
           }
           if(GetHasFeat(1341))//Greater Celestial Totem
           {
                itemproperty ipLight=ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_BRIGHT,IP_CONST_LIGHTCOLOR_WHITE);
                IPSafeAddItemProperty(oWeapon, ipLight, RoundsToSeconds(nCon));
                itemproperty ipDarkImmune=ItemPropertySpellImmunitySpecific(IP_CONST_IMMUNITYSPELL_DARKNESS);
                IPSafeAddItemProperty(oWeapon, ipLight, RoundsToSeconds(nCon));
                itemproperty ipOnHit=ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER,1);
                IPSafeAddItemProperty(oWeapon,ipOnHit, RoundsToSeconds(nCon));
           }
           if(GetHasFeat(1342))//Lesser beast
           {
                int nBeastSkill=GetLevelByClass(CLASS_TYPE_BARBARIAN,oPC)/2;
                effect eBeastSkill=EffectSkillIncrease(SKILL_ATHLETICS,nBeastSkill);
                eBeastSkill=EffectLinkEffects(EffectSkillIncrease(SKILL_SEARCH,nBeastSkill),eBeastSkill);
                eBeastSkill=EffectLinkEffects(EffectSkillIncrease(SKILL_SURVIVAL,nBeastSkill),eBeastSkill);
                eBeastSkill=SupernaturalEffect(eBeastSkill);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeastSkill,oPC,RoundsToSeconds(nCon));
           }
           if(GetHasFeat(1343))//Beast
           {
                effect eBeastBuff=EffectAttackIncrease(6);
                eBeastBuff=EffectLinkEffects(EffectDamageIncrease(DAMAGE_BONUS_6,DAMAGE_TYPE_BLUDGEONING),eBeastBuff);
                eBeastBuff=EffectLinkEffects(EffectMovementSpeedIncrease(50),eBeastBuff);
                eBeastBuff=SupernaturalEffect(eBeastBuff);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeastBuff,oPC,RoundsToSeconds(nCon));
           }
           if(GetHasFeat(1344))//Greater Beast
           {
                effect eBeastArmor=EffectACIncrease(GetLevelByClass(CLASS_TYPE_BARBARIAN,oPC)/7);
                eBeastArmor=SupernaturalEffect(eBeastArmor);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeastArmor,oPC,RoundsToSeconds(nCon));
           }
           if(GetHasFeat(1345))//No Escape!
           {
                IPSafeAddItemProperty(oWeapon,ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER,nCon), RoundsToSeconds(nCon));
           }
           if(GetHasFeat(1346))//Lesser Fiend Totem
           {
                IPSafeAddItemProperty(oWeapon,ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER,nCon), RoundsToSeconds(nCon));
           }
           if(GetHasFeat(1347))//Fiend Totem
           {
                object oFiendVic = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(oPC), TRUE);
                effect eFiend=EffectSavingThrowDecrease(SAVING_THROW_TYPE_ALL,4);
                eFiend=EffectLinkEffects(eFiend,EffectAttackDecrease(4));
                eFiend=EffectLinkEffects(EffectVisualEffect(VFX_IMP_HEAD_EVIL),eFiend);
                eFiend=SupernaturalEffect(eFiend);
                while(GetIsObjectValid(oFiendVic))
                {
                    if(!GetIsFriend(oFiendVic,oPC))
                    {
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFiend, oFiendVic, RoundsToSeconds(nCon));
                    }
                    oFiendVic=GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(oPC), TRUE);
                }
           }
           if(GetHasFeat(1348))//Greater Fiend Totem
           {
                IPSafeAddItemProperty(oWeapon,ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER,nCon), RoundsToSeconds(nCon));
           }
        }
        //Rage power stuff ends here

    }
}
