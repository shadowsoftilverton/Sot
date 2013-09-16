#include "engine"

void main() {
    object oPC = GetPCSpeaker();
    float fDuration = GetLocalFloat(oPC, "wg_sp_veil_duration");
    int nModify = 20;
    effect eDis = EffectSkillIncrease(SKILL_DISGUISE, nModify);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDis, oPC, fDuration);
}
