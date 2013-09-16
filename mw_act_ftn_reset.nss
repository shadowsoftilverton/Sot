#include "engine"

#include "uw_inc"

void main(){
    object oDM  = OBJECT_SELF;
    object oTarget = GetUtilityTarget(oDM);

    if (GetStandardFactionReputation(STANDARD_FACTION_COMMONER, oTarget) <= 10)
    {
        SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 80, oTarget);
    }
    if (GetStandardFactionReputation(STANDARD_FACTION_MERCHANT, oTarget) <= 10)
    {
        SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 80, oTarget);
    }
    if (GetStandardFactionReputation(STANDARD_FACTION_DEFENDER, oTarget) <= 10)
    {
        SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 80, oTarget);
    }
}
