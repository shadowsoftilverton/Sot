#include "engine"
#include "ave_d2_inc"
//This is the loop that makes the slaadi invulnerable
void main()
{
        object oStone=OBJECT_SELF;
        //SendMessageToPC(GetFirstPC(),"Debug: Slaadeff firing");
        float fDur=24.0f;
        DelayCommand(fDur,ExecuteScript("ave_d2_slaadeff",oStone));
        object oSlaad=GetObjectByTag("ave_d2_slaad",0);
        //if(GetIsObjectValid(oSlaad)==FALSE) SendMessageToPC(GetFirstPC(),"Debug: Slaad invalid");
        int nDI=Random(12);
        int DamageExemption;
        effect eBeam;
        switch(nDI)
        {
         case 0: DamageExemption=DAMAGE_TYPE_BLUDGEONING;
         eBeam=EffectVisualEffect(VFX_BEAM_CHAIN);
         break;
         case 1: DamageExemption=DAMAGE_TYPE_PIERCING;
         eBeam=EffectVisualEffect(VFX_BEAM_CHAIN);
         break;
         case 2: DamageExemption=DAMAGE_TYPE_SLASHING;
         eBeam=EffectVisualEffect(VFX_BEAM_CHAIN);
         break;
         case 3: DamageExemption=DAMAGE_TYPE_MAGICAL;
         eBeam=EffectVisualEffect(VFX_BEAM_MIND);
         break;
         case 4: DamageExemption=DAMAGE_TYPE_ACID;
         eBeam=EffectVisualEffect(VFX_BEAM_DISINTEGRATE);
         break;
         case 5: DamageExemption=DAMAGE_TYPE_COLD;
         eBeam=EffectVisualEffect(VFX_BEAM_COLD);
         break;
         case 6: DamageExemption=DAMAGE_TYPE_DIVINE;
         eBeam=EffectVisualEffect(VFX_BEAM_HOLY);
         break;
         case 7: DamageExemption=DAMAGE_TYPE_ELECTRICAL;
         eBeam=EffectVisualEffect(VFX_BEAM_LIGHTNING);
         break;
         case 8: DamageExemption=DAMAGE_TYPE_FIRE;
         eBeam=EffectVisualEffect(VFX_BEAM_FIRE);
         break;
         case 9: DamageExemption=DAMAGE_TYPE_NEGATIVE;
         eBeam=EffectVisualEffect(VFX_BEAM_EVIL);
         break;
         case 10: DamageExemption=DAMAGE_TYPE_POSITIVE;
         eBeam=EffectVisualEffect(VFX_BEAM_BLACK);
         break;
         case 11: DamageExemption=DAMAGE_TYPE_SONIC;
         eBeam=EffectVisualEffect(VFX_BEAM_SILENT_ODD);
         break;
        }
        effect eImmune;
        object oTarget;
        int iSlaadCount;
        while(GetIsObjectValid(oSlaad))
        {
            oTarget=GetAttackTarget(oSlaad);
            effect eOld=GetFirstEffect(oSlaad);
            while(GetIsEffectValid(eOld))
            {
                RemoveEffect(oSlaad,eOld);
                eOld=GetNextEffect(oSlaad);
            }

            //ActionAttack(oTarget);
            int nBin=1;
            while(nBin<2049)
            {
                if(nBin!=DamageExemption)
                {
                    eImmune=SupernaturalEffect(EffectDamageImmunityIncrease(nBin,100));
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eImmune,oSlaad,fDur);
                }
                nBin=nBin*2;
            }
            iSlaadCount++;
            //SendMessageToPC(GetFirstPC(),"Debug: Applying vfx");
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oSlaad,fDur);
            oSlaad=GetObjectByTag("ave_d2_slaad",iSlaadCount);
        }
}
