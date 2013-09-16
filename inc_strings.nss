//::///////////////////////////////////////////////
//:: Ashton Shapcott
//:: Silver Marches Script
//:://////////////////////////////////////////////
/*
    Handles some custom string functions.
*/
//:://////////////////////////////////////////////
//:: Created By: Ashton Shapcott
//:: Created On: Oct. 28, 2010
//:://////////////////////////////////////////////

// Master string for color-picking.
string COLORTOKEN = "                  ##################$%&'()*+,-./0123456789:;;==?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[[]^_`abcdefghijklmnopqrstuvwxyz{|}~~€‚ƒ„…†‡ˆ‰Š‹Œ‘’“”•–—˜™š›œŸ¡¡¢£¤¥¦§¨©ª«¬¬®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÚÛÜİŞßàáâãäåæçèéêëìíîïğñòóôõö÷øùúûüışş";

// Returns a properly color-coded sText string based on specified RGB values
string ColorString(string sText, int nRed=255, int nGreen=255, int nBlue=255);

// Returns TRUE if sString begins with sPrefix.
int GetStringBeginsWith(string sString, string sPrefix);

void PrefixName(object oTarget, string sString);

void SuffixName(object oTarget, string sString);

void ResetName(object oTarget);

void PrefixDescription(object oTarget, string sString);

void SuffixDescription(object oTarget, string sString);

void ResetDescription(object oTarget);

void ErrorMessage(object oPC, string sMessage);

string ColorString(string sText, int nRed=255, int nGreen=255, int nBlue=255){
    return "<c" + GetSubString(COLORTOKEN, nRed, 1) + GetSubString(COLORTOKEN, nGreen, 1) + GetSubString(COLORTOKEN, nBlue, 1) + ">" + sText + "</c>";
}

int GetStringBeginsWith(string sString, string sPrefix){
    int nLength = GetStringLength(sPrefix);

    return GetStringLeft(sString, nLength) == sPrefix;
}

void PrefixName(object oObject, string sString){
    string sName = GetName(oObject);

    SetName(oObject, sString + sName);
}

void SuffixName(object oObject, string sString){
    string sName = GetName(oObject);

    SetName(oObject, sName + sString);
}

void ResetName(object oObject){
    SetName(oObject);
}

void PrefixDescription(object oObject, string sString){
    string sDesc = GetDescription(oObject);

    SetDescription(oObject, sString + sDesc);
}

void SuffixDescription(object oObject, string sString){
    string sDesc = GetDescription(oObject);

    SetDescription(oObject, sDesc + sString);
}

void ResetDescription(object oObject){
    SetDescription(oObject);
}

void ErrorMessage(object oPC, string sMessage){
    FloatingTextStringOnCreature(ColorString(sMessage, 255, 55, 55), oPC, FALSE);
}
