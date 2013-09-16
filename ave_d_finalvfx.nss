//Written by Ave (2012/04/13)
#include "engine"
void DoExternalExplode(object oArea,vector vPos,int nIteration, int nVFX)
{
    if(nIteration>0)
    {
        nIteration=nIteration-1;
        DelayCommand(IntToFloat(Random(5))/10.0,DoExternalExplode(oArea,vPos,nIteration,nVFX));
    }

        vPos=vPos+Vector(IntToFloat(Random(21)-10),IntToFloat(Random(21)-10),IntToFloat(Random(21)-10));
        effect eExplode=EffectVisualEffect(nVFX);
        location lLoc=Location(oArea,vPos,IntToFloat(Random(360)));
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eExplode,lLoc);
}

void main()
{
    vector vPos=GetPosition(OBJECT_SELF);
    object oArea=GetArea(OBJECT_SELF);
    DelayCommand(6.0,DoExternalExplode(oArea,vPos,10,VFX_FNF_MYSTICAL_EXPLOSION));
    DelayCommand(9.0,DoExternalExplode(oArea,vPos,15,VFX_FNF_HOWL_MIND));
    DelayCommand(12.0,DoExternalExplode(oArea,vPos,10,VFX_FNF_DISPEL_DISJUNCTION));
    object oWayPoint=GetObjectByTag("ave_d_exterior");
    vPos=GetPosition(oWayPoint);
    oArea=GetArea(oWayPoint);
    DelayCommand(6.0,DoExternalExplode(oArea,vPos,20,VFX_FNF_PWKILL));
    DelayCommand(12.0,DoExternalExplode(oArea,vPos,40,VFX_FNF_MYSTICAL_EXPLOSION));
    DelayCommand(15.0,DoExternalExplode(oArea,vPos,80,VFX_FNF_METEOR_SWARM));
}
