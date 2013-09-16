#include "ave_inc_rogue"

void main()
{
    object oCaster=OBJECT_SELF;
    location lLoc=GetSpellTargetLocation();
    object oVictim = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lLoc);
    int iDamage;
    int nDC=20;
    if(GetHasFeat(CAUSTIC_FLASK,oCaster)) nDC=45;
    effect eDam;
    effect eVis=EffectVisualEffect(VFX_IMP_ACID_S);
    effect eAOE=EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_ACID);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eAOE,lLoc);
    while(GetIsObjectValid(oVictim))
    {
        if(GetHasFeat(CAUSTIC_FLASK,oCaster))
        {
            iDamage=d8(GetLevelByClass(CLASS_TYPE_ROGUE,oCaster));
            nDC=45;
        }
        else
        {
            iDamage=d6(3);
            nDC=20;
        }
        iDamage=GetReflexAdjustedDamage(iDamage,oVictim,nDC,SAVING_THROW_TYPE_ACID,oCaster);
        eDam=EffectDamage(iDamage,DAMAGE_TYPE_ACID);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oVictim);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oVictim);
        oVictim = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lLoc);
    }
    GeneralCoolDown(MIASMIC_FLASK,oCaster,180.0);
}
