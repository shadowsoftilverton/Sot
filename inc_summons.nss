//Summon related wrappers for Shadows of Tilverton
//By Hardcore UFO

#include "x2_i0_spells"
#include "x2_inc_spellhook"
#include "inc_henchmen"
#include "nwnx_funcs"
#include "engine"

//This determines the number of summons the caster can have at one time.
//Also adjusts the chances of the summon being universally hostile.
int DetermineSummonLimit(object oCaster, int nThresh)
{
    int nFocus1 = GetHasFeat(166, oCaster); //If the caster has Spell Focus: Conjuration
    int nFocus2 = GetHasFeat(394, oCaster); //If the caster has Greater Spell Focus: Conjuration
    int nFocus3 = GetHasFeat(611, oCaster); //If the caster has Epic Spell Focus: Conjuration
    int nLimit;

    if(nFocus3 == 1)
    {
        nLimit = 4;
        nThresh = nThresh - 6;
    }

    else if(nFocus2 == 1)
    {
        nLimit = 3;
        nThresh = nThresh - 4;
    }

    else if(nFocus1 == 1)
    {
        nLimit = 2;
        nThresh = nThresh - 2;
    }

    else
    {
        nLimit = 1;
    }

    return nLimit;
}

//Unsummoning at the end of the duration.
void DoUnsummon(object oCreature, float fDuration)
{
    effect eUnsummon = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2, FALSE);
    location lSummon = GetLocation(oCreature);

    DestroyObject(oCreature, fDuration);
    DelayCommand(fDuration, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eUnsummon, lSummon));
}

//Natural scaling of summon power before feats.
void ScaledBoostSummon(object oSummon, object oCaster)
{
    int nBonus = GetHitDice(oCaster) / 10;
    effect eHeal = EffectHeal(GetMaxHitPoints(oSummon));

    int iStr = GetAbilityScore(oSummon, ABILITY_STRENGTH, TRUE) + nBonus;
    int iDex = GetAbilityScore(oSummon, ABILITY_DEXTERITY, TRUE) + nBonus;
    int iCon = GetAbilityScore(oSummon, ABILITY_CONSTITUTION, TRUE) + nBonus;
    int iInt = GetAbilityScore(oSummon, ABILITY_INTELLIGENCE, TRUE) + nBonus;
    int iWis = GetAbilityScore(oSummon, ABILITY_WISDOM, TRUE) + nBonus;
    int iCha = GetAbilityScore(oSummon, ABILITY_CHARISMA, TRUE) + nBonus;

    effect eAC = EffectACIncrease(nBonus, AC_DODGE_BONUS, AC_VS_DAMAGE_TYPE_ALL);
    effect eSaves = EffectSavingThrowIncrease(SAVING_THROW_ALL, nBonus, SAVING_THROW_TYPE_ALL);
    effect eSkill = EffectSkillIncrease(SKILL_ALL_SKILLS, (nBonus * 2));
    eAC = ExtraordinaryEffect(eAC);
    eSaves = ExtraordinaryEffect(eSaves);
    eSkill = ExtraordinaryEffect(eSkill);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAC, oSummon);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSaves, oSummon);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSkill, oSummon);

    SetAbilityScore(oSummon, ABILITY_STRENGTH, iStr);
    SetAbilityScore(oSummon, ABILITY_DEXTERITY, iDex);
    SetAbilityScore(oSummon, ABILITY_CONSTITUTION, iCon);
    SetAbilityScore(oSummon, ABILITY_INTELLIGENCE, iInt);
    SetAbilityScore(oSummon, ABILITY_WISDOM, iWis);
    SetAbilityScore(oSummon, ABILITY_CHARISMA, iCha);

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oSummon);
}

//Augment the summons for a caster with the Augment Summoning feat.
void AugmentSummon(object oSummon, object oCaster, string sConfirm)
{
    if(!TestStringAgainstPattern("IConfirmThisIsASummonedCreature", sConfirm))
    {
        SendMessageToPC(OBJECT_SELF, "That is not an applicable summoned creature.");
        return;
    }

    //If so, apply permanant increases.
    int nCaster = GetHitDice(oCaster);
    int nPerTenBonus = nCaster / 10;
    int nPerFiveBonus = nCaster / 5;

    int iSummonStr = GetAbilityScore(oSummon, ABILITY_STRENGTH, TRUE) + nPerFiveBonus;
    int iSummonDex = GetAbilityScore(oSummon, ABILITY_DEXTERITY, TRUE) + nPerFiveBonus;
    int iSummonCon = GetAbilityScore(oSummon, ABILITY_CONSTITUTION, TRUE) + nPerFiveBonus;
    int iSummonInt = GetAbilityScore(oSummon, ABILITY_INTELLIGENCE, TRUE) + nPerFiveBonus;
    int iSummonWis = GetAbilityScore(oSummon, ABILITY_WISDOM, TRUE) + nPerFiveBonus;
    int iSummonCha = GetAbilityScore(oSummon, ABILITY_CHARISMA, TRUE) + nPerFiveBonus;
    effect eStone = EffectDamageReduction((nCaster / 4), DAMAGE_POWER_PLUS_FOUR, (nCaster * 10));

    if(nCaster >= 20 && nCaster <= 28)
    {
        eStone = EffectDamageReduction((nCaster / 3), DAMAGE_POWER_PLUS_FIVE, (nCaster * 10));
    }

    else if(nCaster >= 29)
    {
        eStone = EffectDamageReduction((nCaster / 2), DAMAGE_POWER_PLUS_SIX, (nCaster * 12));
    }

    effect eAttack = EffectAttackIncrease(nPerTenBonus, ATTACK_BONUS_MISC);
    int nSpell = GetSpellResistance(oSummon);
    effect eSpell = EffectSpellResistanceIncrease(nSpell + nPerFiveBonus);
    effect eDefense = EffectACIncrease(nPerFiveBonus, AC_DODGE_BONUS, AC_VS_DAMAGE_TYPE_ALL);
    effect eSkill = EffectSkillIncrease(SKILL_ALL_SKILLS, nPerFiveBonus);
    eSpell = ExtraordinaryEffect(eSpell);
    eAttack = ExtraordinaryEffect(eAttack);
    eDefense = ExtraordinaryEffect(eDefense);
    eStone = ExtraordinaryEffect(eStone);
    eSkill = ExtraordinaryEffect(eSkill);
    effect eLink = EffectLinkEffects(eDefense, eAttack);
    eLink = EffectLinkEffects(eSpell, eLink);
    eLink = EffectLinkEffects(eSkill, eLink);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oSummon);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eStone, oSummon);
    SetAbilityScore(oSummon, ABILITY_STRENGTH, iSummonStr);
    SetAbilityScore(oSummon, ABILITY_DEXTERITY, iSummonDex);
    SetAbilityScore(oSummon, ABILITY_CONSTITUTION, iSummonCon);
    SetAbilityScore(oSummon, ABILITY_INTELLIGENCE, iSummonInt);
    SetAbilityScore(oSummon, ABILITY_WISDOM, iSummonWis);
    SetAbilityScore(oSummon, ABILITY_CHARISMA, iSummonCha);
}

//Boost the summons of Hierophants with Divine Proxy feats.
void HierophantAugmentSummon(object oSummon, object oCaster)
{
    int hBonus;

    if(GetHasFeat(1585, oCaster)) {hBonus = 6;}          //Greater Divine Proxy
    else if(GetHasFeat(1584, oCaster)) {hBonus = 4;}     //Divine Proxy
    else if(GetHasFeat(1568, oCaster)) {hBonus = 2;}     //Lesser Divine Proxy

    int hStr = GetAbilityScore(oSummon, ABILITY_STRENGTH, TRUE) + hBonus;
    int hDex = GetAbilityScore(oSummon, ABILITY_DEXTERITY, TRUE) + hBonus;
    int hCon = GetAbilityScore(oSummon, ABILITY_CONSTITUTION, TRUE) + hBonus;
    effect hDamage = EffectDamageIncrease(Random(hBonus), DAMAGE_TYPE_DIVINE);
    hDamage = ExtraordinaryEffect(hDamage);

    SetAbilityScore(oSummon, ABILITY_STRENGTH, hStr);
    SetAbilityScore(oSummon, ABILITY_DEXTERITY, hDex);
    SetAbilityScore(oSummon, ABILITY_CONSTITUTION, hCon);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, hDamage, oSummon);
}

//Holding function for Planar Binding spells
void DoPlanarHold(object oTarget, int nDC, int nDur)
{
    //Initialize effects.
    effect eParal = EffectCutsceneParalyze();
    effect eVis = EffectVisualEffect(82);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eDur2 = EffectVisualEffect(VFX_DUR_PARALYZED);
    effect eDur3 = EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);
    effect eDur4 = EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION);

    effect eLink = EffectLinkEffects(eVis, eParal);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eDur2);
    eLink = EffectLinkEffects(eLink, eDur3);
    eLink = EffectLinkEffects(eLink, eDur4);

    //Do we fail our saving throw?
    if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC) && nDur > 0)
    {
        // Explicitly decrement the duration.
        nDur -= 1;
        // Apply the hold effect.
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, 12.0);
        // Delay another check.
        DelayCommand(12.0, DoPlanarHold(oTarget, nDC, nDur));
    }
}

//Rampaging summon alignment check.
//If Good-aligned, it will be annoyed and leave.
//If Neutral or Evil aligned, it will become hostile to everything around it.
void RampageAlignmentCheck(object oSummon, string sOneLiner)
{
    if(GetGoodEvilValue(oSummon) > 65)
    {
        AssignCommand(oSummon, ActionSpeakString(sOneLiner, TALKVOLUME_TALK));
        DoUnsummon(oSummon, 1.1f);
    }
}

//The summons for various themes. Some themes only affect Summon Creature, others only
//affect the Planar Bindings, and others affect both.
string DetermineSummonedCreature(int nSpellID, location lLocation, object oCaster)
{
    int nFNF_Effect;
    string sSummon;
    int nAlign = GetGoodEvilValue(oCaster);
    int nTheme = GetLocalInt(oCaster, "SummonTheme");

    if(nTheme == 0) //----------------------------------- DEFAULT: MAGICAL BEAST
    {
        switch(nSpellID)
        {
            case SPELL_SUMMON_CREATURE_I:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_magb_01";
                break;
            case SPELL_SUMMON_CREATURE_II:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_magb_02";
                break;
            case SPELL_SUMMON_CREATURE_III:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                if(nAlign >= 66) {sSummon = "sm_magb_03";}
                else if(nAlign >= 33 && nAlign <= 65) {sSummon = "sm_magb_03n";}
                else if(nAlign <= 32) {sSummon = "sm_magb_03e";}
                break;
            case SPELL_SUMMON_CREATURE_IV:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_rept_04";
                break;
            case SPELL_SUMMON_CREATURE_V:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_magb_05";
                break;
            case SPELL_SUMMON_CREATURE_VI:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                if(nAlign >= 66) {sSummon = "sm_magb_06g";}
                else if(nAlign >= 33 && nAlign <= 65) {sSummon = "sm_magb_06n";}
                else if(nAlign <= 32) {sSummon = "sm_magb_06";}
                break;
            case SPELL_SUMMON_CREATURE_VII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                if(nAlign >= 66) {sSummon = "sm_magb_07g";}
                else if(nAlign >= 33 && nAlign <= 65) {sSummon = "sm_magb_07n";}
                else if(nAlign <= 32) {sSummon = "sm_magb_07";}
                break;
            case SPELL_SUMMON_CREATURE_VIII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_magb_08";
                break;
            case SPELL_SUMMON_CREATURE_IX:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_magb_09";
                break;

                //-------------------------//

            case SPELL_LESSER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_magb_11";
                break;
            case SPELL_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_magb_12n";
                break;
            case SPELL_PLANAR_ALLY:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_magb_12n";
                break;
            case SPELL_GREATER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                if(nAlign >= 66) {sSummon = "sm_magb_13g";}
                else if(nAlign >= 33 && nAlign <= 65) {sSummon = "sm_magb_13n";}
                else if(nAlign <= 32) {sSummon = "sm_magb_13e";}
                break;
            case SPELL_GATE:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_magb_14n";
                break;

                //-------------------------//

            default:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_norm_01";
                break;
        }
    }

    if(nTheme == 1) //----------------------------------------------------- FIRE
    {
        switch(nSpellID)
        {
            case SPELL_SUMMON_CREATURE_I:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_fire_01";
                break;
            case SPELL_SUMMON_CREATURE_II:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_fire_02";
                break;
            case SPELL_SUMMON_CREATURE_III:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_fire_03";
                break;
            case SPELL_SUMMON_CREATURE_IV:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_fire_04";
                break;
            case SPELL_SUMMON_CREATURE_V:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_fire_05";
                break;
            case SPELL_SUMMON_CREATURE_VI:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_fire_06";
                break;
            case SPELL_SUMMON_CREATURE_VII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_fire_07";
                break;
            case SPELL_SUMMON_CREATURE_VIII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_fire_08";
                break;
            case SPELL_SUMMON_CREATURE_IX:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_fire_09";
                break;

                //-------------------------//

            case SPELL_LESSER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_fire_11";
                break;
            case SPELL_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_fire_12";
                break;
            case SPELL_PLANAR_ALLY:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_fire_12";
                break;
            case SPELL_GREATER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_fire_13";
                break;
            case SPELL_GATE:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_fire_14";
                break;

                //-------------------------//

            default:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_fire_01";
                break;
        }
    }

    if(nTheme == 2) //------------------------------------------------------ AIR
    {
        switch(nSpellID)
        {
            case SPELL_SUMMON_CREATURE_I:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_wind_01";
                break;
            case SPELL_SUMMON_CREATURE_II:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_wind_02";
                break;
            case SPELL_SUMMON_CREATURE_III:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_wind_03";
                break;
            case SPELL_SUMMON_CREATURE_IV:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_wind_04";
                break;
            case SPELL_SUMMON_CREATURE_V:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_wind_05";
                break;
            case SPELL_SUMMON_CREATURE_VI:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_wind_06";
                break;
            case SPELL_SUMMON_CREATURE_VII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_wind_07";
                break;
            case SPELL_SUMMON_CREATURE_VIII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_wind_08";
                break;
            case SPELL_SUMMON_CREATURE_IX:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_wind_09";
                break;

                //-------------------------//

            case SPELL_LESSER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_wind_11";
                break;
            case SPELL_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_wind_12";
                break;
            case SPELL_PLANAR_ALLY:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_wind_12";
                break;
            case SPELL_GREATER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_wind_13";
                break;
            case SPELL_GATE:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_wind_14";
                break;

                //-------------------------//

            default:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_wind_01";
                break;
        }
    }

    if(nTheme == 3) //---------------------------------------------------- WATER
    {
        switch(nSpellID)
        {
            case SPELL_SUMMON_CREATURE_I:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_watr_01";
                break;
            case SPELL_SUMMON_CREATURE_II:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_watr_02";
                break;
            case SPELL_SUMMON_CREATURE_III:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_watr_03";
                break;
            case SPELL_SUMMON_CREATURE_IV:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_watr_04";
                break;
            case SPELL_SUMMON_CREATURE_V:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_watr_05";
                break;
            case SPELL_SUMMON_CREATURE_VI:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_watr_06";
                break;
            case SPELL_SUMMON_CREATURE_VII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_watr_07";
                break;
            case SPELL_SUMMON_CREATURE_VIII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_watr_08";
                break;
            case SPELL_SUMMON_CREATURE_IX:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_watr_09";
                break;

                //-------------------------//

            case SPELL_LESSER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_watr_11";
                break;
            case SPELL_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_watr_12";
                break;
            case SPELL_PLANAR_ALLY:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_watr_12";
                break;
            case SPELL_GREATER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_watr_13";
                break;
            case SPELL_GATE:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_watr_14";
                break;

                //-------------------------//

            default:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_watr_01";
                break;
        }
    }

    if(nTheme == 4) //---------------------------------------------------- EARTH
    {
        switch(nSpellID)
        {
            case SPELL_SUMMON_CREATURE_I:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_erth_01";
                break;
            case SPELL_SUMMON_CREATURE_II:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_erth_02";
                break;
            case SPELL_SUMMON_CREATURE_III:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_erth_03";
                break;
            case SPELL_SUMMON_CREATURE_IV:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_erth_04";
                break;
            case SPELL_SUMMON_CREATURE_V:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_erth_05";
                break;
            case SPELL_SUMMON_CREATURE_VI:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_erth_06";
                break;
            case SPELL_SUMMON_CREATURE_VII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_erth_07";
                break;
            case SPELL_SUMMON_CREATURE_VIII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_erth_08";
                break;
            case SPELL_SUMMON_CREATURE_IX:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_erth_09";
                break;

                //-------------------------//

            case SPELL_LESSER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_erth_11";
                break;
            case SPELL_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_erth_12";
                break;
            case SPELL_PLANAR_ALLY:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_erth_12";
                break;
            case SPELL_GREATER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_erth_13";
                break;
            case SPELL_GATE:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_erth_14";
                break;

                //-------------------------//

            default:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_erth_01";
                break;
        }
    }

    if(nTheme == 5) //--------------------------------------------------- MAMMAL
    {
        switch(nSpellID)
        {
            case SPELL_SUMMON_CREATURE_I:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_anim_01";
                break;
            case SPELL_SUMMON_CREATURE_II:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_anim_02";
                break;
            case SPELL_SUMMON_CREATURE_III:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_anim_03";
                break;
            case SPELL_SUMMON_CREATURE_IV:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_anim_04";
                break;
            case SPELL_SUMMON_CREATURE_V:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_anim_05";
                break;
            case SPELL_SUMMON_CREATURE_VI:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_anim_06";
                break;
            case SPELL_SUMMON_CREATURE_VII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_anim_07";
                break;
            case SPELL_SUMMON_CREATURE_VIII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_anim_08";
                break;
            case SPELL_SUMMON_CREATURE_IX:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_anim_09";
                break;

                //-------------------------//

            case SPELL_LESSER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_anim_11";
                break;
            case SPELL_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_anim_12";
                break;
            case SPELL_PLANAR_ALLY:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_anim_12";
                break;
            case SPELL_GREATER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_anim_13";
                break;
            case SPELL_GATE:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_anim_14";
                break;

                //-------------------------//

            default:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_anim_01";
                break;
        }
    }

    if(nTheme == 6) //-------------------------------------------------- REPTILE
    {
        switch(nSpellID)
        {
            case SPELL_SUMMON_CREATURE_I:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_rept_01";
                break;
            case SPELL_SUMMON_CREATURE_II:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_rept_02";
                break;
            case SPELL_SUMMON_CREATURE_III:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_rept_03";
                break;
            case SPELL_SUMMON_CREATURE_IV:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_rept_04";
                break;
            case SPELL_SUMMON_CREATURE_V:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_rept_05";
                break;
            case SPELL_SUMMON_CREATURE_VI:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_rept_06";
                break;
            case SPELL_SUMMON_CREATURE_VII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_rept_07";
                break;
            case SPELL_SUMMON_CREATURE_VIII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_rept_08";
                break;
            case SPELL_SUMMON_CREATURE_IX:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_rept_09";
                break;

                //-------------------------//

            case SPELL_LESSER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_rept_11";
                break;
            case SPELL_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_rept_12";
                break;
            case SPELL_PLANAR_ALLY:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_rept_12";
                break;
            case SPELL_GREATER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_rept_13";
                break;
            case SPELL_GATE:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_rept_14";
                break;

                //-------------------------//

            default:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_rept_01";
                break;
        }
    }

    if(nTheme == 7) //--------------------------------------------------- INSECT
    {
        switch(nSpellID)
        {
            case SPELL_SUMMON_CREATURE_I:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_sect_01";
                break;
            case SPELL_SUMMON_CREATURE_II:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_sect_02";
                break;
            case SPELL_SUMMON_CREATURE_III:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_sect_03";
                break;
            case SPELL_SUMMON_CREATURE_IV:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_sect_04";
                break;
            case SPELL_SUMMON_CREATURE_V:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_sect_05";
                break;
            case SPELL_SUMMON_CREATURE_VI:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_sect_06";
                break;
            case SPELL_SUMMON_CREATURE_VII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_sect_07";
                break;
            case SPELL_SUMMON_CREATURE_VIII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_sect_08";
                break;
            case SPELL_SUMMON_CREATURE_IX:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_sect_09";
                break;

                //-------------------------//

            case SPELL_LESSER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_sect_11";
                break;
            case SPELL_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_sect_12";
                break;
            case SPELL_PLANAR_ALLY:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_sect_12";
                break;
            case SPELL_GREATER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_sect_13";
                break;
            case SPELL_GATE:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_sect_14";
                break;

                //-------------------------//

            default:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_sect_01";
                break;
        }
    }

    if(nTheme == 8) //---------------------------------------------------- PLANT
    {
        switch(nSpellID)
        {
            case SPELL_SUMMON_CREATURE_I:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_plnt_01";
                break;
            case SPELL_SUMMON_CREATURE_II:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_plnt_02";
                break;
            case SPELL_SUMMON_CREATURE_III:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_plnt_03";
                break;
            case SPELL_SUMMON_CREATURE_IV:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_plnt_04";
                break;
            case SPELL_SUMMON_CREATURE_V:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_plnt_05";
                break;
            case SPELL_SUMMON_CREATURE_VI:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_plnt_06";
                break;
            case SPELL_SUMMON_CREATURE_VII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_plnt_07";
                break;
            case SPELL_SUMMON_CREATURE_VIII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_plnt_08";
                break;
            case SPELL_SUMMON_CREATURE_IX:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_plnt_09";
                break;

                //-------------------------//

            case SPELL_LESSER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_plnt_11";
                break;
            case SPELL_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_plnt_12";
                break;
            case SPELL_PLANAR_ALLY:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_plnt_12";
                break;
            case SPELL_GREATER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_plnt_13";
                break;
            case SPELL_GATE:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_plnt_14";
                break;

                //-------------------------//

            default:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_plnt_01";
                break;
        }
    }

    if(nTheme == 9) //-------------------------------------------- PENDING NO USE YET
    {
        switch(nSpellID)
        {
            case SPELL_SUMMON_CREATURE_I:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_magb_01";
                break;
            case SPELL_SUMMON_CREATURE_II:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_magb_02";
                break;
            case SPELL_SUMMON_CREATURE_III:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_magb_03";
                break;
            case SPELL_SUMMON_CREATURE_IV:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_magb_04";
                break;
            case SPELL_SUMMON_CREATURE_V:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_magb_05";
                break;
            case SPELL_SUMMON_CREATURE_VI:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_magb_06";
                break;
            case SPELL_SUMMON_CREATURE_VII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_magb_07";
                break;
            case SPELL_SUMMON_CREATURE_VIII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_magb_08";
                break;
            case SPELL_SUMMON_CREATURE_IX:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_magb_09";
                break;

                //-------------------------//

            case SPELL_LESSER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_norm_11";
                break;
            case SPELL_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_norm_12";
                break;
            case SPELL_PLANAR_ALLY:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_norm_12";
                break;
            case SPELL_GREATER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_norm_13";
                break;
            case SPELL_GATE:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_norm_14";
                break;

                //-------------------------//

            default:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_magb_01";
                break;
        }
    }

    if(nTheme == 10) //----------------------------------------------- UNDERDARK
    {
        switch(nSpellID)
        {
            case SPELL_SUMMON_CREATURE_I:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_undk_01";
                break;
            case SPELL_SUMMON_CREATURE_II:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_undk_02";
                break;
            case SPELL_SUMMON_CREATURE_III:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_undk_03";
                break;
            case SPELL_SUMMON_CREATURE_IV:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_undk_04";
                break;
            case SPELL_SUMMON_CREATURE_V:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_undk_05";
                break;
            case SPELL_SUMMON_CREATURE_VI:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_undk_06";
                break;
            case SPELL_SUMMON_CREATURE_VII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_undk_07";
                break;
            case SPELL_SUMMON_CREATURE_VIII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_undk_08";
                break;
            case SPELL_SUMMON_CREATURE_IX:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_undk_09";
                break;

                //-------------------------//

            case SPELL_LESSER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_norm_11";
                break;
            case SPELL_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_norm_12";
                break;
            case SPELL_PLANAR_ALLY:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_norm_12";
                break;
            case SPELL_GREATER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_norm_13";
                break;
            case SPELL_GATE:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_norm_14";
                break;

                //-------------------------//

            default:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_undk_01";
                break;
        }
    }

    if(nTheme == 11) //--------------------------------------------------- DEMON
    {
        switch(nSpellID)
        {
            case SPELL_SUMMON_CREATURE_I:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_norm_01";
                break;
            case SPELL_SUMMON_CREATURE_II:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_norm_02";
                break;
            case SPELL_SUMMON_CREATURE_III:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_norm_03";
                break;
            case SPELL_SUMMON_CREATURE_IV:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_norm_04";
                break;
            case SPELL_SUMMON_CREATURE_V:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_norm_05";
                break;
            case SPELL_SUMMON_CREATURE_VI:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_norm_06";
                break;
            case SPELL_SUMMON_CREATURE_VII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_norm_07";
                break;
            case SPELL_SUMMON_CREATURE_VIII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_norm_08";
                break;
            case SPELL_SUMMON_CREATURE_IX:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_norm_09";
                break;

                //-------------------------//

            case SPELL_LESSER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_demn_11";
                break;
            case SPELL_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_demn_12";
                break;
            case SPELL_PLANAR_ALLY:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_demn_12";
                break;
            case SPELL_GREATER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_demn_13";
                break;
            case SPELL_GATE:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_demn_14";
                break;

                //-------------------------//

            default:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_norm_01";
                break;
        }
    }

    if(nTheme == 12) //--------------------------------------------------- DEVIL
    {
        switch(nSpellID)
        {
            case SPELL_SUMMON_CREATURE_I:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_norm_01";
                break;
            case SPELL_SUMMON_CREATURE_II:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_norm_02";
                break;
            case SPELL_SUMMON_CREATURE_III:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_norm_03";
                break;
            case SPELL_SUMMON_CREATURE_IV:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_norm_04";
                break;
            case SPELL_SUMMON_CREATURE_V:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_norm_05";
                break;
            case SPELL_SUMMON_CREATURE_VI:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_norm_06";
                break;
            case SPELL_SUMMON_CREATURE_VII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_norm_07";
                break;
            case SPELL_SUMMON_CREATURE_VIII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_norm_08";
                break;
            case SPELL_SUMMON_CREATURE_IX:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_norm_09";
                break;

                //-------------------------//

            case SPELL_LESSER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_devl_11";
                break;
            case SPELL_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_devl_12";
                break;
            case SPELL_PLANAR_ALLY:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_devl_12";
                break;
            case SPELL_GREATER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_devl_13";
                break;
            case SPELL_GATE:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_devl_14";
                break;

                //-------------------------//

            default:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_norm_01";
                break;
        }
    }

    if(nTheme == 13) //------------------------------------------------- ELADRIN
    {
        switch(nSpellID)
        {
            case SPELL_SUMMON_CREATURE_I:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_norm_01";
                break;
            case SPELL_SUMMON_CREATURE_II:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_norm_02";
                break;
            case SPELL_SUMMON_CREATURE_III:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_norm_03";
                break;
            case SPELL_SUMMON_CREATURE_IV:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_norm_04";
                break;
            case SPELL_SUMMON_CREATURE_V:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_norm_05";
                break;
            case SPELL_SUMMON_CREATURE_VI:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_norm_06";
                break;
            case SPELL_SUMMON_CREATURE_VII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_norm_07";
                break;
            case SPELL_SUMMON_CREATURE_VIII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_norm_08";
                break;
            case SPELL_SUMMON_CREATURE_IX:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_norm_09";
                break;

                //-------------------------//

            case SPELL_LESSER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_elad_11";
                break;
            case SPELL_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_elad_12";
                break;
            case SPELL_PLANAR_ALLY:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_elad_12";
                break;
            case SPELL_GREATER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_wind_13";
                break;
            case SPELL_GATE:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_elad_14";
                break;

                //-------------------------//

            default:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_norm_01";
                break;
        }
    }

    if(nTheme == 14) //-------------------------------------------------- ARCHON
    {
        switch(nSpellID)
        {
            case SPELL_SUMMON_CREATURE_I:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_norm_01";
                break;
            case SPELL_SUMMON_CREATURE_II:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_norm_02";
                break;
            case SPELL_SUMMON_CREATURE_III:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_norm_03";
                break;
            case SPELL_SUMMON_CREATURE_IV:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_norm_04";
                break;
            case SPELL_SUMMON_CREATURE_V:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_norm_05";
                break;
            case SPELL_SUMMON_CREATURE_VI:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_norm_06";
                break;
            case SPELL_SUMMON_CREATURE_VII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_norm_07";
                break;
            case SPELL_SUMMON_CREATURE_VIII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_norm_08";
                break;
            case SPELL_SUMMON_CREATURE_IX:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_norm_09";
                break;

                //-------------------------//

            case SPELL_LESSER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_arch_11";
                break;
            case SPELL_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_arch_12";
                break;
            case SPELL_PLANAR_ALLY:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_arch_12";
                break;
            case SPELL_GREATER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_arch_13";
                break;
            case SPELL_GATE:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_arch_14";
                break;

                //-------------------------//

            default:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_norm_01";
                break;
        }
    }

    if(nTheme == 15) //--------------------------------------------------- CHAOS
    {
        switch(nSpellID)
        {
            case SPELL_SUMMON_CREATURE_I:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_norm_01";
                break;
            case SPELL_SUMMON_CREATURE_II:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_norm_02";
                break;
            case SPELL_SUMMON_CREATURE_III:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_norm_03";
                break;
            case SPELL_SUMMON_CREATURE_IV:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_norm_04";
                break;
            case SPELL_SUMMON_CREATURE_V:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_norm_05";
                break;
            case SPELL_SUMMON_CREATURE_VI:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_norm_06";
                break;
            case SPELL_SUMMON_CREATURE_VII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_norm_07";
                break;
            case SPELL_SUMMON_CREATURE_VIII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_norm_08";
                break;
            case SPELL_SUMMON_CREATURE_IX:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_norm_09";
                break;

                //-------------------------//

            case SPELL_LESSER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_caos_11";
                break;
            case SPELL_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_caos_12";
                break;
            case SPELL_PLANAR_ALLY:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_caos_12";
                break;
            case SPELL_GREATER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_caos_13";
                break;
            case SPELL_GATE:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_caos_14";
                break;

                //-------------------------//

            default:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_norm_01";
                break;
        }
    }

    if(nTheme == 16) //----------------------------------------------------- LAW
    {
        switch(nSpellID)
        {
            case SPELL_SUMMON_CREATURE_I:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_norm_01";
                break;
            case SPELL_SUMMON_CREATURE_II:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_norm_02";
                break;
            case SPELL_SUMMON_CREATURE_III:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_norm_03";
                break;
            case SPELL_SUMMON_CREATURE_IV:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_norm_04";
                break;
            case SPELL_SUMMON_CREATURE_V:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_norm_05";
                break;
            case SPELL_SUMMON_CREATURE_VI:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "sm_norm_06";
                break;
            case SPELL_SUMMON_CREATURE_VII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_norm_07";
                break;
            case SPELL_SUMMON_CREATURE_VIII:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_norm_08";
                break;
            case SPELL_SUMMON_CREATURE_IX:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "sm_norm_09";
                break;

                //-------------------------//

            case SPELL_LESSER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_laws_11";
                break;
            case SPELL_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_laws_12";
                break;
            case SPELL_PLANAR_ALLY:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_laws_12";
                break;
            case SPELL_GREATER_PLANAR_BINDING:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_laws_13";
                break;
            case SPELL_GATE:
                nFNF_Effect = VFX_FNF_GAS_EXPLOSION_GREASE;
                sSummon = "sm_laws_14";
                break;

                //-------------------------//

            default:
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "sm_norm_01";
                break;
        }
    }

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(nFNF_Effect) , lLocation);
    return sSummon;
}
