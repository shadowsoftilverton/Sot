#include "inc_spells"

void main()
{
     object oDemonstrator=OBJECT_SELF;
     effect eVis=EffectVisualEffect(VFX_DUR_AURA_YELLOW_DARK);
     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis,oDemonstrator,22.0);
     SendMessageToPC(oDemonstrator,"You have entered demonstration mode. Cast a spell, then have an observer target you.");
     SetLocalInt(oDemonstrator,"ave_demonstrate",1);
     DelayCommand(22.0,SetLocalInt(oDemonstrator,"ave_demonstrate",0));
}
