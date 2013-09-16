#include "engine"
#include "inc_loot"

void main()
{
    object oPC = GetLastOpenedBy();
    object oSelf = OBJECT_SELF;

    if(!GetIsPC(oPC) || (GetIsDM(oPC) && GetTag(GetArea(oPC)) != "zdm_planning")) return;

    object oArea = GetArea(oPC);

    int nLevel;
    int nCount;

    object oFaction = GetFirstFactionMember(oPC, TRUE);

    while(GetIsObjectValid(oFaction)){
        if(GetArea(oFaction) == oArea){
            nLevel += GetHitDice(oFaction);

            nCount++;
        }

        oFaction = GetNextFactionMember(oFaction, TRUE);
    }

    GenerateLoot(oSelf, nLevel/nCount,oPC);
}
