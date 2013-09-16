#include "engine"
#include "ave_inc_skills"

void main()
{
    GiveSkillRank(GetPCSpeaker(),SKILL_K_LOCAL);
    TakeSkillRank(GetPCSpeaker(),SKILL_K_NATURE);
}
