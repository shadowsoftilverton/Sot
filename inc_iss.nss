#include "engine"

#include "aps_include"
//#include "inc_bind"
#include "inc_system"

const string ISS_DM_HOLDING  = "wp_dm_holding";

// Persistent Account-Linked
const string ISS_CD_VAR      = "ISS_CDKEY_";
const string ISS_IP_VAR      = "ISS_IP_";
const string ISS_PW_VAR      = "ISS_PASSWORD_";
const string ISS_ENABLED_VAR = "ISS_ENABLED_";

// Local Non-Linked
const string ISS_VERIFIED_VAR = "ISS_VERIFIED";

// Player Messages
const string ISS_MSG_PASSWORD        = "Please enter your ISS password using: /password <password here>";
const string ISS_MSG_CHAT            = "You cannot chat, aside from PMs, until you've entered your password. Use: /password <password here>";
const string ISS_MSG_SUCCESS         = "You've been verified. Have fun!";
const string ISS_MSG_FAILURE         = "That password was not correct. Please try again.";
const string ISS_MSG_WRONG_SYNTAX    = "The correct syntax for this is: /password <old password> <new password>";
const string ISS_MSG_TOO_SHORT       = "The password you entered is too short. Passwords should be 6 or more alphanumeric characters.";
const string ISS_MSG_ISS_ENABLED     = "Your account has been ISS enabled. Remember your password -- you'll be prompted for it whenever you log on.";
const string ISS_MSG_CHANGE_PASSWORD = "Your account password has been successfully changed.";
const string ISS_MSG_DM_MUST_ENABLE  = "Dungeon Masters must use the ISS. Please register your account with ISS using the following command: /password <desired password>";

//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

// To be run on the module's onClientEnter block, and will lock players until
// they enter their password.
void DoISSVerification(object oPC);

// Applies a spell effect to prevent characters from doing anything until they
// enter their password.
void ApplyISSCharacterLock(object oPC);

// Removes the locking effect the security system put on oPC.
void RemoveISSCharacterLock(object oPC);

// Returns the CD key the user has registered with ISS.
// NOTE: This is NOT a recommended feature. This WILL leave vulnerabilities in
// the security system from more experienced hackers. Do NOT use this unless a
// protection against key spoofing exists.
string GetISSKey(object oPC);

// Sets a CD key for ISS registration with the given PC's account. If sKey is
// an empty string, it will set the key to oPC's current public key.
// NOTE: This is NOT a recommended feature. This WILL leave vulnerabilities in
// the security system from more experienced hackers. Do NOT use this unless a
// protection against key spoofing exists.
void SetISSKey(object oPC, string sKey="");

// Returns the IP address the user has registered with ISS.
string GetISSIP(object oPC);

// Sets the IP address for ISS registration with the given PC's account. If sIP
// is an empty string, it will set the IP to oPC's current IP address.
void SetISSIP(object oPC, string sIP="");

// Returns the ISS password for oPC's account.
string GetISSPassword(object oPC);

// Sets the ISS password for oPC's account.
void SetISSPassword(object oPC, string sPassword);

// Returns whether or not oPC's account has ISS enabled.
int GetIsISSEnabled(object oPC);

// Sets whether or not oPC's account has ISS enabled.
void SetIsISSEnabled(object oPC, int nEnabled);

// Returns if oPC has been verified for this session.
int GetIsISSVerified(object oPC);

// Sets if oPC has been verified for this session.
void SetIsISSVerified(object oPC, int nVerified);

//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

void DoISSVerification(object oPC){
    if(GetIsDM(oPC)) AssignCommand(oPC, JumpToObject(GetWaypointByTag(ISS_DM_HOLDING)));

    if(GetIsISSEnabled(oPC)){
        ApplyISSCharacterLock(oPC);

        // Let the player know they need to enter a password.
        DelayCommand(6.0, FloatingTextStringOnCreature(ISS_MSG_PASSWORD, oPC, FALSE));

        // Just to be explicit, even though this is automatically false.
        SetIsISSVerified(oPC, FALSE);
    } else {
        if(GetIsDM(oPC) && !GetIsISSEnabled(oPC)) DelayCommand(6.0, FloatingTextStringOnCreature(ISS_MSG_DM_MUST_ENABLE, oPC, FALSE));

        // Non-ISS enabled accounts still need verification.
        SetIsISSVerified(oPC, TRUE);
    }
}

void ApplyISSCharacterLock(object oPC){
    effect eLock = SystemEffect(EffectCutsceneParalyze());

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLock, oPC);
}

void RemoveISSCharacterLock(object oPC){
    effect eTemp = GetFirstEffect(oPC);

    while(GetIsEffectValid(eTemp)){
        if(GetEffectType(eTemp) == EFFECT_TYPE_CUTSCENE_PARALYZE) RemoveSystemEffect(oPC, eTemp);

        eTemp = GetNextEffect(oPC);
    }
}

string GetISSKey(object oPC){
    string sAccount = GetPCPlayerName(oPC);

    return GetPersistentString(GetModule(), ISS_CD_VAR + sAccount, SQL_TABLE_ACCOUNTS);
}

void SetISSKey(object oPC, string sKey=""){
    string sAccount = GetPCPlayerName(oPC);

    SetPersistentString(GetModule(), ISS_CD_VAR + sAccount, sKey, 0, SQL_TABLE_ACCOUNTS);
}

string GetISSIP(object oPC){
    string sAccount = GetPCPlayerName(oPC);

    return GetPersistentString(GetModule(), ISS_IP_VAR + sAccount, SQL_TABLE_ACCOUNTS);
}

void SetISSIP(object oPC, string sIP){
    string sAccount = GetPCPlayerName(oPC);

    SetPersistentString(GetModule(), ISS_IP_VAR + sAccount, sIP, 0, SQL_TABLE_ACCOUNTS);
}

string GetISSPassword(object oPC){
    string sAccount = GetPCPlayerName(oPC);

    return GetPersistentString(GetModule(), ISS_PW_VAR + sAccount, SQL_TABLE_ACCOUNTS);
}

void SetISSPassword(object oPC, string sPassword){
    string sAccount = GetPCPlayerName(oPC);

    SetPersistentString(GetModule(), ISS_PW_VAR + sAccount, sPassword, 0, SQL_TABLE_ACCOUNTS);
}

int GetIsISSEnabled(object oPC){
    string sAccount = GetPCPlayerName(oPC);

    return GetPersistentInt(GetModule(), ISS_ENABLED_VAR + sAccount, SQL_TABLE_ACCOUNTS);
}

void SetIsISSEnabled(object oPC, int nEnabled){
    string sAccount = GetPCPlayerName(oPC);

    SetPersistentInt(GetModule(), ISS_ENABLED_VAR + sAccount, nEnabled, 0, SQL_TABLE_ACCOUNTS);
}

int GetIsISSVerified(object oPC){
    return GetLocalInt(oPC, ISS_VERIFIED_VAR) || !GetIsPC(oPC) || GetIsPossessedFamiliar(oPC);
}

void SetIsISSVerified(object oPC, int nVerified){
    if(nVerified){
        RemoveISSCharacterLock(oPC);

        ExecuteScript("mod_iss_unlocked", oPC);
    }

    SetLocalInt(oPC, ISS_VERIFIED_VAR, nVerified);
}

//void main() {}
