#include "engine"

void main() {
    object oPC = GetPCSpeaker();
    float fDuration = GetLocalFloat(oPC, "wg_sp_altself_duration");
    int nModify = 10;
    effect eDis = EffectSkillIncrease(SKILL_DISGUISE, nModify);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDis, oPC, fDuration);
}
