#include "engine"

#include "inc_areas"

/**
* Attach this script to transitions intended to be used with the dungeon
* instancing system. Use on transitions
*
* @variable iCreatureType The creature types to spawn in the dungeon.
* @variable iDungeonType The terrain type of the dungeon.
*/
void main()
{
    object oSelf = OBJECT_SELF;
    object oPlayer = GetClickingObject();

    // We don't care if non-PCs use the transition.
    if(!GetIsPC(oPlayer)) return;

    CreateDungeonInstance(oPlayer, oSelf);
}
