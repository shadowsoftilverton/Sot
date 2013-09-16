#include "engine"
#include "ave_wiz_inc"

//Spellhooking: this script should fire every time a spell is cast

void main()
{
   if(GetLocalInt(OBJECT_SELF,"ave_demonstrate")==1) ave_wiz_inc();
}
