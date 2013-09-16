#include "ave_inc_rogue"
#include "nw_i0_spells"

void main()
{
    object oPC=OBJECT_SELF;
    location lLoc=GetLocation(oPC);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lLoc,FALSE,OBJECT_TYPE_CREATURE);
    effect eConfuse=EffectConfused();
    effect eVis = EffectVisualEffect(VFX_IMP_CONFUSION_S);
    float fDur=RoundsToSeconds(GetLevelByClass(CLASS_TYPE_ROGUE,oPC));
    while(GetIsObjectValid(oTarget))
    {
        if(GetIsEnemy(oTarget,oPC))
        {
            int nDC=10+GetLevelByClass(CLASS_TYPE_ROGUE,oPC)+GetAbilityModifier(ABILITY_CHARISMA,oPC);
            if(MySavingThrow(SAVING_THROW_WILL,oTarget,nDC,SAVING_THROW_TYPE_CHAOS,oPC))
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eConfuse,oTarget,fDur);
            }
        }
        oTarget=GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lLoc,FALSE,OBJECT_TYPE_CREATURE);
    }
    GeneralCoolDown(FALSE_FRIEND,oPC,180.0);
}
