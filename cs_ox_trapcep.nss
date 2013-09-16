//Name     : cs_ox_tracep
//Purpose  : OnExit script for a generic trigger controlling a CEP trap
//           placeable.  This script is responsible for determining if the
//           trap is a continuous damage trap (ie. blade whirl) and if so,
//           then set a local int on the exiting creature indicating his/her
//           escape
//
//Created By: Stefan Grose of Faerun Nights
//Created On: 4/13/2004

void main()
{
  // If trap is of the continous damage type
  if(GetLocalInt(OBJECT_SELF, "ContinuousDmg"))
    {

    // if the exiting object is a DM, exit the function
    if (GetIsDM(GetExitingObject()))
      return;

    // if the exiting object is not a PC and the "IncludeNonPC" local variable
    // is set to FALSE, exit the function
    else
      {
      int IncludeNonPC = GetLocalInt(OBJECT_SELF, "IncludeNonPC");
      if(!GetIsPC(GetExitingObject()) && !IncludeNonPC)
        return;
      }

    // Set a local variable on the exiting object indicating they have exited
    // the trigger.  This "flag" allows the object to escape the recursive
    // function calls to cs_oe_trapcep.
    SetLocalInt(GetExitingObject(), "EscapedTrap", TRUE);
    }
}
