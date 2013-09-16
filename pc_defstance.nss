#include "engine"
#include "inc_modalfeats"

void main() {
    int nSpell = GetSpellId();
    object oTarget = GetSpellTargetObject();

    if(DefensiveStanceActive(oTarget)) RemoveDefensiveStanceEffect(oTarget);
    else ActivateDefensiveStanceEffect(oTarget);
}
