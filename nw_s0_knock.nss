//::///////////////////////////////////////////////
//:: Knock
//:: NW_S0_Knock
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Opens doors not locked by magical means.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 29, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Georg 2003/07/31 - Added signal event and custom door flags
//:: VFX Pass By: Preston W, On: June 22, 2001
#include "nw_i0_spells"

#include "x2_inc_spellhook"


void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook

    int nCL=GetCasterLevel(OBJECT_SELF);
    if(nCL>10) nCL=10;
    object oTarget;
    effect eVis = EffectVisualEffect(VFX_IMP_KNOCK);
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 10.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
    float fDelay;
    int nResist;

    while(GetIsObjectValid(oTarget))
    {
        SignalEvent(oTarget,EventSpellCastAt(OBJECT_SELF,GetSpellId()));
        fDelay = GetRandomDelay(0.2, 0.5);
        if(!GetIsEnemy(oTarget,OBJECT_SELF))
        {
            effect eMyEffect=EffectSkillIncrease(SKILL_OPEN_LOCK,nCL);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eMyEffect,oTarget,120.0);
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, 10.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
    }
}
