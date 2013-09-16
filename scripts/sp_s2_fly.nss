//::///////////////////////////////////////////////
//:: SP_S2_FLY.NSS
//:: Silver Marches File
//:://////////////////////////////////////////////
/*
    Script to handle flying.
*/
//:://////////////////////////////////////////////
//:: Created By: Ashton Shapcott
//:: Created On: Aug. 4, 2009
//:://////////////////////////////////////////////

void main()
{
    object oTarget = GetSpellTargetObject();
    location lTarget = GetSpellTargetLocation();

    if(oTarget == OBJECT_SELF){
        SetLocalLocation(OBJECT_SELF, "PREVIOUS_LOCATION", GetLocation(OBJECT_SELF));
        //effect eFly = EffectDisappearAppear();
    } else {
        //effect eFly = EffectDisappearAppear();
    }
}
