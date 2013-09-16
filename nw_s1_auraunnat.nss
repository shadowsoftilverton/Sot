//::///////////////////////////////////////////////
//:: Aura of Unnatural
//:: NW_S1_AuraMencA.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Upon entering the aura all animals are struck with
    fear.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: May 25, 2001
//:://////////////////////////////////////////////

void main()
{
    //Set and apply the AOE object
    effect eAOE = EffectAreaOfEffect(AOE_MOB_UNNATURAL);
    eAOE = ExtraordinaryEffect(eAOE);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAOE, OBJECT_SELF);
}
