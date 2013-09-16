#include "ave_inv_inc"

void DitchStackPart(int iDiff,object oItem,object oPC,float fDelay)
{
    object oSubStack=CopyItem(oItem,oPC,TRUE);
    SetItemStackSize(oItem,GetLocalInt(oItem,"ave_inv_notlootsize"));
    SetItemStackSize(oSubStack,iDiff);
    DitchItem(oSubStack,oPC,fDelay);
}

//Right now, this function just drops all nonloot items in a radius around oPC
void main()
{
    object oPC=OBJECT_SELF;
    int iLoop=0;
    int iDiff=0;
    object oItem=GetFirstItemInInventory(oPC);
    float fDelay=0.0;
    while(GetIsObjectValid(oItem))
    {
        if(GetLocalInt(oItem,"ave_inv_notloot")==0)
        {
            if(iLoop==0)
            {
                iLoop=1;
                //DelayCommand(30.0,ExecuteScript("ave_inv_drop",oPC));
            }
            DitchItem(oItem,oPC,fDelay);
            fDelay=fDelay+5.7;
        }
        else if(GetIsStackableItem(oItem))
        {
            iDiff=GetItemStackSize(oItem)-GetLocalInt(oItem,"ave_inv_notlootsize");
            if(iDiff>0)
            {
                if(iLoop==0)
                {
                    iLoop=1;
                    //DelayCommand(30.0,ExecuteScript("ave_inv_drop",oPC));
                }
                DelayCommand(0.1,DitchStackPart(iDiff,oItem,oPC,fDelay));
                fDelay=fDelay+5.7;
            }
        }
        oItem=GetNextItemInInventory(oPC);
    }
    if(PingDataBase(oPC))
    {
        int iGoldDrop=GetGold(oPC)-GetPersistentInt(oPC,"ave_notloot_gold");
        if(iGoldDrop>0)
        {
            TakeGoldFromCreature(iGoldDrop,oPC,TRUE);
            object oGold=CreateObject(OBJECT_TYPE_ITEM,"nw_it_gold001",GetLocation(oPC));
            SetItemStackSize(oGold,iGoldDrop);
        }
    }
}
