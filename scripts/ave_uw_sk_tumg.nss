#include "engine"
#include "ave_inc_skills"

void main()
{
    GiveSkillRank(GetPCSpeaker(),SKILL_TUMBLE);
    TakeSkillRank(GetPCSpeaker(),SKILL_RIDE);
}
