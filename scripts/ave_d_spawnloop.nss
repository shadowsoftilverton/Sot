//Written by Ave (2012/04/13)
#include "engine"
void main()
{
    object oStatue=OBJECT_SELF;
    int nCount=0;
    object oMinion=GetObjectByTag("ave_minion");
    while(GetIsObjectValid(oMinion))
    {
        nCount++;
        oMinion=GetObjectByTag("ave_minion",nCount);
    }
    object oSkel=GetObjectByTag("ave_skelmage");
    if(GetIsObjectValid(oSkel)&&nCount<10&&GetLocalInt(oStatue,"ave_immune")==1)
    {
        effect eVis=EffectVisualEffect(VFX_IMP_RAISE_DEAD);
        object oMinion=CreateObject(OBJECT_TYPE_CREATURE,"ave_minion",GetLocation(oStatue));
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVis,GetLocation(oMinion));
        DelayCommand(IntToFloat(Random(12)),ExecuteScript("ave_d_spawnloop",oStatue));
    }
}
