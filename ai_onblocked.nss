//OnBlocked
//Default AI script for Shadows of Tilverton
//Written by Harcore UFO
//May 24, 2012

#include "engine"
#include "x0_i0_anims"
#include "nw_i0_generic"
#include "ai_wrapper"

void main()
{
    object oDoor = GetBlockingDoor();

    if(GetObjectType(oDoor) == OBJECT_TYPE_CREATURE)
    {
        DetermineCombatRound(oDoor);
    }

    int nLock = GetLocked(oDoor);

    if(GetAbilityScore(OBJECT_SELF, ABILITY_INTELLIGENCE) >= 5)
    {
        if(nLock == TRUE && GetAbilityScore(OBJECT_SELF, ABILITY_INTELLIGENCE) >= 9)
        {
            DoDoorAction(oDoor, DOOR_ACTION_UNLOCK);
        }

        if(GetIsDoorActionPossible(oDoor, DOOR_ACTION_OPEN) && GetAbilityScore(OBJECT_SELF, ABILITY_INTELLIGENCE) >= 7)
        {
            DoDoorAction(oDoor, DOOR_ACTION_OPEN);
        }

        else if(GetIsDoorActionPossible(oDoor, DOOR_ACTION_BASH))
        {
            DoDoorAction(oDoor, DOOR_ACTION_BASH);
        }
    }
}
