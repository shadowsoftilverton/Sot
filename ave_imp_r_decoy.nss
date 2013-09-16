#include "ave_inc_rogue"
#include "nw_i0_plot"
#include "nwnx_funcs"
#include "ave_inc_duration"

void SetMaxHitPoints_void(object oCreature, int nHP)
{
    SetMaxHitPoints(oCreature,nHP);
}

//Like SetCreatureEventHandler but returns void
void void_SetCreatureEventHandler(object oCreature, int CREATURE_EVENT_,string sScript)
{
    SetCreatureEventHandler(oCreature,CREATURE_EVENT_,sScript);
}

void main()
{
      object oPC=OBJECT_SELF;
      location lLoc=GetSpellTargetLocation();
      object oDecoy=CopyObject(oPC, lLoc, OBJECT_INVALID, "RiggedDecoy");
      int nLevel=GetLevelByClass(CLASS_TYPE_ROGUE,oPC);
      int nDC=10+nLevel/2+GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
      DelayCommand(0.1,SetLocalInt(oDecoy,"ave_decoy",1));
      DelayCommand(0.1,SetLocalInt(oDecoy,"ave_decoydc",nDC));
      DelayCommand(0.1,SetLocalInt(oDecoy,"ave_decoyn",nLevel));
      DelayCommand(0.1,SetMaxHitPoints_void(oDecoy,1));
      DelayCommand(0.1,ClearInventory(oDecoy));
      DelayCommand(0.1,void_SetCreatureEventHandler(oDecoy,CREATURE_EVENT_DEATH,"ave_r_decoyblast"));
      GeneralCoolDown(RIGGED_DECOY,oPC,900.0);
      DestroyObject(oDecoy,900.0);
}
