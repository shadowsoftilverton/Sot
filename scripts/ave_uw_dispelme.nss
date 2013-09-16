#include "engine"
#include "uw_inc"
#include "x2_i0_spells"

void main()
{
    object oMe=GetPCSpeaker();
    int iBreach=0;
    int iBreachID=0; //Spell ID to breach
    effect eCheck;
    while(iBreach<33)
    {
        iBreachID=GetSpellBreachProtection(iBreach);
        eCheck=GetFirstEffect(oMe);
        while(GetIsEffectValid(eCheck))
        {
            if(GetEffectSpellId(eCheck)==iBreachID||GetEffectType(eCheck)==EFFECT_TYPE_INVISIBILITY)
            {
                RemoveEffect(oMe,eCheck);
            }
            eCheck=GetNextEffect(oMe);
        }
        iBreach++;
    }
}
