//This script replaces a fire trap on the door that is being disarmed, and activates
//it after 20 minutes.
//The trap type is decided by a local string on the door (TRAP_TYPE), as well as the
//DC to disarm (TRAP_DISARM) and detect (TRAP_FIND). Failing to give these will give
//ridiculously easy traps of a spike type.
//by dk

void main()
{

object oTarget;
object oPC=GetNearestObject(PLAYER_CHAR_IS_PC);
string sTrapType;
int iTrapType;
int iTrapDisarm;
int iTrapFind;
//oTarget = GetNearestObject(OBJECT_TYPE_DOOR);
oTarget=OBJECT_SELF;

//Determine and set the trap type.
sTrapType=GetLocalString(oTarget, "TRAP_TYPE");

//Average
    if (sTrapType=="AELECTRICAL")
        iTrapType=TRAP_BASE_TYPE_AVERAGE_ELECTRICAL;
    if (sTrapType=="ASPIKE")
        iTrapType=TRAP_BASE_TYPE_AVERAGE_SPIKE;
//Strong
    if (sTrapType=="SACID")
        iTrapType=TRAP_BASE_TYPE_STRONG_ACID;
    if (sTrapType=="SASPLASH")
        iTrapType=TRAP_BASE_TYPE_STRONG_ACID_SPLASH;
    if (sTrapType=="SELECTRICAL")
        iTrapType=TRAP_BASE_TYPE_STRONG_ELECTRICAL;
    if (sTrapType=="SFIRE")
        iTrapType=TRAP_BASE_TYPE_STRONG_FIRE;
    if (sTrapType=="SFROST")
        iTrapType=TRAP_BASE_TYPE_STRONG_FROST;
    if (sTrapType=="SGAS")
        iTrapType=TRAP_BASE_TYPE_STRONG_GAS;
    if (sTrapType=="SHOLY")
        iTrapType=TRAP_BASE_TYPE_STRONG_HOLY;
    if (sTrapType=="SNEGATIVE")
        iTrapType=TRAP_BASE_TYPE_STRONG_NEGATIVE;
    if (sTrapType=="SSONIC")
        iTrapType=TRAP_BASE_TYPE_STRONG_SONIC;
    if (sTrapType=="SSPIKE")
        iTrapType=TRAP_BASE_TYPE_STRONG_SPIKE;
    if (sTrapType=="STANGLE")
        iTrapType=TRAP_BASE_TYPE_STRONG_TANGLE;
//Deadly
    if (sTrapType=="DACID")
        iTrapType=TRAP_BASE_TYPE_DEADLY_ACID;
    if (sTrapType=="DASPLASH")
        iTrapType=TRAP_BASE_TYPE_DEADLY_ACID_SPLASH;
    if (sTrapType=="DELECTRICAL")
        iTrapType=TRAP_BASE_TYPE_DEADLY_ELECTRICAL;
    if (sTrapType=="DFIRE")
        iTrapType=TRAP_BASE_TYPE_DEADLY_FIRE;
    if (sTrapType=="DFROST")
        iTrapType=TRAP_BASE_TYPE_DEADLY_FROST;
    if (sTrapType=="DGAS")
        iTrapType=TRAP_BASE_TYPE_DEADLY_GAS;
    if (sTrapType=="DHOLY")
        iTrapType=TRAP_BASE_TYPE_DEADLY_HOLY;
    if (sTrapType=="DNEGATIVE")
        iTrapType=TRAP_BASE_TYPE_DEADLY_NEGATIVE;
    if (sTrapType=="DSONIC")
        iTrapType=TRAP_BASE_TYPE_DEADLY_SONIC;
    if (sTrapType=="DSPIKE")
        iTrapType=TRAP_BASE_TYPE_DEADLY_SPIKE;
    if (sTrapType=="DTANGLE")
        iTrapType=TRAP_BASE_TYPE_DEADLY_TANGLE;

//Set Disarm and Detect.
iTrapDisarm=GetLocalInt(oTarget, "TRAP_DISARM");
iTrapFind=GetLocalInt(oTarget, "TRAP_FIND");

//Create the Trap
CreateTrapOnObject(iTrapType, oTarget, STANDARD_FACTION_HOSTILE, "sm_doortrap", "");
SetTrapActive(oTarget, FALSE);
SetTrapDetectable(oTarget, FALSE);
SetTrapDetectedBy(oTarget, oPC, FALSE);
SetTrapOneShot(oTarget, FALSE);
SetTrapRecoverable(oTarget, FALSE);

//Activate the Trap
//oTarget = GetNearestTrapToObject(oPC, FALSE);
DelayCommand(1800.0, SetTrapActive(oTarget, TRUE));
DelayCommand(1800.0, SetTrapDetectable(oTarget, TRUE));
DelayCommand(1800.0, SetTrapDetectDC(oTarget, iTrapFind));
DelayCommand(1800.0, SetTrapDisarmDC(oTarget, iTrapDisarm));

}

