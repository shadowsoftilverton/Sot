/*/
    Horse Post-Dismount script
    by Hardcore UFO
    Caller is the rider as per x3_inc_horse
    Removes boni
/*/

#include "engine"
#include "x2_inc_switches"
#include "inc_henchmen"
#include "x3_inc_horse"
#include "x3_inc_skin"
#include "aps_include"
#include "inc_nametag"

void main()
{
    SetSkinInt(OBJECT_SELF, "bX3_IS_MOUNTED", FALSE);

    object oHorse = HorseGetMyHorse(OBJECT_SELF);
    //GetLocalObject(OBJECT_SELF, "oX3_TempHorse");
    effect eHorseEffect = GetFirstEffect(OBJECT_SELF);
    int nDiscipline = GetPersistentInt(OBJECT_SELF, "RiderBaseDiscipline");

    SetSkillRank(OBJECT_SELF, SKILL_DISCIPLINE, nDiscipline);

    while(GetIsEffectValid(eHorseEffect))
    {
        if((GetEffectType(eHorseEffect) == EFFECT_TYPE_SKILL_DECREASE) &&
        (GetEffectSubType(eHorseEffect) == SUBTYPE_SUPERNATURAL) &&
        (GetEffectDurationType(eHorseEffect) == DURATION_TYPE_PERMANENT))
        {
            RemoveEffect(OBJECT_SELF, eHorseEffect);
        }

        else if((GetEffectType(eHorseEffect) == EFFECT_TYPE_MOVEMENT_SPEED_INCREASE) &&
        (GetEffectSubType(eHorseEffect) == SUBTYPE_SUPERNATURAL) &&
        (GetEffectDurationType(eHorseEffect) == DURATION_TYPE_PERMANENT))
        {
            RemoveEffect(OBJECT_SELF, eHorseEffect);
        }

        else if((GetEffectType(eHorseEffect) == EFFECT_TYPE_AC_INCREASE) &&
        (GetEffectSubType(eHorseEffect) == SUBTYPE_SUPERNATURAL) &&
        (GetEffectDurationType(eHorseEffect) == DURATION_TYPE_PERMANENT))
        {
            RemoveEffect(OBJECT_SELF, eHorseEffect);
        }

        else if((GetEffectType(eHorseEffect) == EFFECT_TYPE_AC_DECREASE) &&
        (GetEffectSubType(eHorseEffect) == SUBTYPE_SUPERNATURAL) &&
        (GetEffectDurationType(eHorseEffect) == DURATION_TYPE_PERMANENT))
        {
            RemoveEffect(OBJECT_SELF, eHorseEffect);
        }

        else if((GetEffectType(eHorseEffect) == EFFECT_TYPE_DAMAGE_IMMUNITY_INCREASE) &&
        (GetEffectSubType(eHorseEffect) == SUBTYPE_SUPERNATURAL) &&
        (GetEffectDurationType(eHorseEffect) == DURATION_TYPE_PERMANENT))
        {
            RemoveEffect(OBJECT_SELF, eHorseEffect);
        }

        else if((GetEffectType(eHorseEffect) == EFFECT_TYPE_DAMAGE_INCREASE) &&
        (GetEffectSubType(eHorseEffect) == SUBTYPE_SUPERNATURAL) &&
        (GetEffectDurationType(eHorseEffect) == DURATION_TYPE_PERMANENT))
        {
            RemoveEffect(OBJECT_SELF, eHorseEffect);
        }

        else if((GetEffectType(eHorseEffect) == EFFECT_TYPE_TEMPORARY_HITPOINTS) &&
        (GetEffectDurationType(eHorseEffect) == DURATION_TYPE_PERMANENT))
        {
            RemoveEffect(OBJECT_SELF, eHorseEffect);
        }

        else if((GetEffectType(eHorseEffect) == EFFECT_TYPE_DAMAGE_INCREASE) &&
        (GetEffectSubType(eHorseEffect) == SUBTYPE_SUPERNATURAL) &&
        (GetEffectDurationType(eHorseEffect) == DURATION_TYPE_PERMANENT))
        {
            RemoveEffect(OBJECT_SELF, eHorseEffect);
        }

        else if((GetEffectType(eHorseEffect) == EFFECT_TYPE_ATTACK_INCREASE) &&
        (GetEffectSubType(eHorseEffect) == SUBTYPE_SUPERNATURAL) &&
        (GetEffectDurationType(eHorseEffect) == DURATION_TYPE_PERMANENT))
        {
            RemoveEffect(OBJECT_SELF, eHorseEffect);
        }

        else if((GetEffectType(eHorseEffect) == EFFECT_TRUETYPE_MODIFYNUMATTACKS) &&
        (GetEffectSubType(eHorseEffect) == SUBTYPE_SUPERNATURAL) &&
        (GetEffectDurationType(eHorseEffect) == DURATION_TYPE_PERMANENT))
        {
            RemoveEffect(OBJECT_SELF, eHorseEffect);
        }

        eHorseEffect = GetNextEffect(OBJECT_SELF);
    }

    DeleteLocalObject(OBJECT_SELF, "oX3_TempHorse");

    //If the horse has died from too much damage.
    if(GetCurrentHitPoints(OBJECT_SELF) < (GetMaxHitPoints(OBJECT_SELF) * 10) / 100)
    {
        effect eKillHorse = EffectDamage(1000);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eKillHorse, oHorse);
        FloatingTextStringOnCreature("Your horse has died from exhaustive wounds!", OBJECT_SELF, FALSE);
    }

    SetLocalString(oHorse, "X3_HORSE_PREMOUNT_SCRIPT", "hrs_prem001");
    SetLocalString(oHorse, "X3_HORSE_POSTDISMOUNT_SCRIPT", "hrs_pstd001");
    SetLocalObject(oHorse, "HorseOwner", GetLocalObject(OBJECT_SELF, "HorseOwner"));
    SetTag(oHorse, "HRS_" + GenerateTagFromName(OBJECT_SELF));
    SetName(oHorse, GetName(GetLocalObject(OBJECT_SELF, "HorseOwner")) + "'s Horse");

    DeleteLocalString(OBJECT_SELF, "X3_HORSE_POSTMOUNT_SCRIPT");
    DeleteLocalString(OBJECT_SELF, "X3_HORSE_PREDISMOUNT_SCRIPT");
    DeleteLocalObject(OBJECT_SELF, "HorseWidget");
    DeleteLocalObject(OBJECT_SELF, "HorseOwner");

    if(GetLocalInt(OBJECT_SELF, "HorseParking") > 0)
    {
        SetLocalInt(oHorse, "HorseParking", 1);
        SetImmortal(oHorse, TRUE);
    }
}
