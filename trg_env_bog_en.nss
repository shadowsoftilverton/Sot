/*
    OnEnter bog script
    by Hardcore UFO
    Applies penalties simulating being in a swamp
    Bonuses as well
    Makes Camp impossible
*/

#include "engine"

void main()
{
    object oEnter = GetEnteringObject();
    int nSize = GetCreatureSize(oEnter);
    int nBonus = 1;
    int nAthletic = Std_GetSkillRank(45, oEnter, FALSE);
    int nPenal;

    SetLocalInt(oEnter, "Unrestable", 1);

    switch(nSize)
    {
        case CREATURE_SIZE_MEDIUM:
            nBonus = 4;
            break;

        case CREATURE_SIZE_SMALL:
            nBonus = 7;
            break;

        case CREATURE_SIZE_TINY:
            nBonus = 10;
            break;

        default:
            nBonus = 1;
            break;
    }

    nPenal = nBonus - (nAthletic / 10);
    if(nPenal < 0)  nPenal = 0;

    effect eHide = EffectSkillIncrease(SKILL_HIDE, nBonus);
    effect eMove = EffectSkillIncrease(SKILL_MOVE_SILENTLY, nBonus);
    effect eAC = EffectACDecrease(nPenal);
    effect eBog = EffectLinkEffects(eHide, eMove);
    eBog = EffectLinkEffects(eAC, eBog);
    eBog = ExtraordinaryEffect(eBog);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBog, oEnter);
}
