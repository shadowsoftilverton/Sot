#include "ave_inc_rogue"

void main()
{
     object oPC=OBJECT_SELF;
     float fDur=GetLevelByClass(CLASS_TYPE_ROGUE,oPC)*6.0;
     SmallestVulnerability(oPC,GetSpellTargetObject(),fDur);
     GeneralCoolDown(SMALLEST_VULNERABILITY,oPC,6.0);
}
