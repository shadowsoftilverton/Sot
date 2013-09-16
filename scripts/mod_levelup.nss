#include "engine"

#include "inc_equipment"
#include "inc_mod"
#include "inc_barbarian"
#include "ave_inc_event"
#include "ave_inc_skills"

void main() {
    object oPC = GetPCLevellingUp();

    EnablePrestigeClasses(oPC);

    AddHalfElfSkillPoints(oPC);
    AddMechanicalSkillsForStealth(oPC);
    AddMechanicalSkillsForPerception(oPC);

    DoResetEquipAdjustments(oPC);

    if(GetLevelByClass(CLASS_TYPE_BARBARIAN,oPC)>5)//Is eligible for rage feats?
    {
        DoCheckAndRemindBonusRageFeats(oPC);//Check to see if they should get a rage feat or not, and if so informs
    }

    DoRogueStuff(oPC);

    if(GetLevelByClass(50,oPC)>0) DoHierophantPassives(oPC);

    if(GetHasFeat(1382,oPC)) DoEpicSelfConceal(oPC);

    DoFeatHPBonus(oPC);

    DoMiscFeatBonuses(oPC);

    if(GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE,oPC)>1) DoBloodlineDisciple(oPC);
    if(GetLevelByClass(CLASS_TYPE_BARD,oPC)>1) DoBardWeaponProf(oPC);

    ClearPermanentFeatProperties(oPC);
    ApplyPermanentFeatProperties(oPC);
}
