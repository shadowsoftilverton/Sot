//Written by Ave (2012/04/13)
#include "engine"
#include "ave_d_inc"

void main()
{
     object oSpirit=GetEnteringObject();
     location lLoc=GetLocation(oSpirit);
     if(GetTag(oSpirit)=="ave_spirit")
     {
         string sHeapTag=GetTag(GetLocalObject(oSpirit,"ave_o_dest"));
         string sTrigTag=GetTag(OBJECT_SELF);
         int iMyHeap=GetLocalInt(oSpirit,"ave_myheap");
         object oMyHeap=GetObjectByTag("ave_plc_corpse"+IntToString(iMyHeap));
         if(GetStringRight(sTrigTag,1)==GetStringRight(sHeapTag,1))
         {
            if(GetIsObjectValid(oMyHeap))
            {
                effect eVis=EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oMyHeap);
                SetPlotFlag(oSpirit,FALSE);
                DestroyObject(oSpirit);
                string sCritterNum=IntToString(Random(MAX_CRITTERTYPES));
                object oMonster=CreateObject(OBJECT_TYPE_CREATURE,"ave_undead"+sCritterNum,GetLocation(oMyHeap),FALSE,"ave_undead"+sCritterNum);
                BuffLoop(oMonster,0);
                DelayCommand(0.1,SetLocalInt(oMonster,"ave_orbkill",1));
                DelayCommand(0.1,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_RAISE_DEAD),oMonster));
            }
         }
         if(!GetIsObjectValid(oMyHeap))
         {//Corpse got nuked while we were enroute, time to pick another
            DelayCommand(0.1,SpiritChooseCorpse(oSpirit,lLoc));
         }
     }
}
