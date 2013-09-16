#include "engine"
#include "ave_inc_skills"

void main()
{
    GiveSkillRank(GetPCSpeaker(),SKILL_RIDE);
    TakeSkillRank(GetPCSpeaker(),SKILL_TUMBLE);
}
