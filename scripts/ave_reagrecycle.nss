#include "engine"
#include "ave_crafting"
#include "inc_arrays"

void MergeCosts(int nGold, int nCost, object oGold,object oTable, int nIndex)
{
    while(nIndex>0)
    {
        DestroyObject(GetLocalObject(oTable,"ave_recycle_reagents"+IntToString(nIndex)));
        nIndex=nIndex-1;
    }
    if(nGold==nCost) {DestroyObject(oGold,0.0);}
    else {SetItemStackSize(oGold,nGold-nCost);}
}

void main()
{
    object oPC=GetLastClosedBy();
    object oTable=OBJECT_SELF;
    object oItem=GetFirstItemInInventory(oTable);
    object oGold;
    int nTier=0;
    while(GetIsObjectValid(oItem))
    {
        if(GetResRef(oItem)=="nw_it_gold001")
        {
            oGold=oItem;
        }
        if (GetLocalInt(oItem,"IsCraftingReagent")==1)
        {
            if(GetLocalInt(oItem,"IPVarTier")>nTier)
            nTier=GetLocalInt(oItem,"IPVarTier");
        }
        oItem=GetNextItemInInventory(oTable);
    }
    oItem=GetFirstItemInInventory(oTable);
    int nIndex=0;
    while(GetIsObjectValid(oItem))
    {
        if(GetLocalInt(oItem,"IsCraftingReagent")==1)
        {
            if(GetLocalInt(oItem,"IPVarTier")==nTier)
            {
                nIndex=nIndex+1;
                SetLocalObject(oTable,"ave_recycle_reagents"+IntToString(nIndex),oItem);
                SetLocalString(oTable,"ave_recycle_types"+IntToString(nIndex),GetLocalString(oItem,"IPMain"));
            }
        }
        oItem=GetNextItemInInventory(oTable);
    }
    if(nIndex<4)
    {
        SendMessageToPC(oPC,"You need at least four reagents of the same tier for this process. You only have "+IntToString(nIndex)+" of the top tier - tier "+IntToString(nTier));
        return;
    }
    string sProp=GetLocalString(oTable,"ave_recycle_types1");
    int nCheck=1;
    while(nCheck<nIndex)
    {
        nCheck++;
        if(GetLocalString(oTable,"ave_recycle_types"+IntToString(nIndex))==sProp)
        {
            sProp=GetLocalString(oTable,"ave_recycle_types"+IntToString(nIndex));
        }
        else
        {
            sProp="";
            break;
        }
    }
    if(sProp!="") SendMessageToPC(oPC,"These reagents are all similar - you will create a similar reagent, if successful.");
    int nBoost=0;
    int nFailOdds=1;
    nCheck=nIndex;
    int nCost=nTier*nTier*nTier*nTier;
    while(nCheck>3)
    {
        nBoost=nBoost+1;
        nCheck=nCheck/4;
        nFailOdds=nFailOdds*2;
        nCost=nCost*3;
    }
    int nGold=GetItemStackSize(oGold);
    if(nCost>nGold)
    {
        SendMessageToPC(oPC,"Not enough gold! You must place at least "+IntToString(nCost)+" gp on the table for this!");
        return;
    }
    SendMessageToPC(oPC,"You have a one in "+IntToString(nFailOdds)+" chance of generating a reagent of up to tier "+IntToString(nBoost+nTier));
    if(Random(nFailOdds)==1)
    {
        object oChildReag=CreateReagent(nTier+nBoost,oTable,TRUE,sProp);
        if(oChildReag==OBJECT_INVALID)
        {
            SendMessageToPC(oPC,"Failure! You do not create a new reagent, but your old reagents are intact.");
        }
        else
        {
            SendMessageToPC(oPC,"Success! You create a reagent.");
            MergeCosts(nGold, nCost, oGold,oTable, nIndex);
        }
    }
    else
    {
        SendMessageToPC(oPC,"Failure! You do not create a reagent, and you lose your materials.");
        MergeCosts(nGold, nCost, oGold,oTable, nIndex);
    }
}
