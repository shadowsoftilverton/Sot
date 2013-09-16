#include "ave_inc_rogue"

void main()
{
     object oPC=OBJECT_SELF;
     float fDur=GetLevelByClass(CLASS_TYPE_ROGUE,oPC)*6.0;
     SmallestVulnerability(oPC,GetSpellTargetObject(),fDur);
     //DelayCommand(120.0,IncrementRemainingFeatUses(oPC,SMALLEST_VULNERABILITY));
     GeneralCoolDown(SMALLEST_VULNERABILITY,oPC,120.0);
}
