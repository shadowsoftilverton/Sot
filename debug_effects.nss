//Debug script: running this gives the conversation partner feedback about all the effects integers
//If not called from a conversation, checks the spelltargetobject (so could be added to utility wand)
#include "engine"
#include "nwnx_structs"
void main()
{
    object oTarget=GetSpellTargetObject();
    if(GetObjectType(oTarget)==OBJECT_TYPE_CREATURE)
    {
        int iPropNum=0;
        string sFeed="";
        int iProp;
        effect eCheck=GetFirstEffect(oTarget);
        while(GetIsEffectValid(eCheck))
        {
            iPropNum=0;
            sFeed="";
            while(iPropNum<16)
            {
                iProp=GetEffectInteger(eCheck,iPropNum);
                sFeed=sFeed+IntToString(iProp)+", ";
                iPropNum++;
            }
            SendMessageToPC(oTarget,"Debug: Effect integers (0-15) are "+sFeed);
            eCheck=GetNextEffect(oTarget);
        }
    }
    else if(GetObjectType(oTarget)==OBJECT_TYPE_ITEM)
    {
        int iPropNum=0;
        string sFeed="";
        int iProp;
        itemproperty eCheck=GetFirstItemProperty(oTarget);
        while(GetIsItemPropertyValid(eCheck))
        {
            iPropNum=0;
            sFeed="";
            while(iPropNum<16)
            {
                iProp=GetItemPropertyInteger(eCheck,iPropNum);
                sFeed=sFeed+IntToString(iProp)+", ";
                iPropNum++;
            }
            SendMessageToPC(oTarget,"Debug: For Item Property "+IntToString(iProp)+", Item Property integers (0-15) are "+sFeed);
            eCheck=GetNextItemProperty(oTarget);
        }
    }
}
