#include "engine"
#include "ave_inc_skills"

void main()
{
    GiveSkillRank(GetPCSpeaker(),SKILL_SURVIVAL);
    TakeSkillRank(GetPCSpeaker(),SKILL_SENSE_MOTIVE);
}
