#include "engine"

int GetIsAttackPower(itemproperty ipCheck)
{
    switch(GetItemPropertyType(ipCheck))
    {case ITEM_PROPERTY_ATTACK_BONUS: return 1;
    case ITEM_PROPERTY_DAMAGE_BONUS: return 1;
    case ITEM_PROPERTY_KEEN: return 1;
    case ITEM_PROPERTY_REGENERATION_VAMPIRIC: return 1;
    case ITEM_PROPERTY_MASSIVE_CRITICALS: return 1;
    case ITEM_PROPERTY_AC_BONUS: return 0;
    case ITEM_PROPERTY_ABILITY_BONUS: return 0;
    case ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N: return 0;
    case ITEM_PROPERTY_REGENERATION: return 0;
    case ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC: return 0;
    case ITEM_PROPERTY_SPELL_RESISTANCE: return 0;
    case ITEM_PROPERTY_SAVING_THROW_BONUS: return 0;
    case ITEM_PROPERTY_SKILL_BONUS: return 0;
    case ITEM_PROPERTY_ON_HIT_PROPERTIES: return 1;
    case ITEM_PROPERTY_ONHITCASTSPELL: return 1;}
    return -1;
}

int GetGlovePowerType(object oGlove, object oPC)
{
    itemproperty ipLoop=GetFirstItemProperty(oGlove);
    if(!GetIsItemPropertyValid(ipLoop)){
    SendMessageToPC(oPC,"Glove has no valid properties!");
    return 0;}
    int IsAttack=(-1);
    while(GetIsItemPropertyValid(ipLoop))
    {
        if(GetIsAttackPower(ipLoop)==1&&IsAttack!=0) {IsAttack=1;}
        else if(GetIsAttackPower(ipLoop)==0&&!(IsAttack==1)) {IsAttack=0;}
        else
        {
            SendMessageToPC(oPC,"Glove contains properties that cannot be combined!");
            return -1;
        }
        ipLoop=GetNextItemProperty(oGlove);
    }
    return IsAttack;
}

void MergeProps(object oGlove1, object oGlove2)
{
    itemproperty ipLoop=GetFirstItemProperty(oGlove1);
    while(GetIsItemPropertyValid(ipLoop))
    {
        AddItemProperty(DURATION_TYPE_PERMANENT,ipLoop,oGlove2);
        ipLoop=GetNextItemProperty(oGlove1);
    }
    DestroyObject(oGlove1);
}

void main()
{
    object oPC=GetLastClosedBy();
    object oGlove1=GetFirstItemInInventory();
    int Glove1Type;
    if(GetIsObjectValid(oGlove1))
    {
        if(GetBaseItemType(oGlove1)==BASE_ITEM_GLOVES)
        {
             Glove1Type=GetGlovePowerType(oGlove1,oPC);
             object oGlove2=GetNextItemInInventory();
             if(GetBaseItemType(oGlove2)==BASE_ITEM_GLOVES)
             {
                int Glove2Type=GetGlovePowerType(oGlove2,oPC);
                if((Glove1Type==1&&Glove2Type==0)||(Glove1Type==0&&Glove2Type==1))
                {
                    MergeProps(oGlove1,oGlove2);
                    SendMessageToPC(oPC,"Glove merge successful!");
                }
                else SendMessageToPC(oPC,"You must combine exactly one glove with designated attack powers and exactly one glove with designated defense powers");
             }
             else SendMessageToPC(oPC,"You need at least two pairs of gloves to combine them.");
        }
        else SendMessageToPC(oPC,"You cannot use this to combine nonglove items.");
    }
}
