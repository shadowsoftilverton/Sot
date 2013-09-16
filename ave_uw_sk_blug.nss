#include "engine"
#include "ave_inc_skills"

void main()
{
    GiveSkillRank(GetPCSpeaker(),SKILL_BLUFF);
    TakeSkillRank(GetPCSpeaker(),SKILL_SET_TRAP);
}
