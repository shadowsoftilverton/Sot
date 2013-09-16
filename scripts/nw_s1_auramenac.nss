//::///////////////////////////////////////////////
//:: Aura of Menace
//:: NW_S1_AuraMenac.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Upon entering the aura all creatures of type animal
    are struck with fear.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: May 25, 2001
//:://////////////////////////////////////////////

void main()
{
    //Set and apply AOE object
    effect eAOE = EffectAreaOfEffect(AOE_MOB_MENACE);
    eAOE = ExtraordinaryEffect(eAOE);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAOE, OBJECT_SELF);
}
