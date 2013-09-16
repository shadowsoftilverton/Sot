#include "engine"
#include "inc_modalfeats"

void main()
{
    int nSpell = GetSpellId();
    object oTarget = GetSpellTargetObject();

    if(ExpertiseActive(oTarget)) {
        RemoveExpertiseEffect(oTarget);
    } else {
        ActivateExpertiseEffect(oTarget, nSpell);
    }
}
