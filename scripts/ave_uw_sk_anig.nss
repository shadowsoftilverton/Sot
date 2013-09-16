#include "engine"
#include "ave_inc_skills"

void main()
{
    GiveSkillRank(GetPCSpeaker(),SKILL_ANIMAL_EMPATHY);
    TakeSkillRank(GetPCSpeaker(),SKILL_GATHER_INFORMATION);
}
