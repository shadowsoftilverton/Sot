#include "engine"

#include "nwnx_events"

void main()
{
    object oSelf = OBJECT_SELF;
    object oTarget = GetEventTarget();

    if(GetObjectType(oTarget) == OBJECT_TYPE_ITEM){
        // If we've got Analyze Dweomer active we can identify anything.
        if(GetLocalInt(oSelf, "ANALYZE_DWEOMER")){
            SetIdentified(oTarget, TRUE);
        }
    }
}
