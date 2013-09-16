#include "engine"

void main()
{
    object oStatue=OBJECT_SELF;
    object oItem=GetFirstItemInInventory(oStatue);
    int n=0;
    object EyeGem1;
    object EyeGem2;
    while(GetIsObjectValid(oItem))
    {
        if(GetTag(oItem)=="ave_d2_eyegem"&&n==0)
        {
            EyeGem1=oItem;
        }
        else if(GetTag(oItem)=="ave_d2_eyegem"&&n==1)
        {
            EyeGem2=oItem;
        }
        oItem=GetNextItemInInventory(oStatue);
    }
    if(GetTag(EyeGem1)=="ave_d2_eyegem")
    {
        if(GetTag(EyeGem2)=="ave_d2_eyegem"|GetItemStackSize(EyeGem1)==2)
        {
            DestroyObject(EyeGem1);
            DestroyObject(EyeGem2);
            location lLoc=GetLocation(GetObjectByTag("ave_d2_portloc"));
            object oPortal=CreateObject(OBJECT_TYPE_PLACEABLE,"ave_d2_port01",lLoc,TRUE);
            DestroyObject(oPortal,1800.0);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3),lLoc);
        }
    }
}
