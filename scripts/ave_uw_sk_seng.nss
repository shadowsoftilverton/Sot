#include "engine"
#include "ave_inc_skills"

void main()
{
    GiveSkillRank(GetPCSpeaker(),SKILL_SENSE_MOTIVE);
    TakeSkillRank(GetPCSpeaker(),SKILL_SURVIVAL);
}
