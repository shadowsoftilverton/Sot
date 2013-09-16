#include "engine"
#include "inc_modalfeats"

void main() {
    int nSpell = GetSpellId();
    object oTarget = GetSpellTargetObject();

    if(FocusedAttackActive(oTarget)) {
        RemoveFocusedAttackEffect(oTarget);
    } else {
        ActivateFocusedAttackEffect(oTarget, nSpell);
    }
}
