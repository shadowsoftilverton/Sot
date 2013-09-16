#include "engine"
#include "ave_d_inc"

void main()
{
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
        float fDur=18.0f;
        object oSlaad=GetObjectByTag(SLAADPRINT1,0);
        effect eImmune;
        object oTarget;
        int iSlaadCount;
        while(GetIsObjectValid(oSlaad))
        {
            oTarget=GetAttackTarget(oSlaad);
            //ExecuteScript("ave_d_slaadstrip",oSlaad);//Doing it this way hopefully makes the slaad AI not break
            //object oSlaad=OBJECT_SELF;
            effect eOld=GetFirstEffect(oSlaad);
            while(GetIsEffectValid(eOld))
            {
                RemoveEffect(oSlaad,eOld);
                eOld=GetNextEffect(oSlaad);
            }

            ActionAttack(oTarget);
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
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oSlaad,fDur);
            oSlaad=GetObjectByTag(SLAADPRINT1,iSlaadCount);
        }

}
