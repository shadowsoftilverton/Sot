#include "engine"
#include "ave_inc_skills"

void main()
{
    GiveSkillRank(GetPCSpeaker(),SKILL_SET_TRAP);
    TakeSkillRank(GetPCSpeaker(),SKILL_BLUFF);
}
