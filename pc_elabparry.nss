#include "inc_system"

void main()
{
    object oPC=OBJECT_SELF;
    if(!GetHasSpellEffect(1036,oPC))//If you are not already in Elaborate Parry
    {
        effect MyAC=EffectACIncrease(GetLevelByClass(55,oPC)+2);
        effect MyAB=EffectAttackDecrease(4);
        SetEffectSpellId(MyAC,1036);
        SetEffectSpellId(MyAB,1036);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,MyAC,oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,MyAB,oPC);
    }
    else//If you are already in Elaborate Parry
    {
        effect eEffect = GetFirstEffect(oPC);
        while(GetIsEffectValid(eEffect))
        {
            if(GetEffectSpellId(eEffect)==1036)
            {
                Std_RemoveEffect(oPC,eEffect);
            }
            eEffect = GetNextEffect(oPC);
        }
    }
}
