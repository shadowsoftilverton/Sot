#include "engine"
//Written by Ave (2012/04/13)

void main()
{
    object oSkel=OBJECT_SELF;
    effect eVis;
    object oStatue=GetObjectByTag("ave_plc_statue");
    if(GetIsObjectValid(oSkel))
    {
        effect eLoop=GetFirstEffect(oSkel);
        while(GetIsEffectValid(eLoop))
        {
            RemoveEffect(oSkel,eLoop);
            eLoop=GetNextEffect(oSkel);
        }
        effect eSplashBack=EffectDamageShield(3,DAMAGE_BONUS_2d8,DAMAGE_TYPE_MAGICAL);
        eSplashBack=EffectLinkEffects(eSplashBack,EffectVisualEffect(VFX_DUR_DEATH_ARMOR));
        eSplashBack=SupernaturalEffect(eSplashBack);
        DelayCommand(RoundsToSeconds(d4(2)),ExecuteScript("ave_d_vulnloop",oSkel));
        if(GetLocalInt(oStatue,"ave_immune")==0)
        {
            eVis=EffectVisualEffect(VFX_FNF_HOWL_MIND);
            SetLocalInt(oStatue,"ave_immune",1);
            SetPlotFlag(oSkel,FALSE);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSplashBack,oSkel);
            ExecuteScript("ave_d_spawnloop",oStatue);
        }
        else
        {
            eVis=EffectVisualEffect(VFX_FNF_HOWL_ODD);
            SetLocalInt(oStatue,"ave_immune",0);
            effect eShieldVis=EffectVisualEffect(VFX_DUR_PROT_EPIC_ARMOR);
            eShieldVis=SupernaturalEffect(eShieldVis);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,eShieldVis,oSkel);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSplashBack,oSkel);
            SetPlotFlag(oSkel,TRUE);
        }
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oStatue);
    }
    else SetLocalInt(oStatue,"ave_immune",0);
}
