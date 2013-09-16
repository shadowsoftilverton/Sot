#include "engine"

void main()
{
   object oSlaad=OBJECT_SELF;
   effect eOld=GetFirstEffect(oSlaad);
   while(GetIsEffectValid(eOld))
   {
       RemoveEffect(oSlaad,eOld);
       eOld=GetNextEffect(oSlaad);
   }
}
