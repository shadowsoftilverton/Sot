#include "nwnx_events"

void main()
{
    object oSelf = OBJECT_SELF;
    object oTarget = GetEventTarget();

    int iType = GetEventSubType();

    if(iType == FEAT_KNOCKDOWN || iType == FEAT_IMPROVED_KNOCKDOWN
    || iType == FEAT_DISARM || iType == FEAT_IMPROVED_DISARM || iType == FEAT_SAP){
        DelayCommand(0.0, DecrementRemainingFeatUses(oSelf, iType));
        DelayCommand(12.0, IncrementRemainingFeatUses(oSelf, iType));
    }
}
