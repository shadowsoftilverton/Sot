#include "engine"
#include "ave_inc_rogue"
#include "nw_i0_spells"
#include "nwnx_structs"

void main()
{
    object oCaster=OBJECT_SELF;
    object   oTarget     = GetSpellTargetObject();
    location lLocal      = GetSpellTargetLocation();
    effect   eVis        = EffectVisualEffect(VFX_IMP_BREACH);
    int iCheck=1;
    int iBreachProt=0;
    int iDoneCounting=0;
    float fDur;
    float fMaxDur;
    effect eTake;
    while(iCheck<33)
    {
        iBreachProt=GetSpellBreachProtection(iCheck);
        if(GetHasSpellEffect(iBreachProt,oTarget))
        {
            effect eCheck=GetFirstEffect(oTarget);
            while(GetIsEffectValid(eCheck))
            {
                if(GetEffectSpellId(eCheck)==iBreachProt)
                {
                    fDur=GetEffectDurationRemaining(eTake);
                    fMaxDur=IntToFloat(GetLevelByClass(CLASS_TYPE_ROGUE,oCaster));
                    if(fDur>30.0) fDur=30.0;
                    if(fDur<3.0) fDur=3.0;
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eCheck,oCaster,fDur);
                    eTake=eCheck;
                    iDoneCounting=1;
                }
                eCheck=GetNextEffect(oTarget);
            }
        }
        if(iDoneCounting==1)
        {
            RemoveEffect(oTarget,eTake);
            iCheck=100;
        }
        iCheck++;
    }
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget);
    GeneralCoolDown(SLY_SPELLTHIEF,oCaster,180.0);
}
