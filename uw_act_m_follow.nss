#include "engine"

#include "uw_inc"

void main(){
    object oPC      = GetPCSpeaker();
    object oTarget  = GetUtilityTarget(oPC);
    AssignCommand(oPC, ActionForceFollowObject(oTarget, 1.0));
}
