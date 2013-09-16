#include "engine"
#include "nw_i0_plot"
#include "inc_system"

//Removes canny defense and precise strike bonuses
void ave_DuelRemove(object oPC)
{
    effect eEffect = GetFirstEffect(oPC);
    while(GetIsEffectValid(eEffect))
    {
        if(GetEffectSpellId(eEffect)==1371)
        {
            Std_RemoveEffect(oPC,eEffect);
        }
        if(GetEffectSpellId(eEffect)==1370)
        {
            Std_RemoveEffect(oPC,eEffect);
        }
        eEffect = GetNextEffect(oPC);
    }
}

void ave_DuelEquip(object oPC, object oItem)
{
     ave_DuelRemove(oPC);
     object oOffHand=GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
     if(!GetIsObjectValid(oOffHand))
     {
        object oArmor=GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
        if(GetItemACBase(oArmor)==0)
        {
            //object oOnHand=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
            if(GetIsObjectValid(oItem))
            {
                if(GetBaseItemType(oItem)==BASE_ITEM_SHORTSWORD||GetBaseItemType(oItem)==BASE_ITEM_RAPIER||GetBaseItemType(oItem)==BASE_ITEM_DAGGER)
                {
                    if (GetLevelByClass(55,oPC)>9)
                    {
                        effect MyDamage=EffectDamageIncrease(DAMAGE_BONUS_2d4,DAMAGE_TYPE_PIERCING);
                        SetEffectSpellId(MyDamage,1371);
                        MyDamage=SupernaturalEffect(MyDamage);
                        DelayCommand(0.1f,ApplyEffectToObject(DURATION_TYPE_PERMANENT,MyDamage,oPC));
                    }
                    else if(GetLevelByClass(55,oPC)>4)
                    {
                        effect MyDamage=EffectDamageIncrease(DAMAGE_BONUS_1d4,DAMAGE_TYPE_PIERCING);
                        SetEffectSpellId(MyDamage,1371);
                        MyDamage=SupernaturalEffect(MyDamage);
                        DelayCommand(0.1f,ApplyEffectToObject(DURATION_TYPE_PERMANENT,MyDamage,oPC));
                    }
                    if(GetLevelByClass(55,oPC)>(GetIntelligence(oPC)-10)/2)
                    {
                        effect MyAC=EffectACIncrease((GetIntelligence(oPC)-10)/2);
                        SetEffectSpellId(MyAC,1370);
                        MyAC=SupernaturalEffect(MyAC);
                        DelayCommand(0.1f,ApplyEffectToObject(DURATION_TYPE_PERMANENT,MyAC,oPC));
                    }
                    else
                    {
                        effect MyAC=EffectACIncrease(GetLevelByClass(55,oPC));
                        SetEffectSpellId(MyAC,1370);
                        MyAC=SupernaturalEffect(MyAC);
                        DelayCommand(0.1f,ApplyEffectToObject(DURATION_TYPE_PERMANENT,MyAC,oPC));
                    }
                }
            }
        }
    }
}
