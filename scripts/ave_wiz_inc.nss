#include "inc_spellbook"

void ave_wiz_inc()
{
    object oPC=OBJECT_SELF;
    int iSpellID=GetSpellId()+1;
    if(GetLastSpellCastClass()==IP_CONST_CLASS_WIZARD)
    {
        SendMessageToPC(oPC,"You are demonstrating a spell.");
        SetLocalInt(oPC,"ave_dem_id",iSpellID);
    }
    else SendMessageToPC(oPC,"You can only demonstrate wizard spells");
}
