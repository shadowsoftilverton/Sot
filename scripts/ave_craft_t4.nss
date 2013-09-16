#include "ave_crafting"

void main()
{
   object oPC=GetLastOpenedBy();
   object oChest=OBJECT_SELF;
   int nTier=4;
   //SendMessageToPC(oPC,"Creating Reagent...");
   CreateReagent(nTier, oChest);
}
