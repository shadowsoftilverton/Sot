#include "engine"
#include "ave_inc_duration"
#include "x2_inc_spellhook"
#include "nwnx_structs"

void main()
{
      if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
    object oCaster = OBJECT_SELF;
    DoGeneralOnCast(oCaster);
    //if(GetLocalInt(oCaster,"ave_duration")==-1)
    //{

        int nCasterLvl = GetCasterLevel(oCaster);
        int nMetaMagic = GetMetaMagicFeat();
        int nDC=GetSpellSaveDC();
        object oTarget=GetSpellTargetObject();
        location lLoc=GetSpellTargetLocation();

        StoreLevel(oCaster);
        int nDuration;
        if (nMetaMagic==METAMAGIC_EXTEND)
        nDuration=60;
        else
        nDuration=30;
        if(GetHasFeat(1386,oCaster)) nDuration=nDuration+30;
        effect eDur=EffectVisualEffect(VFX_DUR_AURA_BLUE_LIGHT);
        SetLocalInt(oCaster,"ave_dc",nDC);
        SetLocalInt(oCaster,"ave_duration",SPELL_SUCCUBUS);
        SetLocalInt(oCaster,"ave_cl",nCasterLvl);
        SetLocalInt(oCaster,"ave_metamagic",nMetaMagic);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oCaster,RoundsToSeconds(nDuration));
        IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
        int iAveExpire=GetLocalInt(oCaster,"ave_expire");
        SetLocalInt(oCaster,"ave_expire",iAveExpire+1);
        DelayCommand(RoundsToSeconds(nDuration),DurationEnd(iAveExpire+1,oCaster));

        float fDur=9.0;
        if(nMetaMagic==METAMAGIC_EXTEND) fDur=fDur*2;
        effect eVFX;
        if(GetHitDice(oTarget)>0&&GetHitDice(oTarget)<16)
        {
           if(!GetIsReactionTypeFriendly(oTarget))
             {
                  if(MyResistSpell(oCaster, oTarget)==0)
                  {
                       effect ePrior=GetPriorSuccubusEffect(oTarget);
                       if(GetIsEffectValid(ePrior)) nDC=nDC+2;
                       if(!WillSave(oTarget,nDC,SAVING_THROW_TYPE_SPELL,oCaster))
                       {
                           if(!GetIsEffectValid(ePrior))
                           {
                               int nRand=Random(4);
                               switch(nRand)
                               {
                               case 0: ePrior=EffectStunned();
                               eVFX=EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);
                               break;
                               case 1: ePrior=EffectCurse(4,4,4,4,4,4);
                               eVFX=EffectVisualEffect(VFX_DUR_AURA_BLUE_DARK);
                               break;
                               case 2: ePrior=EffectConfused();
                               eVFX=EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
                               break;
                               case 3: ePrior=EffectDazed();
                               eVFX=EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
                               break;
                               }
                               effect eNew=EffectLinkEffects(ePrior,eVFX);
                               SetEffectSpellId(eNew,SPELL_SUCCUBUS);
                               ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eNew,oTarget,fDur);
                           }
                           else
                           {
                               effect eAdd;
                               switch(GetEffectType(ePrior))
                               {
                                    case EFFECT_TYPE_CONFUSED:
                                    eVFX=EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
                                    eAdd=EffectLinkEffects(eVFX,EffectConfused());
                                    break;
                                    case EFFECT_TYPE_DAZED:
                                    eVFX=EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
                                    eAdd=EffectLinkEffects(eVFX,EffectDazed());
                                    break;
                                    case EFFECT_TYPE_CURSE:
                                    eVFX=EffectVisualEffect(VFX_DUR_AURA_BLUE_DARK);
                                    eAdd=EffectLinkEffects(eVFX,EffectCurse(4,4,4,4,4,4));
                                    break;
                                    case EFFECT_TYPE_STUNNED:
                                    eVFX=EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);
                                    eAdd=EffectLinkEffects(eVFX,EffectStunned());
                                    break;
                               }
                               fDur=fDur+GetEffectDurationRemaining(ePrior);
                               RemoveEffect(oTarget,ePrior);
                               SetEffectSpellId(eAdd,SPELL_SUCCUBUS);
                               ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eAdd,oTarget,fDur);
                           }
                       }
                  }
              }
        }
}
