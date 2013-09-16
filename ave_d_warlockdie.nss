#include "engine"
//Written by Ave (2012/04/13)

#include "ave_d_inc"

void DeathSpurt(vector vPos, int nSpurt, int nVFX, object oArea)
{
    if(nSpurt>0)
    {
        nSpurt=nSpurt-1;
        DelayCommand(IntToFloat(Random(10))/10.0,DeathSpurt(vPos,nSpurt,nVFX,oArea));
    }

    vPos=vPos+Vector(IntToFloat(Random(31)-15)/10.0,IntToFloat(Random(31)-15)/10.0,0.0);
    effect eSpurt=EffectVisualEffect(nVFX);
    location lLoc=Location(oArea,vPos,IntToFloat(Random(360)));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eSpurt,lLoc);
}

void CreateSkel(location lLoc)
{
    object oSkelMage=CreateObject(OBJECT_TYPE_CREATURE,"ave_skelmage",lLoc);
    DelayCommand(0.5,ExecuteScript("ave_d_createskel",oSkelMage));
    DelayCommand(0.5,DoBeginExplodeAndInvulns(oSkelMage));
}

void main()
{
     vector vPos=GetPosition(OBJECT_SELF);
     object oArea=GetArea(OBJECT_SELF);
     location lLoc=GetLocation(OBJECT_SELF);
     CreateSkel(lLoc);
     DeathSpurt(vPos,8,VFX_COM_CHUNK_RED_SMALL,oArea);
     DelayCommand(10.0,DeathSpurt(vPos,4,VFX_COM_CHUNK_RED_MEDIUM,oArea));
     DelayCommand(20.0,DeathSpurt(vPos,2,VFX_COM_CHUNK_RED_LARGE,oArea));
}
