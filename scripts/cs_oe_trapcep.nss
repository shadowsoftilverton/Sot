#include "engine"

//Name    : cs_oe_trapcep
//Purpose : OnEnter script for a generic trigger for any of CEP's placeable traps.
//Created By: Stefan Grose of Faerun Nights
//Created On: 4/13/2004
//
/*
          Note: This trigger and scripts were designed for a generic trigger,
          not a trap trigger.  A trap trigger cannot be reset after a disarm or
          recover.

          If you do set it up as a trap trigger, move the OnEnter script from
          the OnEnter event to the OnTriggered event.  It should work until it
          has been disarmed or recovered.

          Setup required:
          1. Place a generic trigger in your area
          2. Place this script in the OnEnter event of the trigger
          3. Place the cs_ox_trapcep script in the OnExit event
          4. Place the CEP trap placeable on or above the trigger (unless you
             want the trap to be "hidden", then don't place the placeable and
             instead set the TrapHidden local variable to "TRUE" and include
             the trap resref in the TrapResRef local variable.
          5. Configure the trap "parameters" using local variables stored on the
             trigger. Local variables are set from the "variables" button
             on the "Advanced" tab of the trigger.

          The following parameters are configurable and can be setup as
          local variables on the trigger.  The variable name must match
          the string name listed down the left side of the list below:

          TrapTag        : tag of trap placeable (expressed as a string) (required)
                           (Defaults to an empty string)

          TrapReflexDC   : DC required to avoid the trap (expressed as an integer)
                           (Defaults to 15)

          DamageType     : DAMAGE_TYPE_* (expressed as an integer)
                           (Defaults to 1 = DAMAGE_TYPE_BLUDGEONING)

                           1    =  DAMAGE_TYPE_BLUDGEONING
                           2    =  DAMAGE_TYPE_PIERCING
                           4    =  DAMAGE_TYPE_SLASHING
                           8    =  DAMAGE_TYPE_MAGICAL
                           16   = DAMAGE_TYPE_ACID
                           32   = DAMAGE_TYPE_COLD
                           64   = DAMAGE_TYPE_DIVINE
                           128  = DAMAGE_TYPE_ELECTRICAL
                           256  = DAMAGE_TYPE_FIRE
                           512  = DAMAGE_TYPE_NEGATIVE
                           1024 = DAMAGE_TYPE_POSITIVE
                           2048 = DAMAGE_TYPE_SONIC

          NoKnockdown    : TRUE/FALSE (expressed as an integer)
                           (Defaults to FALSE = Knockdown occurs)

          SoundObjectTag : tag of sound that plays during trigger of trap
                           (Defaults to an empty string = no sound)

          MaxDamage      : the maximum damage distributed (expressed as an integer)
                           (Defaults to 10)

          MinDamage      : the minimum damage distributed (expressed as an integer)
                           (Defaults to 1)

          ResetTime      : number of seconds after "trap is triggered" that the
                           trap can be triggered again
                           (Defaults to 120 seconds)

          DeactivateTime : number of seconds after "trigger" that the trap is
                           repositioned in its "ready" state (this value should
                           be equal to or less than ResetTime)
                           (Defaults to 110 seconds)

          IncludeNonPC   : TRUE/FALSE (expressed as an integer) whether the trap
                           can be triggered by a non-PC
                           (Defaults to TRUE = does trigger on non-PC's)

          ContinuousDmg  : TRUE/FALSE (expressed as an integer) a value of TRUE
                           causes damage to the PC every 2 seconds until they
                           exit the trigger
                           (Defaults to FALSE = no continuous damage)

          HiddenTrap     : TRUE/FALSE (expressed as an integer) a value of TRUE
                           assume the trap is "hidden" (not actually placed in
                           the area), so when the trap is triggered, the script
                           actually creates the trap placeable, then activates
                           it.  On deactivate, the trap is destroyed.
                           (Defaults to FALSE = which requires placement of the trap)

          TrapResRef     : the resref of the trap being triggered - only required
                           if HiddenTrap is set to TRUE.
                           (Defaults to empty string)



*/

// Perform a reflex save and apply trap damage on failure
void Check_For_Trap_Damage(object oPC)
{

  // configuration parameters regarding the cep trap placeable
  int TrapReflexDC = GetLocalInt(OBJECT_SELF, "TrapReflexDC");
  int DamageType = GetLocalInt(OBJECT_SELF, "DamageType");
  int NoKnockdown = GetLocalInt(OBJECT_SELF, "NoKnockdown");
  int MaxDamage = GetLocalInt(OBJECT_SELF, "MaxDamage");
  int MinDamage = GetLocalInt(OBJECT_SELF, "MinDamage");
  string SoundObjectTag = GetLocalString(OBJECT_SELF, "SoundObjectTag");

  // Entered object's reflex save is successful
  if(ReflexSave(oPC, TrapReflexDC, SAVING_THROW_TYPE_NONE, GetAreaOfEffectCreator()))
    FloatingTextStringOnCreature("You barely dodge the trap!", oPC);

  else
    {

    // Failed reflex save, damage is inflicted
    effect eEffect;
    int RdmVar = MaxDamage - MinDamage + 1;

    //if no DamageType setup, then default it to Bludgeoning
    if(DamageType ==0)
      DamageType = 1;

    if(NoKnockdown)
      eEffect = EffectDamage(Random(RdmVar) + MinDamage, DamageType, DAMAGE_POWER_NORMAL);
    else
      eEffect = EffectLinkEffects(EffectDamage(Random(RdmVar) + MinDamage, DamageType, DAMAGE_POWER_NORMAL), EffectKnockdown());

    // Apply damage (and knockdown if included)
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, 3.0f);

    FloatingTextStringOnCreature("Argh!", oPC);
    }

  // Play the sound associated to the trap
  object oSound = GetObjectByTag(SoundObjectTag);

  // If the object with the sound tag does not exist
  if(!GetIsObjectValid(oSound))
    WriteTimestampedLogEntry("Error: No such sound exists with tag: " + SoundObjectTag);
  else
    SoundObjectPlay(oSound);

}

void main()
{
  int ContinuousDmg = GetLocalInt(OBJECT_SELF, "ContinuousDmg");
  int Triggered = GetLocalInt(OBJECT_SELF, "Triggered");
  object oPC = GetEnteringObject();

  // Exit if trap has not yet been "reset" (when its not a "Continuous Damage" trap
  if(Triggered && !ContinuousDmg)
    return;

  // Exit if it is a continuous trap, but the oPC has escaped the trap
  else if(ContinuousDmg && GetLocalInt(oPC, "EscapedTrap"))
    {
    DeleteLocalInt(oPC, "EscapedTrap");
    return;
    }

  // do not trigger the trap on a DM
  else if (GetIsDM(oPC))
    return;

  // do not trigger on a non-PC if the IncludeNonPC flag is set to 0 (FALSE)
  else
    {
    int IncludeNonPC = GetLocalInt(OBJECT_SELF, "IncludeNonPC");
    if(!GetIsPC(oPC) && !IncludeNonPC)
      return;
    }

  // Local variables stored on the trigger serving as trigger/trap parameters
  int ResetTime = GetLocalInt(OBJECT_SELF, "ResetTime");
  string TrapTag = GetLocalString(OBJECT_SELF, "TrapTag");
  int DeactivateTime = GetLocalInt(OBJECT_SELF, "DeactivateTime");
  int HiddenTrap = GetLocalInt(OBJECT_SELF, "HiddenTrap");
  string TrapResRef = GetLocalString(OBJECT_SELF, "TrapResRef");

  object oTrap;

  // If the trap has not yet been "triggered"
  if(!GetLocalInt(OBJECT_SELF, "Triggered"))
    {
    // If the trap is supposed to be hidden prior to trigger, create the trap
    // on trigger.
    if(HiddenTrap)
      oTrap = CreateObject(OBJECT_TYPE_PLACEABLE, GetLocalString(OBJECT_SELF, "TrapResRef"), GetLocation(OBJECT_SELF));

    else
      oTrap = GetObjectByTag(TrapTag);

    // If the object with the trap tag does not exist
    if(!GetIsObjectValid(oTrap))
      {
      WriteTimestampedLogEntry("Error: No such trap exists with tag: " + TrapTag);
      return;
      }

    // initiate trap placeable animation
    DelayCommand(0.5, AssignCommand(oTrap, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE)));

    // Flag the trap as being triggered
    SetLocalInt(OBJECT_SELF, "Triggered", TRUE);

    // Remove the variable (preventing the trap from being triggered) based on the
    // number of seconds in "ResetTime"
    DelayCommand(IntToFloat(ResetTime), DeleteLocalInt(OBJECT_SELF, "Triggered"));
    }

  oTrap = GetObjectByTag(TrapTag);

  // If the object with the trap tag does not exist
  if(!GetIsObjectValid(oTrap))
    {
    WriteTimestampedLogEntry("Error: No such trap exists with tag: " + TrapTag);
    return;
    }

  // Check to see if the trap does damage to the entering object
  DelayCommand(0.5, Check_For_Trap_Damage(oPC));

  // Deactivate the trap by placing it back in its "deactivate" state after the number
  // of seconds stored in DeactivateTime
  if(!GetLocalInt(OBJECT_SELF, "DeactivationDelaySet"))
    {
    DelayCommand(IntToFloat(DeactivateTime), AssignCommand(oTrap, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE)));
    SetLocalInt(OBJECT_SELF, "DeactivationDelaySet", TRUE);
    DelayCommand(IntToFloat(DeactivateTime), DeleteLocalInt(OBJECT_SELF, "DeactivationDelaySet"));

    // Make the trap disappear on deactivation (destroy it)
    if(HiddenTrap)
      DelayCommand(1.0, DestroyObject(oTrap, IntToFloat(DeactivateTime)));
    }

  // if the trap is supposed to continuously distribute damage every 2 seconds
  if(ContinuousDmg)
    DelayCommand(2.0f, ExecuteScript("cs_oe_trapcep", OBJECT_SELF));

}
