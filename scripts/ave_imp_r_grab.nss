#include "ave_inc_rogue"
#include "ave_inc_combat"

void DoDamageLoop(object oPC, object oVictim,int iIteration)
{
    if(iIteration>0) DelayCommand(4.0,DoDamageLoop(oPC,oVictim,iIteration-1));
    effect eDam=EffectDamage(d4(GetLevelByClass(CLASS_TYPE_ROGUE,oPC)),DAMAGE_TYPE_SLASHING);
    eDam=EffectLinkEffects(EffectVisualEffect(VFX_COM_SPARKS_PARRY),eDam);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oVictim);
}

void main()
{
    object oPC=OBJECT_SELF;
    object oVictim=GetSpellTargetObject();
    if(GetIsBehind(oPC,oVictim))
    {
        object oDestArea=GetArea(oVictim);
        float fDestFacing=GetFacing(oVictim);
        vector vDestVect=GetPosition(oVictim);
        vDestVect.x = vDestVect.x - (cos(GetFacing(OBJECT_SELF)/2));
        vDestVect.y = vDestVect.y - (sin(GetFacing(OBJECT_SELF)/2));
        location lDest=Location(oDestArea,vDestVect,fDestFacing);
        AssignCommand(oPC,ActionJumpToLocation(lDest));
        //AssignCommand(oPC,PlayAnimation(ANIMATION_LOOPING_SPASM,0.5f));
        int nDC=(GetLevelByClass(CLASS_TYPE_ROGUE,oPC)/2)+GetAbilityModifier(ABILITY_STRENGTH,oPC)+10;
        if(!ReflexSave(oVictim,nDC))
        {
            effect eSilence=SupernaturalEffect(EffectSilence());
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSilence,oVictim,12.0);
            DoDamageLoop(oPC,oVictim,3);
        }
        effect ePar=EffectCutsceneParalyze();
        DelayCommand(0.1,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ePar,oPC,12.0));
        //ePar=EffectLinkEffects(ePar,EffectKnockdown());
        DelayCommand(0.1,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ePar,oVictim,12.0));
    }
    else SendMessageToPC(oPC,"Garrote grab failed! You must be behind the target for this to work.");
    DelayCommand(240.0,IncrementRemainingFeatUses(oPC,GARROTE_GRAB));
}
