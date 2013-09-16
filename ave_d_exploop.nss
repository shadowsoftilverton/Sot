//Written by Ave (2012/04/13)
#include "engine"
#include "ave_d_inc"

void DoExplosion(object oPed, int nType)
{
    location lLoc=GetLocation(oPed);
    effect eAOE;
    effect eVis;
    int nDamType;
    if(nType==0)
    {
        eAOE=EffectVisualEffect(VFX_FNF_LOS_EVIL_20);
        eVis=EffectVisualEffect(VFX_IMP_DESTRUCTION);
        nDamType=DAMAGE_TYPE_NEGATIVE;
    }
    else
    {
        eAOE=EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION);
        eVis=EffectVisualEffect(VFX_IMP_LIGHTNING_S);
        nDamType=DAMAGE_TYPE_MAGICAL;
    }
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eAOE,lLoc);
    object oVictim=GetFirstObjectInShape(SHAPE_SPHERE,10.0,lLoc);
    effect eDam;
    effect eHeal;
    int iDamageAmount;
    object oPC=GetFirstPC();
    object oArea=GetArea(OBJECT_SELF);
    while(GetIsObjectValid(oPC))
    {
        if(GetArea(oPC)==oArea) break;
        oPC=GetNextPC();
    }
    int iHeal;
    while(GetIsObjectValid(oVictim))
    {
        iDamageAmount=d6(20);
        if(GetRacialType(oVictim)==RACIAL_TYPE_UNDEAD)
        {
            if(nType==0)
            {
                iHeal=1;
            }
            else
            {
                iHeal=0;
            }
        }
        else
        {
            iHeal=0;
        }
        if(oVictim==GetObjectByTag("ave_skelmage"))
        {
            if(GetPlotFlag(oVictim)==TRUE)
            {
                SetPlotFlag(oVictim,FALSE);
                if(iHeal==1)
                {
                    eHeal=EffectHeal(iDamageAmount);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,oVictim);
                }
                else
                {
                    iDamageAmount=iDamageAmount*2;
                    SetLocalInt(oArea,"ave_d_ndam",iDamageAmount);
                    SetLocalInt(oArea,"ave_d_tdam",nDamType);
                    SetLocalObject(oArea,"ave_d_odam",oVictim);
                    ExecuteScript("ave_d_damwrap",oPC);

                }
                SetPlotFlag(oVictim,TRUE);
            }
            else
            {
                if(iHeal==1)
                {
                    eHeal=EffectHeal(iDamageAmount);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,oVictim);
                }
                else
                {
                    SetLocalInt(oArea,"ave_d_ndam",iDamageAmount);
                    SetLocalInt(oArea,"ave_d_tdam",nDamType);
                    SetLocalObject(oArea,"ave_d_odam",oVictim);
                    ExecuteScript("ave_d_damwrap",oPC);
                }
            }
        }
        else
        {
            if(iHeal==1)
            {
                eHeal=EffectHeal(iDamageAmount);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,oVictim);
            }
            else
            {
                SetLocalInt(oArea,"ave_d_ndam",iDamageAmount);
                SetLocalInt(oArea,"ave_d_tdam",nDamType);
                SetLocalObject(oArea,"ave_d_odam",oVictim);
                ExecuteScript("ave_d_damwrap",oPC);
            }
        }
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oVictim);
        oVictim=GetNextObjectInShape(SHAPE_SPHERE,10.0,lLoc);
    }
}

void main()
{
    object oSkel=GetObjectByTag("ave_skelmage");
    if(GetIsObjectValid(oSkel))
    {
        DelayCommand(RoundsToSeconds(d2(1)+1),ExecuteScript("ave_d_exploop",OBJECT_SELF));
        int nCount=Random(MAX_PEDESTAL)+1;
        object oPed=GetObjectByTag("ave_d_pedestal"+IntToString(nCount));
        effect eVis;
        if(Random(2)==1)
        {
            eVis=EffectVisualEffect(VFX_DUR_AURA_BLUE);
            DelayCommand(9.0,DoExplosion(oPed,1));
        }
        else
        {
            eVis=EffectVisualEffect(VFX_DUR_AURA_PULSE_RED_BLACK);
            DelayCommand(9.0,DoExplosion(oPed,0));
        }
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis,oPed,9.0);
    }
}
