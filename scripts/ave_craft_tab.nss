#include "ave_crafting"

void main()
{
   object oPC=GetLastClosedBy();
   object oChest=OBJECT_SELF;
   DoCraft(oPC,oChest,0);
}
