#include "engine"
//Written by Ave (2012/04/14)

void ave_d_bloodbeast(int iObjectType,string sTemplate,location lLoc)
{
    CreateObject(iObjectType,sTemplate,lLoc,FALSE,"ave_bloodbeast");
}

void main()
{
    object oBloodMage=OBJECT_SELF;
    vector vPos=GetPosition(oBloodMage);
    vPos=vPos+Vector(IntToFloat(Random(31)-15)/4.0,IntToFloat(Random(31)-15)/4.0,0.0);
    location lLoc=Location(GetArea(oBloodMage),vPos,IntToFloat(Random(360)));
    object oMyBlood=CreateObject(OBJECT_TYPE_PLACEABLE,"ave_bloodstain",lLoc,TRUE,"");
    DestroyObject(oMyBlood,10.0);
    int nCount=0;
    object oBeast=GetObjectByTag("ave_bloodbeast");
    while(GetIsObjectValid(oBeast))
    {
        nCount++;
        oBeast=GetObjectByTag("ave_bloodbeast",nCount);
    }

    if(nCount<=6&&GetLocalInt(oBloodMage,"ave_bloodcool")==0)//6 is the maximum number of bloodbeasts
    {
        SetLocalInt(oBloodMage,"ave_bloodcool",1);
        DelayCommand(1.2,SetLocalInt(oBloodMage,"ave_bloodcool",0));
        effect eChunk=EffectVisualEffect(VFX_COM_CHUNK_RED_SMALL);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eChunk,lLoc);
        effect eVis=EffectVisualEffect(VFX_IMP_EVIL_HELP);
        DelayCommand(1.2,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVis,lLoc));
        DelayCommand(1.2,ave_d_bloodbeast(OBJECT_TYPE_CREATURE,"ave_bloodbeast",lLoc));
    }


    //--------------------------------------------------------------------------
    // GZ: 2003-10-16
    // Make Plot Creatures Ignore Attacks
    //--------------------------------------------------------------------------
    if (GetPlotFlag(OBJECT_SELF))
    {
        return;
    }

    //--------------------------------------------------------------------------
    // Execute old NWN default AI code
    //--------------------------------------------------------------------------
    ExecuteScript("nw_c2_default6", OBJECT_SELF);
}
