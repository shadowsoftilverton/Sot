#include "ave_inc_rogue"

void RecurInvis(object oPC, float fDelay)
{
     effect eInvis=EffectInvisibility(INVISIBILITY_TYPE_NORMAL);
     DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eInvis,oPC,6.0));
     effect eVis=EffectVisualEffect(VFX_DUR_GLOW_WHITE);
     DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis,oPC,6.0));
}

void main()
{
    object oPC=OBJECT_SELF;
    int iTimes=GetLevelByClass(CLASS_TYPE_ROGUE,oPC)/3;
    int i=0;
    float fTime;
    while(i<iTimes)
    {
        fTime=i*6.0;
        RecurInvis(oPC,fTime);
        i++;
    }
    GeneralCoolDown(LINGERING_SHROUD,oPC,300.0);
}
