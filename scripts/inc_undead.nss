#include "engine"

//--------------Undead Creation System and assorted functions-----------------//
//---------------------Created By Invictus 2012-06-03-------------------------//

#include "nwnx_funcs"
#include "x2_inc_spellhook"

//----------------------------------------------------------------------------//

const int CORPSE_CRAFTER_STR_BONUS = 2;
const int CORPSE_CRAFTER_HP_BONUS = 4;
const int BOLSTER_RESISTANCE_BONUS = 6;      // +6 to Turn resist
const int HARDENED_FLESH_BONUS = 4;

//----------------------------------------------------------------------------//

void ApplyCorpseCrafterBonuses(object oUndead, object oCaster);
void ApplyBolsterResistanceBonuses(object oUndead, object oCaster);
void ApplyDeadlyChillBonuses(object oUndead, object oCaster);
void ApplyDestructionRetributionBonuses(object oUndead, object oCaster);
void ApplyHardenedFleshBonuses(object oUndead, object oCaster);
void ApplyNimbleBonesBonuses(object oUndead, object oCaster);
void DestructionRetributionAction(object oUndead);
string DetermineUndeadCreature(int nSpellID, location lLocation, object oCaster);

//----------------------------------------------------------------------------//

void ApplyCorpseCrafterBonuses(object oUndead, object oCaster) {
    SetAbilityScore(oUndead, ABILITY_STRENGTH, GetAbilityScore(oUndead, ABILITY_STRENGTH, TRUE) + ((GetCasterLevel(oCaster) / 5) * CORPSE_CRAFTER_STR_BONUS));
    SetMaxHitPoints(oUndead, GetMaxHitPoints(oUndead) + (GetHitDice(oUndead) * CORPSE_CRAFTER_HP_BONUS));
    SetCurrentHitPoints(oUndead, GetMaxHitPoints(oUndead));
}

void ApplyBolsterResistanceBonuses(object oUndead, object oCaster) {
    SetLocalInt(oUndead, "UndeadSys_BolsterResistance", BOLSTER_RESISTANCE_BONUS);
}

void ApplyDeadlyChillBonuses(object oUndead, object oCaster) {
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oUndead);
    object oCWeaponR = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oUndead);
    object oCWeaponL = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oUndead);
    object oCWeaponB = GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oUndead);

    if(IPGetIsMeleeWeapon(oWeapon) || IPGetIsRangedWeapon(oWeapon)) {
        IPSafeAddItemProperty(oWeapon, ItemPropertyVisualEffect(ITEM_VISUAL_COLD), HoursToSeconds(GetCasterLevel(oCaster)), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
        IPSafeAddItemProperty(oWeapon, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_COLD, IP_CONST_DAMAGEBONUS_1d6), HoursToSeconds(GetCasterLevel(oCaster)), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
    } else {
        if(oCWeaponR != OBJECT_INVALID) {
            IPSafeAddItemProperty(oCWeaponR, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_COLD, IP_CONST_DAMAGEBONUS_1d6), HoursToSeconds(GetCasterLevel(oCaster)), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
        } else if(oCWeaponL != OBJECT_INVALID) {
            IPSafeAddItemProperty(oCWeaponL, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_COLD, IP_CONST_DAMAGEBONUS_1d6), HoursToSeconds(GetCasterLevel(oCaster)), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
        } else if(oCWeaponB != OBJECT_INVALID) {
            IPSafeAddItemProperty(oCWeaponB, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_COLD, IP_CONST_DAMAGEBONUS_1d6), HoursToSeconds(GetCasterLevel(oCaster)), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
        } else {
            // Creature has no weapons.
        }
    }
}

void ApplyDestructionRetributionBonuses(object oUndead, object oCaster) {
    SetLocalInt(oUndead, "UndeadSys_DestructionRetribution", 1);
}

void ApplyHardenedFleshBonuses(object oUndead, object oCaster) {
    ModifyACNaturalBase(oUndead, HARDENED_FLESH_BONUS);
}

void ApplyNimbleBonesBonuses(object oUndead, object oCaster) {
    effect eMovementIncrease = EffectMovementSpeedIncrease(20);
    eMovementIncrease = SupernaturalEffect(eMovementIncrease);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eMovementIncrease, oUndead);
}


void DestructionRetributionAction(object oUndead) {
    //Declare major variables
    int nDamage;
    float fDelay;
    effect eVis = EffectVisualEffect(VFX_IMP_HEALING_M);
    effect eVis2 = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eHowl;
    int nHD = GetHitDice(oUndead);
    int nDC = 10 + nHD;
    effect eImpact = EffectVisualEffect(VFX_IMP_PULSE_NEGATIVE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oUndead);
    //Get first target in spell area
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetLocation(oUndead));
    while(GetIsObjectValid(oTarget))
    {
        if(oTarget != oUndead)
        {
            //Determine effect delay
            fDelay = GetDistanceBetween(oUndead, oTarget)/20;
            //Roll the amount to heal or damage
            nDamage = d4(nHD);
            //If the target is undead
            if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
            {
                //Make a faction check
                if(GetIsFriend(oTarget))
                {
                    //Fire cast spell at event for the specified target
                    SignalEvent(oTarget, EventSpellCastAt(oUndead, SPELLABILITY_PULSE_HOLY, FALSE));
                    //Set heal effect
                    eHowl = EffectHeal(nDamage);
                    //Apply the VFX impact and effects
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHowl, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
            }
            else
            {
                if(!GetIsReactionTypeFriendly(oTarget) && GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
                {
                    //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
                    nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC, SAVING_THROW_TYPE_NEGATIVE);
                    //Set damage effect
                    eHowl = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
                    if(nDamage > 0)
                    {
                        //Fire cast spell at event for the specified target
                        SignalEvent(oTarget, EventSpellCastAt(oUndead, SPELLABILITY_PULSE_HOLY));
                        //Apply the VFX impact and effects
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHowl, oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
                    }
                }
            }
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetLocation(oUndead));
    }
}

int DetermineUndeadLimit(object oCaster, int nThresh)
{
    int nFocus1 = GetHasFeat(171, oCaster); //If the caster has Spell Focus: Necromancy
    int nFocus2 = GetHasFeat(399, oCaster); //If the caster has Greater Spell Focus: Necromancy
    int nFocus3 = GetHasFeat(616, oCaster); //If the caster has Epic Spell Focus: Necromancy
    int nLimit;

    if(nFocus3 == 1) {
        nLimit = 4;
        nThresh = nThresh - 6;
    } else if(nFocus2 == 1) {
        nLimit = 3;
        nThresh = nThresh - 4;
    } else if(nFocus1 == 1) {
        nLimit = 2;
        nThresh = nThresh - 2;
    } else
        nLimit = 1;

    return nLimit;
}


string DetermineUndeadCreature(int nSpellID, location lLocation, object oCaster) {
    int nFNF_Effect;
    string sSummon;
    int nTheme = GetLocalInt(oCaster, "UndeadTheme");
    int nCasterLevel = GetCasterLevel(oCaster);

    if(nTheme == 0) { //------------------------------------------------ DEFAULT
        switch(nSpellID) {
            case SPELL_ANIMATE_DEAD:
                nFNF_Effect = VFX_FNF_SUMMON_UNDEAD;

                if     (nCasterLevel <= 5) sSummon = "dt_tyfog";
                else if(nCasterLevel <= 9) sSummon = "dt_skelwar001";
                else                       sSummon = "dt_skelchief";

                break;
            case SPELL_CREATE_UNDEAD:
                nFNF_Effect = VFX_FNF_SUMMON_UNDEAD;

                if     (nCasterLevel <= 11) sSummon = "dt_ghoul1";
                else if(nCasterLevel <= 13) sSummon = "dt_mohrg";
                else if(nCasterLevel <= 15) sSummon = "dt_wheep";
                else                        sSummon = "dt_spectre";

                break;
            case SPELL_CREATE_GREATER_UNDEAD:
                nFNF_Effect = VFX_FNF_SUMMON_UNDEAD;

                if     (nCasterLevel <= 15) sSummon = "dt_vampar";
                else if(nCasterLevel <= 17) sSummon = "dt_doomknight";
                else if(nCasterLevel <= 19) sSummon = "dt_lich";
                else                        sSummon = "dt_mumpriest";

                break;

                //-------------------------//

            default:
                nFNF_Effect = VFX_FNF_SUMMON_UNDEAD;
                sSummon = "NW_S_ZOMBTYRANT";
                break;
        }
    }

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(nFNF_Effect) , lLocation);
    return sSummon;
}
